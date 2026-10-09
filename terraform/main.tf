terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "static_site" {
  metadata {
    name = "static-site-project"
  }
}

resource "kubernetes_deployment" "static_site" {
  metadata {
    name      = "static-site-deployment"
    namespace = kubernetes_namespace.static_site.metadata[0].name
    labels = {
      app = "static-site"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "static-site"
      }
    }

    template {
      metadata {
        labels = {
          app = "static-site"
        }
      }

      spec {
        container {
          image = "maximusco/static-site-pipeline:latest"
          name  = "static-site-container"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "static_site" {
  metadata {
    name      = "static-site-service"
    namespace = kubernetes_namespace.static_site.metadata[0].name
  }

  spec {
    selector = {
      app = "static-site"
    }

    port {
      port        = 80
      target_port = 80
      node_port   = 30080
    }

    type = "NodePort"
  }
}
