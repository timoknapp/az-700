param location string = resourceGroup().location

param adminUser string = 'TestUser'
@secure()
param adminPassword string

param azureFirewalls_Test_FW01_name string = 'Test_FW01'
param firewallPolicies_fw_test_pol_name string = 'fw-test-pol'
param networkInterfaces_Srv_Work_nic_name string = '${virtualMachines_Srv_Work_name}_nic'
param networkSecurityGroups_Test_FW_VN_Workload_SN_nsg_name string = '${virtualNetworks_Test_FW_VN_name}_${virtualNetworks_Test_FW_VN_Workload_SN_name}_nsg_${location}'
param publicIPAddresses_fw_pip_name string = 'fw-pip'
param routeTables_Firewall_route_name string = 'Firewall-route'
param virtualMachines_Srv_Work_name string = 'Srv_Work'
param virtualNetworks_Test_FW_VN_name string = 'Test_FW_VN'
param virtualNetworks_Test_FW_VN_Workload_SN_name string = 'Workload_SN'
param virtualNetworks_Test_FW_VN_AzureFirewallSubnet_name string = 'AzureFirewallSubnet'

resource firewallPolicies_fw_test_pol_name_resource 'Microsoft.Network/firewallPolicies@2022-05-01' = {
  location: location
  name: firewallPolicies_fw_test_pol_name
  properties: {
    sku: {
      tier: 'Standard'
    }
    threatIntelMode: 'Alert'
  }
}

resource publicIPAddresses_fw_pip_name_resource 'Microsoft.Network/publicIPAddresses@2022-05-01' = {
  location: location
  name: publicIPAddresses_fw_pip_name
  properties: {
    idleTimeoutInMinutes: 4
    ipTags: []
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
  }
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
}

resource virtualMachines_Srv_Work_name_resource 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  location: location
  name: virtualMachines_Srv_Work_name
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS1_v2'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_Srv_Work_nic_name_resource.id
          properties: {
            primary: true
          }
        }
      ]
    }
    osProfile: {
      adminUsername: adminUser
      adminPassword: adminPassword
      allowExtensionOperations: true
      computerName: 'Srv-Work'
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
        name: '${virtualMachines_Srv_Work_name}_disk1_994bb36c71ec4596ab220e27ac727e36'
        osType: 'Windows'
      }
    }
  }
}

resource firewallPolicies_fw_test_pol_name_DefaultApplicationRuleCollectionGroup 'Microsoft.Network/firewallPolicies/ruleCollectionGroups@2022-05-01' = {
  parent: firewallPolicies_fw_test_pol_name_resource
  location: location
  name: 'DefaultApplicationRuleCollectionGroup'
  properties: {
    priority: 300
    ruleCollections: [
      {
        action: {
          type: 'Allow'
        }
        name: 'App-Coll01'
        priority: 200
        ruleCollectionType: 'FirewallPolicyFilterRuleCollection'
        rules: [
          {
            destinationAddresses: []
            fqdnTags: []
            name: 'Allow-Google'
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
              '10.0.2.0/24'
            ]
            sourceIpGroups: []
            targetFqdns: [
              'www.google.com'
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
    azureFirewalls_Test_FW01_name_resource
    firewallPolicies_fw_test_pol_name_resource
  ]
}

resource firewallPolicies_fw_test_pol_name_DefaultDnatRuleCollectionGroup 'Microsoft.Network/firewallPolicies/ruleCollectionGroups@2022-05-01' = {
  parent: firewallPolicies_fw_test_pol_name_resource
  location: location
  name: 'DefaultDnatRuleCollectionGroup'
  properties: {
    priority: 100
    ruleCollections: [
      {
        action: {
          type: 'Dnat'
        }
        name: 'rdp'
        priority: 200
        ruleCollectionType: 'FirewallPolicyNatRuleCollection'
        rules: [
          {
            destinationAddresses: [
              publicIPAddresses_fw_pip_name_resource.properties.ipAddress
            ]
            destinationPorts: [
              '3389'
            ]
            ipProtocols: [
              'TCP'
            ]
            name: 'rdp-nat'
            ruleType: 'NatRule'
            sourceAddresses: [
              '*'
            ]
            sourceIpGroups: []
            translatedAddress: networkInterfaces_Srv_Work_nic_name_resource.properties.ipConfigurations[0].properties.privateIPAddress
            translatedPort: '3389'
          }
        ]
      }
    ]
  }
  dependsOn: [
    azureFirewalls_Test_FW01_name_resource
    firewallPolicies_fw_test_pol_name_resource
    networkInterfaces_Srv_Work_nic_name_resource
    publicIPAddresses_fw_pip_name_resource
  ]
}

resource firewallPolicies_fw_test_pol_name_DefaultNetworkRuleCollectionGroup 'Microsoft.Network/firewallPolicies/ruleCollectionGroups@2022-05-01' = {
  parent: firewallPolicies_fw_test_pol_name_resource
  location: location
  name: 'DefaultNetworkRuleCollectionGroup'
  properties: {
    priority: 200
    ruleCollections: [
      {
        action: {
          type: 'Allow'
        }
        name: 'Net-Col01'
        priority: 200
        ruleCollectionType: 'FirewallPolicyFilterRuleCollection'
        rules: [
          {
            destinationAddresses: [
              '209.244.0.3'
              '209.244.0.4'
            ]
            destinationFqdns: []
            destinationIpGroups: []
            destinationPorts: [
              '53'
            ]
            ipProtocols: [
              'UDP'
            ]
            name: 'Allow-DNS'
            ruleType: 'NetworkRule'
            sourceAddresses: [
              '10.0.2.0/24'
            ]
            sourceIpGroups: []
          }
        ]
      }
    ]
  }
  dependsOn: [
    azureFirewalls_Test_FW01_name_resource
    firewallPolicies_fw_test_pol_name_resource
  ]
}

resource networkInterfaces_Srv_Work_nic_name_resource 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  kind: 'Regular'
  location: location
  name: networkInterfaces_Srv_Work_nic_name
  properties: {
    disableTcpStateTracking: false
    dnsSettings: {
      dnsServers: [
        '209.244.0.3'
        '209.244.0.4'
      ]
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          primary: true
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', '${virtualNetworks_Test_FW_VN_name_resource.name}', virtualNetworks_Test_FW_VN_Workload_SN_name)
          }
        }
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
      }
    ]
    nicType: 'Standard'
  }
}

resource routeTables_Firewall_route_name_resource 'Microsoft.Network/routeTables@2022-05-01' = {
  location: location
  name: routeTables_Firewall_route_name
  properties: {
    disableBgpRoutePropagation: false
    routes: [
      {
        name: 'fw-dg'
        properties: {
          addressPrefix: '0.0.0.0/0'
          hasBgpOverride: false
          nextHopIpAddress: azureFirewalls_Test_FW01_name_resource.properties.ipConfigurations[0].properties.privateIPAddress
          nextHopType: 'VirtualAppliance'
        }
        type: 'Microsoft.Network/routeTables/routes'
      }
    ]
  }
  dependsOn: [
    azureFirewalls_Test_FW01_name_resource
  ]
}

resource networkSecurityGroups_Test_FW_VN_Workload_SN_nsg_resource 'Microsoft.Network/networkSecurityGroups@2022-05-01' = {
  location: location
  name: networkSecurityGroups_Test_FW_VN_Workload_SN_nsg_name
  properties: {
    securityRules: [
      {
        name: 'AllowCorpnet'
        properties: {
          access: 'Allow'
          description: 'CSS Governance Security Rule.  Allow Corpnet inbound.  https://aka.ms/casg'
          destinationAddressPrefix: '*'
          destinationAddressPrefixes: []
          destinationPortRange: '*'
          destinationPortRanges: []
          direction: 'Inbound'
          priority: 2700
          protocol: '*'
          sourceAddressPrefix: 'CorpNetPublic'
          sourceAddressPrefixes: []
          sourcePortRange: '*'
          sourcePortRanges: []
        }
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
      }
      {
        name: 'AllowSAW'
        properties: {
          access: 'Allow'
          description: 'CSS Governance Security Rule.  Allow SAW inbound.  https://aka.ms/casg'
          destinationAddressPrefix: '*'
          destinationAddressPrefixes: []
          destinationPortRange: '*'
          destinationPortRanges: []
          direction: 'Inbound'
          priority: 2701
          protocol: '*'
          sourceAddressPrefix: 'CorpNetSaw'
          sourceAddressPrefixes: []
          sourcePortRange: '*'
          sourcePortRanges: []
        }
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
      }
    ]
  }
}

resource azureFirewalls_Test_FW01_name_resource 'Microsoft.Network/azureFirewalls@2022-05-01' = {
  location: location
  name: azureFirewalls_Test_FW01_name
  properties: {
    additionalProperties: {
    }
    applicationRuleCollections: []
    firewallPolicy: {
      id: firewallPolicies_fw_test_pol_name_resource.id
    }
    ipConfigurations: [
      {
        name: 'fw-pip'
        properties: {
          publicIPAddress: {
            id: publicIPAddresses_fw_pip_name_resource.id
          }
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_Test_FW_VN_name, virtualNetworks_Test_FW_VN_AzureFirewallSubnet_name)
          }
        }
      }
    ]
    natRuleCollections: []
    networkRuleCollections: []
    sku: {
      name: 'AZFW_VNet'
      tier: 'Standard'
    }
    threatIntelMode: 'Alert'
  }
  dependsOn: [
    virtualNetworks_Test_FW_VN_name_resource
  ]
}

resource virtualNetworks_Test_FW_VN_name_resource 'Microsoft.Network/virtualNetworks@2022-05-01' = {
  location: location
  name: virtualNetworks_Test_FW_VN_name
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    dhcpOptions: {
      dnsServers: []
    }
    enableDdosProtection: false
    subnets: [
      {
        name: virtualNetworks_Test_FW_VN_AzureFirewallSubnet_name
        properties: {
          addressPrefix: '10.0.1.0/26'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          serviceEndpoints: []
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: virtualNetworks_Test_FW_VN_Workload_SN_name
        properties: {
          addressPrefix: '10.0.2.0/24'
          delegations: []
          networkSecurityGroup: {
            id: networkSecurityGroups_Test_FW_VN_Workload_SN_nsg_resource.id
          }
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          // routeTable: {
          //   id: routeTables_Firewall_route_name_resource.id
          // }
          serviceEndpoints: []
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: []
  }
}

resource virtualNetworks_Test_FW_VN_Workload_SN_resource 'Microsoft.Network/virtualNetworks/subnets@2022-05-01' = {
  parent: virtualNetworks_Test_FW_VN_name_resource
  name: virtualNetworks_Test_FW_VN_Workload_SN_name
  properties: {
    addressPrefix: '10.0.2.0/24'
    delegations: []
    networkSecurityGroup: {
      id: networkSecurityGroups_Test_FW_VN_Workload_SN_nsg_resource.id
    }
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    routeTable: {
      id: routeTables_Firewall_route_name_resource.id
    }
    serviceEndpoints: []
  }
}

