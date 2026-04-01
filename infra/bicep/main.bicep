targetScope = 'subscription'

@description('Azure region for deployments')
param location string = 'westeurope'

@description('Hub resource group name')
param hubRgName string = 'rg-hub-network'

@description('Spoke resource group name')
param spokeRgName string = 'rg-spoke-network'

// =====================
// HUB RESOURCE GROUP
// =====================
resource rgHub 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: hubRgName
  location: location
}

// =====================
// HUB NETWORK
// =====================
module hubNetwork './modules/hub-network.bicep' = {
  name: 'hubNetworkDeployment'
  scope: rgHub
  params: {
    location: location
    hubVnetName: 'vnet-hub'
    hubAddressPrefix: '10.0.0.0/16'
    bastionSubnetPrefix: '10.0.1.0/26'
    gatewaySubnetPrefix: '10.0.2.0/27'
    sharedServicesSubnetPrefix: '10.0.10.0/24'
  }
}

// =====================
// HUB OUTPUTS
// =====================
output hubResourceGroup string = rgHub.name
output hubVnetId string = hubNetwork.outputs.hubVnetId
output hubVnetName string = hubNetwork.outputs.hubVnetNameOut

// =====================
// SPOKE RESOURCE GROUP
// =====================
resource rgSpoke 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: spokeRgName
  location: location
}

// =====================
// SPOKE NETWORK
// =====================
module spokeNetwork './modules/spoke-network.bicep' = {
  name: 'spokeNetworkDeployment'
  scope: rgSpoke
  params: {
    location: location
    spokeVnetName: 'vnet-spoke-app'
    spokeAddressPrefix: '10.1.0.0/16'
    appSubnetPrefix: '10.1.1.0/24'
  }
}
