provider "azurerm"{
    # alias   =  "petstore"
    subscription_id = var.subscription_id
    client_id       = var.client_id
    client_secret   = var.client_secret
    tenant_id       = var.tenant_id 
    features {}
    //alias   = "west" // if you are going ti create more than 1 instace of the provider .

    // so later it can be used as 
    // only example
    # resource "azure_resource" "web_server" {
    #   provider = aws.west
    # }
}

terraform {
  required_version = "= 1.1.7"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"       
      version = "3.18.0"
    }
  }

  // for random generating function. How to use look in locals.tf
  random  = {
    source  = "hashicorp/random"
    version = "~> 3.0"
  }
}

#########################################################################
################### QUESTION ############################################
#####   Why are they both needed?
#       Shouldn't terraform be able to understand the need for a azure provider, only by provider block?
#########################################################################

#########################################################################
################### Answer ############################################
# The source needs to be provided since this isn't one of the "official" HashiCorp providers. 
# There could be multiple providers with the name "docker" in the provider registry, 
# so providing the source is needed in order to tell Terraform exactly which provider to download.