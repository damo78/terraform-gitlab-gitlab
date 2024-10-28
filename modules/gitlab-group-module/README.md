# gitlab-group-module

## Usage

See `../../examples` for usage information

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3 |
| <a name="requirement_gitlab"></a> [gitlab](#requirement\_gitlab) | ~> 17.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_gitlab"></a> [gitlab](#provider\_gitlab) | ~> 17.5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [gitlab_group.group](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_groups"></a> [groups](#input\_groups) | Map for list of groups | <pre>map(object({<br>    # required<br>    name = string<br>    path = string<br><br>    # optional<br>    auto_devops_enabled = optional(bool)<br>    avatar              = optional(string)<br>    avatar_hash         = optional(string)<br>    default_branch      = optional(string)<br><br>    default_branch_protection_defaults = optional(map(object({<br>      allow_force_push           = optional(bool)<br>      allowed_to_merge           = optional(list(string))<br>      allowed_to_push            = optional(list(string))<br>      developer_can_initial_push = optional(bool)<br>    })))<br><br>    description                        = optional(string)<br>    emails_enabled                     = optional(bool)<br>    extra_shared_runners_minutes_limit = optional(number)<br>    ip_restriction_ranges              = optional(list(string))<br>    lfs_enabled                        = optional(bool)<br>    membership_lock                    = optional(bool)<br>    mentions_disabled                  = optional(bool)<br>    parent_id                          = optional(number)<br>    permanently_remove_on_delete       = optional(bool)<br>    prevent_forking_outside_group      = optional(bool)<br>    project_creation_level             = optional(string)<br>    push_rules = optional(map(object({<br>      author_email_regex            = optional(string)<br>      branch_name_regex             = optional(string)<br>      commit_committer_check        = optional(bool)<br>      commit_committer_name_check   = optional(bool)<br>      commit_message_negative_regex = optional(string)<br>      commit_message_regex          = optional(string)<br>      deny_delete_tag               = optional(bool)<br>      file_name_regex               = optional(string)<br>      max_file_size                 = optional(number)<br>      member_check                  = optional(bool)<br>      prevent_secrets               = optional(bool)<br>      reject_non_dco_commits        = optional(bool)<br>      reject_unsigned_commits       = optional(bool)<br>    })))<br>    request_access_enabled            = optional(bool)<br>    require_two_factor_authentication = optional(bool)<br>    share_with_group_lock             = optional(bool)<br>    shared_runners_minutes_limit      = optional(number)<br>    shared_runners_setting            = optional(string)<br>    subgroup_creation_level           = optional(string)<br>    two_factor_grace_period           = optional(number)<br>    visibility_level                  = optional(string)<br>    wiki_access_level                 = optional(string)<br><br>    # read-only<br>    # avatar_url    = optional(string)<br>    # full_name     = optional(string)<br>    # full_path     = optional(string)<br>    # id            = optional(string)<br>    # runners_token = optional(string)<br>    # web_url       = optional(string)<br><br>  }))</pre> | n/a | yes |
| <a name="input_parent_id"></a> [parent\_id](#input\_parent\_id) | Parent group id | `number` | `0` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_created_groups"></a> [created\_groups](#output\_created\_groups) | List of created groups with module |
<!-- END_TF_DOCS -->
