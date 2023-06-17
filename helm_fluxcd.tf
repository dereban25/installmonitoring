resource "helm_release" "fluxcd" {
  repository       = "https://fluxcd-community.github.io/helm-charts"
  chart            = "flux2"
  name             = "flux2"
  namespace        = "flux-system"
  create_namespace = true
  depends_on = [ null_resource.write_gke_context_to_file ]
}

resource "flux_bootstrap_git" "kube_prometheus" {
  path = "./manifests/monitoring"
  kustomization_override = file("${path.module}/kustomization.yaml")
  depends_on = [ null_resource.write_gke_context_to_file ]
}
