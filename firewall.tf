resource "azurerm_public_ip" "firewall_pip" {
  name                = "pip-azure-firewall"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall_policy" "fw_policy" {
  name                = "fw-policy-hubspoke"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
}

resource "azurerm_firewall_policy_rule_collection_group" "fw_rules" {
  name               = "fw-rule-collections"
  firewall_policy_id = azurerm_firewall_policy.fw_policy.id
  priority           = 100

  network_rule_collection {
    name     = "allow-outbound-any"
    priority = 100
    action   = "Allow"

    rule {
      name                  = "allow-all-outbound"
      protocols             = ["Any"]
      source_addresses      = ["10.1.1.0/24"]
      destination_addresses = ["*"]
      destination_ports     = ["*"]
    }
  }
}

resource "azurerm_firewall" "fw" {
  name                = "azfw-hubspoke"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  firewall_policy_id  = azurerm_firewall_policy.fw_policy.id

  ip_configuration {
    name                 = "fw-ipconfig"
    subnet_id            = azurerm_subnet.azure_firewall_subnet.id
    public_ip_address_id = azurerm_public_ip.firewall_pip.id
  }
}