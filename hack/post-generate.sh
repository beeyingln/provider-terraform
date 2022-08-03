#!/usr/bin/env bash

shopt -s extglob

cd internal/controller
rm -rf !(providerconfig)
cd ../..

cd package/crds
rm -v !("${ProviderNameLower}.jet.crossplane.io_providerconfigs.yaml"|"${ProviderNameLower}.jet.crossplane.io_providerconfigusages.yaml"|"${ProviderNameLower}.jet.crossplane.io_storeconfigs.yaml"|"${ProviderNameLower}.${ProviderNameLower}.jet.crossplane.io_aggregates.yaml")
cd ../..
