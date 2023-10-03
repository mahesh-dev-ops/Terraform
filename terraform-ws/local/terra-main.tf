terraform {
  required_providers {
    aws = {
      version = "~> 4.0 "
    }
    google = {

    }
    azurerm = {
      version = "3.0.0"
    }
  }
}
resource "local_file" "resource-one" {
  content  = "resource-one"
  filename = "a.txt"
}
resource "local_file" "resource-two" {
  content  = "resource-two"
  filename = "b.txt"

}
