param location string = resourceGroup().location
param locationWestUS string = 'westus'

param adminUsername string = 'TestUser'
@secure()
param adminPassword string

param bastionHosts_myBastion_name string = 'myBastion'
param networkInterfaces_myNicVM_name string = 'myNicVM'
param networkInterfaces_myPrivateEndpoint_nic_9cf2302b_0b3c_4e92_943a_51340949cb00_name string = 'myPrivateEndpoint-nic-9cf2302b-0b3c-4e92-943a-51340949cb00'
param privateDnsZones_privatelink_azurewebsites_net_name string = 'privatelink.azurewebsites.net'
param privateEndpoints_myPrivateEndpoint_name string = 'myPrivateEndpoint'
param publicIPAddresses_myBastionIP_name string = 'myBastionIP'
param serverfarms_AppServicePlan_20230105_tkmsft_name string = 'AppServicePlan-20230105-tkmsft'
param sites_20230105_tkmsft_name string = '20230105-tkmsft'
param storageAccounts_playgcreatemyvm010517270_name string = 'playgcreatemyvm010517270'
param virtualMachines_myVM_name string = 'myVM'
param virtualNetworks_MyVNet_name string = 'MyVNet'

resource privateDnsZones_privatelink_azurewebsites_net_name_resource 'Microsoft.Network/privateDnsZones@2018-09-01' = {
  location: 'global'
  name: privateDnsZones_privatelink_azurewebsites_net_name
  properties: {
    // maxNumberOfRecordSets: 25000
    // maxNumberOfVirtualNetworkLinks: 1000
    // maxNumberOfVirtualNetworkLinksWithRegistration: 100
    // numberOfRecordSets: 3
    // numberOfVirtualNetworkLinks: 1
    // numberOfVirtualNetworkLinksWithRegistration: 0
    // provisioningState: 'Succeeded'
  }
}

resource publicIPAddresses_myBastionIP_name_resource 'Microsoft.Network/publicIPAddresses@2022-05-01' = {
  location: location
  name: publicIPAddresses_myBastionIP_name
  properties: {
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
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

resource storageAccounts_playgcreatemyvm010517270_name_resource 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  kind: 'StorageV2'
  location: location
  name: storageAccounts_playgcreatemyvm010517270_name
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    encryption: {
      keySource: 'Microsoft.Storage'
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
    minimumTlsVersion: 'TLS1_0'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
      virtualNetworkRules: []
    }
    supportsHttpsTrafficOnly: true
  }
  sku: {
    name: 'Standard_GRS'
  }
}

resource serverfarms_AppServicePlan_20230105_tkmsft_name_resource 'Microsoft.Web/serverfarms@2022-03-01' = {
  kind: 'app'
  location: locationWestUS
  name: serverfarms_AppServicePlan_20230105_tkmsft_name
  properties: {
    elasticScaleEnabled: false
    hyperV: false
    isSpot: false
    isXenon: false
    maximumElasticWorkerCount: 1
    perSiteScaling: false
    reserved: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
    zoneRedundant: false
  }
  sku: {
    capacity: 1
    family: 'Pv2'
    name: 'P1v2'
    size: 'P1v2'
    tier: 'PremiumV2'
  }
}

resource virtualMachines_myVM_name_BGInfo 'Microsoft.Compute/virtualMachines/extensions@2022-08-01' = {
  parent: virtualMachines_myVM_name_resource
  location: location
  name: 'BGInfo'
  properties: {
    autoUpgradeMinorVersion: true
    publisher: 'Microsoft.Compute'
    type: 'BGInfo'
    typeHandlerVersion: '2.2'
  }
}

resource networkInterfaces_myNicVM_name_resource 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  kind: 'Regular'
  location: location
  name: networkInterfaces_myNicVM_name
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
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_MyVNet_name, 'myBackendSubnet')
          }
        }
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
      }
    ]
    nicType: 'Standard'
  }
}

resource networkInterfaces_myPrivateEndpoint_nic_9cf2302b_0b3c_4e92_943a_51340949cb00_name_resource 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  kind: 'Regular'
  location: location
  name: networkInterfaces_myPrivateEndpoint_nic_9cf2302b_0b3c_4e92_943a_51340949cb00_name
  properties: {
    disableTcpStateTracking: false
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    ipConfigurations: [
      {
        name: 'privateEndpointIpConfig.8891a22d-c35c-4d83-8c96-8cbc9f41e393'
        properties: {
          primary: true
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_MyVNet_name, 'myBackendSubnet')
          }
        }
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
      }
    ]
    nicType: 'Standard'
  }
}

resource privateDnsZones_privatelink_azurewebsites_net_name_20230105_tkmsft 'Microsoft.Network/privateDnsZones/A@2018-09-01' = {
  parent: privateDnsZones_privatelink_azurewebsites_net_name_resource
  name: '20230105-tkmsft'
  properties: {
    aRecords: [
      {
        ipv4Address: '10.0.0.5'
      }
    ]
    metadata: {
      creator: 'created by private endpoint myPrivateEndpoint with resource guid 44bb38e4-8ae1-480f-a3a1-b417ccad2c72'
    }
    ttl: 10
  }
}

resource privateDnsZones_privatelink_azurewebsites_net_name_20230105_tkmsft_scm 'Microsoft.Network/privateDnsZones/A@2018-09-01' = {
  parent: privateDnsZones_privatelink_azurewebsites_net_name_resource
  name: '20230105-tkmsft.scm'
  properties: {
    aRecords: [
      {
        ipv4Address: '10.0.0.5'
      }
    ]
    metadata: {
      creator: 'created by private endpoint myPrivateEndpoint with resource guid 44bb38e4-8ae1-480f-a3a1-b417ccad2c72'
    }
    ttl: 10
  }
}

resource Microsoft_Network_privateDnsZones_SOA_privateDnsZones_privatelink_azurewebsites_net_name 'Microsoft.Network/privateDnsZones/SOA@2018-09-01' = {
  parent: privateDnsZones_privatelink_azurewebsites_net_name_resource
  name: '@'
  properties: {
    soaRecord: {
      email: 'azureprivatedns-host.microsoft.com'
      expireTime: 2419200
      host: 'azureprivatedns.net'
      minimumTtl: 10
      refreshTime: 3600
      retryTime: 300
      serialNumber: 1
    }
    ttl: 3600
  }
}

resource storageAccounts_playgcreatemyvm010517270_name_default 'Microsoft.Storage/storageAccounts/blobServices@2022-05-01' = {
  parent: storageAccounts_playgcreatemyvm010517270_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: false
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_playgcreatemyvm010517270_name_default 'Microsoft.Storage/storageAccounts/fileServices@2022-05-01' = {
  parent: storageAccounts_playgcreatemyvm010517270_name_resource
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

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_playgcreatemyvm010517270_name_default 'Microsoft.Storage/storageAccounts/queueServices@2022-05-01' = {
  parent: storageAccounts_playgcreatemyvm010517270_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_playgcreatemyvm010517270_name_default 'Microsoft.Storage/storageAccounts/tableServices@2022-05-01' = {
  parent: storageAccounts_playgcreatemyvm010517270_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource sites_20230105_tkmsft_name_resource 'Microsoft.Web/sites@2022-03-01' = {
  kind: 'app'
  location: locationWestUS
  name: sites_20230105_tkmsft_name
  properties: {
    clientAffinityEnabled: true
    clientCertEnabled: false
    clientCertMode: 'Required'
    containerSize: 0
    customDomainVerificationId: 'B12F785B29ADF4BB8566BF211C4D6EE45491ED65AEC774CD4EFBEFF0D9C3927A'
    dailyMemoryTimeQuota: 0
    enabled: true
    hostNameSslStates: [
      {
        hostType: 'Standard'
        name: '${sites_20230105_tkmsft_name}.azurewebsites.net'
        sslState: 'Disabled'
      }
      {
        hostType: 'Repository'
        name: '${sites_20230105_tkmsft_name}.scm.azurewebsites.net'
        sslState: 'Disabled'
      }
    ]
    hostNamesDisabled: false
    httpsOnly: false
    hyperV: false
    isXenon: false
    keyVaultReferenceIdentity: 'SystemAssigned'
    redundancyMode: 'None'
    reserved: false
    scmSiteAlsoStopped: false
    serverFarmId: serverfarms_AppServicePlan_20230105_tkmsft_name_resource.id
    siteConfig: {
      acrUseManagedIdentityCreds: false
      alwaysOn: false
      functionAppScaleLimit: 0
      http20Enabled: false
      minimumElasticInstanceCount: 0
      numberOfWorkers: 1
    }
    storageAccountRequired: false
    vnetContentShareEnabled: false
    vnetImagePullEnabled: false
    vnetRouteAllEnabled: false
  }
}

resource sites_20230105_tkmsft_name_ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2022-03-01' = {
  parent: sites_20230105_tkmsft_name_resource
  location: locationWestUS
  name: 'ftp'
  properties: {
    allow: true
  }
}

resource sites_20230105_tkmsft_name_scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2022-03-01' = {
  parent: sites_20230105_tkmsft_name_resource
  location: locationWestUS
  name: 'scm'
  properties: {
    allow: true
  }
}

resource sites_20230105_tkmsft_name_web 'Microsoft.Web/sites/config@2022-03-01' = {
  parent: sites_20230105_tkmsft_name_resource
  location: locationWestUS
  name: 'web'
  properties: {
    acrUseManagedIdentityCreds: false
    alwaysOn: false
    autoHealEnabled: false
    azureStorageAccounts: {
    }
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'Default.asp'
      'index.htm'
      'index.html'
      'iisstart.htm'
      'default.aspx'
      'index.php'
      'hostingstart.html'
    ]
    detailedErrorLoggingEnabled: false
    experiments: {
      rampUpRules: []
    }
    ftpsState: 'AllAllowed'
    functionsRuntimeScaleMonitoringEnabled: false
    http20Enabled: false
    httpLoggingEnabled: false
    ipSecurityRestrictions: [
      {
        action: 'Allow'
        description: 'Allow all access'
        ipAddress: 'Any'
        name: 'Allow all'
        priority: 2147483647
      }
    ]
    loadBalancing: 'LeastRequests'
    localMySqlEnabled: false
    logsDirectorySizeLimit: 35
    managedPipelineMode: 'Integrated'
    minTlsVersion: '1.2'
    minimumElasticInstanceCount: 0
    netFrameworkVersion: 'v4.0'
    numberOfWorkers: 1
    phpVersion: '5.6'
    preWarmedInstanceCount: 0
    publishingUsername: '$20230105-tkmsft'
    remoteDebuggingEnabled: false
    requestTracingEnabled: false
    scmIpSecurityRestrictions: [
      {
        action: 'Allow'
        description: 'Allow all access'
        ipAddress: 'Any'
        name: 'Allow all'
        priority: 2147483647
      }
    ]
    scmIpSecurityRestrictionsUseMain: false
    scmMinTlsVersion: '1.2'
    scmType: 'None'
    use32BitWorkerProcess: true
    virtualApplications: [
      {
        physicalPath: 'site\\wwwroot'
        preloadEnabled: false
        virtualPath: '/'
      }
    ]
    vnetPrivatePortsCount: 0
    vnetRouteAllEnabled: false
    webSocketsEnabled: false
  }
}

resource sites_20230105_tkmsft_name_sites_20230105_tkmsft_name_azurewebsites_net 'Microsoft.Web/sites/hostNameBindings@2022-03-01' = {
  parent: sites_20230105_tkmsft_name_resource
  location: locationWestUS
  name: '${sites_20230105_tkmsft_name}.azurewebsites.net'
  properties: {
    hostNameType: 'Verified'
    siteName: '20230105-tkmsft'
  }
}

resource sites_20230105_tkmsft_name_myConnection_442931a6_80ab_4307_814a_757f19b02b62 'Microsoft.Web/sites/privateEndpointConnections@2022-03-01' = {
  parent: sites_20230105_tkmsft_name_resource
  location: locationWestUS
  name: 'myConnection-442931a6-80ab-4307-814a-757f19b02b62'
  properties: {
    privateLinkServiceConnectionState: {
      actionsRequired: 'None'
      status: 'Approved'
    }
  }
}

resource virtualMachines_myVM_name_resource 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  location: location
  name: virtualMachines_myVM_name
  properties: {
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: 'https://${storageAccounts_playgcreatemyvm010517270_name}.blob.core.windows.net/'
      }
    }
    hardwareProfile: {
      vmSize: 'Standard_DS1_v2'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_myNicVM_name_resource.id
        }
      ]
    }
    osProfile: {
      adminUsername: adminUsername
      adminPassword: adminPassword
      allowExtensionOperations: true
      computerName: virtualMachines_myVM_name
      requireGuestProvisionSignal: true
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
        name: '${virtualMachines_myVM_name}_disk1_dba592b92fc04e2099c886ae0dec7895'
        osType: 'Windows'
      }
    }
  }
  dependsOn: [

    storageAccounts_playgcreatemyvm010517270_name_resource
  ]
}

resource bastionHosts_myBastion_name_resource 'Microsoft.Network/bastionHosts@2022-05-01' = {
  location: location
  name: bastionHosts_myBastion_name
  properties: {
    dnsName: 'bst-7c55ad8b-de88-4066-bf17-48164701ac70.bastion.azure.com'
    ipConfigurations: [
      {
        name: 'IpConf'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_myBastionIP_name_resource.id
          }
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_MyVNet_name, 'AzureBastionSubnet')
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

resource privateDnsZones_privatelink_azurewebsites_net_name_mylink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2018-09-01' = {
  parent: privateDnsZones_privatelink_azurewebsites_net_name_resource
  location: 'global'
  name: 'mylink'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: resourceId('Microsoft.Network/virtualNetworks', virtualNetworks_MyVNet_name)
    }
  }
}

resource privateEndpoints_myPrivateEndpoint_name_resource 'Microsoft.Network/privateEndpoints@2022-05-01' = {
  location: location
  name: privateEndpoints_myPrivateEndpoint_name
  properties: {
    customDnsConfigs: []
    ipConfigurations: []
    manualPrivateLinkServiceConnections: []
    privateLinkServiceConnections: [
      {
        name: 'myConnection'
        properties: {
          groupIds: [
            'sites'
          ]
          privateLinkServiceConnectionState: {
            actionsRequired: 'None'
            status: 'Approved'
          }
          privateLinkServiceId: sites_20230105_tkmsft_name_resource.id
        }
      }
    ]
    subnet: {
      id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_MyVNet_name, 'myBackendSubnet')
    }
  }
}

resource privateEndpoints_myPrivateEndpoint_name_myZoneGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2022-05-01' = {
  name: '${privateEndpoints_myPrivateEndpoint_name}/myZoneGroup'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'privatelink.Azurewebsites.net'
        properties: {
          privateDnsZoneId: privateDnsZones_privatelink_azurewebsites_net_name_resource.id
        }
      }
    ]
  }
  dependsOn: [
    privateEndpoints_myPrivateEndpoint_name_resource

  ]
}

resource virtualNetworks_MyVNet_name_resource 'Microsoft.Network/virtualNetworks@2022-05-01' = {
  location: location
  name: virtualNetworks_MyVNet_name
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
        name: 'myBackendSubnet'
        properties: {
          addressPrefix: '10.0.0.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          serviceEndpoints: []
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'AzureBastionSubnet'
        properties: {
          addressPrefix: '10.0.1.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          serviceEndpoints: []
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: []
  }
}

resource storageAccounts_playgcreatemyvm010517270_name_default_bootdiagnostics_myvm_39fdcd0b_d398_4ada_b957_33c9fa5f6e58 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
  parent: storageAccounts_playgcreatemyvm010517270_name_default
  name: 'bootdiagnostics-myvm-39fdcd0b-d398-4ada-b957-33c9fa5f6e58'
  properties: {
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    immutableStorageWithVersioning: {
      enabled: false
    }
    publicAccess: 'None'
  }
}
