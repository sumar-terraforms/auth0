#triniti
# terraform {
#   backend "s3" {
#     bucket  = "triniti-terraform-shared"
#     key     = "terraform.tfstate"
#     region  = "ap-southeast-2"
#     profile = "terraform"
#   }
# }

# sumar
terraform {
  backend "s3" {
    bucket  = "sumar-terraform-shared"
    key     = "auth.tfstate"
    region  = "ap-southeast-1"
    profile = "personal"
  }
}
