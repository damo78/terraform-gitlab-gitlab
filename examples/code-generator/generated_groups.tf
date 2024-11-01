
module "glab_groups_0" {
  source = "../../modules/gitlab-group-module"
  groups = {
    "devops" = {
      mentions_disabled = false
      request_access_enabled = true
      share_with_group_lock = false
      visibility_level = "private"
      default_branch_protection_defaults = {
  allowed_to_push = []
  developer_can_initial_push = false
  allowed_to_merge = []
  allow_force_push = false
}
      wiki_access_level = "enabled"
      project_creation_level = "developer"
      require_two_factor_authentication = false
      auto_devops_enabled = false
      ip_restriction_ranges = []
      extra_shared_runners_minutes_limit = 0
      subgroup_creation_level = "maintainer"
      default_branch = "main"
      two_factor_grace_period = 48
      prevent_forking_outside_group = false
      shared_runners_setting = "enabled"
      avatar = ""
      avatar_hash = ""
      push_rules = {
  author_email_regex = ""
  max_file_size = null
  commit_message_regex = ""
  file_name_regex = ""
  deny_delete_tag = false
  prevent_secrets = true
  commit_committer_name_check = false
  commit_committer_check = false
  branch_name_regex = ""
  commit_message_negative_regex = ""
  reject_non_dco_commits = false
  reject_unsigned_commits = false
  member_check = false
}
      emails_enabled = true
      permanently_remove_on_delete = false
      membership_lock = false
      lfs_enabled = true
      description = "Root group for Aleph Codes"
      name = "devops"
      path = "devops"
      }
    "engineering" = {
      mentions_disabled = false
      request_access_enabled = true
      share_with_group_lock = false
      visibility_level = "private"
      default_branch_protection_defaults = {
  allowed_to_push = []
  developer_can_initial_push = false
  allowed_to_merge = []
  allow_force_push = false
}
      wiki_access_level = "enabled"
      project_creation_level = "developer"
      require_two_factor_authentication = false
      auto_devops_enabled = false
      ip_restriction_ranges = []
      extra_shared_runners_minutes_limit = 0
      subgroup_creation_level = "maintainer"
      default_branch = "main"
      two_factor_grace_period = 48
      prevent_forking_outside_group = false
      shared_runners_setting = "enabled"
      avatar = ""
      avatar_hash = ""
      push_rules = {
  author_email_regex = ""
  max_file_size = null
  commit_message_regex = ""
  file_name_regex = ""
  deny_delete_tag = false
  prevent_secrets = true
  commit_committer_name_check = false
  commit_committer_check = false
  branch_name_regex = ""
  commit_message_negative_regex = ""
  reject_non_dco_commits = false
  reject_unsigned_commits = false
  member_check = false
}
      emails_enabled = true
      permanently_remove_on_delete = false
      membership_lock = false
      lfs_enabled = true
      description = "Engineering Department"
      name = "Engineering"
      path = "engineering"
      }
    }
}
module "glab_groups_1" {
  source = "../../modules/gitlab-group-module"
  depends_on = [
    module.glab_groups_0,
    ]
  groups = {
    "devops/terraform-projects" = {
      mentions_disabled = false
      request_access_enabled = true
      share_with_group_lock = false
      visibility_level = "private"
      default_branch_protection_defaults = {
  allowed_to_push = []
  developer_can_initial_push = false
  allowed_to_merge = []
  allow_force_push = false
}
      wiki_access_level = "enabled"
      project_creation_level = "developer"
      require_two_factor_authentication = false
      auto_devops_enabled = false
      ip_restriction_ranges = []
      extra_shared_runners_minutes_limit = 0
      subgroup_creation_level = "maintainer"
      default_branch = "main"
      two_factor_grace_period = 48
      prevent_forking_outside_group = false
      shared_runners_setting = "enabled"
      avatar = ""
      avatar_hash = ""
      push_rules = {
  author_email_regex = ""
  max_file_size = null
  commit_message_regex = ""
  file_name_regex = ""
  deny_delete_tag = false
  prevent_secrets = true
  commit_committer_name_check = false
  commit_committer_check = false
  branch_name_regex = ""
  commit_message_negative_regex = ""
  reject_non_dco_commits = false
  reject_unsigned_commits = false
  member_check = false
}
      emails_enabled = true
      permanently_remove_on_delete = false
      membership_lock = false
      lfs_enabled = true
      description = "Terraform projects group implementing infrastructure state"
      name = "Terraform Projects"
      path = "terraform-projects"
      parent_id = module.glab_groups_0.created_groups["devops"].id
      }
    "devops/terraform-shared" = {
      mentions_disabled = false
      request_access_enabled = true
      share_with_group_lock = false
      visibility_level = "private"
      default_branch_protection_defaults = {
  allowed_to_push = []
  developer_can_initial_push = false
  allowed_to_merge = []
  allow_force_push = false
}
      wiki_access_level = "enabled"
      project_creation_level = "developer"
      require_two_factor_authentication = false
      auto_devops_enabled = false
      ip_restriction_ranges = []
      extra_shared_runners_minutes_limit = 0
      subgroup_creation_level = "maintainer"
      default_branch = "main"
      two_factor_grace_period = 48
      prevent_forking_outside_group = false
      shared_runners_setting = "enabled"
      avatar = ""
      avatar_hash = ""
      push_rules = {
  author_email_regex = ""
  max_file_size = null
  commit_message_regex = ""
  file_name_regex = ""
  deny_delete_tag = false
  prevent_secrets = true
  commit_committer_name_check = false
  commit_committer_check = false
  branch_name_regex = ""
  commit_message_negative_regex = ""
  reject_non_dco_commits = false
  reject_unsigned_commits = false
  member_check = false
}
      emails_enabled = true
      permanently_remove_on_delete = false
      membership_lock = false
      lfs_enabled = true
      description = "Terraform modules group shared across terraform-projects"
      name = "Terraform shared"
      path = "terraform-shared"
      parent_id = module.glab_groups_0.created_groups["devops"].id
      }
    "engineering/devops" = {
      mentions_disabled = false
      request_access_enabled = true
      share_with_group_lock = false
      visibility_level = "private"
      default_branch_protection_defaults = {
  allowed_to_push = []
  developer_can_initial_push = false
  allowed_to_merge = []
  allow_force_push = false
}
      wiki_access_level = "enabled"
      project_creation_level = "developer"
      require_two_factor_authentication = false
      auto_devops_enabled = false
      ip_restriction_ranges = []
      extra_shared_runners_minutes_limit = 0
      subgroup_creation_level = "maintainer"
      default_branch = "main"
      two_factor_grace_period = 48
      prevent_forking_outside_group = false
      shared_runners_setting = "enabled"
      avatar = ""
      avatar_hash = ""
      push_rules = {
  author_email_regex = ""
  max_file_size = null
  commit_message_regex = ""
  file_name_regex = ""
  deny_delete_tag = false
  prevent_secrets = true
  commit_committer_name_check = false
  commit_committer_check = false
  branch_name_regex = ""
  commit_message_negative_regex = ""
  reject_non_dco_commits = false
  reject_unsigned_commits = false
  member_check = false
}
      emails_enabled = true
      permanently_remove_on_delete = false
      membership_lock = false
      lfs_enabled = true
      description = "DevOps team for managing CI/CD pipelines"
      name = "DevOps"
      path = "devops"
      parent_id = module.glab_groups_0.created_groups["engineering"].id
      }
    }
}
module "glab_groups_2" {
  source = "../../modules/gitlab-group-module"
  depends_on = [
    module.glab_groups_1,
    ]
  groups = {
    "devops/terraform-projects/glab" = {
      mentions_disabled = false
      request_access_enabled = true
      share_with_group_lock = false
      visibility_level = "private"
      default_branch_protection_defaults = {
  allowed_to_push = []
  developer_can_initial_push = false
  allowed_to_merge = []
  allow_force_push = false
}
      wiki_access_level = "enabled"
      project_creation_level = "developer"
      require_two_factor_authentication = false
      auto_devops_enabled = false
      ip_restriction_ranges = []
      extra_shared_runners_minutes_limit = 0
      subgroup_creation_level = "maintainer"
      default_branch = "main"
      two_factor_grace_period = 48
      prevent_forking_outside_group = false
      shared_runners_setting = "enabled"
      avatar = ""
      avatar_hash = ""
      push_rules = {
  author_email_regex = ""
  max_file_size = null
  commit_message_regex = ""
  file_name_regex = ""
  deny_delete_tag = false
  prevent_secrets = true
  commit_committer_name_check = false
  commit_committer_check = false
  branch_name_regex = ""
  commit_message_negative_regex = ""
  reject_non_dco_commits = false
  reject_unsigned_commits = false
  member_check = false
}
      emails_enabled = true
      permanently_remove_on_delete = false
      membership_lock = false
      lfs_enabled = true
      description = "Terraform project group for glab"
      name = "Terraform glab project"
      path = "glab"
      parent_id = module.glab_groups_1.created_groups["devops/terraform-projects"].id
      }
    "devops/terraform-shared/components" = {
      mentions_disabled = false
      request_access_enabled = true
      share_with_group_lock = false
      visibility_level = "private"
      default_branch_protection_defaults = {
  allowed_to_push = []
  developer_can_initial_push = false
  allowed_to_merge = []
  allow_force_push = false
}
      wiki_access_level = "enabled"
      project_creation_level = "developer"
      require_two_factor_authentication = false
      auto_devops_enabled = false
      ip_restriction_ranges = []
      extra_shared_runners_minutes_limit = 0
      subgroup_creation_level = "maintainer"
      default_branch = "main"
      two_factor_grace_period = 48
      prevent_forking_outside_group = false
      shared_runners_setting = "enabled"
      avatar = ""
      avatar_hash = ""
      push_rules = {
  author_email_regex = ""
  max_file_size = null
  commit_message_regex = ""
  file_name_regex = ""
  deny_delete_tag = false
  prevent_secrets = true
  commit_committer_name_check = false
  commit_committer_check = false
  branch_name_regex = ""
  commit_message_negative_regex = ""
  reject_non_dco_commits = false
  reject_unsigned_commits = false
  member_check = false
}
      emails_enabled = true
      permanently_remove_on_delete = false
      membership_lock = false
      lfs_enabled = true
      description = "Terraform component modules group shared across terraform-projects"
      name = "Terraform shared components"
      path = "components"
      parent_id = module.glab_groups_1.created_groups["devops/terraform-shared"].id
      }
    "devops/terraform-shared/resources" = {
      mentions_disabled = false
      request_access_enabled = true
      share_with_group_lock = false
      visibility_level = "private"
      default_branch_protection_defaults = {
  allowed_to_push = []
  developer_can_initial_push = false
  allowed_to_merge = []
  allow_force_push = false
}
      wiki_access_level = "enabled"
      project_creation_level = "developer"
      require_two_factor_authentication = false
      auto_devops_enabled = false
      ip_restriction_ranges = []
      extra_shared_runners_minutes_limit = 0
      subgroup_creation_level = "maintainer"
      default_branch = "main"
      two_factor_grace_period = 48
      prevent_forking_outside_group = false
      shared_runners_setting = "enabled"
      avatar = ""
      avatar_hash = ""
      push_rules = {
  author_email_regex = ""
  max_file_size = null
  commit_message_regex = ""
  file_name_regex = ""
  deny_delete_tag = false
  prevent_secrets = true
  commit_committer_name_check = false
  commit_committer_check = false
  branch_name_regex = ""
  commit_message_negative_regex = ""
  reject_non_dco_commits = false
  reject_unsigned_commits = false
  member_check = false
}
      emails_enabled = true
      permanently_remove_on_delete = false
      membership_lock = false
      lfs_enabled = true
      description = "Terraform resource modules group shared across terraform-projects"
      name = "Terraform shared resources"
      path = "resources"
      parent_id = module.glab_groups_1.created_groups["devops/terraform-shared"].id
      }
    }
}
module "glab_groups_3" {
  source = "../../modules/gitlab-group-module"
  depends_on = [
    module.glab_groups_2,
    ]
  groups = {
    "devops/terraform-shared/components/frontend" = {
      mentions_disabled = false
      request_access_enabled = true
      share_with_group_lock = false
      visibility_level = "private"
      default_branch_protection_defaults = {
  allowed_to_push = []
  developer_can_initial_push = false
  allowed_to_merge = []
  allow_force_push = false
}
      wiki_access_level = "enabled"
      project_creation_level = "developer"
      require_two_factor_authentication = false
      auto_devops_enabled = false
      ip_restriction_ranges = []
      extra_shared_runners_minutes_limit = 0
      subgroup_creation_level = "maintainer"
      default_branch = "main"
      two_factor_grace_period = 48
      prevent_forking_outside_group = false
      shared_runners_setting = "enabled"
      avatar = ""
      avatar_hash = ""
      push_rules = {
  author_email_regex = ""
  max_file_size = null
  commit_message_regex = ""
  file_name_regex = ""
  deny_delete_tag = false
  prevent_secrets = true
  commit_committer_name_check = false
  commit_committer_check = false
  branch_name_regex = ""
  commit_message_negative_regex = ""
  reject_non_dco_commits = false
  reject_unsigned_commits = false
  member_check = false
}
      emails_enabled = true
      permanently_remove_on_delete = false
      membership_lock = false
      lfs_enabled = true
      description = "Frontend component modules"
      name = "Frontend Components"
      path = "frontend"
      parent_id = module.glab_groups_2.created_groups["devops/terraform-shared/components"].id
      }
    "devops/terraform-shared/components/backend" = {
      mentions_disabled = false
      request_access_enabled = true
      share_with_group_lock = false
      visibility_level = "private"
      default_branch_protection_defaults = {
  allowed_to_push = []
  developer_can_initial_push = false
  allowed_to_merge = []
  allow_force_push = false
}
      wiki_access_level = "enabled"
      project_creation_level = "developer"
      require_two_factor_authentication = false
      auto_devops_enabled = false
      ip_restriction_ranges = []
      extra_shared_runners_minutes_limit = 0
      subgroup_creation_level = "maintainer"
      default_branch = "main"
      two_factor_grace_period = 48
      prevent_forking_outside_group = false
      shared_runners_setting = "enabled"
      avatar = ""
      avatar_hash = ""
      push_rules = {
  author_email_regex = ""
  max_file_size = null
  commit_message_regex = ""
  file_name_regex = ""
  deny_delete_tag = false
  prevent_secrets = true
  commit_committer_name_check = false
  commit_committer_check = false
  branch_name_regex = ""
  commit_message_negative_regex = ""
  reject_non_dco_commits = false
  reject_unsigned_commits = false
  member_check = false
}
      emails_enabled = true
      permanently_remove_on_delete = false
      membership_lock = false
      lfs_enabled = true
      description = "Backend component modules"
      name = "Backend Components"
      path = "backend"
      parent_id = module.glab_groups_2.created_groups["devops/terraform-shared/components"].id
      }
    }
}
