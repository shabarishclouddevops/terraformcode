# Terraform Free Tier AWS Lab

This project creates a minimal AWS infrastructure using only low-cost, Free Tier–eligible resources wherever applicable. It provisions a single VPC, one public subnet, one internet gateway, one route table, one security group, one Amazon Linux EC2 instance, and an EC2 key pair created from an existing local public SSH key.

Important: Free Tier eligibility depends on the AWS account type, account age, region, and current AWS Free Tier terms. Creating the resources in this project does not guarantee zero cost. The user must review their AWS Free Tier usage and pricing before deployment.

## Project structure

```text
terraform-free-tier-aws/
├── providers.tf
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars.example
├── versions.tf
└── README.md
```

## Prerequisites

Before you deploy this project, make sure you have:

- An AWS account with permissions to create VPC, subnet, internet gateway, route table, security group, key pair, and EC2 resources.
- The AWS CLI installed and configured.
- Terraform installed locally.
- A local SSH key pair already present, such as:
  - `~/.ssh/id_rsa`
  - `~/.ssh/id_rsa.pub`
- A valid public IPv4 address for SSH access (for example, your home network IP or office IP).

## AWS account setup

1. Sign in to AWS Console.
2. Create or use an AWS account.
3. Ensure the account is not blocked from creating EC2 instances.
4. Confirm that your region supports the default instance type (`t2.micro`) or be prepared to change it to another Free Tier–eligible instance type such as `t3.micro`.

## AWS CLI configuration

Configure the AWS CLI with your credentials:

```bash
aws configure
```

Or set environment variables:

```bash
export AWS_ACCESS_KEY_ID="your_access_key"
export AWS_SECRET_ACCESS_KEY="your_secret_key"
export AWS_DEFAULT_REGION="us-east-1"
```

## Terraform installation

Install Terraform from the official HashiCorp website:

- https://developer.hashicorp.com/terraform/install

Verify the installation:

```bash
terraform version
```

## SSH key generation if required

If you do not already have an SSH key pair, generate one:

```bash
mkdir -p ~/.ssh
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa
```

This creates:

- `~/.ssh/id_rsa` (private key)
- `~/.ssh/id_rsa.pub` (public key)

The Terraform project uses the public key only, and the EC2 instance is accessed through the matching private key.

## Configure terraform.tfvars

Copy the example file and update it with your values:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Example `terraform.tfvars`:

```hcl
aws_region = "us-east-1"
vpc_cidr = "10.0.0.0/16"
subnet_cidr = "10.0.1.0/24"
instance_type = "t2.micro"
key_name = "terraform-free-tier-key"
public_key_path = "~/.ssh/id_rsa.pub"
ssh_allowed_cidr = "203.0.113.10/32"
```

Important: Replace `203.0.113.10/32` with your actual public IPv4 address, for example:

```hcl
ssh_allowed_cidr = "24.24.24.24/32"
```

Do not use `0.0.0.0/0` for SSH access in this project. The SSH security group is intentionally restricted to a configured public CIDR.

## Deployment instructions

From the project directory:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

When prompted, confirm the apply.

## Verify the resources

Check the Terraform state:

```bash
terraform state list
```

View outputs:

```bash
terraform output
```

To retrieve only the public IP:

```bash
terraform output -raw ec2_public_ip
```

## How to retrieve the EC2 public IP

You can view the public IP from the Terraform output:

```bash
terraform output -raw ec2_public_ip
```

Or inspect the output table:

```bash
terraform output
```

## SSH connection instructions

This project creates an EC2 Key Pair from your local public SSH key and allows SSH access on port 22. Use the matching private key:

```bash
ssh -i ~/.ssh/id_rsa ec2-user@$(terraform output -raw ec2_public_ip)
```

The EC2 instance uses the Amazon Linux AMI, which is configured for the `ec2-user` login account by default.

## Destroy all resources

To remove the EC2 instance and all related resources created by this project:

```bash
terraform plan -destroy
terraform destroy
```

This will remove:

- EC2 instance
- Key Pair
- Security Group
- Route table resources
- Internet Gateway
- Subnet
- VPC

Do not create a separate Terraform project to delete these resources. Use the same Terraform project and state file that created the infrastructure.

## Security recommendations

- Restrict SSH access to your own public IP or office network.
- Do not allow `0.0.0.0/0` to SSH into the EC2 instance.
- Keep your private key secure and do not check it into source control.
- Rotate or replace the SSH key if it is ever exposed.
- Periodically review AWS billing and resource usage.
- Use least-privilege IAM permissions for any AWS credentials used during deployment.

## Free Tier limitations and warnings

This project intentionally avoids many expensive or non-Free-Tier AWS services by using only the minimal network and compute resources required for a simple public EC2 lab.

However, usage is still subject to:

- AWS account type
- account age
- deployment region
- current AWS Free Tier terms
- any concurrent usage beyond your free allowance

This project does not create any of the following:

- NAT Gateway
- Elastic Load Balancer
- Application Load Balancer
- Network Load Balancer
- RDS
- Aurora
- EKS
- ECS
- Lambda with unnecessary provisioning
- VPN Gateway
- Transit Gateway
- AWS Network Firewall
- VPC Endpoints
- Dedicated Hosts
- Additional EC2 instances
- Additional EBS volumes
- Elastic IP
- CloudFront
- Route 53 hosted zones
- Marketplace AMIs with extra charges

The main resource is a single Amazon Linux EC2 instance in a public subnet, plus required networking and access control.

## Network architecture

```text
Internet
    |
Internet Gateway
    |
Public Subnet
    |
Security Group
    |
Amazon Linux EC2
```

The VPC CIDR is `10.0.0.0/16` and the public subnet is `10.0.1.0/24` with `map_public_ip_on_launch = true` enabled.

## Cost and billing note

Free Tier eligibility depends on the AWS account type, account age, region, and current AWS Free Tier terms. Creating the resources in this project does not guarantee zero cost. The user must review their AWS Free Tier usage and pricing before deployment.

## Typical Terraform lifecycle

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
terraform output
terraform destroy
```
