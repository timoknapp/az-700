param location string = resourceGroup().location

@description('Specifies the location for resources.')
param location_Weu string = 'westeurope'

@description('Specifies the location for resources.')
param location_Eus string = 'eastus'

@description('Specifies the location for resources.')
param location_Sea string = 'southeastasia'

@description('description')
param vmName1 string = 'CoreServicesVM'

@description('description')
param nicName1 string = 'CoreServicesVM-nic'

@description('description')
param vmName2 string = 'ManufacturingVM'

@description('description')
param nicName2 string = 'ManufacturingVM-nic'

@description('Virtual machine size')
param vmSize string = 'Standard_D2s_v3'

@description('Admin username')
param adminUsername string = 'TestUser'

@description('Admin password')
@secure()
param adminPassword string

@description('description')
param vpnConnectionSharedKey string

param virtualNetworks_ResearchVnet_name string = 'ResearchVnet'
param virtualNetworks_CoreServicesVnet_name string = 'CoreServicesVnet'
param virtualNetworks_ManufacturingVnet_name string = 'ManufacturingVnet'
param publicIPAddresses_CoreServicesVnetGateway_ip_name string = 'CoreServicesVnetGateway-ip'
param connections_CoreServicesGW_to_ManufacturingGW_name string = 'CoreServicesGW-to-ManufacturingGW'
param connections_ManufacturingGW_to_CoreServicesGW_name string = 'ManufacturingGW-to-CoreServicesGW'
param publicIPAddresses_ManufacturingVnetGateway_ip_name string = 'ManufacturingVnetGateway-ip'
param virtualNetworkGateways_CoreServicesVnetGateway_name string = 'CoreServicesVnetGateway'
param virtualNetworkGateways_ManufacturingVnetGateway_name string = 'ManufacturingVnetGateway'

var nsgName1 = 'CoreServicesVM-nsg'
var PIPName1 = 'CoreServicesVM-ip'
var subnetNameCoreDatabase = 'DatabaseSubnet'
var subnetRefCoreDatabase = resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_CoreServicesVnet_name, subnetNameCoreDatabase)
var subnetNameCoreGateway = 'GatewaySubnet'
var subnetRefCoreGateway = resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_CoreServicesVnet_name, subnetNameCoreGateway)

var nsgName2 = 'ManufacturingVM-nsg'
var PIPName2 = 'ManufacturingVM-ip'
var subnetNameManufacturingSystem = 'ManufacturingSystemSubnet'
var subnetRefManufacturingSystem = resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_ManufacturingVnet_name, subnetNameManufacturingSystem)
var subnetNameManufacturingGateway = 'GatewaySubnet'
var subnetRefManufacturingGateway = resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_ManufacturingVnet_name, subnetNameManufacturingGateway)

resource virtualNetworks_CoreServicesVnet_name_resource 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: virtualNetworks_CoreServicesVnet_name
  location: location_Eus
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.20.0.0/16'
      ]
    }
    dhcpOptions: {
      dnsServers: []
    }
    subnets: [
      {
        name: 'GatewaySubnet'
        properties: {
          addressPrefix: '10.20.0.0/27'
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'SharedServicesSubnet'
        properties: {
          addressPrefix: '10.20.10.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'DatabaseSubnet'
        properties: {
          addressPrefix: '10.20.20.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'PublicWebServiceSubnet'
        properties: {
          addressPrefix: '10.20.30.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource virtualNetworks_ManufacturingVnet_name_resource 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: virtualNetworks_ManufacturingVnet_name
  location: location_Weu
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.30.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'GatewaySubnet'
        properties: {
          addressPrefix: '10.30.0.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'ManufacturingSystemSubnet'
        properties: {
          addressPrefix: '10.30.10.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'SensorSubnet1'
        properties: {
          addressPrefix: '10.30.20.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'SensorSubnet2'
        properties: {
          addressPrefix: '10.30.21.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'SensorSubnet3'
        properties: {
          addressPrefix: '10.30.22.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource virtualNetworks_ResearchVnet_name_resource 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: virtualNetworks_ResearchVnet_name
  location: location_Sea
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.40.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'ResearchSystemSubnet'
        properties: {
          addressPrefix: '10.40.0.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}


resource vm1 'Microsoft.Compute/virtualMachines@2018-06-01' = {
  name: vmName1
  location: location_Eus
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
}

resource nic1 'Microsoft.Network/networkInterfaces@2018-08-01' = {
  name: nicName1
  location: location_Eus
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
  location: location_Eus
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
  location: location_Eus
  sku: {
    name: 'Basic'
    tier: 'Regional'
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Dynamic'
  }
}

resource vm2 'Microsoft.Compute/virtualMachines@2018-06-01' = {
  name: vmName2
  location: location_Weu
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
}

resource nic2 'Microsoft.Network/networkInterfaces@2018-08-01' = {
  name: nicName2
  location: location_Weu
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnetRefManufacturingSystem
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
  location: location_Weu
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

resource PIP2 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: PIPName2
  location: location_Weu
  sku: {
    name: 'Basic'
    tier: 'Regional'
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Dynamic'
  }
}

resource virtualNetworkGateways_CoreServicesVnetGateway_name_resource 'Microsoft.Network/virtualNetworkGateways@2022-01-01' = {
  name: virtualNetworkGateways_CoreServicesVnetGateway_name
  location: location_Eus
  properties: {
    ipConfigurations: [
      {
        name: 'default'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_CoreServicesVnetGateway_ip_name_resource.id
          }
          subnet: {
            id: subnetRefCoreGateway
          }
        }
      }
    ]
    sku: {
      name: 'VpnGw1'
      tier: 'VpnGw1'
    }
    gatewayType: 'Vpn'
    vpnType: 'RouteBased'
    enableBgp: false
    activeActive: false
    vpnGatewayGeneration: 'Generation1'
  }
}

resource publicIPAddresses_CoreServicesVnetGateway_ip_name_resource 'Microsoft.Network/publicIPAddresses@2022-01-01' = {
  name: publicIPAddresses_CoreServicesVnetGateway_ip_name
  location: location_Eus
  sku: {
    name: 'Basic'
    tier: 'Regional'
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Dynamic'
  }
}

resource virtualNetworkGateways_ManufacturingVnetGateway_name_resource 'Microsoft.Network/virtualNetworkGateways@2022-01-01' = {
  name: virtualNetworkGateways_ManufacturingVnetGateway_name
  location: location_Weu
  properties: {
    ipConfigurations: [
      {
        name: 'default'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_ManufacturingVnetGateway_ip_name_resource.id
          }
          subnet: {
            id: subnetRefManufacturingGateway
          }
        }
      }
    ]
    sku: {
      name: 'VpnGw1'
      tier: 'VpnGw1'
    }
    gatewayType: 'Vpn'
    vpnType: 'RouteBased'
    enableBgp: false
    activeActive: false
    vpnGatewayGeneration: 'Generation1'
  }
}

resource publicIPAddresses_ManufacturingVnetGateway_ip_name_resource 'Microsoft.Network/publicIPAddresses@2022-01-01' = {
  name: publicIPAddresses_ManufacturingVnetGateway_ip_name
  location: location_Weu
  sku: {
    name: 'Basic'
    tier: 'Regional'
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Dynamic'
  }
}

resource connections_CoreServicesGW_to_ManufacturingGW_name_resource 'Microsoft.Network/connections@2022-01-01' = {
  name: connections_CoreServicesGW_to_ManufacturingGW_name
  location: location_Eus
  properties: {
    virtualNetworkGateway1: {
      id: virtualNetworkGateways_CoreServicesVnetGateway_name_resource.id
      properties: {
      }
    }
    virtualNetworkGateway2: {
      id: virtualNetworkGateways_ManufacturingVnetGateway_name_resource.id
      properties: {
      }
    }
    connectionType: 'Vnet2Vnet'
    connectionProtocol: 'IKEv2'
    enableBgp: false
    useLocalAzureIpAddress: false
    connectionMode: 'Default'
    sharedKey: vpnConnectionSharedKey
  }
}

resource connections_ManufacturingGW_to_CoreServicesGW_name_resource 'Microsoft.Network/connections@2022-01-01' = {
  name: connections_ManufacturingGW_to_CoreServicesGW_name
  location: location_Weu
  properties: {
    virtualNetworkGateway1: {
      id: virtualNetworkGateways_ManufacturingVnetGateway_name_resource.id
      properties: {
      }
    }
    virtualNetworkGateway2: {
      id: virtualNetworkGateways_CoreServicesVnetGateway_name_resource.id
      properties: {
      }
    }
    connectionType: 'Vnet2Vnet'
    connectionProtocol: 'IKEv2'
    enableBgp: false
    useLocalAzureIpAddress: false
    connectionMode: 'Default'
    sharedKey: vpnConnectionSharedKey
  }
}
