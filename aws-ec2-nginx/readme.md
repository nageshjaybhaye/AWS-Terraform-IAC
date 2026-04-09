# 🚀 Terraform AWS EC2 Nginx Deployment

## 📌 Overview
This project demonstrates how to use **Terraform** to provision an AWS EC2 instance and automatically configure it with **Nginx** using **User Data**.

The deployed instance serves a basic web page over **HTTP (Port 80)**.

---

## 🏗️ Architecture

<p align="center">
  <img src="./images/architecture.png" width="700"/>
</p>


---

## 📁 Project Structure
```
.
├── main.tf          # Main Terraform configuration
├── variables.tf     # Input variables
├── outputs.tf       # Outputs (e.g., public IP)
├── provider.tf      # AWS provider config
└── README.md        # Project documentation
```

---

## ⚙️ Tech Stack
- AWS (EC2) – Cloud infrastructure
- Terraform – Infrastructure as Code
- Nginx – Web server (Port 80)
- Bash (User Data) – Instance setup automation
- Linux (Ubuntu) – Operating system
- Terraform CLI – Deployment tool

---

## 💡 Key Concepts
- **Provider** – Plugin to interact with AWS
- **Resource** – Infrastructure component (EC2)
- **Variable** – Makes configs reusable
- **User Data** – Script executed at launch
- **EC2 Instance** – Virtual server
- **Nginx** – Web server

---

## 🧾 Terraform Configuration

### 🔹 Provider (AWS)
```hcl
provider "aws" {
  alias  = "ohio"
  region = var.aws_region
}
```

---

### 🔹 Key Pair
```hcl
resource "aws_key_pair" "terraform_key_pair" {
  key_name   = "local_key_pair"
  public_key = file(var.key_path)
}
```

---

### 🔹 Security Group
```hcl
resource "aws_security_group" "terraform_ec2_sg" {
  name        = "terraform-ec2-sg"
  description = "Security group for Terraform EC2 instance"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

---

### 🔹 EC2 Instance
```hcl
resource "aws_instance" "terraform_ec2_instance" {
  count                  = var.server_count
  ami                    = var.ami_id
  instance_type          = var.instace_type
  key_name               = aws_key_pair.terraform_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.terraform_ec2_sg.id]

  user_data = file("user_data.sh")

  root_block_device {
    volume_size = var.volume_size
    volume_type = "gp2"
  }

  tags = {
    Name = "${var.instance_name}-${count.index + 1}"
  }
}
```

---

## 📜 user_data.sh (Nginx Setup)
```bash
#!/bin/bash
sudo apt update -y
sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
echo "<h1>Welcome to Terraform EC2 Instance</h1>" | sudo tee /var/www/html/index.html
```

---

## 🔧 Variables (variables.tf)
```hcl
variable "aws_region" {
  description = "The AWS region to deploy the EC2 instance"
  type        = string
  default     = "ap-south-1"
}

variable "instace_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
  default     = "ami-"
}

variable "key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "c:/users/altam/.ssh/id_ed25519.pub"
}

variable "server_count" {
  description = "Number of instances"
  type        = number
  default     = 1
}

variable "instance_name" {
  description = "Instance name"
  type        = string
  default     = "Terraform-EC2-Instance"
}

variable "volume_size" {
  description = "EBS volume size"
  type        = number
  default     = 8
}
```

---

## 📤 Outputs (outputs.tf)
```hcl
output "instance_public_ips" {
  value = aws_instance.terraform_ec2_instance[*].public_ip
}

output "instance_dns_names" {
  value = aws_instance.terraform_ec2_instance[*].public_dns
}

output "instance_ids" {
  value = aws_instance.terraform_ec2_instance[*].id
}
```

---

## 🚀 Deployment Steps

```bash
terraform init
terraform validate
terraform plan
terraform apply
```
<p align="center">
  <img src="./images/vs-code.png" width="700"/>
</p>

```bash
EC2 Console
```
<p align="center">
  <img src="./images/ec2-instance.png" width="700"/>
</p>



---

## 🌐 Access the Application

Open in browser:
```bash
(http://<public-ip> )
```

<p align="center">
  <img src="./images/terraform-nginx-deploy-page.png" width="700"/>
</p>


---

## ✅ Result
- EC2 instance running on AWS
- Nginx installed automatically
- Web server accessible

---

## 🧹 Cleanup
```bash
terraform destroy
```

---

## 📌 Conclusion
This project demonstrates a simple yet powerful DevOps workflow using Terraform to automate infrastructure provisioning and application setup on AWS.
