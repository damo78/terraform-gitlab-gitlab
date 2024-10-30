variable "projects" {
  description = "Map for list of projects"
  type = map(object({
    # required
    name = string

    # optional
    allow_merge_on_skipped_pipeline           = optional(bool)
    allow_pipeline_trigger_approve_deployment = optional(bool)
    analytics_access_level                    = optional(string)
    approvals_before_merge                    = optional(number)
    archive_on_destroy                        = optional(bool)
    archived                                  = optional(bool)
    auto_cancel_pending_pipelines             = optional(string)
    auto_devops_deploy_strategy               = optional(string)
    auto_devops_enabled                       = optional(bool)
    autoclose_referenced_issues               = optional(bool)
    avatar                                    = optional(string)
    avatar_hash                               = optional(string)
    build_git_strategy                        = optional(string)
    build_timeout                             = optional(number)
    builds_access_level                       = optional(string)
    ci_config_path                            = optional(string)
    ci_default_git_depth                      = optional(number)
    ci_forward_deployment_enabled             = optional(bool)
    ci_restrict_pipeline_cancellation_role    = optional(string)
    ci_separated_caches                       = optional(bool)

    container_expiration_policy = optional(object({
      cadence           = optional(string)
      enabled           = optional(bool)
      keep_n            = optional(number)
      name_regex_delete = optional(string)
      name_regex_keep   = optional(string)
      older_than        = optional(string)
      })
    )

    container_registry_access_level                  = optional(string)
    default_branch                                   = optional(string)
    description                                      = optional(string)
    emails_enabled                                   = optional(bool)
    environments_access_level                        = optional(string)
    external_authorization_classification_label      = optional(string)
    feature_flags_access_level                       = optional(string)
    forked_from_project_id                           = optional(number)
    forking_access_level                             = optional(string)
    group_runners_enabled                            = optional(bool)
    group_with_project_templates_id                  = optional(number)
    import_url                                       = optional(string)
    import_url_password                              = optional(string)
    import_url_username                              = optional(string)
    infrastructure_access_level                      = optional(string)
    initialize_with_readme                           = optional(bool)
    issues_access_level                              = optional(string)
    issues_enabled                                   = optional(bool)
    issues_template                                  = optional(string)
    keep_latest_artifact                             = optional(bool)
    lfs_enabled                                      = optional(bool)
    merge_commit_template                            = optional(string)
    merge_method                                     = optional(string)
    merge_pipelines_enabled                          = optional(bool)
    merge_requests_access_level                      = optional(string)
    merge_requests_enabled                           = optional(bool)
    merge_requests_template                          = optional(string)
    merge_trains_enabled                             = optional(bool)
    mirror                                           = optional(bool)
    mirror_overwrites_diverged_branches              = optional(bool)
    mirror_trigger_builds                            = optional(bool)
    model_experiments_access_level                   = optional(string)
    model_registry_access_level                      = optional(string)
    monitor_access_level                             = optional(string)
    mr_default_target_self                           = optional(bool)
    namespace_id                                     = optional(number)
    only_allow_merge_if_all_discussions_are_resolved = optional(bool)
    only_allow_merge_if_pipeline_succeeds            = optional(bool)
    only_mirror_protected_branches                   = optional(bool)
    packages_enabled                                 = optional(bool)
    pages_access_level                               = optional(string)
    path                                             = optional(string)
    pre_receive_secret_detection_enabled             = optional(bool)
    printing_merge_request_link_enabled              = optional(bool)
    public_jobs                                      = optional(bool)

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
      })
    )

    releases_access_level                   = optional(string)
    remove_source_branch_after_merge        = optional(bool)
    repository_access_level                 = optional(string)
    repository_storage                      = optional(string)
    request_access_enabled                  = optional(bool)
    requirements_access_level               = optional(string)
    resolve_outdated_diff_discussions       = optional(bool)
    restrict_user_defined_variables         = optional(bool)
    security_and_compliance_access_level    = optional(string)
    shared_runners_enabled                  = optional(bool)
    skip_wait_for_default_branch_protection = optional(bool)
    snippets_access_level                   = optional(string)
    snippets_enabled                        = optional(bool)
    squash_commit_template                  = optional(string)
    squash_option                           = optional(string)
    suggestion_commit_message               = optional(string)
    tags                                    = optional(list(string))
    template_name                           = optional(string)
    template_project_id                     = optional(number)

    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
    }))

    topics              = optional(list(string))
    use_custom_template = optional(bool)
    visibility_level    = optional(string)
    wiki_access_level   = optional(string)
    wiki_enabled        = optional(bool)
  }))
}
