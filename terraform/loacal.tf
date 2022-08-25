resource "random_integer" "rand"{
    min = 1
    max = 9
}


locals {
    environment = "dev"
    suffix  =   "petstore"
    tags = {
        Company         = "Vats Family",
        Status          = "Dev-${random_integer.rand}"
        DepartmentZone  = var.location
  }
}