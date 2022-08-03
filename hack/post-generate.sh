#!/usr/bin/env bash

shopt -s extglob

cd internal/controller
rm -rf !(providerconfig)
cd ../..

cd package/crds
rm -v !("${ProviderNameLower}.jet.crossplane.io_providerconfigs.yaml"|"${ProviderNameLower}.jet.crossplane.io_providerconfigusages.yaml"|"${ProviderNameLower}.jet.crossplane.io_storeconfigs.yaml"|"${ProviderNameLower}.${ProviderNameLower}.jet.crossplane.io_aggregates.yaml")
cd ../..


cp xno-templates/package/crds/resource.terraform.jet.crossplane.io_resources.yaml.tmpl package/crds/resource.${ProviderNameLower}.jet.crossplane.io_resources.yaml
sed -i "s/<PROVIDER_NAME>/${ProviderNameLower}/g" "package/crds/resource.${ProviderNameLower}.jet.crossplane.io_resources.yaml"

mkdir internal/controller/resource
cp -R xno-templates/internal/controller/resource/zz_controller.go.tmpl internal/controller/zz_controller.go
sed -i "s/<PROVIDER_NAME>/${ProviderNameLower}/g" internal/controller/resource/zz_controller.go

cp xno-templates/internal/controller/zz_setup.go.tmpl internal/controller/zz_setup.go
sed -i "s/<PROVIDER_NAME>/${ProviderNameLower}/g" internal/controller/zz_setup.go

mkdir examples/resource
cp xno-templates/examples/resource/resource.yaml.tmpl examples/resource/resource.yaml
sed -i "s/<PROVIDER_NAME>/${ProviderNameLower}/g" examples/resource/resource.yaml

sed -i "s/<PROVIDER_NAME>/${ProviderNameLower}/g" config/resource/config.go

#Update Schema json

mkdir -f apis/resource/v1alpha1
cp -R xno-templates/apis/resource/v1alpha1/zz_generated.deepcopy.go.tmpl apis/resource/v1alpha1/zz_generated.deepcopy.go 
cp -R xno-templates/apis/resource/v1alpha1/zz_generated.managed.go.tmpl apis/resource/v1alpha1/zz_generated.managed.go
cp -R xno-templates/apis/resource/v1alpha1/zz_generated.managedlist.go.tmpl apis/resource/v1alpha1/zz_generated.managedlist.go
cp -R xno-templates/apis/resource/v1alpha1/zz_generated_terraformed.go.tmpl apis/resource/v1alpha1/zz_generated_terraformed.go
cp -R xno-templates/apis/resource/v1alpha1/zz_groupversion_info.go.tmpl apis/resource/v1alpha1/zz_groupversion_info.go
cp -R xno-templates/apis/resource/v1alpha1/zz_resource_types.go.tmpl apis/resource/v1alpha1/zz_resource_types.go
#TODO Replace

cp xno-templates/apis/zz_register.go.tmpl apis/zz_register.go
sed -i "s/<PROVIDER_NAME>/${ProviderNameLower}/g" apis/zz_register.go
