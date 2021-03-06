# https://azure.github.io/secrets-store-csi-driver-provider-azure/docs/demos/standard-walkthrough/
# https://docs.microsoft.com/en-us/azure/aks/csi-secrets-store-driver
# https://docs.microsoft.com/en-us/azure/aks/csi-secrets-store-identity-access

# Enable csi aks driver when installing aks 2

az aks show -g <resource-group> -n <cluster-name> --query addonProfiles.azureKeyvaultSecretsProvider.identity.clientId -o tsv

# take the client id and assign aks permissions

# old way - https://azure.github.io/secrets-store-csi-driver-provider-azure/docs/getting-started/installation/
helm repo add csi-secrets-store-provider-azure https://azure.github.io/secrets-store-csi-driver-provider-azure/charts
helm install csi csi-secrets-store-provider-azure/csi-secrets-store-provider-azure
