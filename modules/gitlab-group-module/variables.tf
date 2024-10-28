variable "groups" {
  description = "Map for list of groups"
  type = map(object({
    # required
    name = string
    path = string

    # optional
    auto_devops_enabled = optional(bool)
    avatar              = optional(string)
    avatar_hash         = optional(string)
    default_branch      = optional(string)

    default_branch_protection_defaults = optional(object({
      allow_force_push           = optional(bool)
      allowed_to_merge           = optional(list(string))
      allowed_to_push            = optional(list(string))
      developer_can_initial_push = optional(bool)
    }))

    description                        = optional(string)
    emails_enabled                     = optional(bool)
    extra_shared_runners_minutes_limit = optional(number)
    ip_restriction_ranges              = optional(list(string))
    lfs_enabled                        = optional(bool)
    membership_lock                    = optional(bool)
    mentions_disabled                  = optional(bool)
    parent_id                          = optional(number)
    permanently_remove_on_delete       = optional(bool)
    prevent_forking_outside_group      = optional(bool)
    project_creation_level             = optional(string)
    push_rules = optional(object({
      author_email_regex            = optional(string)
      branch_name_regex             = optional(string)
      commit_committer_check        = optional(bool)
      commit_committer_name_check   = optional(bool)
      commit_message_negative_regex = optional(string)
      commit_message_regex          = optional(string)
      deny_delete_tag               = optional(bool)
      file_name_regex               = optional(string)
      max_file_size                 = optional(number)
      member_check                  = optional(bool)
      prevent_secrets               = optional(bool)
      reject_non_dco_commits        = optional(bool)
      reject_unsigned_commits       = optional(bool)
    }))
    request_access_enabled            = optional(bool)
    require_two_factor_authentication = optional(bool)
    share_with_group_lock             = optional(bool)
    shared_runners_minutes_limit      = optional(number)
    shared_runners_setting            = optional(string)
    subgroup_creation_level           = optional(string)
    two_factor_grace_period           = optional(number)
    visibility_level                  = optional(string)
    wiki_access_level                 = optional(string)
  }))
}

variable "parent_id" {
  description = "Parent group id"
  type        = number
  default     = 0
}
