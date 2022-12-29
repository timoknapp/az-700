param location string = resourceGroup().location

param serverfarms_ContosoAppServicePlanEastUS_name string = 'ContosoAppServicePlanEastUS'
param sites_ContosoWebAppEastUSDE_name string = 'ContosoWebAppEastUSDE'
param sites_ContosoWebAppWestEuropeDE_externalid string = 'ContosoWebAppWestEuropeDE'
param trafficManagerProfiles_Contoso_TMProfileDE_name string = 'Contoso-TMProfileDE'
#disable-next-line no-hardcoded-env-urls
param trafficManagerHostname string = 'contoso-tmprofilede.trafficmanager.net'

resource serverfarms_ContosoAppServicePlanEastUS_name_resource 'Microsoft.Web/serverfarms@2022-03-01' = {
  kind: 'app'
  location: location
  name: serverfarms_ContosoAppServicePlanEastUS_name
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

resource trafficManagerProfiles_Contoso_TMProfileDE_name_resource 'Microsoft.Network/trafficManagerProfiles@2018-04-01' = {
  location: 'global'
  name: trafficManagerProfiles_Contoso_TMProfileDE_name
  properties: {
    dnsConfig: {
      relativeName: 'contoso-tmprofilede'
      ttl: 60
    }
    endpoints: [
      {
        name: 'myPrimaryEndpoint'
        properties: {
          endpointLocation: location
          endpointMonitorStatus: 'Online'
          endpointStatus: 'Enabled'
          priority: 1
          target: 'contosowebappeastusde.azurewebsites.net'
          targetResourceId: sites_ContosoWebAppEastUSDE_name_resource.id
          weight: 1
        }
        type: 'Microsoft.Network/trafficManagerProfiles/azureEndpoints'
      }
      {
        name: 'myFailoverEndpoint'
        properties: {
          customHeaders: []
          endpointLocation: 'West Europe'
          endpointMonitorStatus: 'Online'
          endpointStatus: 'Enabled'
          priority: 2
          subnets: []
          target: 'contosowebappwesteuropede.azurewebsites.net'
          targetResourceId: resourceId('Contoso-RG-TM2', 'Microsoft.Web/sites', sites_ContosoWebAppWestEuropeDE_externalid)
          weight: 1
        }
        type: 'Microsoft.Network/trafficManagerProfiles/azureEndpoints'
      }
    ]
    monitorConfig: {
      customHeaders: []
      expectedStatusCodeRanges: []
      intervalInSeconds: 30
      path: '/'
      port: 443
      profileMonitorStatus: 'Online'
      protocol: 'HTTPS'
      timeoutInSeconds: 10
      toleratedNumberOfFailures: 3
    }
    profileStatus: 'Enabled'
    trafficRoutingMethod: 'Priority'
    trafficViewEnrollmentStatus: 'Enabled'
  }
}

resource sites_ContosoWebAppEastUSDE_name_resource 'Microsoft.Web/sites@2022-03-01' = {
  kind: 'app'
  location: location
  name: sites_ContosoWebAppEastUSDE_name
  properties: {
    clientAffinityEnabled: true
    clientCertEnabled: false
    clientCertMode: 'Required'
    containerSize: 0
    // customDomainVerificationId: 'B12F785B29ADF4BB8566BF211C4D6EE45491ED65AEC774CD4EFBEFF0D9C3927A'
    dailyMemoryTimeQuota: 0
    enabled: true
    hostNameSslStates: [
      {
        hostType: 'Standard'
        name: 'contoso-tmprofilede.trafficmanager.net'
        sslState: 'Disabled'
      }
      {
        hostType: 'Standard'
        name: 'contosowebappeastusde.azurewebsites.net'
        sslState: 'Disabled'
      }
      {
        hostType: 'Repository'
        name: 'contosowebappeastusde.scm.azurewebsites.net'
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
    serverFarmId: serverfarms_ContosoAppServicePlanEastUS_name_resource.id
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

resource sites_ContosoWebAppEastUSDE_name_ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2022-03-01' = {
  parent: sites_ContosoWebAppEastUSDE_name_resource
  location: location
  name: 'ftp'
  properties: {
    allow: true
  }
}

resource sites_ContosoWebAppEastUSDE_name_scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2022-03-01' = {
  parent: sites_ContosoWebAppEastUSDE_name_resource
  location: location
  name: 'scm'
  properties: {
    allow: true
  }
}

resource sites_ContosoWebAppEastUSDE_name_web 'Microsoft.Web/sites/config@2022-03-01' = {
  parent: sites_ContosoWebAppEastUSDE_name_resource
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
    netFrameworkVersion: 'v4.0'
    numberOfWorkers: 1
    preWarmedInstanceCount: 0
    publishingUsername: '$ContosoWebAppEastUSDE'
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

// resource sites_ContosoWebAppEastUSDE_name_contoso_tmprofilede_trafficmanager_net 'Microsoft.Web/sites/hostNameBindings@2022-03-01' = {
//   parent: sites_ContosoWebAppEastUSDE_name_resource
//   name: trafficManagerHostname
//   properties: {
//     hostNameType: 'Verified'
//     siteName: 'ContosoWebAppEastUSDE'
//   }
// }

// resource sites_ContosoWebAppEastUSDE_name_sites_ContosoWebAppEastUSDE_name_azurewebsites_net 'Microsoft.Web/sites/hostNameBindings@2022-03-01' = {
//   parent: sites_ContosoWebAppEastUSDE_name_resource
//   name: '${sites_ContosoWebAppEastUSDE_name}.azurewebsites.net'
//   properties: {
//     hostNameType: 'Verified'
//     siteName: 'ContosoWebAppEastUSDE'
//   }
// }

// resource sites_ContosoWebAppEastUSDE_name_2022_12_29T14_16_25_9190643 'Microsoft.Web/sites/snapshots@2015-08-01' = {
//   parent: sites_ContosoWebAppEastUSDE_name_resource
//   name: '2022-12-29T14_16_25_9190643'
// }
