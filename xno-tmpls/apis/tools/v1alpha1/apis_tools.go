package v1alpha1

import (
	"encoding/json"

	ipaddressv1alpha1 "github.com/crossplane-contrib/provider-jet-netbox/apis/ip/v1alpha1"
	manufacturerv1alpha1 "github.com/crossplane-contrib/provider-jet-netbox/apis/netbox/v1alpha1"

	tfjson "github.com/crossplane/terrajet/pkg/resource/json"
	"k8s.io/apimachinery/pkg/runtime"
)

func GetObservationId(terraformResourceType string, data []byte) (string, error) {
	switch terraformResourceType {
	case "netbox_ip_address":
		obj := &ipaddressv1alpha1.AddressObservation{}
		err := json.Unmarshal(data, obj)
		if err != nil {
			return "", err
		}
		return *obj.ID, nil
	case "netbox_manufacturer":
		obj := &manufacturerv1alpha1.ManufacturerObservation{}
		err := json.Unmarshal(data, obj)
		if err != nil {
			return "", err
		}
		return *obj.ID, nil
	}

	return "", nil
}

func ConvertJSONToResourceParameters(terraformResourceType string, data runtime.RawExtension) (interface{}, error) {
	var rp interface{}

	switch terraformResourceType {
	case "netbox_ip_address":
		rp = ipaddressv1alpha1.AddressParameters{}
	case "netbox_manufacturer":
		rp = manufacturerv1alpha1.ManufacturerParameters{}
	}

	err := json.Unmarshal(data.Raw, &rp)
	if err != nil {
		return nil, err
	}

	return rp, nil
}

func ConvertTFJSONToResourceParameters(terraformResourceType string, data []byte) (interface{}, error) {
	var rp interface{}

	switch terraformResourceType {
	case "netbox_ip_address":
		rp = ipaddressv1alpha1.AddressParameters{}
	case "netbox_manufacturer":
		rp = manufacturerv1alpha1.ManufacturerParameters{}
	}

	err := tfjson.TFParser.Unmarshal(data, &rp)
	if err != nil {
		return nil, err
	}

	return rp, nil
}
