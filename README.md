# Init
terraform init

# Workspace
## Create Workspace
terraform workspace new development
terraform workspace new staging
terraform workspace new production

## List workspace
terraform workspace list

## Select workspace
terraform workspace select development
terraform workspace select staging
terraform workspace select production

## Show current workspace
terraform workspace show

## Plan/Apply/Destroy based on current workspace
terraform plan -var-file=terraform-$(terraform workspace show).tfvars
terraform apply -var-file=terraform-$(terraform workspace show).tfvars
terraform destroy -var-file=terraform-$(terraform workspace show).tfvars

