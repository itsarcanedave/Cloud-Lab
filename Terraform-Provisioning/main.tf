provider "azurerm" {
	features{}
}

# create resource group
resource "azurerm_resource_group" "rg"{
    name = "cloud"
    location = "southeastasia"
}
resource "null_resource" "loadbalancer" {

        connection {
                type = "ssh"
                host = "[ALAMAT IP VM LOADBALANCER]"
                user = "azureuser"
                private_key  
= file("/home/[USERNAME]/[NAMA KEY PAIR.PEM]")
                }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install haproxy -y",
    ]
  }
}
resource "null_resource" "web1" {

        connection {
                type = "ssh"
                host = "[ALAMAT IP VM WEB1]"
                user = "azureuser"
                private_key 
= file("/home/[USERNAME]/[NAMA KEY PAIR.PEM]")
                }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install apache2 -y",
    ]
  }
}
resource "null_resource" "web2" {

        connection {
                type = "ssh"
                host = "[ALAMAT IP VM WEB2]"
                user = "azureuser"
                private_key 
= file("/home/[USERNAME]/[NAMA KEY PAIR.PEM]")
                }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install apache2 -y",
    ]
  }
}
