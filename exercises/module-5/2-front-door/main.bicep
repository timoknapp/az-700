param locationCUS string = resourceGroup().location
param locationEUS string = 'eastus'

param profiles_FrontDoor_name string = 'FrontDoor'
param serverfarms_myAppServicePlanCentralUS_name string = 'myAppServicePlanCentralUS'
param serverfarms_myAppServicePlanEastUS_name string = 'myAppServicePlanEastUS'
param sites_WebAppContoso_1_cus_name string = 'WebAppContoso-1-cus-${uniqueString('cus')}'
param sites_WebAppContoso_2_eus_name string = 'WebAppContoso-2-eus-${uniqueString('eus')}'

resource profiles_FrontDoor_name_resource 'Microsoft.Cdn/profiles@2022-05-01-preview' = {
  kind: 'frontdoor'
  location: 'Global'
  name: profiles_FrontDoor_name
  properties: {
    extendedProperties: {
    }
    originResponseTimeoutSeconds: 60
  }
  sku: {
    name: 'Standard_AzureFrontDoor'
  }
}

resource serverfarms_myAppServicePlanCentralUS_name_resource 'Microsoft.Web/serverfarms@2022-03-01' = {
  kind: 'app'
  location: locationCUS
  name: serverfarms_myAppServicePlanCentralUS_name
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
    family: 'S'
    name: 'S1'
    size: 'S1'
    tier: 'Standard'
  }
}

resource serverfarms_myAppServicePlanEastUS_name_resource 'Microsoft.Web/serverfarms@2022-03-01' = {
  kind: 'app'
  location: locationEUS
  name: serverfarms_myAppServicePlanEastUS_name
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
    family: 'S'
    name: 'S1'
    size: 'S1'
    tier: 'Standard'
  }
}

resource profiles_FrontDoor_name_contoso_frontend_1 'Microsoft.Cdn/profiles/afdendpoints@2022-05-01-preview' = {
  parent: profiles_FrontDoor_name_resource
  location: 'Global'
  name: 'contoso-frontend-911'
  properties: {
    enabledState: 'Enabled'
  }
}

resource profiles_FrontDoor_name_default_origin_group 'Microsoft.Cdn/profiles/origingroups@2022-05-01-preview' = {
  parent: profiles_FrontDoor_name_resource
  name: 'backendPools'
  properties: {
    healthProbeSettings: {
      probeIntervalInSeconds: 100
      probePath: '/'
      probeProtocol: 'Http'
      probeRequestType: 'HEAD'
    }
    loadBalancingSettings: {
      additionalLatencyInMilliseconds: 50
      sampleSize: 4
      successfulSamplesRequired: 3
    }
    sessionAffinityState: 'Disabled'
  }
}

resource sites_WebAppContoso_1_cus_name_resource 'Microsoft.Web/sites@2022-03-01' = {
  kind: 'app'
  location: locationCUS
  name: sites_WebAppContoso_1_cus_name
  properties: {
    clientAffinityEnabled: true
    clientCertEnabled: false
    clientCertMode: 'Required'
    containerSize: 0
    dailyMemoryTimeQuota: 0
    enabled: true
    hostNameSslStates: [
      {
        hostType: 'Standard'
        name: '${sites_WebAppContoso_1_cus_name}.azurewebsites.net'
        sslState: 'Disabled'
      }
      {
        hostType: 'Repository'
        name: '${sites_WebAppContoso_1_cus_name}.scm.azurewebsites.net'
        sslState: 'Disabled'
      }
    ]
    hostNamesDisabled: false
    httpsOnly: true
    hyperV: false
    isXenon: false
    keyVaultReferenceIdentity: 'SystemAssigned'
    redundancyMode: 'None'
    reserved: false
    scmSiteAlsoStopped: false
    serverFarmId: serverfarms_myAppServicePlanCentralUS_name_resource.id
    siteConfig: {
      acrUseManagedIdentityCreds: false
      alwaysOn: true
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

resource sites_WebAppContoso_2_eus_name_resource 'Microsoft.Web/sites@2022-03-01' = {
  kind: 'app'
  location: locationEUS
  name: sites_WebAppContoso_2_eus_name
  properties: {
    clientAffinityEnabled: true
    clientCertEnabled: false
    clientCertMode: 'Required'
    containerSize: 0
    dailyMemoryTimeQuota: 0
    enabled: true
    hostNameSslStates: [
      {
        hostType: 'Standard'
        name: '${sites_WebAppContoso_2_eus_name}.azurewebsites.net'
        sslState: 'Disabled'
      }
      {
        hostType: 'Repository'
        name: '${sites_WebAppContoso_2_eus_name}.scm.azurewebsites.net'
        sslState: 'Disabled'
      }
    ]
    hostNamesDisabled: false
    httpsOnly: true
    hyperV: false
    isXenon: false
    keyVaultReferenceIdentity: 'SystemAssigned'
    redundancyMode: 'None'
    reserved: false
    scmSiteAlsoStopped: false
    serverFarmId: serverfarms_myAppServicePlanEastUS_name_resource.id
    siteConfig: {
      acrUseManagedIdentityCreds: false
      alwaysOn: true
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

resource sites_WebAppContoso_1_cus_name_ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2022-03-01' = {
  parent: sites_WebAppContoso_1_cus_name_resource
  location: locationCUS
  name: 'ftp'
  properties: {
    allow: true
  }
}

resource sites_WebAppContoso_2_eus_name_ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2022-03-01' = {
  parent: sites_WebAppContoso_2_eus_name_resource
  location: locationEUS
  name: 'ftp'
  properties: {
    allow: true
  }
}

resource sites_WebAppContoso_1_cus_name_scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2022-03-01' = {
  parent: sites_WebAppContoso_1_cus_name_resource
  location: locationCUS
  name: 'scm'
  properties: {
    allow: true
  }
}

resource sites_WebAppContoso_2_eus_name_scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2022-03-01' = {
  parent: sites_WebAppContoso_2_eus_name_resource
  location: locationEUS
  name: 'scm'
  properties: {
    allow: true
  }
}

resource sites_WebAppContoso_1_cus_name_web 'Microsoft.Web/sites/config@2022-03-01' = {
  parent: sites_WebAppContoso_1_cus_name_resource
  location: locationCUS
  name: 'web'
  properties: {
    acrUseManagedIdentityCreds: false
    alwaysOn: true
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
    ftpsState: 'FtpsOnly'
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
    netFrameworkVersion: 'v6.0'
    numberOfWorkers: 1
    preWarmedInstanceCount: 0
    publishingUsername: '$WebAppContoso-1-cus'
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
        preloadEnabled: true
        virtualPath: '/'
      }
    ]
    vnetPrivatePortsCount: 0
    vnetRouteAllEnabled: false
    webSocketsEnabled: false
  }
}

resource sites_WebAppContoso_2_eus_name_web 'Microsoft.Web/sites/config@2022-03-01' = {
  parent: sites_WebAppContoso_2_eus_name_resource
  location: locationEUS
  name: 'web'
  properties: {
    acrUseManagedIdentityCreds: false
    alwaysOn: true
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
    ftpsState: 'FtpsOnly'
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
    netFrameworkVersion: 'v6.0'
    numberOfWorkers: 1
    preWarmedInstanceCount: 0
    publishingUsername: '$WebAppContoso-2-eus'
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
        preloadEnabled: true
        virtualPath: '/'
      }
    ]
    vnetPrivatePortsCount: 0
    vnetRouteAllEnabled: false
    webSocketsEnabled: false
  }
}

resource profiles_FrontDoor_name_default_origin_group_default_origin 'Microsoft.Cdn/profiles/origingroups/origins@2022-05-01-preview' = {
  parent: profiles_FrontDoor_name_default_origin_group
  name: 'WebAppContoso-1'
  properties: {
    enabledState: 'Enabled'
    enforceCertificateNameCheck: true
    hostName: '${sites_WebAppContoso_1_cus_name}.azurewebsites.net'
    httpPort: 80
    httpsPort: 443
    originHostHeader: '${sites_WebAppContoso_1_cus_name}.azurewebsites.net'
    priority: 1
    weight: 1000
  }
}

resource profiles_FrontDoor_name_default_origin_group_WebAppContoso_2 'Microsoft.Cdn/profiles/origingroups/origins@2022-05-01-preview' = {
  parent: profiles_FrontDoor_name_default_origin_group
  name: 'WebAppContoso-2'
  properties: {
    enabledState: 'Enabled'
    enforceCertificateNameCheck: true
    hostName: '${sites_WebAppContoso_2_eus_name}.azurewebsites.net'
    httpPort: 80
    httpsPort: 443
    originHostHeader: '${sites_WebAppContoso_2_eus_name}.azurewebsites.net'
    priority: 1
    weight: 1000
  }
}

resource profiles_FrontDoor_name_contoso_frontend_1_default_route 'Microsoft.Cdn/profiles/afdendpoints/routes@2022-05-01-preview' = {
  parent: profiles_FrontDoor_name_contoso_frontend_1
  name: 'default-route'
  properties: {
    customDomains: []
    enabledState: 'Enabled'
    forwardingProtocol: 'MatchRequest'
    httpsRedirect: 'Enabled'
    linkToDefaultDomain: 'Enabled'
    originGroup: {
      id: profiles_FrontDoor_name_default_origin_group.id
    }
    patternsToMatch: [
      '/*'
    ]
    ruleSets: []
    supportedProtocols: [
      'Http'
      'Https'
    ]
  }
}
