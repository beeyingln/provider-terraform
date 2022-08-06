/*
Copyright 2021 The Crossplane Authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

package v1alpha1

import (
	"github.com/crossplane-contrib/provider-jet-template/apis/tools"
	"github.com/pkg/errors"

	"github.com/crossplane/terrajet/pkg/resource"
	"github.com/crossplane/terrajet/pkg/resource/json"
)

// GetTerraformResourceType returns Terraform resource type for this Resource
func (mg *Resource) GetTerraformResourceType() string {
	return mg.ObjectMeta.Annotations["terraformResourceType"]
}

// GetConnectionDetailsMapping for this Resource
func (tr *Resource) GetConnectionDetailsMapping() map[string]string {
	return nil
}

// GetObservation of this Resource
func (tr *Resource) GetObservation() (map[string]interface{}, error) {
	o, err := json.TFParser.Marshal(tr.Status.AtProvider)
	if err != nil {
		return nil, err
	}
	base := map[string]interface{}{}
	return base, json.TFParser.Unmarshal(o, &base)
}

// SetObservation for this Resource
func (tr *Resource) SetObservation(obs map[string]interface{}) error {
	p, err := json.TFParser.Marshal(obs)
	if err != nil {
		return err
	}
	return json.TFParser.Unmarshal(p, &tr.Status.AtProvider)
}

// GetID returns ID of underlying Terraform resource of this Resource
func (tr *Resource) GetID() string {
	id, err := tools.GetObservationId(tr.GetTerraformResourceType(), tr.Status.AtProvider.Raw)
	if err != nil {
		return ""
	}
	return id
}

// GetParameters of this Resource
func (tr *Resource) GetParameters() (map[string]interface{}, error) {
	obj, er := tools.ConvertJSONToResourceParameters(tr.GetTerraformResourceType(), tr.Spec.ForProvider)
	if er != nil {
		return nil, er
	}
	/*p, err := json.TFParser.Marshal(tr.Spec.ForProvider)*/
	p, err := json.TFParser.Marshal(obj)
	if err != nil {
		return nil, err
	}
	base := map[string]interface{}{}
	return base, json.TFParser.Unmarshal(p, &base)
}

// SetParameters for this Resource
func (tr *Resource) SetParameters(params map[string]interface{}) error {
	p, err := json.TFParser.Marshal(params)
	if err != nil {
		return err
	}
	return json.TFParser.Unmarshal(p, &tr.Spec.ForProvider)
}

// LateInitialize this Resource using its observed tfState.
// returns True if there are any spec changes for the resource.
/*func (tr *Resource) LateInitialize(attrs []byte) (bool, error) {
	params := &ResourceParameters{}
	if err := json.TFParser.Unmarshal(attrs, params); err != nil {
		return false, errors.Wrap(err, "failed to unmarshal Terraform state parameters for late-initialization")
	}
	opts := []resource.GenericLateInitializerOption{resource.WithZeroValueJSONOmitEmptyFilter(resource.CNameWildcard)}

	li := resource.NewGenericLateInitializer(opts...)
	return li.LateInitialize(&tr.Spec.ForProvider, params)
}*/
func (tr *Resource) LateInitialize(attrs []byte) (bool, error) {
	params, er := tools.ConvertTFJSONToResourceParameters(tr.GetTerraformResourceType(), attrs)
	if er != nil {
		return false, errors.Wrap(er, "failed to unmarshal Terraform state parameters for late-initialization")
	}
	ap, err := tools.ConvertJSONToResourceParameters(tr.GetTerraformResourceType(), tr.Spec.ForProvider)
	if err != nil {
		return false, errors.Wrap(err, "failed to unmarshal state parameters for late-initialization")
	}

	opts := []resource.GenericLateInitializerOption{resource.WithZeroValueJSONOmitEmptyFilter(resource.CNameWildcard)}

	li := resource.NewGenericLateInitializer(opts...)
	return li.LateInitialize(ap, params)
}

// GetTerraformSchemaVersion returns the associated Terraform schema version
func (tr *Resource) GetTerraformSchemaVersion() int {
	return 0
}
