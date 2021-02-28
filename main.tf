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
  
# ---------------------------------------------------------------------------------------------------------------------
# Provision the worker using remote-exec
# ---------------------------------------------------------------------------------------------------------------------

resource "null_resource" "example_provisioner" {
  triggers = {
    public_ip = 192.168.1.208
  }

  connection {
    type  = "ssh"
    host  = 192.168.1.208
    user  = ubuntu
    port  = 22
    agent = true
  }

 // change permissions to executable and pipe its output into a new file
  provisioner "remote-exec" {
    inline = [
	  "pwd "
      "mkdir testdirectory",
      "echo here in remote",
    ]
  }

}

  
  
}