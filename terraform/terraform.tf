terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.85.0"  # Azure provider (latest stable)
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"  
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"  # Unchanged
    }

/*
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23.0" # (for AKS interactions)
    }
*/
  }

  # Azure Backend
  backend "azurerm" {
    resource_group_name  = "oratio-onboarding-ahmed-imen-rg"       # Pre-created RG for state files
    storage_account_name = "vprofileactions25"         # Azure Storage Account name
    container_name       = "vprofieapp"                  # Blob container name
    key                  = "terraform.tfstate"        # State file name
    use_oidc             = true                       # Recommended for auth
  }

  required_version = "~> 1.6.3"  # Unchanged
}