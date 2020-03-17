provider "azurerm" {
    environment = "china"
}

data "azurerm_subscription" "SubscriptionObject" {
}

resource "azurerm_policy_definition" "PolicyDefObject" {
  name         = "vm-image-limit"
  policy_type  = "Custom"
  mode         = "all"
  display_name = "vm image limit"

  policy_rule  = file("<rule file path>")
  parameters   = file("<parameters file path>")
}

resource "azurerm_policy_assignment" "PolicyAssignObject" {
  name                 = "vm-image-limit"
  scope                = data.azurerm_subscription.SubscriptionObject.id
  policy_definition_id = resource.azurerm_policy_definition.PolicyDefObject.id
  description          = "vm image limit"
  display_name         = "vm-image-limit"

  parameters = <<PARAMETERS
    {
      "AllowPublicImageUrnList": {
        "value": [
            "Canonical:UbuntuServer:16.04-LTS:latest"
        ]
      },
      "AllowCustomerImageResourceIDList": {
        "value": [
            "/subscriptions/<subid>/resourceGroups/samtest/providers/Microsoft.Compute/images/TestUbuntu-image-2020031"
        ]
      }
    }
    PARAMETERS
}