# MERN Stack Deployment on AWS Using Terraform & Ansible

Automated, reproducible cloud deployment of the full-stack **TravelMemory** MERN application on Amazon Web Services (AWS) using **Terraform** for infrastructure-as-code and **Ansible** for automated configuration management.

## Repository Structure
```text
mern-terraform-ansible/
├── ansible/
│   ├── ansible.cfg          # SSH proxy settings, connection tuning & defaults
│   ├── db_playbook.yml      # Docker engine setup & persistent MongoDB container
│   ├── env.yml              # Dynamic variables (backend & database IP addresses)
│   ├── inventory.yml        # Host inventory definitions with ProxyJump configuration
│   └── web_playbook.yml     # Swap space, Node.js, PM2, app deployment & CORS setup
├── terraform/
│   ├── .terraform.lock.hcl  # Pinned provider dependency hashes
│   ├── ec2.tf               # EC2 instances (web & db) and key pair definitions
│   ├── main.tf              # Terraform settings and AWS provider configuration
│   ├── outputs.tf           # Exported IPs (web public IP, db private IP)
│   ├── security_groups.tf   # Web SG (22, 3000, 3001) & DB SG (22, 27017) rules
│   ├── variables.tf         # Input variable definitions (region, CIDRs, AMI, types)
│   └── vpc.tf               # VPC, subnets, IGW, NAT Gateway, and route tables
├── .gitignore
└── README.md

```

## Architecture Overview

```text
               +-------------------------------------------------------+
               |                       AWS VPC                         |
               |                                                       |
               |  +--------------------+        +--------------------+ |
               |  |   Public Subnet    |        |   Private Subnet   | |
               |  |                    |        |                    | |
Internet <---> |  | [Internet Gateway] |        |   [NAT Gateway]    | |
               |  |         |          |        |         ^          | |
               |  |         v          |        |         |          | |
               |  |     Web Server     | ====== | Database Server    | |
               |  |  (Amazon Linux 23) |  Port  | (Amazon Linux 23)  | |
               |  |   - React (:3000)  |  27017 | - Docker MongoDB   | |
               |  |   - Express (:3001)|        |   Container        | |
               |  |   - PM2 Process Mgr|        |   (Persistent Vol) | |
               |  +--------------------+        +--------------------+ |
               +-------------------------------------------------------+
