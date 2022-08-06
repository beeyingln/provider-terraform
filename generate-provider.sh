export ProviderNameLower="${ProviderNameLower:-github}"
export ProviderNameUpper"${ProviderNameUpper:-Github}"

export TERRAFORM_PROVIDER_SOURCE="${TERRAFORM_PROVIDER_SOURCE:-integrations/github}"
export TERRAFORM_PROVIDER_VERSION="${TERRAFORM_PROVIDER_VERSION:-4.19.2}"
export TERRAFORM_PROVIDER_DOWNLOAD_NAME="${TERRAFORM_PROVIDER_DOWNLOAD_NAME:-terraform-provider-github}"
export TERRAFORM_PROVIDER_DOWNLOAD_URL_PREFIX="${TERRAFORM_PROVIDER_DOWNLOAD_URL_PREFIX:-https://releases.hashicorp.com/terraform-provider-github/4.19.2}"
export TERRAFORM_NATIVE_PROVIDER_BINARY="${TERRAFORM_NATIVE_PROVIDER_BINARY:-terraform-provider-github_4.19.2}"

echo "Start Generate Terraform Provider"
echo "ProviderNameLower=$ProviderNameLower"
echo "ProviderNameUpper=$ProviderNameUpper"

echo "TERRAFORM_PROVIDER_SOURCE=${TERRAFORM_PROVIDER_SOURCE}"
echo "TERRAFORM_PROVIDER_VERSION=${TERRAFORM_PROVIDER_VERSION}"
echo "TERRAFORM_PROVIDER_DOWNLOAD_NAME=${TERRAFORM_PROVIDER_DOWNLOAD_NAME}"
echo "TERRAFORM_PROVIDER_DOWNLOAD_URL_PREFIX=${TERRAFORM_PROVIDER_DOWNLOAD_URL_PREFIX}"
echo "TERRAFORM_NATIVE_PROVIDER_BINARY=${TERRAFORM_NATIVE_PROVIDER_BINARY}"


sed -i "s/\/\/REPLACE-TO-LOCAL\/\//replace github.com\/crossplane\/terrajet => \/home\/vagrant\/workspace\/spike\/terrajet/g" go.mod


make generate-provider