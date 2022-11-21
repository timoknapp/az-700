
@description('description')
param vmName1 string = 'vm-mfg'

@description('description')
param nicName1 string = 'nic-1-manufacturing'

@description('Virtual machine size')
param vmSize string = 'Standard_DS1_v2'

@description('Admin username')
param adminUsername string = 'TestUser'

@description('Admin password')
@secure()
param adminPassword string

var nsgName1 = 'nsg-manufacturing'
var PIPName1 = 'pip-manufacturing'
var subnetNameManufacturing = 'snet-manufacturingsystem'
var subnetRefManufacturing = resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_ManufacturingVnet_name, subnetNameManufacturing)
param location string = 'westeurope'

param virtualNetworks_CoreServicesVnet_name string = 'vnet-coreservices'
param virtualNetworks_ManufacturingVnet_name string = 'vnet-manufacturing'
param virtualNetworks_ResearchVnet_name string = 'vnet-research'

resource virtualNetworks_CoreServiceVnet_resource 'Microsoft.Network/virtualNetworks@2022-05-01' existing = {
  name: virtualNetworks_CoreServicesVnet_name
}

resource virtualNetworks_Manufacturing_resource 'Microsoft.Network/virtualNetworks@2022-05-01' existing = {
  name: virtualNetworks_ManufacturingVnet_name
}

resource virtualNetworks_ResearchVnet_resource 'Microsoft.Network/virtualNetworks@2022-05-01' existing = {
  name: virtualNetworks_ResearchVnet_name
}

resource virtualNetworks_CoreServicesVnet_name_vnet_peering_core_manufacturing 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-01-01' = {
  name: 'vnet-peering-core-manufacturing'
  parent: virtualNetworks_CoreServiceVnet_resource
  properties: {
    remoteVirtualNetwork: {
      id: virtualNetworks_Manufacturing_resource.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    doNotVerifyRemoteGateways: false
  }
}

resource virtualNetworks_CoreServicesVnet_name_vnet_peering_core_research 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-01-01' = {
  name: 'vnet-peering-core-research'
  parent: virtualNetworks_CoreServiceVnet_resource
  properties: {
    remoteVirtualNetwork: {
      id: virtualNetworks_ResearchVnet_resource.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    doNotVerifyRemoteGateways: false
  }
}

resource virtualNetworks_ManufacturingVnet_name_vnet_peering_manufacturing_core 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-01-01' = {
  name: 'vnet-peering-manufacturing-core'
  parent: virtualNetworks_Manufacturing_resource
  properties: {
    remoteVirtualNetwork: {
      id: virtualNetworks_CoreServiceVnet_resource.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    doNotVerifyRemoteGateways: false
  }
}

resource virtualNetworks_ResearchVnet_name_vnet_peering_research_core 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-01-01' = {
  name: 'vnet-peering-research-core'
  parent: virtualNetworks_ResearchVnet_resource
  properties: {
    remoteVirtualNetwork: {
      id: virtualNetworks_CoreServiceVnet_resource.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    doNotVerifyRemoteGateways: false
  }
}


resource vm1 'Microsoft.Compute/virtualMachines@2022-03-01' = {
  name: vmName1
  location: location
  properties: {
    storageProfile: {
      osDisk: {
        createOption: 'fromImage'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
        deleteOption: 'Delete'
      }
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-datacenter-gensecond'
        version: 'latest'
      }
    }
    hardwareProfile: {
      vmSize: vmSize
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic1.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    osProfile: {
      computerName: vmName1
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        enableAutomaticUpdates: true
        provisionVMAgent: true
        patchSettings: {
          enableHotpatching: false
          patchMode: 'AutomaticByOS'
        }
      }
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}

resource nic1 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  name: nicName1
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnetRefManufacturing
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

resource nsg1 'Microsoft.Network/networkSecurityGroups@2022-05-01' = {
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

resource PIP1 'Microsoft.Network/publicIPAddresses@2022-05-01' = {
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
