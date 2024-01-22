# EKS-ArgoCD-Terraform-CI-CD


This repository contains the terraform file code, which we can use to provision the Amazon EKS cluster & other aws resources as part of this project, along Gitops tools like argocd to Manage continuous delivery tool for Kubernetes.


Installation of Terraform

Follow the below steps to Install the Terraform and another dependency.

1️⃣ Clone the repo

git clone https://github.com/prati08/EKS-ArgoCD-Terraform.git

2️⃣ Let's install dependency to deploy the application

cd terraform/aws/
terraform init

The below command will tell you what terraform is going to create.

terraform plan

Finally, HIT the below command to create the infrastructure...

terraform apply

type yes, and it will prompt you for permission or use --auto-approve in the command above.
Note: (in this project we are locally storing the terraform state file, instead of stoing in s3 bucket.)



