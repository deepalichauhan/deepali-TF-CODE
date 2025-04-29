/*resource "null_resource" "nginx_ingress" {
  provisioner "local-exec" {
    command = "kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.3.0/deploy/static/provider/cloud/deploy.yaml --validate=false"
    
  }
}*/


/*resource "null_resource" "check_kube_system_pods" {
  provisioner "local-exec" {
    command = "kubectl get pods -n kube-system"
  }
}*/