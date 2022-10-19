@description('Specifies the location for resources.')
param location_Weu string = 'westeurope'

@description('Specifies the location for resources.')
param location_Eus string = 'eastus'

@description('Specifies the location for resources.')
param location_Sea string = 'southeastasia'

param virtualNetworks_ResearchVnet_name string = 'ResearchVnet'
param virtualNetworks_CoreServicesVnet_name string = 'CoreServicesVnet'
param virtualNetworks_ManufacturingVnet_name string = 'ManufacturingVnet'

resource virtualNetworks_CoreServicesVnet_name_resource 'Microsoft.Network/virtualNetworks@2022-01-01' = {
  name: virtualNetworks_CoreServicesVnet_name
  location: location_Eus
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.20.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'GatewaySubnet'
        properties: {
          addressPrefix: '10.20.0.0/27'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'SharedServicesSubnet'
        properties: {
          addressPrefix: '10.20.10.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'DatabaseSubnet'
        properties: {
          addressPrefix: '10.20.20.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'PublicWebServiceSubnet'
        properties: {
          addressPrefix: '10.20.30.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

// Creating Subnets within VNET Resource
// resource virtualNetworks_CoreServicesVnet_name_DatabaseSubnet 'Microsoft.Network/virtualNetworks/subnets@2022-01-01' = {
//   name: '${virtualNetworks_CoreServicesVnet_name}/DatabaseSubnet'
//   properties: {
//     addressPrefix: '10.20.20.0/24'
//     delegations: []
//     privateEndpointNetworkPolicies: 'Disabled'
//     privateLinkServiceNetworkPolicies: 'Enabled'
//   }
//   dependsOn: [
//     virtualNetworks_CoreServicesVnet_name_resource
//   ]
// }

// resource virtualNetworks_CoreServicesVnet_name_GatewaySubnet 'Microsoft.Network/virtualNetworks/subnets@2022-01-01' = {
//   name: '${virtualNetworks_CoreServicesVnet_name}/GatewaySubnet'
//   properties: {
//     addressPrefix: '10.20.0.0/27'
//     delegations: []
//     privateEndpointNetworkPolicies: 'Disabled'
//     privateLinkServiceNetworkPolicies: 'Enabled'
//   }
//   dependsOn: [
//     virtualNetworks_CoreServicesVnet_name_resource
//   ]
// }

// resource virtualNetworks_CoreServicesVnet_name_PublicWebServiceSubnet 'Microsoft.Network/virtualNetworks/subnets@2022-01-01' = {
//   name: '${virtualNetworks_CoreServicesVnet_name}/PublicWebServiceSubnet'
//   properties: {
//     addressPrefix: '10.20.30.0/24'
//     delegations: []
//     privateEndpointNetworkPolicies: 'Disabled'
//     privateLinkServiceNetworkPolicies: 'Enabled'
//   }
//   dependsOn: [
//     virtualNetworks_CoreServicesVnet_name_resource
//   ]
// }

// resource virtualNetworks_CoreServicesVnet_name_SharedServicesSubnet 'Microsoft.Network/virtualNetworks/subnets@2022-01-01' = {
//   name: '${virtualNetworks_CoreServicesVnet_name}/SharedServicesSubnet'
//   properties: {
//     addressPrefix: '10.20.10.0/24'
//     delegations: []
//     privateEndpointNetworkPolicies: 'Disabled'
//     privateLinkServiceNetworkPolicies: 'Enabled'
//   }
//   dependsOn: [
//     virtualNetworks_CoreServicesVnet_name_resource
//   ]
// }

resource virtualNetworks_ManufacturingVnet_name_resource 'Microsoft.Network/virtualNetworks@2022-01-01' = {
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
        name: 'ManufacturingSystemSubnet'
        properties: {
          addressPrefix: '10.30.10.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'SensorSubnet1'
        properties: {
          addressPrefix: '10.30.20.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'SensorSubnet2'
        properties: {
          addressPrefix: '10.30.21.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        name: 'SensorSubnet3'
        properties: {
          addressPrefix: '10.30.22.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

// resource virtualNetworks_ManufacturingVnet_name_ManufacturingSystemSubnet 'Microsoft.Network/virtualNetworks/subnets@2022-01-01' = {
//   name: '${virtualNetworks_ManufacturingVnet_name}/ManufacturingSystemSubnet'
//   properties: {
//     addressPrefix: '10.30.10.0/24'
//     delegations: []
//     privateEndpointNetworkPolicies: 'Disabled'
//     privateLinkServiceNetworkPolicies: 'Enabled'
//   }
//   dependsOn: [
//     virtualNetworks_ManufacturingVnet_name_resource
//   ]
// }

// resource virtualNetworks_ManufacturingVnet_name_SensorSubnet1 'Microsoft.Network/virtualNetworks/subnets@2022-01-01' = {
//   name: '${virtualNetworks_ManufacturingVnet_name}/SensorSubnet1'
//   properties: {
//     addressPrefix: '10.30.20.0/24'
//     delegations: []
//     privateEndpointNetworkPolicies: 'Disabled'
//     privateLinkServiceNetworkPolicies: 'Enabled'
//   }
//   dependsOn: [
//     virtualNetworks_ManufacturingVnet_name_resource
//   ]
// }

// resource virtualNetworks_ManufacturingVnet_name_SensorSubnet2 'Microsoft.Network/virtualNetworks/subnets@2022-01-01' = {
//   name: '${virtualNetworks_ManufacturingVnet_name}/SensorSubnet2'
//   properties: {
//     addressPrefix: '10.30.21.0/24'
//     delegations: []
//     privateEndpointNetworkPolicies: 'Disabled'
//     privateLinkServiceNetworkPolicies: 'Enabled'
//   }
//   dependsOn: [
//     virtualNetworks_ManufacturingVnet_name_resource
//   ]
// }

// resource virtualNetworks_ManufacturingVnet_name_SensorSubnet3 'Microsoft.Network/virtualNetworks/subnets@2022-01-01' = {
//   name: '${virtualNetworks_ManufacturingVnet_name}/SensorSubnet3'
//   properties: {
//     addressPrefix: '10.30.22.0/24'
//     delegations: []
//     privateEndpointNetworkPolicies: 'Disabled'
//     privateLinkServiceNetworkPolicies: 'Enabled'
//   }
//   dependsOn: [
//     virtualNetworks_ManufacturingVnet_name_resource
//   ]
// }

resource virtualNetworks_ResearchVnet_name_resource 'Microsoft.Network/virtualNetworks@2022-01-01' = {
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
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

// resource virtualNetworks_ResearchVnet_name_ResearchSystemSubnet 'Microsoft.Network/virtualNetworks/subnets@2022-01-01' = {
//   name: '${virtualNetworks_ResearchVnet_name}/ResearchSystemSubnet'
//   properties: {
//     addressPrefix: '10.40.0.0/24'
//     delegations: []
//     privateEndpointNetworkPolicies: 'Disabled'
//     privateLinkServiceNetworkPolicies: 'Enabled'
//   }
//   dependsOn: [
//     virtualNetworks_ResearchVnet_name_resource
//   ]
// }
