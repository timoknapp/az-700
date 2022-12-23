param name string = 'CoreServicesERGateway'
param location string = resourceGroup().location

@allowed([
  'Vpn'
  'ExpressRoute'
])
param gatewayType string = 'Vpn'
param sku string = 'Standard'
param newPublicIpAddressName string = 'CoreServicesVnetGateway-IP'
param virtualNetworks_CoreServicesVnet_name string = 'CoreServicesVnet'

resource virtualNetworks_CoreServicesVnet_name_resource 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: virtualNetworks_CoreServicesVnet_name
  location: location
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
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource name_resource 'Microsoft.Network/virtualNetworkGateways@2020-11-01' = {
  name: name
  location: location
  tags: {
  }
  properties: {
    gatewayType: gatewayType
    ipConfigurations: [
      {
        name: 'default'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworks_CoreServicesVnet_name, 'GatewaySubnet')
          }
          publicIPAddress: {
            id: newPublicIpAddress.id
          }
        }
      }
    ]
    sku: {
      name: sku
      tier: sku
    }
  }
}

resource newPublicIpAddress 'Microsoft.Network/publicIPAddresses@2020-08-01' = {
  name: newPublicIpAddressName
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}
