param location string = resourceGroup().location

param adminUsername string = 'TestUser'
@secure()
param adminPassword string

param bastionHosts_myBastionHost_name string = 'myBastionHost'
param loadBalancers_myIntLoadBalancer_name string = 'myIntLoadBalancer'
param networkInterfaces_myVMnic1_name string = 'myVMnic1'
param networkInterfaces_myVMnic2_name string = 'myVMnic2'
param networkInterfaces_myVMnic3_name string = 'myVMnic3'
param networkInterfaces_mytestvm498_name string = 'mytestvm498' 
param networkSecurityGroups_myNSG_name string = 'myNSG'
param publicIPAddresses_myBastionIP_name string = 'myBastionIP'
param virtualMachines_myTestVM_name string = 'myTestVM'
param virtualMachines_myVM1_name string = 'myVM1'
param virtualMachines_myVM2_name string = 'myVM2'
param virtualMachines_myVM3_name string = 'myVM3'
param virtualNetworks_IntLB_VNet_name string = 'IntLB-VNet'
param workspaces_myLAworkspace_name string = 'myLAworkspace'

resource publicIPAddresses_myBastionIP_name_resource 'Microsoft.Network/publicIPAddresses@2022-05-01' = {
  location: location
  name: publicIPAddresses_myBastionIP_name
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

resource workspaces_myLAworkspace_name_resource 'Microsoft.OperationalInsights/workspaces@2021-12-01-preview' = {
  location: location
  name: workspaces_myLAworkspace_name
  properties: {
    features: {
      enableLogAccessUsingOnlyResourcePermissions: true
    }
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    retentionInDays: 30
    sku: {
      name: 'pergb2018'
    }
    workspaceCapping: {
      dailyQuotaGb: -1
    }
  }
}

resource virtualMachines_myTestVM_name_resource 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  location: location
  name: virtualMachines_myTestVM_name
  properties: {
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_mytestvm498_name_resource.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    osProfile: {
      adminUsername: adminUsername
      adminPassword: adminPassword
      allowExtensionOperations: true
      computerName: virtualMachines_myTestVM_name
      requireGuestProvisionSignal: true
      secrets: []
      windowsConfiguration: {
        enableAutomaticUpdates: true
        enableVMAgentPlatformUpdates: false
        patchSettings: {
          assessmentMode: 'ImageDefault'
          enableHotpatching: false
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
        sku: '2019-datacenter-gensecond'
        version: 'latest'
      }
      osDisk: {
        caching: 'ReadWrite'
        createOption: 'FromImage'
        deleteOption: 'Delete'
        diskSizeGB: 127
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
        name: '${virtualMachines_myTestVM_name}_disk1_65caa27287ed41bdb3c3d049ca0e6439'
        osType: 'Windows'
      }
    }
  }
}

resource virtualMachines_myVM1_name_resource 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  location: location
  name: virtualMachines_myVM1_name
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS1_v2'
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
    osProfile: {
      adminUsername: adminUsername
      adminPassword: adminPassword
      allowExtensionOperations: true
      computerName: virtualMachines_myVM1_name
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
        name: '${virtualMachines_myVM1_name}_disk1_519858b93f394d5386e967dc0db12193'
        osType: 'Windows'
      }
    }
  }
}

resource virtualMachines_myVM2_name_resource 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  location: location
  name: virtualMachines_myVM2_name
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS1_v2'
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
    osProfile: {
      adminUsername: adminUsername
      adminPassword: adminPassword
      allowExtensionOperations: true
      computerName: virtualMachines_myVM2_name
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
        name: '${virtualMachines_myVM2_name}_disk1_62391a773ef149c9ba7bc9b2d7a08e37'
        osType: 'Windows'
      }
    }
  }
}

resource virtualMachines_myVM3_name_resource 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  location: location
  name: virtualMachines_myVM3_name
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS1_v2'
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
    osProfile: {
      adminUsername: adminUsername
      adminPassword: adminPassword
      allowExtensionOperations: true
      computerName: virtualMachines_myVM3_name
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
        name: '${virtualMachines_myVM3_name}_disk1_a5190b6cf2044767835f59666eaf7fba'
        osType: 'Windows'
      }
    }
  }
}

resource virtualMachines_myVM1_name_VMConfig 'Microsoft.Compute/virtualMachines/extensions@2022-08-01' = {
  parent: virtualMachines_myVM1_name_resource
  location: location
  name: 'VMConfig'
  properties: {
    autoUpgradeMinorVersion: true
    protectedSettings: {
    }
    publisher: 'Microsoft.Compute'
    settings: {
      commandToExecute: 'powershell.exe -ExecutionPolicy Unrestricted -File install-iis.ps1'
      fileUris: [
        'https://raw.githubusercontent.com/MicrosoftLearning/AZ-700-Designing-and-Implementing-Microsoft-Azure-Networking-Solutions/master/Allfiles/Exercises/M08/install-iis.ps1'
      ]
    }
    type: 'CustomScriptExtension'
    typeHandlerVersion: '1.7'
  }
}

resource virtualMachines_myVM2_name_VMConfig 'Microsoft.Compute/virtualMachines/extensions@2022-08-01' = {
  parent: virtualMachines_myVM2_name_resource
  location: location
  name: 'VMConfig'
  properties: {
    autoUpgradeMinorVersion: true
    protectedSettings: {
    }
    publisher: 'Microsoft.Compute'
    settings: {
      commandToExecute: 'powershell.exe -ExecutionPolicy Unrestricted -File install-iis.ps1'
      fileUris: [
        'https://raw.githubusercontent.com/MicrosoftLearning/AZ-700-Designing-and-Implementing-Microsoft-Azure-Networking-Solutions/master/Allfiles/Exercises/M08/install-iis.ps1'
      ]
    }
    type: 'CustomScriptExtension'
    typeHandlerVersion: '1.7'
  }
}

resource virtualMachines_myVM3_name_VMConfig 'Microsoft.Compute/virtualMachines/extensions@2022-08-01' = {
  parent: virtualMachines_myVM3_name_resource
  location: location
  name: 'VMConfig'
  properties: {
    autoUpgradeMinorVersion: true
    protectedSettings: {
    }
    publisher: 'Microsoft.Compute'
    settings: {
      commandToExecute: 'powershell.exe -ExecutionPolicy Unrestricted -File install-iis.ps1'
      fileUris: [
        'https://raw.githubusercontent.com/MicrosoftLearning/AZ-700-Designing-and-Implementing-Microsoft-Azure-Networking-Solutions/master/Allfiles/Exercises/M08/install-iis.ps1'
      ]
    }
    type: 'CustomScriptExtension'
    typeHandlerVersion: '1.7'
  }
}

resource networkSecurityGroups_myNSG_name_resource 'Microsoft.Network/networkSecurityGroups@2022-05-01' = {
  location: location
  name: networkSecurityGroups_myNSG_name
  properties: {
    securityRules: [
      {
        name: 'default-allow-rdp'
        properties: {
          access: 'Allow'
          destinationAddressPrefix: '*'
          destinationAddressPrefixes: []
          destinationPortRange: '3389'
          destinationPortRanges: []
          direction: 'Inbound'
          priority: 1000
          protocol: 'Tcp'
          sourceAddressPrefix: '*'
          sourceAddressPrefixes: []
          sourcePortRange: '*'
          sourcePortRanges: []
        }
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
      }
    ]
  }
}

resource bastionHosts_myBastionHost_name_resource 'Microsoft.Network/bastionHosts@2022-05-01' = {
  location: location
  name: bastionHosts_myBastionHost_name
  properties: {
    dnsName: 'bst-7c98ef7d-2c20-4710-aa31-475472cadaad.bastion.azure.com'
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
    scaleUnits: 2
  }
  sku: {
    name: 'Basic'
  }
}

resource loadBalancers_myIntLoadBalancer_name_resource 'Microsoft.Network/loadBalancers@2022-05-01' = {
  location: location
  name: loadBalancers_myIntLoadBalancer_name
  properties: {
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
    frontendIPConfigurations: [
      {
        name: 'LoadBalancerFrontEnd'
        properties: {
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', 'IntLB-VNet', 'myBackendSubnet')
          }
        }
      }
    ]
    inboundNatPools: []
    inboundNatRules: []
    loadBalancingRules: [
      {
        name: 'myHTTPRule'
        properties: {
          backendAddressPool: {
            id: resourceId('Microsoft.Network/loadBalancers/backendAddressPools', loadBalancers_myIntLoadBalancer_name, 'myBackendPool')
          }
          backendAddressPools: [
            {
              id: resourceId('Microsoft.Network/loadBalancers/backendAddressPools', loadBalancers_myIntLoadBalancer_name, 'myBackendPool')
            }
          ]
          backendPort: 80
          disableOutboundSnat: true
          enableFloatingIP: false
          enableTcpReset: false
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/loadBalancers/frontendIPConfigurations', loadBalancers_myIntLoadBalancer_name, 'LoadBalancerFrontEnd')
          }
          frontendPort: 80
          idleTimeoutInMinutes: 15
          loadDistribution: 'Default'
          probe: {
            id: resourceId('Microsoft.Network/loadBalancers/probes', loadBalancers_myIntLoadBalancer_name, 'myHealthProbe')
          }
          protocol: 'Tcp'
        }
      }
    ]
    outboundRules: []
    probes: [
      {
        name: 'myHealthProbe'
        properties: {
          intervalInSeconds: 15
          numberOfProbes: 1
          port: 80
          probeThreshold: 1
          protocol: 'Http'
          requestPath: '/'
        }
      }
    ]
  }
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
}

resource networkInterfaces_mytestvm498_name_resource 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  kind: 'Regular'
  location: location
  name: networkInterfaces_mytestvm498_name
  properties: {
    disableTcpStateTracking: false
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: true
    enableIPForwarding: false
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          primary: true
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_IntLB_VNet_name, 'myBackendSubnet')
          }
        }
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
      }
    ]
    networkSecurityGroup: {
      id: resourceId('Microsoft.Network/networkSecurityGroups', networkSecurityGroups_myNSG_name)
    }
    nicType: 'Standard'
  }
}

resource virtualNetworks_IntLB_VNet_name_resource 'Microsoft.Network/virtualNetworks@2022-05-01' = {
  location: location
  name: virtualNetworks_IntLB_VNet_name
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    enableDdosProtection: false
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
    ]
    virtualNetworkPeerings: []
  }
}

resource networkInterfaces_myVMnic1_name_resource 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  kind: 'Regular'
  location: location
  name: networkInterfaces_myVMnic1_name
  properties: {
    disableTcpStateTracking: false
    dnsSettings: {
      dnsServers: []
    }
    enableIPForwarding: false
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          loadBalancerBackendAddressPools: [
            {
              id: resourceId('Microsoft.Network/loadBalancers/backendAddressPools', loadBalancers_myIntLoadBalancer_name, 'myBackendPool')
            }
          ]
          primary: true
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_IntLB_VNet_name, 'myBackendSubnet')
          }
        }
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
      }
    ]
    networkSecurityGroup: {
      id: resourceId('Microsoft.Network/networkSecurityGroups', networkSecurityGroups_myNSG_name)
    }
    nicType: 'Standard'
  }
}

resource networkInterfaces_myVMnic2_name_resource 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  kind: 'Regular'
  location: location
  name: networkInterfaces_myVMnic2_name
  properties: {
    disableTcpStateTracking: false
    dnsSettings: {
      dnsServers: []
    }
    enableIPForwarding: false
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          loadBalancerBackendAddressPools: [
            {
              id: resourceId('Microsoft.Network/loadBalancers/backendAddressPools', loadBalancers_myIntLoadBalancer_name, 'myBackendPool')
            }
          ]
          primary: true
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_IntLB_VNet_name, 'myBackendSubnet')
          }
        }
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
      }
    ]
    networkSecurityGroup: {
      id: resourceId('Microsoft.Network/networkSecurityGroups', networkSecurityGroups_myNSG_name)
    }
    nicType: 'Standard'
  }
}

resource networkInterfaces_myVMnic3_name_resource 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  kind: 'Regular'
  location: location
  name: networkInterfaces_myVMnic3_name
  properties: {
    disableTcpStateTracking: false
    dnsSettings: {
      dnsServers: []
    }
    enableIPForwarding: false
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          loadBalancerBackendAddressPools: [
            {
              id: resourceId('Microsoft.Network/loadBalancers/backendAddressPools', loadBalancers_myIntLoadBalancer_name, 'myBackendPool')
            }
          ]
          primary: true
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_IntLB_VNet_name, 'myBackendSubnet')
          }
        }
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
      }
    ]
    networkSecurityGroup: {
      id: resourceId('Microsoft.Network/networkSecurityGroups', networkSecurityGroups_myNSG_name)
    }
    nicType: 'Standard'
  }
}
