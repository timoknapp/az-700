param virtualNetworks_CoreServicesVnet_name string = 'CoreServicesVnet'
param virtualNetworks_ManufacturingVnet_name string = 'ManufacturingVnet'
param virtualNetworks_ResearchVnet_name string = 'ResearchVnet'

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
