provider "azurerm" {
    environment = "china"
}

data "azurerm_subscription" "SubscriptionObject" {
}

resource "azurerm_policy_definition" "vmlimit" {
  name         = "vm-limit"
  policy_type  = "Custom"
  mode         = "all"
  display_name = "vm limt"

  policy_rule  = "${file("<rule file path>")}"
  parameters   = "${file("<parameters file path>")}"
}

resource "azurerm_policy_assignment" "Assignment-vmlimit" {
  name                 = "vmlimit"
  scope                = "${data.azurerm_subscription.SubscriptionObject.id}"
  policy_definition_id = "${data.azurerm_policy_definition.vmlimit.id}}"
  description          = "vm limit"
  display_name         = "vm-limit"

  parameters = <<PARAMETERS
    {
      "listOfAllowedLinuxSKUs": {
        "value": [
            "Standard_B1s",
            "Standard_B2ms",
            "Standard_B2s",
            "Standard_B4ms",
            "Standard_B8ms",
            "Standard_B12ms",
            "Standard_B16ms",
            "Standard_B20ms"
        ]
      },
      "listOfAllowedWindowsSKUs": {
        "value": [
            "Standard_D1_v2",
            "Standard_D2_v2",
            "Standard_D3_v2",
            "Standard_D4_v2",
            "Standard_D5_v2",
            "Standard_D11_v2",
            "Standard_D12_v2",
            "Standard_D13_v2",
            "Standard_D14_v2"
        ]
      }
    }
    PARAMETERS
}