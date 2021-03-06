# Trusted Access Guardrails - https://turbot.com/v5/docs/concepts/guardrails/trusted-access

# Trusted Account Template - sets the global template for all services, pulls trusted list from tfvars file
# Individual services can have their own set of trusted accounts as well

# AWS > Account > Trusted Accounts [Default]
# https://turbot.com/v5/mods/turbot/aws/inspect#/policy/types/trustedAccounts
resource "turbot_policy_setting" "aws_trusted_accounts_template" {
  count          = var.enable_aws_trusted_accounts_template ? 1 : 0
  resource       = turbot_smart_folder.aws_public_access.id
  type           = "tmod:@turbot/aws#/policy/types/trustedAccounts"
  template_input = <<-QUERY
    {
    account{
     Id
      }
    }
    QUERY

  # set trustedAccounts from demo.tfvars
  template = <<-TEMPLATE
    ${yamlencode([for account in var.trusted_accounts : account])}
    TEMPLATE
}
