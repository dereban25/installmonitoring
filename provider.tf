provider "google" {
  project = var.GOOGLE_PROJECT
  region  = var.GOOGLE_REGION
}
provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "gke_kuber-351315_us-central1_main"
  }
}
provider "flux" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}
terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">=2.9.0"
    }
    flux = {
      source  = "fluxcd/flux"
      version = "1.0.0-rc.3"
    }
  }
  backend "gcs" {
    bucket = "terraform-maks"
    prefix = "kubertest/state"
  }
}