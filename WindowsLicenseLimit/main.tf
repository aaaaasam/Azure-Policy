provider "azurerm" {
    environment = "china"
}

data "azurerm_subscription" "SubscriptionObject" {
}

resource "azurerm_policy_definition" "WindowsLiceseLimit" {
  name         = "Windows-License-limit"
  policy_type  = "Custom"
  mode         = "all"
  display_name = "Windows License limt"

  policy_rule  = "${file("<rule file path>")}"
  parameters   = "${file("<parameters file path>")}"
}

resource "azurerm_policy_assignment" "Assignment-WindowsLiceseLimit" {
  name                 = "vmlimit"
  scope                = "${data.azurerm_subscription.SubscriptionObject.id}"
  policy_definition_id = "${data.azurerm_policy_definition.WindowsLiceseLimit.id}}"
  description          = "windows license limit"
  display_name         = "windows-license-limit"
}