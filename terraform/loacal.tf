locals {
    environment = "dev"
    suffix  =   "petstore"
    tags = {
        Company         = "Vats Family",
        Status          = "Dev"
        DepartmentZone  = var.location
  }
}