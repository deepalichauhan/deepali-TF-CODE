provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

data "aws_eks_cluster" "eks_cluster" {
  name = "terraform-mrm-vault"  # Replace with your EKS cluster name
}

# Fetch EKS Authentication Token
data "aws_eks_cluster_auth" "eks_auth" {
  name = data.aws_eks_cluster.eks_cluster.name
}

# Kubernetes Provider for managing the cluster
provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks_auth.token
}

# Create the ingress-nginx namespace
resource "kubernetes_namespace" "ingress_nginx" {
  metadata {
    name = "ingress-nginx"
  }
}

# Apply the NGINX Ingress Controller manifest using null_resource
resource "null_resource" "nginx_ingress_controller" {
  provisioner "local-exec" {
    command = "kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.3.0/deploy/static/provider/cloud/deploy.yaml"
    
  }

  depends_on = [kubernetes_namespace.ingress_nginx]
}

resource "null_resource" "metrics_server" {
  provisioner "local-exec" {
    command = "curl -sSL https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml -o metrics_server.yaml && kubectl apply -f metrics_server.yaml"
  }

}


resource "null_resource" "cluster_autoscaler" {
  provisioner "local-exec" {
    command = "kubectl apply -f https://raw.githubusercontent.com/kubernetes/autoscaler/master/cluster-autoscaler/cloudprovider/aws/examples/cluster-autoscaler-autodiscover.yaml"
  }

}
