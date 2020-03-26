provider "azurerm" {
    environment = "china"
}

data "azurerm_subscription" "SubscriptionObject" {
}

resource "azurerm_policy_definition" "AzureDBLimit" {
  name         = "AzureDBLimit"
  policy_type  = "Custom"
  mode         = "all"
  display_name = "Azure DB Limit"

  policy_rule  = "${file("<rule file path>")}"
  parameters   = "${file("<parameters file path>")}"
}

resource "azurerm_policy_assignment" "Assignment-AzureDBLimit" {
  name                 = "Azure DB Limit"
  scope                = "${data.azurerm_subscription.SubscriptionObject.id}"
  policy_definition_id = "${data.azurerm_policy_definition.vmlimit.id}}"
  description          = "Azure DB Limit"
  display_name         = "Azure_DB_Limit"
}