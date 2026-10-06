# ContentSphere – Infrastructure as Code

## Project Overview

**ContentSphere** is an Infrastructure as Code (IaC) project developed using Terraform and AWS CloudFormation.

The project demonstrates how cloud infrastructure can be provisioned, managed, reused, monitored for configuration drift, and maintained using Infrastructure as Code practices.

The primary infrastructure is provisioned using **Terraform**, with reusable Terraform modules. An equivalent infrastructure template is also implemented and deployed using **AWS CloudFormation**.

---

## Student Details

| Field            | Details                       |
| ---------------- | ----------------------------- |
| Student Name     | Essakimuthu Shanmugam Konar   |
| Course           | DevOps / Cloud                |
| Institute        | IT Vedant                     |
| Project          | ContentSphere                 |
| AWS Region       | ap-south-1                    |
| Environment      | dev                           |
| IaC Tools        | Terraform, AWS CloudFormation |
| Operating System | Windows                       |

---

## Project Objective

The objective of this project is to demonstrate practical Infrastructure as Code implementation using Terraform.

The project covers:

* Terraform installation and configuration
* AWS provider configuration
* VPC creation
* Public subnet creation
* Internet Gateway
* Route Table
* Security Group
* EC2 instance
* Elastic IP
* S3 bucket
* Terraform variables and outputs
* Terraform modules
* Infrastructure lifecycle management
* Terraform state management
* Remote state using Amazon S3
* Infrastructure drift detection
* AWS CloudFormation equivalent
* Git and GitHub project management

---

# Architecture

The ContentSphere Terraform infrastructure contains:

```text
                         AWS
                          |
                    ContentSphere
                          |
                       VPC
                    10.0.0.0/16
                          |
                    Public Subnet
                    10.0.1.0/24
                          |
              +-----------+-----------+
              |                       |
        Internet Gateway          EC2 Instance
                                      |
                                  Apache Web Server
                                      |
                              ContentSphere Website

                          |
                     S3 Storage
```

---

# AWS Resources

The Terraform project provisions the following resources:

* VPC
* Public Subnet
* Internet Gateway
* Route Table
* Route Table Association
* Security Group
* EC2 Instance
* Elastic IP
* S3 Bucket
* S3 Bucket Versioning

---

# Terraform Project Structure

```text
Terraform project/
│
├── terraform.tf
├── provider.tf
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars.example
├── terraform.tfvars
├── .gitignore
│
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── security-group/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── ec2/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── s3/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
├── cloudformation/
│   └── contentsphere-stack.yaml
│
├── screenshots/
│
└── documentation/
    └── Project_Report.pdf
```

---

# Terraform Modules

Reusable modules were created to organize the infrastructure.

### VPC Module

The VPC module creates:

* VPC
* Subnet
* Internet Gateway
* Route Table
* Route Table Association

### Security Group Module

The Security Group module provides:

* SSH access on port 22
* HTTP access on port 80
* Outbound internet access

### EC2 Module

The EC2 module creates:

* EC2 instance
* Apache web server
* Elastic IP
* ContentSphere website

### S3 Module

The S3 module creates:

* S3 bucket
* S3 bucket versioning

---

# Terraform Commands

## Initialize Terraform

```bash
terraform init
```

## Format Terraform files

```bash
terraform fmt -recursive
```

## Validate configuration

```bash
terraform validate
```

## Create execution plan

```bash
terraform plan
```

## Deploy infrastructure

```bash
terraform apply
```

## Display outputs

```bash
terraform output
```

## View Terraform state

```bash
terraform state list
```

---

# Terraform Variables

The project uses variables for configurable infrastructure values.

Example:

```hcl
project_name      = "ContentSphere"
environment       = "dev"
vpc_cidr          = "10.0.0.0/16"
subnet_cidr       = "10.0.1.0/24"
availability_zone = "ap-south-1a"
instance_type     = "t3.micro"
key_name          = "terraform"
```

This makes the infrastructure easier to modify and reuse.

---

# ContentSphere Website

The EC2 instance automatically installs Apache using Terraform `user_data`.

The website displays:

* Project title
* Student name
* Batch
* AWS Region
* Environment
* Infrastructure provisioning message

Example:

```text
ContentSphere

Infrastructure Provisioned using Terraform

Student: Essakimuthu Shanmugam Konar
Batch: IT Vedant
Region: ap-south-1
Environment: dev
```

---

# Remote Terraform State

Terraform state was configured to use an Amazon S3 backend.

Remote state bucket:

```text
contentsphere-terraform-state-2026-essaki
```

State path:

```text
contentsphere/terraform.tfstate
```

S3 bucket versioning is enabled to improve state recovery and management.

---

# Infrastructure Drift

Infrastructure drift occurs when AWS infrastructure is manually changed outside Terraform.

For this project, a test tag was manually added to the EC2 instance:

```text
DriftTest = ChangedOutsideTerraform
```

Terraform detected the external change during:

```bash
terraform plan
```

Terraform identified that the manually added configuration differed from the desired Terraform configuration.

This demonstrates Terraform's ability to detect infrastructure drift.

---

# AWS CloudFormation

An equivalent ContentSphere infrastructure template was created using AWS CloudFormation.

File:

```text
cloudformation/contentsphere-stack.yaml
```

The CloudFormation template contains:

* VPC
* Subnet
* Internet Gateway
* Route Table
* Security Group
* EC2
* S3 Bucket

The template was validated using:

```bash
aws cloudformation validate-template --template-body file://cloudformation/contentsphere-stack.yaml
```

The CloudFormation project was also deployed as a separate stack:

```text
ContentSphere-CF-Demo
```

Deployment command:

```bash
aws cloudformation deploy \
--template-file cloudformation/contentsphere-stack.yaml \
--stack-name ContentSphere-CF-Demo \
--parameter-overrides KeyName=terraform Environment=dev \
--region ap-south-1
```

The CloudFormation stack successfully reached:

```text
CREATE_COMPLETE
```

This demonstrates that the infrastructure can also be provisioned using AWS-native Infrastructure as Code.

---

# Terraform vs CloudFormation vs AWS CDK

| Feature          | Terraform         | CloudFormation        | AWS CDK               |
| ---------------- | ----------------- | --------------------- | --------------------- |
| Provider         | Multi-cloud       | AWS                   | AWS                   |
| Configuration    | HCL               | YAML/JSON             | Programming languages |
| State            | Terraform state   | Managed by AWS        | CloudFormation        |
| AWS Integration  | Excellent         | Native                | Native                |
| Reusable Modules | Terraform modules | Nested stacks/modules | Constructs            |
| Main Use         | Multi-cloud IaC   | AWS-native IaC        | Programmatic AWS IaC  |

For this project, Terraform was used as the primary IaC tool and CloudFormation was implemented as an AWS-native equivalent.

AWS CDK was reviewed as part of the IaC comparison but was not implemented as a separate deployment in this project.

---

# Infrastructure Lifecycle

Terraform was used to demonstrate infrastructure lifecycle management.

Typical workflow:

```text
Write Terraform Configuration
          ↓
terraform init
          ↓
terraform validate
          ↓
terraform plan
          ↓
terraform apply
          ↓
AWS Infrastructure
          ↓
Modify Configuration
          ↓
terraform plan
          ↓
terraform apply
```

Infrastructure can also be removed using:

```bash
terraform destroy
```

---

# Git Workflow

The project is prepared for GitHub using:

```bash
git init
git add .
git commit -m "Initial ContentSphere Terraform project"
git branch -M main
git remote add origin <GITHUB_REPOSITORY_URL>
git push -u origin main
```

Sensitive Terraform variable files and state files are excluded from Git using `.gitignore`.

---

# Security

The following files should not be committed:

```text
terraform.tfvars
*.tfstate
*.tfstate.*
.terraform/
```

The project uses an example variable file:

```text
terraform.tfvars.example
```

---

# Project Outcome

The ContentSphere project successfully demonstrates:

* AWS infrastructure provisioning
* Terraform Infrastructure as Code
* Terraform reusable modules
* Variables and outputs
* EC2 web server deployment
* S3 storage
* Remote state
* State management
* Infrastructure drift detection
* AWS CloudFormation deployment
* Git/GitHub project structure

The project provides practical experience with the Infrastructure as Code concepts used in real-world DevOps environments.

---

# Author

**Essakimuthu Shanmugam Konar**

DevOps / Cloud Engineer

IT Vedant
