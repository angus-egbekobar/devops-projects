# AWS Terraform Foundation

Infrastructure as Code (IaC) project that provisions a production-ready 
AWS environment using Terraform.

## What This Project Does

Deploys the following AWS infrastructure from code:

- **VPC** — isolated network with CIDR block 10.0.0.0/16
- **Public Subnet** — subnet in us-east-1a with auto-assigned public IPs
- **Internet Gateway** — allows internet access to the VPC
- **Route Table** — routes internet traffic through the gateway
- **Security Group** — firewall allowing SSH (22) and HTTP (80)
- **EC2 Instance** — Ubuntu 22.04 t2.micro server

## Architecture
Internet
│
Internet Gateway
│
Public Subnet (10.0.1.0/24)
│
EC2 Instance (Ubuntu 22.04)
│
Security Group (ports 22, 80)

## Prerequisites

- Terraform >= 1.0
- AWS CLI configured with valid credentials
- AWS account with EC2 and VPC permissions

## Usage

**Clone the repo:**
```bash
git clone https://github.com/angus-egbekobar/devops-projects.git
cd devops-projects/aws-terraform-foundation
```

**Initialise Terraform:**
```bash
terraform init
```

**Preview what will be created:**
```bash
terraform plan
```

**Create the infrastructure:**
```bash
terraform apply
```

**Destroy when done:**
```bash
terraform destroy
```

## Variables

| Variable | Description | Default |
|----------|-------------|---------|
| region | AWS region | us-east-1 |
| project_name | Name prefix for all resources | devops-foundation |
| environment | Environment tag | production |
| instance_type | EC2 instance type | t2.micro |
| ami_id | Ubuntu 22.04 AMI | ami-0c7217cdde317cfec |

## Skills Demonstrated

- Terraform HCL syntax
- AWS VPC networking
- Infrastructure as Code principles
- Resource tagging and organisation
- Secure credential management via AWS CLI

## Author

**Angus Egbekobar**  
AWS Certified Solutions Architect  
[GitHub](https://github.com/angus-egbekobar) | 
[LinkedIn](https://linkedin.com/in/www.linkedin.com/in/angus-egbekobar-bb1515179