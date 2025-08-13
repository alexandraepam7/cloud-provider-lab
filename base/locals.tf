locals {
  prefix      = "alexlab"
  location    = "centralus"
  owner       = "AlexandraG"
  environment = "lab"

  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = local.owner
  }

  resource_group_name = "${local.prefix}-01"
  vnet_name           = "${local.resource_group_name}-vnet-us-central"
  subnet_name         = "${local.resource_group_name}-subnet"
}
