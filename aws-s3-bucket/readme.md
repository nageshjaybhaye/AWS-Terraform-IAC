# 🚀 AWS S3 Bucket Provisioning with Terraform

## 📌 Overview
I built this project to understand how **Infrastructure as Code (IaC)** works in a real-world setup.

The main idea was to stop relying on the **AWS Console** and instead manage infrastructure through code — making everything cleaner, reusable, and version-controlled.

---

## 🏗️ Architecture
```
Terraform → AWS S3 → Bucket Created
```

---

## ⚙️ Tech Stack
- **Cloud Provider:** AWS  
- **IaC Tool:** Terraform (v1.x)  
- **Language:** HCL (HashiCorp Configuration Language)  
- **Service:** AWS S3  

---

## ✅ Prerequisites
Before running this project, make sure you have:

- AWS CLI installed and configured (`aws configure`)  
- Terraform installed on your system  
- Proper IAM permissions to create S3 buckets  

---

## 💡 What is Terraform?
Terraform is an **Infrastructure as Code (IaC)** tool used to create and manage infrastructure using code instead of manual setup.

- Uses HCL (HashiCorp Configuration Language)  
- Configuration files use `.tf` extension  
- Works with cloud providers like AWS  

---

## 🔌 Provider in Terraform
A provider is a plugin that allows Terraform to interact with a specific platform.

```hcl
provider "aws" {
  alias  = "mumbai"
  region = "ap-south-1"
}
```

---

## 🧱 Understanding Terraform Blocks
Blocks are the main building units in Terraform.

**Simple meaning:** A block is just a section of code with a specific purpose.

### Common Blocks
- `provider` → connects to cloud  
- `resource` → creates infrastructure  
- `variable` → input values  
- `output` → shows results  

---

## 📦 Terraform Resource (S3 Bucket)
This block creates an S3 bucket in AWS:

```hcl
resource "aws_s3_bucket" "demo_project_bucket" {
  bucket = "demo-with-project-bucket-terraform"

  tags = {
    Name        = "my-demo-project-bucket"
    environment = "dev"
  }
}
```

---

## 🚀 Terraform Workflow

### 🔹 Initialize Terraform
```bash
terraform init
```
- Downloads required provider plugins  
- Prepares working directory  

---

### 🔹 Validate Configuration
```bash
terraform validate
```
- Checks syntax errors  
- Verifies configuration  

---

### 🔹 Preview Changes
```bash
terraform plan
```
- Shows what will be created, updated, or deleted  

---

### 🔹 Apply Configuration
```bash
terraform apply
```
- Creates/updates infrastructure  
- Asks for confirmation  

---

## 🔍 Verify in AWS Console
- Go to **S3 service**
- Check bucket: `demo-with-project-bucket-terraform`
- Verify tags and details  

---

## 🧹 Cleanup (Destroy Resources)

```bash
terraform destroy
```

### What it does:
- Deletes the S3 bucket  
- Removes all resources  
- Cleans up infrastructure  

👉 Type `yes` when prompted

---

## 📌 Conclusion
This project helped me understand how to use **Terraform to automate AWS infrastructure**, making deployments faster, consistent, and version-controlled.
