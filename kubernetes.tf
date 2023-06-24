terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.1"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.11.0"
    }
  }
}

resource "myhost" "mine" {
    host = var.host
}

resource "client_certificate" "mine2" {
  client_certificate = var.client_certificate
}

resource "client_key" "mykey" {
    client_key = var.client_key
}

resource "cluster_ca_certificate" "mycertificate" {
    cluster_ca_certificate = var.cluster_ca_certificate
}



provider "kubernetes" {
  host        = "https://127.0.0.1:40131"
  config_path = "/home/ubuntu/.kube/config"
}

provider "docker" {
  host = "tcp://localhost:2376"
}

resource "kubernetes_deployment" "cpflask" {
  metadata {
    name = "scalable-cpflask-example"
    labels = {
      App = "ScalableflaskappExample"
    }
  }

  spec {
    replicas = 3
    selector {
      match_labels = {
        App = "ScalableflaskappExample"
      }
    }
    template {
      metadata {
        labels = {
          App = "ScalableflaskappExample"
        }
      }
      spec {
        container {
          image = "vijaya81kp/tfflaskapp"
          name  = "example"

          port {
            container_port = 8080
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "128Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "cpflask" {
  metadata {
    name = "cpflask-example"
  }
  spec {
    selector = {
      App = kubernetes_deployment.cpflask.spec.0.template.0.metadata[0].labels.App
    }
    port {
      node_port   = 30201
      port        = 8080
      target_port = 8080
    }

    type = "NodePort"
  }
}
