import yaml
import json
from collections import defaultdict
from jinja2 import Environment, Template
import sys
import argparse
from cerberus import Validator
import os

# Define the YAML schema using Cerberus
group_schema = {
    'defaults': {
        'type': 'dict',
        'required': True,
        'schema': {
            'auto_devops_enabled': {'type': 'boolean', 'required': True},
            'avatar': {'type': 'string', 'required': True},
            'avatar_hash': {'type': 'string', 'required': True},
            'default_branch': {'type': 'string', 'required': True},
            'default_branch_protection_defaults': {
                'type': 'dict',
                'required': True,
                'schema': {
                    'allow_force_push': {'type': 'boolean', 'required': True},
                    'allowed_to_merge': {'type': 'list', 'required': True, 'schema': {'type': 'string'}},
                    'allowed_to_push': {'type': 'list', 'required': True, 'schema': {'type': 'string'}},
                    'developer_can_initial_push': {'type': 'boolean', 'required': True},
                }
            },
            'description': {'type': 'string', 'required': True},
            'emails_enabled': {'type': 'boolean', 'required': True},
            'extra_shared_runners_minutes_limit': {'type': 'integer', 'required': True},
            'ip_restriction_ranges': {'type': 'list', 'required': True, 'schema': {'type': 'string'}},
            'lfs_enabled': {'type': 'boolean', 'required': True},
            'membership_lock': {'type': 'boolean', 'required': True},
            'mentions_disabled': {'type': 'boolean', 'required': True},
            'permanently_remove_on_delete': {'type': 'boolean', 'required': True},
            'prevent_forking_outside_group': {'type': 'boolean', 'required': True},
            'project_creation_level': {'type': 'string', 'required': True, 'allowed': ['disabled', 'maintainer', 'developer']},
            'push_rules': {
                'type': 'dict',
                'required': True,
                'schema': {
                    'author_email_regex': {'type': 'string', 'required': True},
                    'branch_name_regex': {'type': 'string', 'required': True},
                    'commit_committer_check': {'type': 'boolean', 'required': True},
                    'commit_committer_name_check': {'type': 'boolean', 'required': True},
                    'commit_message_negative_regex': {'type': 'string', 'required': True},
                    'commit_message_regex': {'type': 'string', 'required': True},
                    'deny_delete_tag': {'type': 'boolean', 'required': True},
                    'file_name_regex': {'type': 'string', 'required': True},
                    'max_file_size': {'type': 'integer', 'required': False, 'nullable': True},
                    'member_check': {'type': 'boolean', 'required': True},
                    'prevent_secrets': {'type': 'boolean', 'required': True},
                    'reject_non_dco_commits': {'type': 'boolean', 'required': True},
                    'reject_unsigned_commits': {'type': 'boolean', 'required': True},
                }
            },
            'request_access_enabled': {'type': 'boolean', 'required': True},
            'require_two_factor_authentication': {'type': 'boolean', 'required': True},
            'share_with_group_lock': {'type': 'boolean', 'required': True},
            'shared_runners_setting': {'type': 'string', 'required': True, 'allowed': ['enabled', 'disabled']},
            'subgroup_creation_level': {'type': 'string', 'required': True, 'allowed': ['noone', 'maintainer', 'developer']},
            'two_factor_grace_period': {'type': 'integer', 'required': True},
            'visibility_level': {'type': 'string', 'required': True, 'allowed': ['private', 'internal', 'public']},
            'wiki_access_level': {'type': 'string', 'required': True, 'allowed': ['disabled', 'private', 'enabled']},
        }
    },
    'groups': {
        'type': 'list',
        'required': True,
        'schema': {
            'type': 'dict',
            'schema': {
                'level': {'type': 'integer', 'required': True, 'min': 0},
                'key': {'type': 'string', 'required': True},
                'name': {'type': 'string', 'required': True},
                'path': {'type': 'string', 'required': True},
                'parent_key': {'type': 'string', 'required': False, 'regex': r'^([a-zA-Z0-9\-]+)(/[a-zA-Z0-9\-]+)*$'},
                'attributes': {'type': 'dict', 'required': True},
            }
        }
    }
}

# Template for Terraform module blocks with depends_on and improved whitespace control
TERRAFORM_MODULE_TEMPLATE = """
{% for module in modules -%}
module "{{ module.name }}" {
  source = "../../modules/gitlab-group-module"
  {% if module.depends_on -%}
  depends_on = [
    {% for dependency in module.depends_on -%}
    {{ dependency }},
    {% endfor -%}
  ]
  {% endif -%}
  groups = {
    {% for group_name, group_attrs in module.groups.items() -%}
    "{{ group_name }}" = {
      {% for key, value in group_attrs.items() -%}
      {{ key }} = {{ value | to_terraform }}
      {% endfor -%}
    }
    {% endfor -%}
  }
}
{% endfor -%}
"""

# Template for Terraform outputs
TERRAFORM_OUTPUT_TEMPLATE = """
output "group_ids" {
  description = "IDs of the created GitLab groups"
  value = {
    {% for group in all_groups -%}
    "{{ group.full_path }}" = module.{{ group.module_name }}.created_groups["{{ group.key }}"].id
    {% endfor -%}
  }
}

output "group_names" {
  description = "Names of the created GitLab groups"
  value = {
    {% for group in all_groups -%}
    "{{ group.full_path }}" = module.{{ group.module_name }}.created_groups["{{ group.key }}"].name
    {% endfor -%}
  }
}

output "group_paths" {
  description = "Paths of the created GitLab groups"
  value = {
    {% for group in all_groups -%}
    "{{ group.full_path }}" = module.{{ group.module_name }}.created_groups["{{ group.key }}"].path
    {% endfor -%}
  }
}
"""

# Function to convert Python dicts to HCL-compatible strings
def dict_to_hcl(d, indent=2):
    lines = ["{"]
    for key, value in d.items():
        if isinstance(value, dict):
            nested = dict_to_hcl(value, indent + 2)
            lines.append(" " * indent + f"{key} = {nested}")
        elif isinstance(value, list):
            if all(isinstance(item, str) for item in value):
                list_items = ", ".join([f'"{item}"' for item in value])
            else:
                list_items = ", ".join([to_terraform(item) for item in value])
            lines.append(" " * indent + f"{key} = [{list_items}]")
        else:
            lines.append(" " * indent + f"{key} = {to_terraform(value)}")
    lines.append(" " * (indent - 2) + "}")
    return "\n".join(lines)

# Custom Jinja2 filter to convert Python types to Terraform-compatible strings
def to_terraform(value):
    if isinstance(value, str):
        if value.startswith('expr:'):
            return value[5:]  # Remove 'expr:' prefix and return as-is
        return f'"{value}"'
    elif isinstance(value, bool):
        return "true" if value else "false"
    elif value is None:
        return "null"
    elif isinstance(value, dict):
        # Convert dictionary to Terraform map syntax
        return dict_to_hcl(value, indent=2)
    elif isinstance(value, list):
        # Convert list to Terraform list syntax
        list_items = ", ".join([to_terraform(item) for item in value])
        return f"[{list_items}]"
    else:
        return str(value)

def main(yaml_file, output_tf, output_tf_outputs):
    # Load YAML configuration
    try:
        with open(yaml_file, 'r') as f:
            config = yaml.safe_load(f)
    except yaml.YAMLError as e:
        print(f"Error parsing YAML file: {e}")
        sys.exit(1)
    except FileNotFoundError:
        print(f"Error: YAML file '{yaml_file}' not found.")
        sys.exit(1)

    # Validate YAML configuration against schema
    v = Validator(group_schema, require_all=True)
    if not v.validate(config):
        print("YAML validation failed with the following errors:")
        for field, errors in v.errors.items():
            if isinstance(errors, list):
                for error in errors:
                    print(f" - {field}: {error}")
            elif isinstance(errors, dict):
                for subfield, suberrors in errors.items():
                    for error in suberrors:
                        print(f" - {field}.{subfield}: {error}")
            else:
                print(f" - {field}: {errors}")
        sys.exit(1)

    defaults = config.get('defaults', {})
    groups = config.get('groups', [])

    # Create a mapping from group key to group details for easy lookup
    group_map = {group['key']: group for group in groups}

    # Organize groups by level
    levels = defaultdict(list)
    for group in groups:
        level = group['level']
        levels[level].append(group)

    # Sort levels to ensure parents are processed before children
    sorted_levels = sorted(levels.items())

    # Track group keys to their full paths and module names for dependency resolution
    group_full_path_map = {}  # key -> full_path
    group_to_module = {}       # key -> module_name

    # Collect all groups for output generation
    all_groups = []

    # Prepare modules
    modules = []
    for level, groups_in_level in sorted_levels:
        module_name = f"glab_groups_{level}"
        module_groups = {}
        depends_on = set()

        for group in groups_in_level:
            key = group['key']
            path = group['path']
            parent_key = group.get('parent_key')

            # Compute full_path
            if parent_key:
                if parent_key not in group_full_path_map:
                    print(f"Error: Group '{key}' references undefined parent_key '{parent_key}'.")
                    sys.exit(1)
                parent_full_path = group_full_path_map[parent_key]
                full_path = f"{parent_full_path}/{path}"
            else:
                full_path = path  # For level 0 groups

            # Ensure full_path is unique
            if full_path in group_full_path_map.values():
                print(f"Error: Duplicate full_path '{full_path}' detected for group '{key}'.")
                sys.exit(1)

            group_full_path_map[key] = full_path

            # Merge defaults and group-specific attributes
            attributes = merge_dicts(defaults, group.get('attributes', {}))

            # Add 'name' and 'path' to attributes
            attributes['name'] = group['name']
            attributes['path'] = group['path']

            # Handle parent_key if present
            if parent_key:
                parent_module = group_to_module.get(parent_key)
                if parent_module is None:
                    print(f"Error: Parent group '{parent_key}' for group '{key}' has not been processed yet.")
                    sys.exit(1)

                # Reference parent_id using Terraform module output
                parent_id_expr = f'module.{parent_module}.created_groups["{parent_key}"].id'
                attributes['parent_id'] = f'expr:{parent_id_expr}'

                # Add dependency on the parent module
                depends_on.add(f'module.{parent_module}')

                # Validate level
                parent_group = group_map.get(parent_key)
                if parent_group:
                    expected_level = parent_group['level'] + 1
                    if group['level'] != expected_level:
                        print(f"Error: Group '{key}' is at level {group['level']} but its parent '{parent_key}' is at level {parent_group['level']}. Expected level {parent_group['level'] + 1}.")
                        sys.exit(1)

            module_groups[key] = attributes
            group_to_module[key] = module_name

            # Collect group info for outputs
            all_groups.append({
                'key': key,
                'full_path': full_path,
                'module_name': module_name
            })

        # Add depends_on for the module if there are dependencies
        if depends_on:
            # Ensure dependencies are unique and sorted
            depends_on = sorted(depends_on)
        else:
            depends_on = []

        modules.append({
            'name': module_name,
            'groups': module_groups,
            'depends_on': depends_on
        })

    # Create Jinja2 Environment and register the custom filter
    env = Environment()
    env.filters['to_terraform'] = to_terraform

    # Create Jinja2 template for modules
    module_template = env.from_string(TERRAFORM_MODULE_TEMPLATE)

    # Render Terraform modules
    terraform_modules = module_template.render(modules=modules)

    # Create Jinja2 template for outputs
    output_template = env.from_string(TERRAFORM_OUTPUT_TEMPLATE)

    # Render Terraform outputs
    terraform_outputs = output_template.render(all_groups=all_groups)

    # Write module definitions to output_tf
    try:
        # Ensure the output directory exists
        output_dir = os.path.dirname(os.path.abspath(output_tf))
        if output_dir and not os.path.exists(output_dir):
            os.makedirs(output_dir, exist_ok=True)

        with open(output_tf, 'w') as f:
            f.write(terraform_modules)
    except IOError as e:
        print(f"Error writing to output file '{output_tf}': {e}")
        sys.exit(1)

    print(f"Terraform modules generated successfully in '{output_tf}'.")

    # Write outputs to output_tf_outputs
    try:
        # Ensure the output directory exists
        output_dir = os.path.dirname(os.path.abspath(output_tf_outputs))
        if output_dir and not os.path.exists(output_dir):
            os.makedirs(output_dir, exist_ok=True)

        with open(output_tf_outputs, 'w') as f:
            f.write(terraform_outputs)
    except IOError as e:
        print(f"Error writing to outputs file '{output_tf_outputs}': {e}")
        sys.exit(1)

    print(f"Terraform outputs generated successfully in '{output_tf_outputs}'.")

def merge_dicts(defaults, overrides):
    """
    Recursively merge two dictionaries. The overrides take precedence over defaults.
    """
    result = {}
    for key in set(defaults.keys()).union(overrides.keys()):
        if key in defaults and key not in overrides:
            result[key] = defaults[key]
        elif key not in defaults and key in overrides:
            result[key] = overrides[key]
        else:
            if isinstance(defaults[key], dict) and isinstance(overrides[key], dict):
                result[key] = merge_dicts(defaults[key], overrides[key])
            else:
                result[key] = overrides[key]
    return result

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Generate Terraform groups from YAML configuration with validation and unique paths.')
    parser.add_argument('yaml_file', help='Path to the YAML configuration file.')
    parser.add_argument('-o', '--output', default='generated_groups.tf', help='Output Terraform modules file.')
    parser.add_argument('-O', '--output-outputs', default='generated_groups_output.tf', help='Output Terraform outputs file.')
    args = parser.parse_args()

    main(args.yaml_file, args.output, args.output_outputs)