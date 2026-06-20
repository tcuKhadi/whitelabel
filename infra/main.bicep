targetScope = 'resourceGroup'

@description('Environment name (dev or prod)')
@allowed(['dev', 'prod'])
param environment string

@description('Azure region for all resources')
param location string = resourceGroup().location

@description('Project name used as prefix for all resources')
param projectName string = 'whitelabel'

module identity 'modules/managed-identity.bicep' = {
  name: 'managed-identity'
  params: {
    name: '${projectName}-identity-${environment}'
    location: location
  }
}

module keyVault 'modules/key-vault.bicep' = {
  name: 'key-vault'
  params: {
    name: '${projectName}-kv-${environment}'
    location: location
    managedIdentityPrincipalId: identity.outputs.principalId
  }
}

module containerApp 'modules/container-app.bicep' = {
  name: 'container-app'
  params: {
    name: '${projectName}-api-${environment}'
    location: location
    managedIdentityId: identity.outputs.id
    keyVaultName: keyVault.outputs.name
  }
}

module staticWebApp 'modules/static-web-app.bicep' = {
  name: 'static-web-app'
  params: {
    name: '${projectName}-web-${environment}'
    location: location
  }
}

module defender 'modules/defender.bicep' = {
  name: 'defender'
  params: {
    location: location
  }
}

module cosmosPostgres 'modules/cosmos-pg.bicep' = {
  name: 'cosmos-pg'
  params: {
    name: '${projectName}-pg-${environment}'
    location: location
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
  }
}

module blobStorage 'modules/blob-storage.bicep' = {
  name: 'blob-storage'
  params: {
    name: '${projectName}store${environment}'
    location: location
    managedIdentityPrincipalId: identity.outputs.principalId
  }
}
output staticWebAppUrl string = staticWebApp.outputs.url
output containerAppUrl string = containerApp.outputs.url
output keyVaultUri string = keyVault.outputs.uri
output managedIdentityId string = identity.outputs.id