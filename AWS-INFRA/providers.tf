provider "aws" {
  region     = "us-east-1"
  profile = "default"
}


terraform {
  backend "s3" {
    bucket         = "mrm-vault-tfstate"             //create this before runnning script 
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "dynamo-db-state-locking"       //create this before runnning script  with partion key is LockID
    
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.tf-eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.tf-eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.tf-eksauth.token
}

