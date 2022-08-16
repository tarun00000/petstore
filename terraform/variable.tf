#############################################################
# SUBSCRIPTION INFORMATION
#############################################################
variable "subscription_id" {
    type = string
    description = "azue subscription ID"
    sensitive = false
} 

variable "resource_grp"{
    type = string
    description = "Resource grp name"
    default = "petstore-resoruce-grp"
    sensitive = false
}

variable "location"{
    type = string
    description = "Resource location"
    default = "eastus"
    sensitive = false
}

variable "client_id" {
    type = string
    description = "Servicence principle username/client_ID"
    sensitive = false
}

variable "client_secret" { 
    type = string
    description = "Servicence principle secret"
    sensitive = true
}

variable "tenant_id" { 
    type = string
    description = "Servicence principle tenant id"
    sensitive = true
}

#############################################################
# Networking INFORMATION
#############################################################

variable "vnet_cidr_range"{
    type = list(string)
    description = "CIDR for the resources"
    default = ["10.0.0.0/16"]
    sensitive = false
}

variable "subnet_prefixes"{
    type = list(string)
    description = "subnets list"
    default = ["10.0.1.0/24", "10.0.0.0/24"]
    sensitive = false
}

variable "subnet_names"{
    type = list(string)
    description = "subnets names"
    default = ["petstore_web", "petstore_database"]
    sensitive = false
}

variable "nsg_association"{
     type = map(string)
     description = "subnets to nsg"
     default = {
       petstore_web = ""
       petstore_database = ""
     }
}