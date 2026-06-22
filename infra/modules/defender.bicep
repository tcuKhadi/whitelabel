@description('Azure region')
param location string

resource defenderContainers 'Microsoft.Security/pricings@2023-01-01' = {
  name: 'Containers'
  properties: {
    pricingTier: 'Free'
  }
}

resource defenderAppService 'Microsoft.Security/pricings@2023-01-01' = {
  name: 'AppServices'
  properties: {
    pricingTier: 'Free'
  }
}

resource defenderKeyVault 'Microsoft.Security/pricings@2023-01-01' = {
  name: 'KeyVaults'
  properties: {
    pricingTier: 'Free'
  }
}

resource securityContact 'Microsoft.Security/securityContacts@2023-03-01-preview' = {
  name: 'default'
  properties: {
    emails: ''
    notificationsByRole: {
      state: 'On'
      roles: ['Owner', 'Contributor']
    }
    alertNotifications: {
      state: 'On'
      minimalSeverity: 'Medium'
    }
  }
}