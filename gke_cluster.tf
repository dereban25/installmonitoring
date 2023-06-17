module "gke_cluster" {
  source           = "git::https://github.com/dereban25/prom-terra-modules.git//modules/eks"
  GOOGLE_REGION    = var.GOOGLE_REGION
  GOOGLE_PROJECT   = var.GOOGLE_PROJECT
  GKE_NUM_NODES    = 1
  GKE_MACHINE_TYPE = "e2-standard-4"
  DISK_SIZE_GB     = 20
  GKE_CLUSTER_NAME = "main"
}

resource "null_resource" "write_gke_context_to_file" {
  depends_on = [module.gke_cluster]
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials main --zone us-central1 --project ${var.GOOGLE_PROJECT}"
  }
}