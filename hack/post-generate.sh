#!/usr/bin/env bash

cp xno-tmpls/apis/resource/v1alpha1/zz_generated_terraformed.go.tmpl apis/resource/v1alpha1/zz_generated_terraformed.go
sed -i "s/<PROVIDER_NAME>/${ProviderNameLower}/g" apis/resource/v1alpha1/zz_generated_terraformed.go
cp xno-tmpls/apis/resource/v1alpha1/zz_resource_types.go.tmpl apis/resource/v1alpha1/zz_resource_types.go
sed -i "s/<PROVIDER_NAME>/${ProviderNameLower}/g" apis/resource/v1alpha1/zz_resource_types.go
