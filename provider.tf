provider "aws" {
  # profile = var.profile # managment account local aws credential/config profile name

  # Common tags for all resources that accept tags
  default_tags {
    tags = {
      ManagedBy         = "Terraform"
      Terraform-Version = var.tf-version
      Cost              = var.cost
      Consulting        = var.consulting
      Owner             = var.owner
      Project           = var.project
    }
  }

  # Make it faster by skipping something
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
}