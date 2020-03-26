provider "azurerm" {
    environment = "china"
}

data "azurerm_subscription" "SubscriptionObject" {
}

resource "azurerm_policy_definition" "PolicyDefinition" {
  name         = "PolicyDefinitionName"
  policy_type  = "Custom"
  mode         = "all"
  display_name = "Policy Definition Name"

  policy_rule  = "${file("<rule file path>")}"
  parameters   = "${file("<parameters file path>")}"
}

resource "azurerm_policy_assignment" "PolicyAssignment" {
  name                 = "PolicyAssignmentname"
  scope                = "${data.azurerm_subscription.SubscriptionObject.id}"
  policy_definition_id = "${data.azurerm_policy_definition.vmlimit.id}}"
  description          = "Policy Assignment"
  display_name         = "Policy Assignment Name"
}