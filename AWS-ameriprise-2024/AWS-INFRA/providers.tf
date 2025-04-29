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



