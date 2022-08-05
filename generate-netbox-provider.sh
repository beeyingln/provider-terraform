sed -i "s/\/\/REPLACE-TO-LOCAL\/\//replace github.com\/crossplane\/terrajet => \/home\/vagrant\/workspace\/spike\/terrajet/g" go.mod

ProviderNameLower=netbox \
ProviderNameUpper=Netbox \
TERRAFORM_PROVIDER_SOURCE="e-breuninger/netbox" \
TERRAFORM_PROVIDER_VERSION="2.0.2" \
TERRAFORM_PROVIDER_DOWNLOAD_NAME="terraform-provider-netbox" \
TERRAFORM_PROVIDER_DOWNLOAD_URL_PREFIX="https://github.com/e-breuninger/terraform-provider-netbox/releases/download/v2.0.2" \
TERRAFORM_NATIVE_PROVIDER_BINARY="terraform-provider-netbox_v2.0.2" \
make generate-provider