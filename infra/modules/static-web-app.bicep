@description('Name of the Static Web App')
param name string

@description('Azure region')
param location string

resource staticWebApp 'Microsoft.Web/staticSites@2023-01-01' = {
  name: name
  location: location
  sku: {
    name: 'Free'
    tier: 'Free'
  }
  properties: {
    stagingEnvironmentPolicy: 'Enabled'
    allowConfigFileUpdates: true
    buildProperties: {
      skipGithubActionWorkflowGeneration: true
    }
  }
}

output url string = 'https://${staticWebApp.properties.defaultHostname}'
output id string = staticWebApp.id
output name string = staticWebApp.name