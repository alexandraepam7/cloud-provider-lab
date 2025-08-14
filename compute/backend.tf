terraform {
  backend "azurerm" {
    resource_group_name  = "alexlab-01"
    storage_account_name = "epamazurelabstate0707"
    container_name       = "epam-azure-tf-state"
    key                  = "terraform.tfstate"
  }
}
