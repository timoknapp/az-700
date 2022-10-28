param location string = resourceGroup().location

@description('Name of VM1')
param vmName1 string = 'vm-testvm-1'

@description('Name of NIC1')
param nicName1 string = 'nic-1-testvm-1'

@description('Name of VM2')
param vmName2 string = 'vm-testvm-2'

@description('Name of NIC2')
param nicName2 string = 'nic-1-testvm-2'

@description('Virtual machine size')
param vmSize string = 'Standard_D2s_v3'

@description('Admin username')
param adminUsername string = 'TestUser'

@description('Admin password')
@secure()
param adminPassword string

var coreVirtualNetworkName = 'vnet-coreservices'
var manufacturingVirtualNetworkName = 'vnet-manufacturing'
var researchVirtualNetworkName = 'vnet-research'
var virtualNetworks_CoreServicesVnet_externalid = resourceId('Microsoft.Network/virtualNetworks', coreVirtualNetworkName)
var virtualNetworks_ManufacturingVnet_externalid = resourceId('Microsoft.Network/virtualNetworks', manufacturingVirtualNetworkName)
var virtualNetworks_ResearchVnet_externalid = resourceId('Microsoft.Network/virtualNetworks', researchVirtualNetworkName)
var nsgName1 = 'nsg-testvm-1'
var nsgName2 = 'nsg-testvm-2'
var PIPName1 = 'pip-testvm-1'
var PIPName2 = 'pip-testvm-2'
var subnetNameCoreDatabase = 'snet-database'
var subnetRefCoreDatabase = resourceId('Microsoft.Network/virtualNetworks/subnets', coreVirtualNetworkName, subnetNameCoreDatabase)

resource privateDnsZones_contoso_com_name_resource 'Microsoft.Network/privateDnsZones@2018-09-01' = {
  name: 'contoso.com'
  location: 'global'
}

resource privateDnsZones_contoso_com_name_coreservicesvnetlink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2018-09-01' = {
  parent: privateDnsZones_contoso_com_name_resource
  name: 'coreservicesvnetlink'
  location: 'global'
  properties: {
    registrationEnabled: true
    virtualNetwork: {
      id: virtualNetworks_CoreServicesVnet_externalid
    }
  }
}

resource privateDnsZones_contoso_com_name_manufacturingvnetlink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2018-09-01' = {
  parent: privateDnsZones_contoso_com_name_resource
  name: 'manufacturingvnetlink'
  location: 'global'
  properties: {
    registrationEnabled: true
    virtualNetwork: {
      id: virtualNetworks_ManufacturingVnet_externalid
    }
  }
}

resource privateDnsZones_contoso_com_name_researchvnetlink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2018-09-01' = {
  parent: privateDnsZones_contoso_com_name_resource
  name: 'researchvnetlink'
  location: 'global'
  properties: {
    registrationEnabled: true
    virtualNetwork: {
      id: virtualNetworks_ResearchVnet_externalid
    }
  }
}

resource vm1 'Microsoft.Compute/virtualMachines@2018-06-01' = {
  name: vmName1
  location: location
  properties: {
    osProfile: {
      computerName: vmName1
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        provisionVMAgent: true
      }
    }
    hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        createOption: 'fromImage'
      }
      dataDisks: []
    }
    networkProfile: {
      networkInterfaces: [
        {
          properties: {
            primary: true
          }
          id: nic1.id
        }
      ]
    }
  }
  dependsOn: [
    privateDnsZones_contoso_com_name_resource
    privateDnsZones_contoso_com_name_coreservicesvnetlink
    privateDnsZones_contoso_com_name_manufacturingvnetlink
    privateDnsZones_contoso_com_name_researchvnetlink
  ]
}

resource nic1 'Microsoft.Network/networkInterfaces@2018-08-01' = {
  name: nicName1
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnetRefCoreDatabase
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: PIP1.id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nsg1.id
    }
  }
}

resource nsg1 'Microsoft.Network/networkSecurityGroups@2018-08-01' = {
  name: nsgName1
  location: location
  properties: {
    securityRules: [
      {
        name: 'default-allow-rdp'
        properties: {
          priority: 1000
          sourceAddressPrefix: '*'
          protocol: 'Tcp'
          destinationPortRange: '3389'
          access: 'Allow'
          direction: 'Inbound'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

resource vm2 'Microsoft.Compute/virtualMachines@2018-06-01' = {
  name: vmName2
  location: location
  properties: {
    osProfile: {
      computerName: vmName2
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        provisionVMAgent: true
      }
    }
    hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        createOption: 'fromImage'
      }
      dataDisks: []
    }
    networkProfile: {
      networkInterfaces: [
        {
          properties: {
            primary: true
          }
          id: nic2.id
        }
      ]
    }
  }
  dependsOn: [
    privateDnsZones_contoso_com_name_resource
    privateDnsZones_contoso_com_name_coreservicesvnetlink
    privateDnsZones_contoso_com_name_manufacturingvnetlink
    privateDnsZones_contoso_com_name_researchvnetlink
  ]
}

resource nic2 'Microsoft.Network/networkInterfaces@2018-08-01' = {
  name: nicName2
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnetRefCoreDatabase
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: PIP2.id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nsg2.id
    }
  }
}

resource nsg2 'Microsoft.Network/networkSecurityGroups@2018-08-01' = {
  name: nsgName2
  location: location
  properties: {
    securityRules: [
      {
        name: 'default-allow-rdp'
        properties: {
          priority: 1000
          sourceAddressPrefix: '*'
          protocol: 'Tcp'
          destinationPortRange: '3389'
          access: 'Allow'
          direction: 'Inbound'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

resource PIP1 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: PIPName1
  location: location
  sku: {
    name: 'Basic'
    tier: 'Regional'
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Dynamic'
  }
}

resource PIP2 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: PIPName2
  location: location
  sku: {
    name: 'Basic'
    tier: 'Regional'
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Dynamic'
  }
}
