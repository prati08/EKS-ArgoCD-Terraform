# EKS-ArgoCD-Terraform-CI-CD

Problem Statement: 
=====================

  1. Create EKS Cluster with the help of below aws resource
       1. VPC(with Public and Private subnet)
       2. with 1 node-group using above network configuration
       3. Deployment Tools: Terraform
    
  2. Deploy ArgoCD and Argo Rollout in EKS Cluster Mentioned above.
  3. Create Gitops Pipeline to deploy & manage Nginx Application for blue-green upgrade Strategy. 


Repo Directory Info:
=========

This repository contains the below Code Directory:
  1. Terraform code base for Create EKS Cluster with above mentioned aws services. --> https://github.com/prati08/EKS-ArgoCD-Terraform/tree/main/terraform,
  2. Application/Service Manifest code base, where nginx application is maintained in form of helm charts.  --> https://github.com/prati08/EKS-ArgoCD-Terraform/tree/main/EKS-ArgoCD-Terraform-Gitops-Service/deployments/charts
  3. EKS-ArgoCD-Terraform-Gitops, where Gitops Strategy is maintained to manage above Application. --> https://github.com/prati08/EKS-ArgoCD-Terraform/tree/main/EKS-ArgoCD-Terraform-Gitops 


Installation Steps:
==================

  Installation of EKS Cluster along with aws service using Terraform.
  ==========
    Follow the below steps to Install the Terraform and another dependency.
    1. Clone the repo
      git clone https://github.com/prati08/EKS-ArgoCD-Terraform.git
    2. Let's install dependency to deploy the application
      cd terraform/aws/
      terraform init
      The below command will tell you what terraform is going to create.
      terraform plan
      Finally, HIT the below command to create the infrastructure...
      terraform apply
      type yes, and it will prompt you for permission or use --auto-approve in the command above.
    
    Note: (in this project we are locally storing the terraform state file, instead of stoing in s3 bucket.)
  
Installation of argocd and argo rollout in above EKS Cluster(only first time execution later argocd will manage argocd).
==========
  Assuming above repo is cloned:

  1. Create Namespace argocd in above eks cluster
  2. cd to EKS-ArgoCD-Terraform-Gitops/deployments directory
  3. deployments => helm -n argocd install argo-cd charts/argo-cd/
      Before Performing helm install first we need to add the argocd repo
     =======
      helm repo add argo-cd https://argoproj.github.io/argo-helm - one time only
      helm dep update charts/argo-cd/
  once argocd is installed we can perform below steps to verify argocd is installed.
     1. check argocd status kubectl -n argocd rollout status deployment argo-cd-argocd-server
     2. Once step 1 is passed, we can get password of argocd admin user using below command
          kubectl get secret argocd-initial-admin-secret -n argocd -o yaml
     3. intially password is base64 encoded, we can decode to use via ui or cli
    
     4. once the argocd is installed we need to add below application
               cd  EKS-ArgoCD-Terraform-Gitops/deployments/charts/
               helm template root-app/ | kubectl apply -f -
     5. that it, internally gitops created in apps-of-apps of pattern, where it will sync below application automatically from EKS-ArgoCD-Terraform-Gitops repo.
          sync sequence:
               1. argo-cd(self-managed)
               2. argo-rollout(for blue-green upgrade strategy)
               3. nginx application for staging.
     





