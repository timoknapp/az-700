@description('This is the name of the ExpressRoute circuit')
param circuitName string = 'TestERCircuit'

@description('This is the port type of the ExpressRoute circuit. True means provider port. False means direct.')
param portType bool = true

@description('This is the create type of the ExpressRoute circuit. True means create new. False means import.')
param createType bool = true

@description('This is the name of the ExpressRoute Service Provider. It must exactly match one of the Service Providers from List ExpressRoute Service Providers API call.')
param serviceProviderName string = 'Equinix'

@description('This is the name of the peering location and not the ARM resource location. It must exactly match one of the available peering locations from List ExpressRoute Service Providers API call.')
param peeringLocation string = 'Seattle'

param bandwidthInGbps int = 0

@description('This is the bandwidth in Mbps of the circuit being created. It must exactly match one of the available bandwidth offers List ExpressRoute Service Providers API call.')
param bandwidthInMbps int = 50

@description('Location where Circuit resource would be created.')
param location string = 'eastus2'

@description('Chosen SKU Tier of ExpressRoute circuit. Choose from Premium or Standard SKU tiers.')
@allowed([
  'Basic'
  'Local'
  'Standard'
  'Premium'
])
param sku_tier string = 'Premium'

@description('Chosen SKU family of ExpressRoute circuit. Choose from MeteredData or UnlimitedData SKU families.')
@allowed([
  'MeteredData'
  'UnlimitedData'
])
param sku_family string = 'UnlimitedData'

@description('Allow the circuit to interact with classic (RDFE) resources')
param allowClassicOperations bool = false

resource portType_createType_circuitName_nodeploy0 'Microsoft.Network/expressRouteCircuits@2019-02-01' = if (portType && createType) {
  name: ((portType && createType) ? circuitName : 'nodeploy0')
  location: location
  sku: {
    name: '${sku_tier}_${sku_family}'
    tier: sku_tier
    family: sku_family
  }
  properties: {
    serviceProviderProperties: {
      serviceProviderName: serviceProviderName
      peeringLocation: peeringLocation
      bandwidthInMbps: bandwidthInMbps
    }
    allowClassicOperations: allowClassicOperations
  }
}

resource portType_circuitName_nodeploy2 'Microsoft.Network/expressRouteCircuits@2019-02-01' = if (!portType) {
  name: ((!portType) ? circuitName : 'nodeploy2')
  location: location
  sku: {
    name: '${sku_tier}_${sku_family}'
    tier: sku_tier
    family: sku_family
  }
  properties: {
    bandwidthInGbps: bandwidthInGbps
  }
}
