#!/usr/bin/env bash

shopt -s extglob

cd internal/controller
rm -rf !(providerconfig|resource)
cd ../..

cd package/crds
rm -v !("${ProviderNameLower}.jet.crossplane.io_providerconfigs.yaml"|"${ProviderNameLower}.jet.crossplane.io_providerconfigusages.yaml"|"${ProviderNameLower}.jet.crossplane.io_storeconfigs.yaml")
cd ../..

cp xno-tmpls/package/crds/resource.terraform.jet.crossplane.io_resources.yaml.tmpl package/crds/resource.${ProviderNameLower}.jet.crossplane.io_resources.yaml
sed -i "s/<PROVIDER_NAME>/${ProviderNameLower}/g" "package/crds/resource.${ProviderNameLower}.jet.crossplane.io_resources.yaml"


cp xno-tmpls/internal/controller/zz_setup.go.tmpl internal/controller/zz_setup.go
sed -i "s/<PROVIDER_NAME>/${ProviderNameLower}/g" internal/controller/zz_setup.go


#TODO Update Schema json

mkdir -p apis/resource/v1alpha1
cp xno-tmpls/apis/resource/v1alpha1/zz_generated_terraformed.go.tmpl apis/resource/v1alpha1/zz_generated_terraformed.go
sed -i "s/<PROVIDER_NAME>/${ProviderNameLower}/g" apis/resource/v1alpha1/zz_generated_terraformed.go
cp xno-tmpls/apis/resource/v1alpha1/zz_resource_types.go.tmpl apis/resource/v1alpha1/zz_resource_types.go
sed -i "s/<PROVIDER_NAME>/${ProviderNameLower}/g" apis/resource/v1alpha1/zz_resource_types.go

cp xno-tmpls/apis/zz_register.go.tmpl apis/zz_register.go
sed -i "s/<PROVIDER_NAME>/${ProviderNameLower}/g" apis/zz_register.go
