param location string = resourceGroup().location

param adminUser string = 'TestUser'
@secure()
param adminPassword string

param networkInterfaces_ContosoPrivate_nic_name string = 'ContosoPrivate-nic'
param networkInterfaces_ContosoPublic_nic_name string = 'ContosoPublic-nic'
param networkSecurityGroups_ContosoPrivateNSG_name string = 'ContosoPrivateNSG'
param networkSecurityGroups_ContosoPrivate_nsg_name string = 'ContosoPrivate-nsg'
param networkSecurityGroups_ContosoPublic_nsg_name string = 'ContosoPublic-nsg'
param publicIPAddresses_ContosoPrivate_ip_name string = 'ContosoPrivate-ip'
param publicIPAddresses_ContosoPublic_ip_name string = 'ContosoPublic-ip'
param storageAccounts_contosostoragewestde_name string = 'contosostoragewestde'
param virtualMachines_ContosoPrivate_name string = 'ContosoPrivate'
param virtualMachines_ContosoPublic_name string = 'ContosoPublic'
param virtualNetworks_CoreServicesVNet_name string = 'CoreServicesVNet'

resource publicIPAddresses_ContosoPrivate_ip_name_resource 'Microsoft.Network/publicIPAddresses@2022-05-01' = {
  location: location
  name: publicIPAddresses_ContosoPrivate_ip_name
  properties: {
    idleTimeoutInMinutes: 4
    ipTags: []
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Dynamic'
  }
  sku: {
    name: 'Basic'
    tier: 'Regional'
  }
}

resource publicIPAddresses_ContosoPublic_ip_name_resource 'Microsoft.Network/publicIPAddresses@2022-05-01' = {
  location: location
  name: publicIPAddresses_ContosoPublic_ip_name
  properties: {
    idleTimeoutInMinutes: 4
    ipTags: []
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Dynamic'
  }
  sku: {
    name: 'Basic'
    tier: 'Regional'
  }
}

resource virtualMachines_ContosoPrivate_name_resource 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  location: location
  name: virtualMachines_ContosoPrivate_name
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS1_v2'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_ContosoPrivate_nic_name_resource.id
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
      computerName: virtualMachines_ContosoPrivate_name
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
        name: '${virtualMachines_ContosoPrivate_name}_OsDisk_1_53b36eb7c9824082892c3130b2869c70'
        osType: 'Windows'
      }
    }
  }
}

resource virtualMachines_ContosoPublic_name_resource 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  location: location
  name: virtualMachines_ContosoPublic_name
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS1_v2'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_ContosoPublic_nic_name_resource.id
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
      computerName: virtualMachines_ContosoPublic_name
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
        name: '${virtualMachines_ContosoPublic_name}_OsDisk_1_b4d7eb34dcdd4f659441fa6a171f9029'
        osType: 'Windows'
      }
    }
  }
}

resource networkSecurityGroups_ContosoPrivate_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2022-05-01' = {
  location: location
  name: networkSecurityGroups_ContosoPrivate_nsg_name
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

resource networkSecurityGroups_ContosoPublic_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2022-05-01' = {
  location: location
  name: networkSecurityGroups_ContosoPublic_nsg_name
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

resource networkSecurityGroups_ContosoPrivateNSG_name_Allow_RDP_All 'Microsoft.Network/networkSecurityGroups/securityRules@2022-05-01' = {
  name: '${networkSecurityGroups_ContosoPrivateNSG_name}/Allow-RDP-All'
  properties: {
    access: 'Allow'
    destinationAddressPrefix: 'VirtualNetwork'
    destinationAddressPrefixes: []
    destinationPortRange: '3389'
    destinationPortRanges: []
    direction: 'Inbound'
    priority: 120
    protocol: '*'
    sourceAddressPrefix: '*'
    sourceAddressPrefixes: []
    sourcePortRange: '*'
    sourcePortRanges: []
  }
  dependsOn: [
    networkSecurityGroups_ContosoPrivateNSG_name_resource
  ]
}

resource networkSecurityGroups_ContosoPrivateNSG_name_Allow_Storage_All 'Microsoft.Network/networkSecurityGroups/securityRules@2022-05-01' = {
  name: '${networkSecurityGroups_ContosoPrivateNSG_name}/Allow-Storage_All'
  properties: {
    access: 'Allow'
    destinationAddressPrefix: 'Storage'
    destinationAddressPrefixes: []
    destinationPortRange: '*'
    destinationPortRanges: []
    direction: 'Outbound'
    priority: 100
    protocol: '*'
    sourceAddressPrefix: 'VirtualNetwork'
    sourceAddressPrefixes: []
    sourcePortRange: '*'
    sourcePortRanges: []
  }
  dependsOn: [
    networkSecurityGroups_ContosoPrivateNSG_name_resource
  ]
}

resource networkSecurityGroups_ContosoPrivate_nsg_name_default_allow_rdp 'Microsoft.Network/networkSecurityGroups/securityRules@2022-05-01' = {
  name: '${networkSecurityGroups_ContosoPrivate_nsg_name}/default-allow-rdp'
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
  dependsOn: [
    networkSecurityGroups_ContosoPrivate_nsg_name_resource
  ]
}

resource networkSecurityGroups_ContosoPublic_nsg_name_default_allow_rdp 'Microsoft.Network/networkSecurityGroups/securityRules@2022-05-01' = {
  name: '${networkSecurityGroups_ContosoPublic_nsg_name}/default-allow-rdp'
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
  dependsOn: [
    networkSecurityGroups_ContosoPublic_nsg_name_resource
  ]
}

resource networkSecurityGroups_ContosoPrivateNSG_name_Deny_Internet_All 'Microsoft.Network/networkSecurityGroups/securityRules@2022-05-01' = {
  name: '${networkSecurityGroups_ContosoPrivateNSG_name}/Deny-Internet-All'
  properties: {
    access: 'Deny'
    destinationAddressPrefix: 'Internet'
    destinationAddressPrefixes: []
    destinationPortRange: '*'
    destinationPortRanges: []
    direction: 'Outbound'
    priority: 110
    protocol: '*'
    sourceAddressPrefix: 'VirtualNetwork'
    sourceAddressPrefixes: []
    sourcePortRange: '*'
    sourcePortRanges: []
  }
  dependsOn: [
    networkSecurityGroups_ContosoPrivateNSG_name_resource
  ]
}

resource storageAccounts_contosostoragewestde_name_resource 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  kind: 'StorageV2'
  location: location
  name: storageAccounts_contosostoragewestde_name
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
    allowSharedKeyAccess: true
    defaultToOAuthAuthentication: false
    dnsEndpointType: 'Standard'
    encryption: {
      keySource: 'Microsoft.Storage'
      requireInfrastructureEncryption: false
      services: {
        blob: {
          enabled: true
          keyType: 'Account'
        }
        file: {
          enabled: true
          keyType: 'Account'
        }
      }
    }
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
      ipRules: []
      resourceAccessRules: []
      virtualNetworkRules: [
        {
          action: 'Allow'
          id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_CoreServicesVNet_name, 'Private')
          state: 'Succeeded'
        }
      ]
    }
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
  }
  sku: {
    name: 'Standard_LRS'
  }
}

resource storageAccounts_contosostoragewestde_name_default 'Microsoft.Storage/storageAccounts/blobServices@2022-05-01' = {
  parent: storageAccounts_contosostoragewestde_name_resource
  name: 'default'
  properties: {
    changeFeed: {
      enabled: false
    }
    containerDeleteRetentionPolicy: {
      days: 7
      enabled: true
    }
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      days: 7
      enabled: true
    }
    isVersioningEnabled: false
    restorePolicy: {
      enabled: false
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_contosostoragewestde_name_default 'Microsoft.Storage/storageAccounts/fileServices@2022-05-01' = {
  parent: storageAccounts_contosostoragewestde_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
    protocolSettings: {
      smb: {
      }
    }
    shareDeleteRetentionPolicy: {
      days: 7
      enabled: true
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_contosostoragewestde_name_default 'Microsoft.Storage/storageAccounts/queueServices@2022-05-01' = {
  parent: storageAccounts_contosostoragewestde_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_contosostoragewestde_name_default 'Microsoft.Storage/storageAccounts/tableServices@2022-05-01' = {
  parent: storageAccounts_contosostoragewestde_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource storageAccounts_contosostoragewestde_name_default_marketing 'Microsoft.Storage/storageAccounts/fileServices/shares@2022-05-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_contosostoragewestde_name_default
  name: 'marketing'
  properties: {
    accessTier: 'TransactionOptimized'
    enabledProtocols: 'SMB'
    shareQuota: 5120
  }
}

resource networkInterfaces_ContosoPrivate_nic_name_resource 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  kind: 'Regular'
  location: location
  name: networkInterfaces_ContosoPrivate_nic_name
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
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_ContosoPrivate_ip_name_resource.id
          }
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_CoreServicesVNet_name, 'Private')
          }
        }
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
      }
    ]
    networkSecurityGroup: {
      id: networkSecurityGroups_ContosoPrivate_nsg_name_resource.id
    }
    nicType: 'Standard'
  }
}

resource networkInterfaces_ContosoPublic_nic_name_resource 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  kind: 'Regular'
  location: location
  name: networkInterfaces_ContosoPublic_nic_name
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
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_ContosoPublic_ip_name_resource.id
          }
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_CoreServicesVNet_name, 'Public')
          }
        }
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
      }
    ]
    networkSecurityGroup: {
      id: networkSecurityGroups_ContosoPublic_nsg_name_resource.id
    }
    nicType: 'Standard'
  }
}

resource networkSecurityGroups_ContosoPrivateNSG_name_resource 'Microsoft.Network/networkSecurityGroups@2022-05-01' = {
  location: location
  name: networkSecurityGroups_ContosoPrivateNSG_name
  properties: {
    securityRules: [
      {
        name: 'Allow-Storage_All'
        properties: {
          access: 'Allow'
          destinationAddressPrefix: 'Storage'
          destinationAddressPrefixes: []
          destinationPortRange: '*'
          destinationPortRanges: []
          direction: 'Outbound'
          priority: 100
          protocol: '*'
          sourceAddressPrefix: 'VirtualNetwork'
          sourceAddressPrefixes: []
          sourcePortRange: '*'
          sourcePortRanges: []
        }
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
      }
      {
        name: 'Deny-Internet-All'
        properties: {
          access: 'Deny'
          destinationAddressPrefix: 'Internet'
          destinationAddressPrefixes: []
          destinationPortRange: '*'
          destinationPortRanges: []
          direction: 'Outbound'
          priority: 110
          protocol: '*'
          sourceAddressPrefix: 'VirtualNetwork'
          sourceAddressPrefixes: []
          sourcePortRange: '*'
          sourcePortRanges: []
        }
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
      }
      {
        name: 'Allow-RDP-All'
        properties: {
          access: 'Allow'
          destinationAddressPrefix: 'VirtualNetwork'
          destinationAddressPrefixes: []
          destinationPortRange: '3389'
          destinationPortRanges: []
          direction: 'Inbound'
          priority: 120
          protocol: '*'
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

resource virtualNetworks_CoreServicesVNet_name_resource 'Microsoft.Network/virtualNetworks@2022-05-01' = {
  location: location
  name: virtualNetworks_CoreServicesVNet_name
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    enableDdosProtection: false
    subnets: [
      {
        name: 'Public'
        properties: {
          addressPrefix: '10.0.0.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'Private'
        properties: {
          addressPrefix: '10.0.1.0/24'
          delegations: []
          networkSecurityGroup: {
            id: networkSecurityGroups_ContosoPrivateNSG_name_resource.id
          }
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          serviceEndpoints: [
            {
              locations: [
                location
                'westus'
              ]
              service: 'Microsoft.Storage'
            }
          ]
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: []
  }
}
