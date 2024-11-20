module "api_gateway" {
  source = "../../submodules/api_gateway"
  api_name = "secondary-api"
  api_path = var.api_path
}
