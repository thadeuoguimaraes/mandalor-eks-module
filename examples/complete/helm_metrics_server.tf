resource "helm_release" "metrics_server" {
  name             = "metrics-server"
  repository       = "https://kubernetes-sigs.github.io/metrics-server/"
  chart            = "metrics-server"
  namespace        = "kube-system"
  create_namespace = true

  wait = false

  set = [
    { name = "apiService.create", value = "true" },
  ]

  depends_on = [
    module.eks
  ]
}
