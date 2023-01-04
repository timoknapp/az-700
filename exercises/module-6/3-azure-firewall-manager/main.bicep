param location string = resourceGroup().location
param adminUsername string = 'TestUser'
@secure()
param adminPassword string

param azureFirewalls_AzureFirewall_Hub_01_name string = 'AzureFirewall-Hub-01'
param firewallPolicies_Policy_01_name string = 'Policy-01'
param networkInterfaces_Srv_workload_01nic_name string = 'Srv-workload-01nic'
param networkInterfaces_Srv_workload_02nic_name string = 'Srv-workload-02nic'
param virtualHubs_Hub_01_name string = 'Hub-01'
param virtualMachines_Srv_workload_01_name string = 'Srv-workload-01'
param virtualMachines_Srv_workload_02_name string = 'Srv-workload-02'
param virtualNetworks_HV_Hub_01_6a27709e_0df4_4dd8_85c1_64f69d1624c2_externalid string 
param virtualNetworks_Spoke_01_name string = 'Spoke-01'
param virtualNetworks_Spoke_02_name string = 'Spoke-02'
param virtualWans_Vwan_01_name string = 'Vwan-01'

resource firewallPolicies_Policy_01_name_resource 'Microsoft.Network/firewallPolicies@2022-05-01' = {
  location: location
  name: firewallPolicies_Policy_01_name
  properties: {
    sku: {
      tier: 'Standard'
    }
    threatIntelMode: 'Alert'
  }
}

resource virtualWans_Vwan_01_name_resource 'Microsoft.Network/virtualWans@2022-05-01' = {
  location: location
  name: virtualWans_Vwan_01_name
  properties: {
    allowBranchToBranchTraffic: true
    disableVpnEncryption: false
    type: 'Standard'
  }
}

resource virtualMachines_Srv_workload_01_name_resource 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  location: location
  name: virtualMachines_Srv_workload_01_name
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS1_v2'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_Srv_workload_01nic_name_resource.id
          properties: {
            primary: true
          }
        }
      ]
    }
    osProfile: {
      adminUsername: adminUsername
      adminPassword: adminPassword
      allowExtensionOperations: true
      computerName: virtualMachines_Srv_workload_01_name
      secrets: []
      windowsConfiguration: {
        enableAutomaticUpdates: true
        enableVMAgentPlatformUpdates: false
        patchSettings: {
          assessmentMode: 'ImageDefault'
          patchMode: 'AutomaticByOS'
        }
        provisionVMAgent: true
      }
    }
    storageProfile: {
      dataDisks: []
      imageReference: {
        offer: 'WindowsServer'
        publisher: 'MicrosoftWindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        caching: 'ReadWrite'
        createOption: 'FromImage'
        deleteOption: 'Detach'
        diskSizeGB: 127
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
        name: '${virtualMachines_Srv_workload_01_name}_OsDisk_1_2923fdcb8a3540a2b05715345370a3b4'
        osType: 'Windows'
      }
    }
  }
}

resource virtualMachines_Srv_workload_02_name_resource 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  location: location
  name: virtualMachines_Srv_workload_02_name
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS1_v2'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_Srv_workload_02nic_name_resource.id
          properties: {
            primary: true
          }
        }
      ]
    }
    osProfile: {
      adminUsername: adminUsername
      adminPassword: adminPassword
      allowExtensionOperations: true
      computerName: virtualMachines_Srv_workload_02_name
      secrets: []
      windowsConfiguration: {
        enableAutomaticUpdates: true
        enableVMAgentPlatformUpdates: false
        patchSettings: {
          assessmentMode: 'ImageDefault'
          patchMode: 'AutomaticByOS'
        }
        provisionVMAgent: true
      }
    }
    storageProfile: {
      dataDisks: []
      imageReference: {
        offer: 'WindowsServer'
        publisher: 'MicrosoftWindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        caching: 'ReadWrite'
        createOption: 'FromImage'
        deleteOption: 'Detach'
        diskSizeGB: 127
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
        name: '${virtualMachines_Srv_workload_02_name}_disk1_cc42da5357ea48af9589193a4726126d'
        osType: 'Windows'
      }
    }
  }
}

resource firewallPolicies_Policy_01_name_DefaultApplicationRuleCollectionGroup 'Microsoft.Network/firewallPolicies/ruleCollectionGroups@2022-05-01' = {
  parent: firewallPolicies_Policy_01_name_resource
  location: location
  name: 'DefaultApplicationRuleCollectionGroup'
  properties: {
    priority: 300
    ruleCollections: [
      {
        action: {
          type: 'Allow'
        }
        name: 'App-RV-01'
        priority: 100
        ruleCollectionType: 'FirewallPolicyFilterRuleCollection'
        rules: [
          {
            destinationAddresses: []
            fqdnTags: []
            name: 'Allow-msft'
            protocols: [
              {
                port: 80
                protocolType: 'Http'
              }
              {
                port: 443
                protocolType: 'Https'
              }
            ]
            ruleType: 'ApplicationRule'
            sourceAddresses: [
              '*'
            ]
            sourceIpGroups: []
            targetFqdns: [
              '*.microsoft.com'
            ]
            targetUrls: []
            terminateTLS: false
            webCategories: []
          }
        ]
      }
    ]
  }
  dependsOn: [
    firewallPolicies_Policy_01_name_resource
    // azureFirewalls_AzureFirewall_Hub_01_name_resource
  ]
}

resource firewallPolicies_Policy_01_name_DefaultDnatRuleCollectionGroup 'Microsoft.Network/firewallPolicies/ruleCollectionGroups@2022-05-01' = {
  parent: firewallPolicies_Policy_01_name_resource
  location: location
  name: 'DefaultDnatRuleCollectionGroup'
  properties: {
    priority: 100
    ruleCollections: [
      {
        action: {
          type: 'Dnat'
        }
        name: 'dnat-rdp'
        priority: 100
        ruleCollectionType: 'FirewallPolicyNatRuleCollection'
        rules: [
          {
            destinationAddresses: [
              azureFirewalls_AzureFirewall_Hub_01_name_resource.properties.ipConfigurations[0].properties.publicIPAddress.properties.ipAddress
            ]
            destinationPorts: [
              '3389'
            ]
            ipProtocols: [
              'TCP'
            ]
            name: 'allow-rdp'
            ruleType: 'NatRule'
            sourceAddresses: [
              '*'
            ]
            sourceIpGroups: []
            translatedAddress: networkInterfaces_Srv_workload_01nic_name_resource.properties.ipConfigurations[0].properties.privateIPAddress
            translatedPort: '3389'
          }
        ]
      }
    ]
  }
}

resource firewallPolicies_Policy_01_name_DefaultNetworkRuleCollectionGroup 'Microsoft.Network/firewallPolicies/ruleCollectionGroups@2022-05-01' = {
  parent: firewallPolicies_Policy_01_name_resource
  location: location
  name: 'DefaultNetworkRuleCollectionGroup'
  properties: {
    priority: 200
    ruleCollections: [
      {
        action: {
          type: 'Allow'
        }
        name: 'vnet-rdp'
        priority: 100
        ruleCollectionType: 'FirewallPolicyFilterRuleCollection'
        rules: [
          {
            destinationAddresses: [
              '10.1.1.4'
            ]
            destinationFqdns: []
            destinationIpGroups: []
            destinationPorts: [
              '3389'
            ]
            ipProtocols: [
              'TCP'
            ]
            name: 'allow-vnet'
            ruleType: 'NetworkRule'
            sourceAddresses: [
              '*'
            ]
            sourceIpGroups: []
          }
        ]
      }
    ]
  }
}

resource networkInterfaces_Srv_workload_01nic_name_resource 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  kind: 'Regular'
  location: location
  name: networkInterfaces_Srv_workload_01nic_name
  properties: {
    disableTcpStateTracking: false
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          primary: true
          // privateIPAddress: '10.0.1.4'
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_Spoke_01_name, 'Workload_01_SN')
          }
        }
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
      }
    ]
    nicType: 'Standard'
  }
}

resource networkInterfaces_Srv_workload_02nic_name_resource 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  kind: 'Regular'
  location: location
  name: networkInterfaces_Srv_workload_02nic_name
  properties: {
    disableTcpStateTracking: false
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          primary: true
          // privateIPAddress: '10.1.1.4'
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_Spoke_02_name_resource.name, 'Workload_02_SN')
          }
        }
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
      }
    ]
    nicType: 'Standard'
  }
}

resource virtualHubs_Hub_01_name_noneRouteTable 'Microsoft.Network/virtualHubs/hubRouteTables@2022-05-01' = {
  name: '${virtualHubs_Hub_01_name}/noneRouteTable'
  properties: {
    labels: [
      'none'
    ]
    routes: []
  }
  // dependsOn: [
  //   virtualHubs_Hub_01_name_resource+
  // ]
}

resource virtualNetworks_Spoke_01_name_RemoteVnetToHubPeering_5e0816f3_5d88_47f7_a392_2d77e79a0578 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-05-01' = {
  name: '${virtualNetworks_Spoke_01_name}/RemoteVnetToHubPeering_5e0816f3-5d88-47f7-a392-2d77e79a0578'
  properties: {
    allowForwardedTraffic: false
    allowGatewayTransit: false
    allowVirtualNetworkAccess: true
    doNotVerifyRemoteGateways: true
    peeringState: 'Connected'
    peeringSyncLevel: 'FullyInSync'
    remoteAddressSpace: {
      addressPrefixes: [
        '10.2.0.0/16'
      ]
    }
    remoteVirtualNetwork: {
      id: virtualNetworks_HV_Hub_01_6a27709e_0df4_4dd8_85c1_64f69d1624c2_externalid
    }
    remoteVirtualNetworkAddressSpace: {
      addressPrefixes: [
        '10.2.0.0/16'
      ]
    }
    useRemoteGateways: true
  }
  dependsOn: [
    virtualNetworks_Spoke_01_name_resource
  ]
}

resource virtualNetworks_Spoke_02_name_RemoteVnetToHubPeering_5e0816f3_5d88_47f7_a392_2d77e79a0578 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-05-01' = {
  name: '${virtualNetworks_Spoke_02_name}/RemoteVnetToHubPeering_5e0816f3-5d88-47f7-a392-2d77e79a0578'
  properties: {
    allowForwardedTraffic: false
    allowGatewayTransit: false
    allowVirtualNetworkAccess: true
    doNotVerifyRemoteGateways: true
    peeringState: 'Connected'
    peeringSyncLevel: 'FullyInSync'
    remoteAddressSpace: {
      addressPrefixes: [
        '10.2.0.0/16'
      ]
    }
    remoteVirtualNetwork: {
      id: virtualNetworks_HV_Hub_01_6a27709e_0df4_4dd8_85c1_64f69d1624c2_externalid
    }
    remoteVirtualNetworkAddressSpace: {
      addressPrefixes: [
        '10.2.0.0/16'
      ]
    }
    useRemoteGateways: true
  }
  dependsOn: [
    virtualNetworks_Spoke_02_name_resource
  ]
}

resource azureFirewalls_AzureFirewall_Hub_01_name_resource 'Microsoft.Network/azureFirewalls@2022-05-01' = {
  location: location
  name: azureFirewalls_AzureFirewall_Hub_01_name
  properties: {
    additionalProperties: {
    }
    firewallPolicy: {
      id: firewallPolicies_Policy_01_name_resource.id
    }
    hubIPAddresses: {
      // privateIPAddress: '10.2.64.4'
      publicIPs: {
        // addresses: [
        //   {
        //     address: '108.142.185.58'
        //   }
        // ]
        count: 1
      }
    }
    sku: {
      name: 'AZFW_Hub'
      tier: 'Standard'
    }
  }
}

resource virtualHubs_Hub_01_name_resource 'Microsoft.Network/virtualHubs@2022-05-01' = {
  location: location
  name: virtualHubs_Hub_01_name
  properties: {
    addressPrefix: '10.2.0.0/16'
    allowBranchToBranchTraffic: false
    azureFirewall: {
      id: azureFirewalls_AzureFirewall_Hub_01_name_resource.id
    }
    hubRoutingPreference: 'ExpressRoute'
    routeTable: {
      routes: []
    }
    sku: 'Standard'
    virtualHubRouteTableV2s: []
    virtualRouterAsn: 65515
    virtualRouterAutoScaleConfiguration: {
      minCapacity: 2
    }
    virtualRouterIps: [
      '10.2.32.4'
      '10.2.32.5'
    ]
    virtualWan: {
      id: virtualWans_Vwan_01_name_resource.id
    }
  }
}

resource virtualHubs_Hub_01_name_defaultRouteTable 'Microsoft.Network/virtualHubs/hubRouteTables@2022-05-01' = {
  name: '${virtualHubs_Hub_01_name}/defaultRouteTable'
  properties: {
    labels: [
      'default'
    ]
    routes: [
      {
        destinationType: 'CIDR'
        destinations: [
          '0.0.0.0/0'
          '10.0.0.0/8'
          '172.16.0.0/12'
          '192.168.0.0/16'
        ]
        name: 'all_traffic'
        nextHop: azureFirewalls_AzureFirewall_Hub_01_name_resource.id
        nextHopType: 'ResourceId'
      }
    ]
  }
  dependsOn: [
    virtualHubs_Hub_01_name_resource

  ]
}

resource virtualNetworks_Spoke_01_name_resource 'Microsoft.Network/virtualNetworks@2022-05-01' = {
  location: location
  name: virtualNetworks_Spoke_01_name
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    enableDdosProtection: false
    subnets: [
      {
        name: 'Workload-01-SN'
        properties: {
          addressPrefix: '10.0.1.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: [
      {
        name: 'RemoteVnetToHubPeering_5e0816f3-5d88-47f7-a392-2d77e79a0578'
        properties: {
          allowForwardedTraffic: false
          allowGatewayTransit: false
          allowVirtualNetworkAccess: true
          doNotVerifyRemoteGateways: true
          peeringState: 'Connected'
          peeringSyncLevel: 'FullyInSync'
          remoteAddressSpace: {
            addressPrefixes: [
              '10.2.0.0/16'
            ]
          }
          remoteVirtualNetwork: {
            id: virtualNetworks_HV_Hub_01_6a27709e_0df4_4dd8_85c1_64f69d1624c2_externalid
          }
          remoteVirtualNetworkAddressSpace: {
            addressPrefixes: [
              '10.2.0.0/16'
            ]
          }
          useRemoteGateways: true
        }
        type: 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings'
      }
    ]
  }
}

resource virtualNetworks_Spoke_02_name_resource 'Microsoft.Network/virtualNetworks@2022-05-01' = {
  location: location
  name: virtualNetworks_Spoke_02_name
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    enableDdosProtection: false
    subnets: [
      {
        name: 'Workload-02-SN'
        properties: {
          addressPrefix: '10.1.1.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: [
      {
        name: 'RemoteVnetToHubPeering_5e0816f3-5d88-47f7-a392-2d77e79a0578'
        properties: {
          allowForwardedTraffic: false
          allowGatewayTransit: false
          allowVirtualNetworkAccess: true
          doNotVerifyRemoteGateways: true
          peeringState: 'Connected'
          peeringSyncLevel: 'FullyInSync'
          remoteAddressSpace: {
            addressPrefixes: [
              '10.2.0.0/16'
            ]
          }
          remoteVirtualNetwork: {
            id: virtualNetworks_HV_Hub_01_6a27709e_0df4_4dd8_85c1_64f69d1624c2_externalid
          }
          remoteVirtualNetworkAddressSpace: {
            addressPrefixes: [
              '10.2.0.0/16'
            ]
          }
          useRemoteGateways: true
        }
        type: 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings'
      }
    ]
  }
}

resource virtualHubs_Hub_01_name_hub_spoke_01 'Microsoft.Network/virtualHubs/hubVirtualNetworkConnections@2022-05-01' = {
  name: '${virtualHubs_Hub_01_name}/hub-spoke-01'
  properties: {
    allowHubToRemoteVnetTransit: true
    allowRemoteVnetToUseHubVnetGateways: true
    enableInternetSecurity: true
    remoteVirtualNetwork: {
      id: virtualNetworks_Spoke_01_name_resource.id
    }
    routingConfiguration: {
      associatedRouteTable: {
        id: virtualHubs_Hub_01_name_defaultRouteTable.id
      }
      propagatedRouteTables: {
        ids: [
          {
            id: virtualHubs_Hub_01_name_noneRouteTable.id
          }
        ]
        labels: [
          'none'
        ]
      }
      vnetRoutes: {
        staticRoutes: []
        staticRoutesConfig: {
          vnetLocalRouteOverrideCriteria: 'Contains'
        }
      }
    }
  }
  dependsOn: [
    virtualHubs_Hub_01_name_resource

  ]
}

resource virtualHubs_Hub_01_name_hub_spoke_02 'Microsoft.Network/virtualHubs/hubVirtualNetworkConnections@2022-05-01' = {
  name: '${virtualHubs_Hub_01_name}/hub-spoke-02'
  properties: {
    allowHubToRemoteVnetTransit: true
    allowRemoteVnetToUseHubVnetGateways: true
    enableInternetSecurity: true
    remoteVirtualNetwork: {
      id: virtualNetworks_Spoke_02_name_resource.id
    }
    routingConfiguration: {
      associatedRouteTable: {
        id: virtualHubs_Hub_01_name_defaultRouteTable.id
      }
      propagatedRouteTables: {
        ids: [
          {
            id: virtualHubs_Hub_01_name_noneRouteTable.id
          }
        ]
        labels: [
          'none'
        ]
      }
      vnetRoutes: {
        staticRoutes: []
        staticRoutesConfig: {
          vnetLocalRouteOverrideCriteria: 'Contains'
        }
      }
    }
  }
  dependsOn: [
    virtualHubs_Hub_01_name_resource

  ]
}
