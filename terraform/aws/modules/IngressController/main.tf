provider "helm" {
  kubernetes {
    host                   = var.EKS_CLUSTER_ENDPOINT
    cluster_ca_certificate = base64decode(var.EKS_CLUSTER_CERTIFICATE_AUTHORITY)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", var.EKS_CLUSTER_NAME]
      command     = "aws"
    }
  }
}

resource "helm_release" "aws-load-balancer-controller" {
  name             = "aws-load-balancer-controller"
  repository       = "https://aws.github.io/eks-charts"
  chart            = "aws-load-balancer-controller"
  namespace        = "kube-system"
  version          = "1.4.1"
  create_namespace = true

  values = [
    file("./values-override/ingress.yaml")
  ]

  set {
    name  = "clusterName"
    value = var.EKS_CLUSTER_NAME
  }

  set {
    name  = "image.tag"
    value = "v2.4.2"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.aws-load-balancer-controller.arn
  }

  depends_on = [
    var.EKS_NODE_GROUP,
    aws_iam_role_policy_attachment.aws_load_balancer_controller_attach
  ]
}
