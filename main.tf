terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "nginx_cross_origin_resource_sharing_error" {
  source    = "./modules/nginx_cross_origin_resource_sharing_error"

  providers = {
    shoreline = shoreline
  }
}