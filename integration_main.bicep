param storageAccountName string = toLower(concat('st', uniqueString(resourceGroup().id)))
param location string = resourceGroup().location
param skuName string = 'Standard_LRS' // options: Standard_LRS, Standard_GRS, Premium_LRS, etc.
param kind string = 'StorageV2' // Storage, StorageV2, BlobStorage, FileStorage, BlockBlobStorage
param accessTier string = 'Hot' // Hot or Cool (only for StorageV2 / BlobStorage)
param enableHttpsTrafficOnly bool = true
param minimumTlsVersion string = 'TLS1_2'
param allowBlobPublicAccess bool = false
param tags object = {}

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: skuName
  }
  kind: kind
  tags: tags
  properties: {
    accessTier: accessTier
    supportsHttpsTrafficOnly: enableHttpsTrafficOnly
    minimumTlsVersion: minimumTlsVersion
    allowBlobPublicAccess: allowBlobPublicAccess
  }
}

output storageAccountName string = storageAccount.name
output storageAccountId string = storageAccount.id
output primaryBlobEndpoint string = storageAccount.properties.primaryEndpoints.blob
