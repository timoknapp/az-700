@description('Specifies the location for resources.')
param location_Weu string = 'westeurope'

@description('Specifies the location for resources.')
param location_Wus string = 'westus'

param virtualWans_vwan_contoso_name string = 'vwan-contoso'
param virtualNetworks_ResearchVnet_name string = 'ResearchVnet'
param virtualHubs_vwan_hub_contoso_westus_name string = 'vwan-hub-contoso-westus'
param vpnGateways_14977f89de324befb109e2db312cbb8d_westus_gw_name string = '14977f89de324befb109e2db312cbb8d-westus-gw'
param virtualNetworks_HV_vwan_hub_contoso_wes_9c4113d9_0cb9_42eb_b458_fec096942f32_externalid string = '/subscriptions/efcbe855-f5f9-4940-88e6-b196193f6199/resourceGroups/RG_vwan-hub-contoso-westus_1c3ace10-a074-46b2-8009-0da68b4505c2/providers/Microsoft.Network/virtualNetworks/HV_vwan-hub-contoso-wes_9c4113d9-0cb9-42eb-b458-fec096942f32'

resource virtualWans_vwan_contoso_name_resource 'Microsoft.Network/virtualWans@2022-05-01' = {
  name: virtualWans_vwan_contoso_name
  location: location_Weu
  properties: {
    disableVpnEncryption: false
    allowBranchToBranchTraffic: true
    type: 'Standard'
  }
}

resource vpnGateways_14977f89de324befb109e2db312cbb8d_westus_gw_name_resource 'Microsoft.Network/vpnGateways@2022-05-01' = {
  name: vpnGateways_14977f89de324befb109e2db312cbb8d_westus_gw_name
  location: location_Wus
  properties: {
    // connections: []
    virtualHub: {
      id: virtualHubs_vwan_hub_contoso_westus_name_resource.id
    }
    bgpSettings: {
      asn: 65515
      // peerWeight: 0
      // bgpPeeringAddresses: [
      //   {
      //     ipconfigurationId: 'Instance0'
      //     customBgpIpAddresses: []
      //   }
      //   {
      //     ipconfigurationId: 'Instance1'
      //     customBgpIpAddresses: []
      //   }
      // ]
    }
    vpnGatewayScaleUnit: 1
    // natRules: []
    // enableBgpRouteTranslationForNat: false
    isRoutingPreferenceInternet: false
  }
}

resource virtualHubs_vwan_hub_contoso_westus_name_resource 'Microsoft.Network/virtualHubs@2022-05-01' = {
  name: virtualHubs_vwan_hub_contoso_westus_name
  location: location_Wus
  properties: {
    virtualHubRouteTableV2s: []
    addressPrefix: '10.60.0.0/24'
    // virtualRouterAsn: 65515
    // virtualRouterIps: [
    //   '10.60.0.69'
    //   '10.60.0.68'
    // ]
    // routeTable: {
    //   routes: []
    // }
    virtualRouterAutoScaleConfiguration: {
      minCapacity: 2
    }
    virtualWan: {
      id: virtualWans_vwan_contoso_name_resource.id
    }
    // vpnGateway: {
    //   id: vpnGateways_14977f89de324befb109e2db312cbb8d_westus_gw_name_resource.id
    // }
    // sku: 'Standard'
    // allowBranchToBranchTraffic: false
    hubRoutingPreference: 'VpnGateway'
  }
}

resource virtualHubs_vwan_hub_contoso_westus_name_defaultRouteTable 'Microsoft.Network/virtualHubs/hubRouteTables@2022-05-01' = {
  name: '${virtualHubs_vwan_hub_contoso_westus_name}/defaultRouteTable'
  properties: {
    routes: []
    labels: [
      'default'
    ]
  }
  dependsOn: [
    virtualHubs_vwan_hub_contoso_westus_name_resource
  ]
}

resource virtualHubs_vwan_hub_contoso_westus_name_noneRouteTable 'Microsoft.Network/virtualHubs/hubRouteTables@2022-05-01' = {
  name: '${virtualHubs_vwan_hub_contoso_westus_name}/noneRouteTable'
  properties: {
    routes: []
    labels: [
      'none'
    ]
  }
  dependsOn: [
    virtualHubs_vwan_hub_contoso_westus_name_resource
  ]
}

resource virtualNetworks_ResearchVnet_resource 'Microsoft.Network/virtualNetworks@2022-05-01' existing = {
  name: virtualNetworks_ResearchVnet_name
}

// resource virtualNetworks_ResearchVnet_name_RemoteVnetToHubPeering_976e827a_3c73_4f06_9317_d9bcf6b8a337 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-05-01' = {
//   name: 'RemoteVnetToHubPeering_976e827a-3c73-4f06-9317-d9bcf6b8a337'
//   parent: virtualNetworks_ResearchVnet_resource
//   properties: {
//     remoteVirtualNetwork: {
//       id: virtualNetworks_HV_vwan_hub_contoso_wes_9c4113d9_0cb9_42eb_b458_fec096942f32_externalid
//     }
//     allowVirtualNetworkAccess: true
//     allowForwardedTraffic: false
//     allowGatewayTransit: false
//     useRemoteGateways: true
//     doNotVerifyRemoteGateways: true
//   }
// }

resource virtualHubs_vwan_hub_contoso_westus_name_vwan_connection_contoso_to_research 'Microsoft.Network/virtualHubs/hubVirtualNetworkConnections@2022-05-01' = {
  name: '${virtualHubs_vwan_hub_contoso_westus_name}/vwan-connection-contoso-to-research'
  properties: {
    routingConfiguration: {
      associatedRouteTable: {
        id: virtualHubs_vwan_hub_contoso_westus_name_defaultRouteTable.id
      }
      propagatedRouteTables: {
        labels: [
          'none'
        ]
        ids: [
          {
            id: virtualHubs_vwan_hub_contoso_westus_name_noneRouteTable.id
          }
        ]
      }
      // vnetRoutes: {
      //   staticRoutes: []
      //   staticRoutesConfig: {
      //     vnetLocalRouteOverrideCriteria: 'Contains'
      //   }
      // }
    }
    remoteVirtualNetwork: {
      id: virtualNetworks_ResearchVnet_resource.id
    }
    allowHubToRemoteVnetTransit: true
    allowRemoteVnetToUseHubVnetGateways: true
    enableInternetSecurity: true
  }
  dependsOn: [
    virtualHubs_vwan_hub_contoso_westus_name_resource
  ]
}
