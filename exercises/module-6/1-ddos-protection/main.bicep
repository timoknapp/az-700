param location string = resourceGroup().location

param adminUser string = 'azureuser'
@secure()
param adminPassword string
param ddosProtectionPlans_MyDdoSProtectionPlan_name string = 'MyDdoSProtectionPlan'
param metricAlerts_MyDdosAlert_name string = 'MyDdosAlert'
param networkInterfaces_myvirtualmachine_nic_name string = 'myvirtualmachine-nic'
param networkSecurityGroups_MyVirtualMachine_nsg_name string = 'MyVirtualMachine-nsg'
param publicIPAddresses_MyPublicIPAddress_name string = 'MyPublicIPAddress'
param virtualMachines_MyVirtualMachine_name string = 'MyVirtualMachine'
param virtualNetworks_MyVirtualNetwork_name string = 'MyVirtualNetwork'

resource ddosProtectionPlans_MyDdoSProtectionPlan_name_resource 'Microsoft.Network/ddosProtectionPlans@2022-05-01' = {
  location: location
  name: ddosProtectionPlans_MyDdoSProtectionPlan_name
  properties: {
  }
}

resource publicIPAddresses_MyPublicIPAddress_name_resource 'Microsoft.Network/publicIPAddresses@2022-05-01' = {
  location: location
  name: publicIPAddresses_MyPublicIPAddress_name
  properties: {
    dnsSettings: {
      domainNameLabel: 'mypublicdnsde2'
      fqdn: 'mypublicdnsde2.westeurope.cloudapp.azure.com'
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

resource virtualMachines_MyVirtualMachine_name_resource 'Microsoft.Compute/virtualMachines@2022-08-01' = {
  location: location
  name: virtualMachines_MyVirtualMachine_name
  properties: {
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
    hardwareProfile: {
      vmSize: 'Standard_B1ls'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_myvirtualmachine_nic_name_resource.id
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
      computerName: virtualMachines_MyVirtualMachine_name
      linuxConfiguration: {
        disablePasswordAuthentication: false
        enableVMAgentPlatformUpdates: false
        patchSettings: {
          assessmentMode: 'ImageDefault'
          patchMode: 'ImageDefault'
        }
        provisionVMAgent: true
      }
      secrets: []
    }
    storageProfile: {
      dataDisks: []
      imageReference: {
        offer: 'UbuntuServer'
        publisher: 'Canonical'
        sku: '18_04-lts-gen2'
        version: 'latest'
      }
      osDisk: {
        caching: 'ReadWrite'
        createOption: 'FromImage'
        deleteOption: 'Delete'
        diskSizeGB: 30
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
        name: '${virtualMachines_MyVirtualMachine_name}_OsDisk_1_d43fc4795cc4442997d8475a1be02231'
        osType: 'Linux'
      }
    }
  }
}

resource metricAlerts_MyDdosAlert_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  location: 'global'
  name: metricAlerts_MyDdosAlert_name
  properties: {
    actions: []
    autoMitigate: true
    criteria: {
      allOf: [
        {
          criterionType: 'StaticThresholdCriterion'
          metricName: 'IfUnderDDoSAttack'
          metricNamespace: 'Microsoft.Network/publicIPAddresses'
          name: 'Metric1'
          operator: 'GreaterThanOrEqual'
          threshold: '1'
          timeAggregation: 'Maximum'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
    enabled: true
    evaluationFrequency: 'PT1M'
    scopes: [
      publicIPAddresses_MyPublicIPAddress_name_resource.id
    ]
    severity: 3
    targetResourceRegion: location
    targetResourceType: 'Microsoft.Network/publicIPAddresses'
    windowSize: 'PT5M'
  }
}

resource networkSecurityGroups_MyVirtualMachine_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2022-05-01' = {
  location: location
  name: networkSecurityGroups_MyVirtualMachine_nsg_name
  properties: {
    securityRules: [
    ]
  }
}

resource virtualNetworks_MyVirtualNetwork_name_resource 'Microsoft.Network/virtualNetworks@2022-05-01' = {
  location: location
  name: virtualNetworks_MyVirtualNetwork_name
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    ddosProtectionPlan: {
      id: ddosProtectionPlans_MyDdoSProtectionPlan_name_resource.id
    }
    enableDdosProtection: true
    subnets: [
      {
        name: 'default'
        properties: {
          addressPrefix: '10.0.0.0/24'
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

resource networkInterfaces_myvirtualmachine_nic_name_resource 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  location: location
  name: networkInterfaces_myvirtualmachine_nic_name
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
          privateIPAddress: '10.0.0.4'
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_MyPublicIPAddress_name_resource.id
          }
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_MyVirtualNetwork_name, 'default')
          }
        }
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
      }
    ]
    networkSecurityGroup: {
      id: networkSecurityGroups_MyVirtualMachine_nsg_name_resource.id
    }
    nicType: 'Standard'
  }
}
