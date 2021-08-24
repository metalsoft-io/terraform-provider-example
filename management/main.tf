#list required providers
terraform {
  required_providers {
    metalcloud = {
      source = "metalsoft-io/metalcloud"
      version = "1.0.17"
    }
  }
}



# Configure the metalcloud provider
provider "metalcloud" {
   user_email = var.user_email
   api_key = var.api_key 
   endpoint = var.endpoint
}

# Identity the ID of the volume template we want
data "metalcloud_volume_template" "esxi7" {
  volume_template_label = "esxi-700-uefi-v2"
}

