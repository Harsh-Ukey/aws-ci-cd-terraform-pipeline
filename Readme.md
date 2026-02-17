# ☁️ AWS End-to-End CI/CD Pipeline with Terraform & Docker

## 🚀 Project Overview
This project demonstrates an enterprise-grade DevOps workflow by provisioning highly available AWS cloud infrastructure using **Terraform** and automating application deployment via **GitHub Actions** and **Docker**. 

It is designed to showcase core Cloud Engineering and DevOps practices, including Infrastructure as Code (IaC), containerization, automated testing/deployment, and strict IAM security policies.

## 🏗️ Architecture & Technologies Used
* **Cloud Provider:** Amazon Web Services (AWS - `eu-north-1`)
* **Infrastructure as Code (IaC):** Terraform (with remote S3 backend state management)
* **CI/CD:** GitHub Actions
* **Containerization:** Docker & Amazon Elastic Container Registry (ECR)
* **Compute & Networking:** AWS EC2 (`t3.micro`), Application Load Balancer (ALB), Auto Scaling Groups (ASG), VPC, Public Subnets, Security Groups.
* **Application:** Python Flask web application.

## ⚙️ Key Features & Security Implementations
1. **Automated Provisioning:** GitHub Actions pipeline triggers on every push to the `main` branch, building the Docker image, pushing to ECR, and applying Terraform infrastructure updates seamlessly.
2. **Strict Security Groups:** Implemented defense-in-depth. EC2 instances only accept traffic originating from the Application Load Balancer (ALB).
3. **IAM Least Privilege:** Dedicated GitHub Actions deployment user configured with restricted access, and EC2 instances assigned an IAM Role strictly limited to `AmazonEC2ContainerRegistryReadOnly` to securely pull Docker images.
4. **Remote State Management:** Terraform state (`.tfstate`) is securely stored in an AWS S3 bucket with strict public-access blocks.
5. **Self-Healing Infrastructure:** Configured an Auto Scaling Group (ASG) and Launch Templates to ensure high availability. 

---

## 📸 Proof of Execution

### 1. Live Web Application (Served via ALB)
*The Python Flask application successfully running and served to the internet through the AWS Application Load Balancer.*
![Live Web App](screenshots/live-app.png)

### 2. Automated CI/CD Pipeline (GitHub Actions)
*Successful workflow run showing code checkout, AWS authentication, Docker build/push to ECR, and Terraform initialization/application.*
![CI/CD Pipeline](screenshots/github-actions.png)

### 3. Container Registry (Amazon ECR)
*The private repository securely storing the versioned Docker images.*
![Amazon ECR](screenshots/ecr-repo.png)

### 4. Remote State Backend (Amazon S3)
*Terraform state secured in an S3 bucket with public access fully blocked.*
![Amazon S3 Backend](screenshots/s3-backend.png)

### 5. IAM Security (Least Privilege)
*Restricted IAM user policies attached to the GitHub Actions deployer to ensure secure infrastructure provisioning.*
![IAM Setup](screenshots/iam-permissions.png)

---

## 🛠️ Deployment Workflow (How it Works)
1. **Code Commit:** Developer pushes updated Python code and Terraform configurations to GitHub.
2. **Authentication:** GitHub Actions securely authenticates with AWS using stored repository secrets.
3. **Containerization:** The pipeline builds a new Docker image from the source code and pushes it to Amazon ECR.
4. **Infrastructure Update:** GitHub Actions initializes Terraform and applies the configuration (`terraform apply -auto-approve`).
5. **Instance Bootstrapping:** The Auto Scaling Group spins up EC2 instances. The user-data script runs on boot, installs Docker, authenticates with ECR, and runs the latest containerized application on Port 80.