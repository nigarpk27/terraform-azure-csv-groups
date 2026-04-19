terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
  }
}

provider "azuread" {}

# Read CSV
locals {
  users = csvdecode(file("${path.module}/users.csv"))
}

# Convert list to map
locals {
  users_map = {
    for user in local.users :
    user.name => user
  }
}

# -------------------------
# Create Groups
# -------------------------
resource "azuread_group" "admin" {
  display_name     = "Admin-Group"
  security_enabled = true
}

resource "azuread_group" "dev" {
  display_name     = "Dev-Group"
  security_enabled = true
}

resource "azuread_group" "readonly" {
  display_name     = "ReadOnly-Group"
  security_enabled = true
}

# -------------------------
# Create Users
# -------------------------
resource "azuread_user" "users" {
  for_each = local.users_map

  user_principal_name = "${each.value.name}@nigarparweengmail.onmicrosoft.com"
  display_name        = title(each.value.name)
  mail_nickname       = each.value.name

  password = "P@ssw0rd123!"
}

# -------------------------
# Assign Admin Users
# -------------------------
resource "azuread_group_member" "admin_members" {
  for_each = {
    for k, v in local.users_map : k => v if v.role == "admin"
  }

  group_object_id  = azuread_group.admin.id
  member_object_id = azuread_user.users[each.key].id
}

# -------------------------
# Assign Dev Users
# -------------------------
resource "azuread_group_member" "dev_members" {
  for_each = {
    for k, v in local.users_map : k => v if v.role == "dev"
  }

  group_object_id  = azuread_group.dev.id
  member_object_id = azuread_user.users[each.key].id
}

# -------------------------
# Assign ReadOnly Users
# -------------------------
resource "azuread_group_member" "readonly_members" {
  for_each = {
    for k, v in local.users_map : k => v if v.role == "readonly"
  }

  group_object_id  = azuread_group.readonly.id
  member_object_id = azuread_user.users[each.key].id
}