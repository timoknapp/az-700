param location string = 'eastus'
param adminUser string = 'TestUser'
@secure()
param adminPassword string

param virtualMachines_myVm_name string = 'myVm'
param virtualMachines_myVM1_name string = 'myVM1'
param virtualMachines_myVM2_name string = 'myVM2'
param virtualMachines_myVM3_name string = 'myVM3'
param networkInterfaces_myvm948_name string = 'myvm948'
param bastionHosts_myBastionHost_name string = 'myBastionHost'
param networkInterfaces_myVMnic1_name string = 'myVMnic1'
param networkInterfaces_myVMnic2_name string = 'myVMnic2'
param networkInterfaces_myVMnic3_name string = 'myVMnic3'
param virtualNetworks_IntLB_VNet_name string = 'IntLB-VNet'
param networkSecurityGroups_myNSG_name string = 'myNSG'
param publicIPAddresses_myBastionIP_name string = 'myBastionIP'
param loadBalancers_myIntLoadBalancer_name string = 'myIntLoadBalancer'

resource publicIPAddresses_myBastionIP_name_resource 'Microsoft.Network/publicIPAddresses@2022-05-01' = {
  name: publicIPAddresses_myBastionIP_name
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    // ipAddress: '20.224.83.8'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

resource virtualMachines_myVm_name_resource 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  name: virtualMachines_myVm_name
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-datacenter-gensecond'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${virtualMachines_myVm_name}_disk1_a681c7c132d8452da847a5d138a9d7df'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
        deleteOption: 'Delete'
        diskSizeGB: 127
      }
      dataDisks: []
    }
    osProfile: {
      computerName: virtualMachines_myVm_name
      adminUsername: adminUser
      adminPassword: adminPassword
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
          enableHotpatching: false
        }
        enableVMAgentPlatformUpdates: false
      }
      secrets: []
      allowExtensionOperations: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_myvm948_name_resource.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}

resource virtualMachines_myVM1_name_resource 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  name: virtualMachines_myVM1_name
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS1_v2'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${virtualMachines_myVM1_name}_disk1_c31e8260c4ca410f924dc4eba75ab559'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
        deleteOption: 'Detach'
        diskSizeGB: 127
      }
      dataDisks: []
    }
    osProfile: {
      computerName: virtualMachines_myVM1_name
      adminUsername: adminUser
      adminPassword: adminPassword
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
        }
        enableVMAgentPlatformUpdates: false
      }
      secrets: []
      allowExtensionOperations: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_myVMnic1_name_resource.id
          properties: {
            primary: true
          }
        }
      ]
    }
  }
}

resource virtualMachines_myVM2_name_resource 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  name: virtualMachines_myVM2_name
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS1_v2'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${virtualMachines_myVM2_name}_disk1_033dbaa429044fb998b89e01c283a401'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
        deleteOption: 'Detach'
        diskSizeGB: 127
      }
      dataDisks: []
    }
    osProfile: {
      computerName: virtualMachines_myVM2_name
      adminUsername: adminUser
      adminPassword: adminPassword
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
        }
        enableVMAgentPlatformUpdates: false
      }
      secrets: []
      allowExtensionOperations: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_myVMnic2_name_resource.id
          properties: {
            primary: true
          }
        }
      ]
    }
  }
}

resource virtualMachines_myVM3_name_resource 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  name: virtualMachines_myVM3_name
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS1_v2'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${virtualMachines_myVM3_name}_OsDisk_1_697d7d025941449abc1a9319fb4ef3ba'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
        deleteOption: 'Detach'
        diskSizeGB: 127
      }
      dataDisks: []
    }
    osProfile: {
      computerName: virtualMachines_myVM3_name
      adminUsername: adminUser
      adminPassword: adminPassword
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
        }
        enableVMAgentPlatformUpdates: false
      }
      secrets: []
      allowExtensionOperations: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_myVMnic3_name_resource.id
          properties: {
            primary: true
          }
        }
      ]
    }
  }
}

resource virtualMachines_myVM1_name_VMConfig 'Microsoft.Compute/virtualMachines/extensions@2022-08-01' = {
  parent: virtualMachines_myVM1_name_resource
  name: 'VMConfig'
  location: location
  properties: {
    autoUpgradeMinorVersion: true
    publisher: 'Microsoft.Compute'
    type: 'CustomScriptExtension'
    typeHandlerVersion: '1.7'
    settings: {
      fileUris: [
        'https://raw.githubusercontent.com/tiagocostapt/az-700-labs/master/install-iis.ps1'
      ]
      commandToExecute: 'powershell.exe -ExecutionPolicy Unrestricted -File install-iis.ps1'
    }
    protectedSettings: {
    }
  }
}

resource virtualMachines_myVM2_name_VMConfig 'Microsoft.Compute/virtualMachines/extensions@2022-08-01' = {
  parent: virtualMachines_myVM2_name_resource
  name: 'VMConfig'
  location: location
  properties: {
    autoUpgradeMinorVersion: true
    publisher: 'Microsoft.Compute'
    type: 'CustomScriptExtension'
    typeHandlerVersion: '1.7'
    settings: {
      fileUris: [
        'https://raw.githubusercontent.com/tiagocostapt/az-700-labs/master/install-iis.ps1'
      ]
      commandToExecute: 'powershell.exe -ExecutionPolicy Unrestricted -File install-iis.ps1'
    }
    protectedSettings: {
    }
  }
}

resource virtualMachines_myVM3_name_VMConfig 'Microsoft.Compute/virtualMachines/extensions@2022-08-01' = {
  parent: virtualMachines_myVM3_name_resource
  name: 'VMConfig'
  location: location
  properties: {
    autoUpgradeMinorVersion: true
    publisher: 'Microsoft.Compute'
    type: 'CustomScriptExtension'
    typeHandlerVersion: '1.7'
    settings: {
      fileUris: [
        'https://raw.githubusercontent.com/tiagocostapt/az-700-labs/master/install-iis.ps1'
      ]
      commandToExecute: 'powershell.exe -ExecutionPolicy Unrestricted -File install-iis.ps1'
    }
    protectedSettings: {
    }
  }
}

resource networkSecurityGroups_myNSG_name_resource 'Microsoft.Network/networkSecurityGroups@2022-05-01' = {
  name: networkSecurityGroups_myNSG_name
  location: location
  properties: {
    securityRules: [
      {
        name: 'default-allow-rdp'
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1000
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource bastionHosts_myBastionHost_name_resource 'Microsoft.Network/bastionHosts@2022-05-01' = {
  name: bastionHosts_myBastionHost_name
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    // dnsName: 'bst-dd4304e5-a8ad-4834-8679-ac953a62e1db.bastion.azure.com'
    scaleUnits: 2
    ipConfigurations: [
      {
        name: 'IpConf'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_myBastionIP_name_resource.id
          }
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_IntLB_VNet_name, 'AzureBastionSubnet')
          }
        }
      }
    ]
  }
}

resource loadBalancers_myIntLoadBalancer_name_resource 'Microsoft.Network/loadBalancers@2022-05-01' = {
  name: loadBalancers_myIntLoadBalancer_name
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    frontendIPConfigurations: [
      {
        name: 'LoadBalancerFrontEnd'
        properties: {
          // privateIPAddress: '10.1.2.4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_IntLB_VNet_name, 'myFrontEndSubnet')
          }
          privateIPAddressVersion: 'IPv4'
        }
        zones: [
          '3'
          '1'
          '2'
        ]
      }
    ]
    backendAddressPools: [
      {
        name: 'myBackendPool'
        properties: {
          loadBalancerBackendAddresses: [
            {
              name: 'IntLB-RG_myVMnic2ipconfig1'
              properties: {
              }
            }
            {
              name: 'IntLB-RG_myVMnic3ipconfig1'
              properties: {
              }
            }
            {
              name: 'IntLB-RG_myVMnic1ipconfig1'
              properties: {
              }
            }
          ]
        }
      }
    ]
    loadBalancingRules: [
      {
        name: 'myHTTPRule'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/loadBalancers/frontendIPConfigurations', loadBalancers_myIntLoadBalancer_name, 'LoadBalancerFrontEnd')
          }
          frontendPort: 80
          backendPort: 80
          enableFloatingIP: false
          idleTimeoutInMinutes: 15
          protocol: 'Tcp'
          enableTcpReset: false
          loadDistribution: 'Default'
          disableOutboundSnat: true
          backendAddressPool: {
            id: resourceId('Microsoft.Network/loadBalancers/backendAddressPools', loadBalancers_myIntLoadBalancer_name, 'myBackendPool')
          }
          backendAddressPools: [
            {
              id: resourceId('Microsoft.Network/loadBalancers/backendAddressPools', loadBalancers_myIntLoadBalancer_name, 'myBackendPool')
            }
          ]
          probe: {
            id: resourceId('Microsoft.Network/loadBalancers/probes', loadBalancers_myIntLoadBalancer_name, 'myHealthProbe')
          }
        }
      }
    ]
    probes: [
      {
        name: 'myHealthProbe'
        properties: {
          protocol: 'Http'
          port: 80
          requestPath: '/'
          intervalInSeconds: 15
          numberOfProbes: 1
          probeThreshold: 1
        }
      }
    ]
    inboundNatRules: []
    outboundRules: []
    inboundNatPools: []
  }
}

resource networkInterfaces_myvm948_name_resource 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  name: networkInterfaces_myvm948_name
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          // privateIPAddress: '10.1.0.7'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_IntLB_VNet_name, 'myBackendSubnet')
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: true
    enableIPForwarding: false
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkSecurityGroups_myNSG_name_resource.id
    }
    nicType: 'Standard'
  }
}

resource networkInterfaces_myVMnic2_name_resource 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  name: networkInterfaces_myVMnic2_name
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_IntLB_VNet_name, 'myBackendSubnet')
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
          // loadBalancerBackendAddressPools: [
          //   {
          //     id: resourceId('Microsoft.Network/loadBalancers/backendAddressPools', loadBalancers_myIntLoadBalancer_name, 'myBackendPool')
          //   }
          // ]
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkSecurityGroups_myNSG_name_resource.id
    }
    nicType: 'Standard'
  }
}

resource networkInterfaces_myVMnic1_name_resource 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  name: networkInterfaces_myVMnic1_name
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          // privateIPAddress: '10.1.0.4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_IntLB_VNet_name, 'myBackendSubnet')
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
          // loadBalancerBackendAddressPools: [
          //   {
          //     id: resourceId('Microsoft.Network/loadBalancers/backendAddressPools', loadBalancers_myIntLoadBalancer_name, 'myBackendPool')
          //   }
          // ]
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkSecurityGroups_myNSG_name_resource.id
    }
    nicType: 'Standard'
  }
}

resource networkInterfaces_myVMnic3_name_resource 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  name: networkInterfaces_myVMnic3_name
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          // privateIPAddress: '10.1.0.6'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_IntLB_VNet_name, 'myBackendSubnet')
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
          // loadBalancerBackendAddressPools: [
          //   {
          //     id: resourceId('Microsoft.Network/loadBalancers/backendAddressPools', loadBalancers_myIntLoadBalancer_name, 'myBackendPool')
          //   }
          // ]
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkSecurityGroups_myNSG_name_resource.id
    }
    nicType: 'Standard'
  }
}

resource virtualNetworks_IntLB_VNet_name_resource 'Microsoft.Network/virtualNetworks@2022-05-01' = {
  name: virtualNetworks_IntLB_VNet_name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'myBackendSubnet'
        properties: {
          addressPrefix: '10.1.0.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'AzureBastionSubnet'
        properties: {
          addressPrefix: '10.1.1.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'myFrontEndSubnet'
        properties: {
          addressPrefix: '10.1.2.0/24'
          serviceEndpoints: []
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}
