terraform {
  backend "local" {
    # Path is resolved relative to the directory containing this file (env/dev/)
    path = "../../terraform-dev.tfstate"
  }
}
