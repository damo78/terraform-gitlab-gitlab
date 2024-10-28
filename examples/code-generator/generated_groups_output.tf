
output "group_ids" {
  description = "IDs of the created GitLab groups"
  value = {
    "devops" = module.glab_groups_0.created_groups["devops"].id
    "engineering" = module.glab_groups_0.created_groups["engineering"].id
    "devops/terraform-projects" = module.glab_groups_1.created_groups["devops/terraform-projects"].id
    "devops/terraform-shared" = module.glab_groups_1.created_groups["devops/terraform-shared"].id
    "engineering/devops" = module.glab_groups_1.created_groups["engineering/devops"].id
    "devops/terraform-projects/glab" = module.glab_groups_2.created_groups["devops/terraform-projects/glab"].id
    "devops/terraform-shared/components" = module.glab_groups_2.created_groups["devops/terraform-shared/components"].id
    "devops/terraform-shared/resources" = module.glab_groups_2.created_groups["devops/terraform-shared/resources"].id
    "devops/terraform-shared/components/frontend" = module.glab_groups_3.created_groups["devops/terraform-shared/components/frontend"].id
    "devops/terraform-shared/components/backend" = module.glab_groups_3.created_groups["devops/terraform-shared/components/backend"].id
    }
}

output "group_names" {
  description = "Names of the created GitLab groups"
  value = {
    "devops" = module.glab_groups_0.created_groups["devops"].name
    "engineering" = module.glab_groups_0.created_groups["engineering"].name
    "devops/terraform-projects" = module.glab_groups_1.created_groups["devops/terraform-projects"].name
    "devops/terraform-shared" = module.glab_groups_1.created_groups["devops/terraform-shared"].name
    "engineering/devops" = module.glab_groups_1.created_groups["engineering/devops"].name
    "devops/terraform-projects/glab" = module.glab_groups_2.created_groups["devops/terraform-projects/glab"].name
    "devops/terraform-shared/components" = module.glab_groups_2.created_groups["devops/terraform-shared/components"].name
    "devops/terraform-shared/resources" = module.glab_groups_2.created_groups["devops/terraform-shared/resources"].name
    "devops/terraform-shared/components/frontend" = module.glab_groups_3.created_groups["devops/terraform-shared/components/frontend"].name
    "devops/terraform-shared/components/backend" = module.glab_groups_3.created_groups["devops/terraform-shared/components/backend"].name
    }
}

output "group_paths" {
  description = "Paths of the created GitLab groups"
  value = {
    "devops" = module.glab_groups_0.created_groups["devops"].path
    "engineering" = module.glab_groups_0.created_groups["engineering"].path
    "devops/terraform-projects" = module.glab_groups_1.created_groups["devops/terraform-projects"].path
    "devops/terraform-shared" = module.glab_groups_1.created_groups["devops/terraform-shared"].path
    "engineering/devops" = module.glab_groups_1.created_groups["engineering/devops"].path
    "devops/terraform-projects/glab" = module.glab_groups_2.created_groups["devops/terraform-projects/glab"].path
    "devops/terraform-shared/components" = module.glab_groups_2.created_groups["devops/terraform-shared/components"].path
    "devops/terraform-shared/resources" = module.glab_groups_2.created_groups["devops/terraform-shared/resources"].path
    "devops/terraform-shared/components/frontend" = module.glab_groups_3.created_groups["devops/terraform-shared/components/frontend"].path
    "devops/terraform-shared/components/backend" = module.glab_groups_3.created_groups["devops/terraform-shared/components/backend"].path
    }
}