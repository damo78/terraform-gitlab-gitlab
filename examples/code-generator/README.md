# Code Generator
This example demonstrates how it is possible to use code-generating scripts based on a structured YAML input to provide a convenient method to specify and control complex multi-level hierarchies of groups with the option to specify group defaults, and overrides using YAML.

Note: that any level 0 group, i.e. root level group, cannot be created by terraform.  It will require a terraform import after the `terraform/tofu plan` stage for each level 0 group: 

```terraform import 'module.glab_groups_0.gitlab_group.group["devops"]' <group_id>```

## Usage

The example provided sets some basic defaults as an example and works for most use cases.  Note that the extended available attributes offered by the provider and this project may have some issues if not used in alignment with current Gitlab API quirks, [Issue 6317](https://gitlab.com/gitlab-org/terraform-provider-gitlab/-/issues/6317).


### Generate groups
```bash
pip install -r requirements.txt
python generate_tf_groups.py groups.yml
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_glab_groups_0"></a> [glab\_groups\_0](#module\_glab\_groups\_0) | ../../modules/gitlab-group-module | n/a |
| <a name="module_glab_groups_1"></a> [glab\_groups\_1](#module\_glab\_groups\_1) | ../../modules/gitlab-group-module | n/a |
| <a name="module_glab_groups_2"></a> [glab\_groups\_2](#module\_glab\_groups\_2) | ../../modules/gitlab-group-module | n/a |
| <a name="module_glab_groups_3"></a> [glab\_groups\_3](#module\_glab\_groups\_3) | ../../modules/gitlab-group-module | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gitlab_token"></a> [gitlab\_token](#input\_gitlab\_token) | Gitlab token | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_group_ids"></a> [group\_ids](#output\_group\_ids) | IDs of the created GitLab groups |
| <a name="output_group_names"></a> [group\_names](#output\_group\_names) | Names of the created GitLab groups |
| <a name="output_group_paths"></a> [group\_paths](#output\_group\_paths) | Paths of the created GitLab groups |
<!-- END_TF_DOCS -->