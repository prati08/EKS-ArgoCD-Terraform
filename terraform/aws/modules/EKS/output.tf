output "EKS_CLUSTER_NAME" {
    value = aws_eks_cluster.eks_cluster.id
}

output "EKS_CLUSTER_ENDPOINT" {
    value = aws_eks_cluster.eks_cluster.endpoint
}

output "EKS_CLUSTER_CERTIFICATE_AUTHORITY" {
    value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "EKS_CLUSTER_IDENTITY" {
    value = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

