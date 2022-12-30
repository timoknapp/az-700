param location string = resourceGroup().location

param adminUser string = 'TestUser'
@secure()
param adminPassword string

param applicationGateways_ContosoAppGateway_name string = 'ContosoAppGateway'
param networkInterfaces_backendvm1381_name string = 'backendvm1381'
param networkInterfaces_backendvm2380_name string = 'backendvm2380'
param networkSecurityGroups_BackendVM1_nsg_name string = 'BackendVM1_nsg'
param networkSecurityGroups_BackendVM2_nsg_name string = 'BackendVM2_nsg'
param publicIPAddresses_AGPublicIPAddress_name string = 'AGPublicIPAddress'
param virtualMachines_BackendVM1_name string = 'BackendVM1'
param virtualMachines_BackendVM2_name string = 'BackendVM2'
param virtualNetworks_ContosoVNet_name string = 'ContosoVNet'

resource networkSecurityGroups_BackendVM1_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2022-05-01' = {
  location: location
  name: networkSecurityGroups_BackendVM1_nsg_name
  properties: {
    securityRules: []
  }
}

resource networkSecurityGroups_BackendVM2_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2022-05-01' = {
  location: location
  name: networkSecurityGroups_BackendVM2_nsg_name
  properties: {
    securityRules: []
  }
}

resource publicIPAddresses_AGPublicIPAddress_name_resource 'Microsoft.Network/publicIPAddresses@2022-05-01' = {
  location: location
  name: publicIPAddresses_AGPublicIPAddress_name
  properties: {
    idleTimeoutInMinutes: 4
    ipAddress: '172.173.213.66'
    ipTags: []
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
  }
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
}

resource virtualMachines_BackendVM1_name_resource 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  location: location
  name: virtualMachines_BackendVM1_name
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_backendvm1381_name_resource.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    osProfile: {
      adminUsername: adminUser
      adminPassword: adminPassword
      allowExtensionOperations: true
      computerName: virtualMachines_BackendVM1_name
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
        sku: '2022-datacenter-azure-edition'
        version: 'latest'
      }
      osDisk: {
        caching: 'ReadWrite'
        createOption: 'FromImage'
        deleteOption: 'Delete'
        diskSizeGB: 127
        managedDisk: {
          id: resourceId('Microsoft.Compute/disks', '${virtualMachines_BackendVM1_name}_disk1_e9ebcf577a1f4efab6e3c93e55f71249')
          storageAccountType: 'Premium_LRS'
        }
        name: '${virtualMachines_BackendVM1_name}_disk1_e9ebcf577a1f4efab6e3c93e55f71249'
        osType: 'Windows'
      }
    }
  }
}

resource virtualMachines_BackendVM2_name_resource 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  location: location
  name: virtualMachines_BackendVM2_name
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_backendvm2380_name_resource.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    osProfile: {
      adminUsername: adminUser
      adminPassword: adminPassword
      allowExtensionOperations: true
      computerName: virtualMachines_BackendVM2_name
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
        sku: '2022-datacenter-azure-edition'
        version: 'latest'
      }
      osDisk: {
        caching: 'ReadWrite'
        createOption: 'FromImage'
        deleteOption: 'Delete'
        diskSizeGB: 127
        managedDisk: {
          id: resourceId('Microsoft.Compute/disks', '${virtualMachines_BackendVM2_name}_OsDisk_1_9c4bfea6a2564a3ab0a65b39571b4163')
          storageAccountType: 'Premium_LRS'
        }
        name: '${virtualMachines_BackendVM2_name}_OsDisk_1_9c4bfea6a2564a3ab0a65b39571b4163'
        osType: 'Windows'
      }
    }
  }
}

resource virtualMachines_BackendVM1_name_IIS 'Microsoft.Compute/virtualMachines/extensions@2022-08-01' = {
  parent: virtualMachines_BackendVM1_name_resource
  location: location
  name: 'IIS'
  properties: {
    autoUpgradeMinorVersion: true
    protectedSettings: {
    }
    publisher: 'Microsoft.Compute'
    settings: {
      commandToExecute: 'powershell Add-WindowsFeature Web-Server; powershell Add-Content -Path "C:\\inetpub\\wwwroot\\Default.htm" -Value $($env:computername)'
    }
    type: 'CustomScriptExtension'
    typeHandlerVersion: '1.4'
  }
}

resource virtualMachines_BackendVM2_name_IIS 'Microsoft.Compute/virtualMachines/extensions@2022-08-01' = {
  parent: virtualMachines_BackendVM2_name_resource
  location: location
  name: 'IIS'
  properties: {
    autoUpgradeMinorVersion: true
    protectedSettings: {
    }
    publisher: 'Microsoft.Compute'
    settings: {
      commandToExecute: 'powershell Add-WindowsFeature Web-Server; powershell Add-Content -Path "C:\\inetpub\\wwwroot\\Default.htm" -Value $($env:computername)'
    }
    type: 'CustomScriptExtension'
    typeHandlerVersion: '1.4'
  }
}

resource applicationGateways_ContosoAppGateway_name_resource 'Microsoft.Network/applicationGateways@2022-05-01' = {
  location: location
  name: applicationGateways_ContosoAppGateway_name
  properties: {
    autoscaleConfiguration: {
      maxCapacity: 10
      minCapacity: 0
    }
    backendAddressPools: [
      {
        name: 'BackendPool'
        properties: {
          backendAddresses: []
        }
      }
    ]
    backendHttpSettingsCollection: [
      {
        name: 'HTTPSetting'
        properties: {
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress: false
          port: 80
          protocol: 'Http'
          requestTimeout: 20
        }
      }
    ]
    backendSettingsCollection: []
    enableHttp2: false
    frontendIPConfigurations: [
      {
        name: 'appGwPublicFrontendIp'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_AGPublicIPAddress_name_resource.id
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'port_80'
        properties: {
          port: 80
        }
      }
    ]
    gatewayIPConfigurations: [
      {
        name: 'appGatewayIpConfig'
        properties: {
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_ContosoVNet_name, 'AGSubnet')
          }
        }
      }
    ]
    httpListeners: [
      {
        name: 'Listener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', applicationGateways_ContosoAppGateway_name, 'appGwPublicFrontendIp')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', applicationGateways_ContosoAppGateway_name, 'port_80')
          }
          hostNames: []
          protocol: 'Http'
          requireServerNameIndication: false
        }
      }
    ]
    listeners: []
    loadDistributionPolicies: []
    privateLinkConfigurations: []
    probes: []
    redirectConfigurations: []
    requestRoutingRules: [
      {
        name: 'RoutingRule'
        properties: {
          backendAddressPool: {
            id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', applicationGateways_ContosoAppGateway_name, 'BackendPool')
          }
          backendHttpSettings: {
            id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection', applicationGateways_ContosoAppGateway_name, 'HTTPSetting')
          }
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', applicationGateways_ContosoAppGateway_name, 'Listener')
          }
          priority: 100
          ruleType: 'Basic'
        }
      }
    ]
    rewriteRuleSets: []
    routingRules: []
    sku: {
      name: 'Standard_v2'
      tier: 'Standard_v2'
    }
    sslCertificates: []
    sslProfiles: []
    trustedClientCertificates: []
    trustedRootCertificates: []
    urlPathMaps: []
  }
}

resource networkInterfaces_backendvm1381_name_resource 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  location: location
  name: networkInterfaces_backendvm1381_name
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
          applicationGatewayBackendAddressPools: [
            {
              id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', applicationGateways_ContosoAppGateway_name, 'BackendPool')
            }
          ]
          primary: true
          // privateIPAddress: '10.0.1.4'
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_ContosoVNet_name, 'BackendSubnet')
          }
        }
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
      }
    ]
    networkSecurityGroup: {
      id: networkSecurityGroups_BackendVM1_nsg_name_resource.id
    }
    nicType: 'Standard'
  }
  dependsOn: [
    applicationGateways_ContosoAppGateway_name_resource
  ]
}

resource networkInterfaces_backendvm2380_name_resource 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  location: location
  name: networkInterfaces_backendvm2380_name
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
          applicationGatewayBackendAddressPools: [
            {
              id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', applicationGateways_ContosoAppGateway_name, 'BackendPool')
            }
          ]
          primary: true
          // privateIPAddress: '10.0.1.5'
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_ContosoVNet_name, 'BackendSubnet')
          }
        }
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
      }
    ]
    networkSecurityGroup: {
      id: networkSecurityGroups_BackendVM2_nsg_name_resource.id
    }
    nicType: 'Standard'
  }
  dependsOn: [
    applicationGateways_ContosoAppGateway_name_resource
  ]
}

resource virtualNetworks_ContosoVNet_name_resource 'Microsoft.Network/virtualNetworks@2022-05-01' = {
  location: location
  name: virtualNetworks_ContosoVNet_name
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    enableDdosProtection: false
    subnets: [
      {
        name: 'AGSubnet'
        properties: {
          addressPrefix: '10.0.0.0/24'
          applicationGatewayIpConfigurations: [
            {
              id: resourceId('Microsoft.Network/applicationGateways/gatewayIPConfigurations', applicationGateways_ContosoAppGateway_name, 'appGatewayIpConfig')
            }
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'BackendSubnet'
        properties: {
          addressPrefix: '10.0.1.0/24'
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
