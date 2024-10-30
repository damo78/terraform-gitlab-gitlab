resource "gitlab_project" "project" {
  for_each = var.projects

  # required
  name = each.value.name

  # optional
  allow_merge_on_skipped_pipeline           = lookup(each.value, "allow_merge_on_skipped_pipeline", false)
  allow_pipeline_trigger_approve_deployment = lookup(each.value, "allow_pipeline_trigger_approve_deployment", false)
  analytics_access_level                    = lookup(each.value, "analytics_access_level", "private")
  approvals_before_merge                    = lookup(each.value, "approvals_before_merge", 0)
  archive_on_destroy                        = lookup(each.value, "archive_on_destroy", null)
  archived                                  = lookup(each.value, "archived", false)
  auto_cancel_pending_pipelines             = lookup(each.value, "auto_cancel_pending_pipelines", "enabled")
  auto_devops_deploy_strategy               = lookup(each.value, "auto_devops_deploy_strategy", "manual")
  auto_devops_enabled                       = lookup(each.value, "auto_devops_enabled", false)
  autoclose_referenced_issues               = lookup(each.value, "autoclose_referenced_issues", false)
  avatar                                    = lookup(each.value, "avatar", "")
  avatar_hash                               = lookup(each.value, "avatar_hash", "")
  build_git_strategy                        = lookup(each.value, "build_git_strategy", "fetch")
  build_timeout                             = lookup(each.value, "build_timeout", 3600)
  builds_access_level                       = lookup(each.value, "builds_access_level", "private")
  ci_config_path                            = lookup(each.value, "ci_config_path", "")
  ci_default_git_depth                      = lookup(each.value, "ci_default_git_depth", 20)
  ci_forward_deployment_enabled             = lookup(each.value, "ci_forward_deployment_enabled", true)
  ci_restrict_pipeline_cancellation_role    = lookup(each.value, "ci_restrict_pipeline_cancellation_role", "not_protected")
  ci_separated_caches                       = lookup(each.value, "ci_separated_caches", false)

  dynamic "container_expiration_policy" {
    for_each = lookup(each.value, "container_expiration_policy", null) != null ? [1] : []
    content {
      cadence           = lookup(each.value.container_expiration_policy, "cadence", "24h")
      enabled           = lookup(each.value.container_expiration_policy, "enabled", true)
      keep_n            = lookup(each.value.container_expiration_policy, "keep_n", 0)
      name_regex_delete = lookup(each.value.container_expiration_policy, "name_regex_delete", "")
      name_regex_keep   = lookup(each.value.container_expiration_policy, "name_regex_keep", "")
      older_than        = lookup(each.value.container_expiration_policy, "older_than", "30d")
    }
  }

  container_registry_access_level                  = lookup(each.value, "container_registry_access_level", "disabled")
  default_branch                                   = lookup(each.value, "default_branch", "main")
  description                                      = lookup(each.value, "description", "")
  emails_enabled                                   = lookup(each.value, "emails_enabled", true)
  environments_access_level                        = lookup(each.value, "environments_access_level", "private")
  external_authorization_classification_label      = lookup(each.value, "external_authorization_classification_label", "External Authorization")
  feature_flags_access_level                       = lookup(each.value, "feature_flags_access_level", "disabled")
  forked_from_project_id                           = lookup(each.value, "forked_from_project_id", null)
  forking_access_level                             = lookup(each.value, "forking_access_level", "disabled")
  group_runners_enabled                            = lookup(each.value, "group_runners_enabled", true)
  group_with_project_templates_id                  = lookup(each.value, "group_with_project_templates_id", null)
  import_url                                       = lookup(each.value, "import_url", null)
  import_url_password                              = lookup(each.value, "import_url_password", "")
  import_url_username                              = lookup(each.value, "import_url_username", "")
  infrastructure_access_level                      = lookup(each.value, "infrastructure_access_level", "disabled")
  initialize_with_readme                           = lookup(each.value, "initialize_with_readme", null)
  issues_access_level                              = lookup(each.value, "issues_access_level", "disabled")
  issues_enabled                                   = lookup(each.value, "issues_enabled", true)
  issues_template                                  = lookup(each.value, "issues_template", "")
  keep_latest_artifact                             = lookup(each.value, "keep_latest_artifact", true)
  lfs_enabled                                      = lookup(each.value, "lfs_enabled", true)
  merge_commit_template                            = lookup(each.value, "merge_commit_template", "")
  merge_method                                     = lookup(each.value, "merge_method", "merge")
  merge_pipelines_enabled                          = lookup(each.value, "merge_pipelines_enabled", false)
  merge_requests_access_level                      = lookup(each.value, "merge_requests_access_level", "disabled")
  merge_requests_enabled                           = lookup(each.value, "merge_requests_enabled", true)
  merge_requests_template                          = lookup(each.value, "merge_requests_template", "")
  merge_trains_enabled                             = lookup(each.value, "merge_trains_enabled", false)
  mirror                                           = lookup(each.value, "mirror", null)
  mirror_overwrites_diverged_branches              = lookup(each.value, "mirror_overwrites_diverged_branches", null)
  mirror_trigger_builds                            = lookup(each.value, "mirror_trigger_builds", null)
  model_experiments_access_level                   = lookup(each.value, "model_experiments_access_level", "disabled")
  model_registry_access_level                      = lookup(each.value, "model_registry_access_level", "disabled")
  monitor_access_level                             = lookup(each.value, "monitor_access_level", "disabled")
  mr_default_target_self                           = lookup(each.value, "mr_default_target_self", false)
  namespace_id                                     = lookup(each.value, "namespace_id", null)
  only_allow_merge_if_all_discussions_are_resolved = lookup(each.value, "only_allow_merge_if_all_discussions_are_resolved", false)
  only_allow_merge_if_pipeline_succeeds            = lookup(each.value, "only_allow_merge_if_pipeline_succeeds", false)
  only_mirror_protected_branches                   = lookup(each.value, "only_mirror_protected_branches", null)
  packages_enabled                                 = lookup(each.value, "packages_enabled", true)
  pages_access_level                               = lookup(each.value, "pages_access_level", "private")
  path                                             = lookup(each.value, "path", each.value.name) # set name as path
  pre_receive_secret_detection_enabled             = lookup(each.value, "pre_receive_secret_detection_enabled", true)
  printing_merge_request_link_enabled              = lookup(each.value, "printing_merge_request_link_enabled", true)
  public_jobs                                      = lookup(each.value, "public_jobs", false)

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

  releases_access_level                   = lookup(each.value, "releases_access_level", "disabled")
  remove_source_branch_after_merge        = lookup(each.value, "remove_source_branch_after_merge", true)
  repository_access_level                 = lookup(each.value, "repository_access_level", "disabled")
  repository_storage                      = lookup(each.value, "repository_storage", "default")
  request_access_enabled                  = lookup(each.value, "request_access_enabled", true)
  requirements_access_level               = lookup(each.value, "requirements_access_level", "disabled")
  resolve_outdated_diff_discussions       = lookup(each.value, "resolve_outdated_diff_discussions", false)
  restrict_user_defined_variables         = lookup(each.value, "restrict_user_defined_variables", false)
  security_and_compliance_access_level    = lookup(each.value, "security_and_compliance_access_level", "disabled")
  shared_runners_enabled                  = lookup(each.value, "shared_runners_enabled", true)
  skip_wait_for_default_branch_protection = lookup(each.value, "skip_wait_for_default_branch_protection", true)
  snippets_access_level                   = lookup(each.value, "snippets_access_level", "disabled")
  snippets_enabled                        = lookup(each.value, "snippets_enabled", true)
  squash_commit_template                  = lookup(each.value, "squash_commit_template", "")
  squash_option                           = lookup(each.value, "squash_option", "default_off")
  suggestion_commit_message               = lookup(each.value, "suggestion_commit_message", "")
  tags                                    = lookup(each.value, "tags", [])
  template_name                           = lookup(each.value, "template_name", null)
  template_project_id                     = lookup(each.value, "template_project_id", null)

  dynamic "timeouts" {
    for_each = lookup(each.value, "timeouts", null) != null ? [1] : []
    content {
      create = lookup(each.value.timeouts, "create", null)
      delete = lookup(each.value.timeouts, "delete", null)
    }
  }

  topics              = lookup(each.value, "topics", [])
  use_custom_template = lookup(each.value, "use_custom_template", null)
  visibility_level    = lookup(each.value, "visibility_level", "private")
  wiki_access_level   = lookup(each.value, "wiki_access_level", "disabled")
  wiki_enabled        = lookup(each.value, "wiki_enabled", true)

}
