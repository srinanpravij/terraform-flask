terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.1"
    }
   docker = {
      source = "kreuzwerker/docker"
      version = "2.11.0"
    }
  }
  
resource "kind_deployment" "flaskapptf" {
  triggers = {
    public_ip = "192.168.1.208"
  }

  connection {
    type  = "ssh"
    host  = "192.168.1.208"
    user  = "ubuntu"
    port  = 22
    agent = true
  }

 provisioner "remote-exec" {
    inline = [
	  "pwd ",
      "mkdir testdirectory",
      "echo here in remote",
    ]
  }

}

  
  
}