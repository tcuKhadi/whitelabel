using '../main.bicep'

param environment = 'dev'
param location = 'southafricanorth'
param projectName = 'whitelabel'
param administratorLogin = ''
param administratorLoginPassword = '' // pulled from Key Vault at deploy time