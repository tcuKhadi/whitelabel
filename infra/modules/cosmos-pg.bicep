@description('Cluster name')
param name string

@description('Azure region')
param location string

@description('Admin username')
@secure()
param administratorLogin string

@description('Admin password')
@secure()
param administratorLoginPassword string

resource cosmosPostgres 'Microsoft.DBforPostgreSQL/serverGroupsv2@2022-11-08' = {
  name: name
  location: location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    nodeCount: 0
    coordinatorVCores: 1
    coordinatorStorageQuotaInMb: 32768
    coordinatorEsnablePublicIpAccess: false
    enableShardsOnCoordinator: true
    postgresqlVersion: '16'
    citusVersion: '12.1'
  }
}

output fqdn string = cosmosPostgres.properties.serverNames[0].fullyQualifiedDomainName
output id string = cosmosPostgres.id