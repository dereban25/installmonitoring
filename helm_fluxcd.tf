resource "helm_release" "fluxcd" {
  repository       = "https://fluxcd-community.github.io/helm-charts"
  chart            = "flux2"
  name             = "flux2"
  namespace        = "flux-system"
  create_namespace = true
  depends_on = [ null_resource.write_gke_context_to_file ]
}

resource "null_resource" "prom" {
  depends_on = [module.gke_cluster]
  provisioner "local-exec" {
    command = "bash monitor.sh"
  }
}
