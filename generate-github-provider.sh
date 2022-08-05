sed -i "s/\/\/REPLACE-TO-LOCAL\/\//replace github.com\/crossplane\/terrajet => \/home\/vagrant\/workspace\/spike\/terrajet/g" go.mod

ProviderNameUpper=Github \
ProviderNameLower=github \
TERRAFORM_PROVIDER_SOURCE="integrations/github" \
TERRAFORM_PROVIDER_VERSION="4.19.2" \
TERRAFORM_PROVIDER_DOWNLOAD_NAME="terraform-provider-github" \
TERRAFORM_PROVIDER_DOWNLOAD_URL_PREFIX="https://releases.hashicorp.com/terraform-provider-github/4.19.2" \
TERRAFORM_NATIVE_PROVIDER_BINARY="terraform-provider-github_4.19.2" \
make generate-provider