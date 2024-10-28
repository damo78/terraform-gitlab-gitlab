resource "gitlab_group" "group" {
  for_each = var.groups

  # required
  name = each.value.name
  path = each.value.path

  # optional
  auto_devops_enabled = lookup(each.value, "auto_devops_enabled", false)
  avatar              = lookup(each.value, "avatar", "")
  avatar_hash         = lookup(each.value, "avatar_hash", "")
  default_branch      = lookup(each.value, "default_branch", "main")

  dynamic "default_branch_protection_defaults" {
    for_each = lookup(each.value, "default_branch_protection_defaults", null) != null ? [1] : []
    content {
      allow_force_push           = lookup(each.value.default_branch_protection_defaults, "allow_force_push", false)
      allowed_to_merge           = lookup(each.value.default_branch_protection_defaults, "allowed_to_merge", [])
      allowed_to_push            = lookup(each.value.default_branch_protection_defaults, "allowed_to_push", [])
      developer_can_initial_push = lookup(each.value.default_branch_protection_defaults, "developer_can_initial_push", false)
    }
  }

  description                        = lookup(each.value, "description", "default_description")
  emails_enabled                     = lookup(each.value, "emails_enabled", true)
  extra_shared_runners_minutes_limit = lookup(each.value, "extra_shared_runners_minutes_limit", 0)
  ip_restriction_ranges              = lookup(each.value, "ip_restriction_ranges", [])
  lfs_enabled                        = lookup(each.value, "lfs_enabled", true)
  membership_lock                    = lookup(each.value, "membership_lock", false)
  mentions_disabled                  = lookup(each.value, "mentions_disabled", false)
  parent_id                          = lookup(each.value, "parent_id", var.parent_id)
  permanently_remove_on_delete       = lookup(each.value, "permanently_remove_on_delete", false)
  prevent_forking_outside_group      = lookup(each.value, "prevent_forking_outside_group", null)
  project_creation_level             = lookup(each.value, "project_creation_level", "Maintainer")

  dynamic "push_rules" {
    for_each = lookup(each.value, "push_rules", null) != null ? [1] : []
    content {
      author_email_regex            = lookup(each.value.push_rules, "author_email_regex", "")
      branch_name_regex             = lookup(each.value.push_rules, "branch_name_regex", "")
      commit_committer_check        = lookup(each.value.push_rules, "commit_committer_check", false)
      commit_committer_name_check   = lookup(each.value.push_rules, "commit_committer_name_check", false)
      commit_message_negative_regex = lookup(each.value.push_rules, "commit_message_negative_regex", "")
      commit_message_regex          = lookup(each.value.push_rules, "commit_message_regex", "")
      deny_delete_tag               = lookup(each.value.push_rules, "deny_delete_tag", false)
      file_name_regex               = lookup(each.value.push_rules, "file_name_regex", "")
      max_file_size                 = lookup(each.value.push_rules, "max_file_size", 0)
      member_check                  = lookup(each.value.push_rules, "member_check", false)
      prevent_secrets               = lookup(each.value.push_rules, "prevent_secrets", false)
      reject_non_dco_commits        = lookup(each.value.push_rules, "reject_non_dco_commits", false)
      reject_unsigned_commits       = lookup(each.value.push_rules, "reject_unsigned_commits", false)
    }
  }

  request_access_enabled            = lookup(each.value, "request_access_enabled", false)
  require_two_factor_authentication = lookup(each.value, "require_two_factor_authentication", false)

  share_with_group_lock        = lookup(each.value, "share_with_group_lock", false)
  shared_runners_minutes_limit = lookup(each.value, "shared_runners_minutes_limit", null)
  shared_runners_setting       = lookup(each.value, "shared_runners_setting", null)
  subgroup_creation_level      = lookup(each.value, "subgroup_creation_level", "Owner")
  two_factor_grace_period      = lookup(each.value, "two_factor_grace_period", 48)
  visibility_level             = lookup(each.value, "visibility_level", "private")

  wiki_access_level = lookup(each.value, "wiki_access_level", null)
}
