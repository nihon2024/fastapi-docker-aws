FastAPI on AWS – Production-Grade Deployment

Overview

This project demonstrates a production-ready deployment of a containerised FastAPI application on AWS using Terraform. It follows best practices for networking, security, and scalability.

⸻

Architecture
	•	FastAPI application (Dockerised)
	•	Amazon ECS Fargate (serverless containers)
	•	Application Load Balancer (ALB)
	•	Amazon ECR (container registry)
	•	VPC with public and private subnets
	•	NAT Gateway for secure outbound internet access
	•	AWS Certificate Manager (ACM) for HTTPS
	•	Terraform for infrastructure provisioning

⸻

Architecture Design
	•	ALB is deployed in public subnets
	•	ECS tasks run in private subnets
	•	No public IPs assigned to containers
	•	NAT Gateway enables outbound access (e.g. pulling images from ECR)
	•	Security Groups enforce least-privilege access:
	•	Internet → ALB (HTTP/HTTPS)
	•	ALB → ECS (port 8000 only)

⸻

Request Flow

User → ALB (Public Subnet) → ECS Fargate (Private Subnet) → Response

Outbound traffic:
ECS → NAT Gateway → Internet (ECR, updates, etc.)

⸻

Project Structure

.
├── app/                    # FastAPI application
│   ├── main.py
│   ├── Dockerfile
│   └── requirements.txt
│
├── infra/                  # Terraform infrastructure
│   ├── provider.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── networking.tf
│   ├── security.tf
│   ├── ecr.tf
│   ├── ecs.tf
│   ├── alb.tf
│   ├── terraform.tfvars.example
│
├── .gitignore
├── README.md
Deployment

1. Build and Push Docker Image
docker build -t fastapi-app .

docker tag fastapi-app:latest <your-account-id>.dkr.ecr.<region>.amazonaws.com/fastapi-app:latest

docker push <your-account-id>.dkr.ecr.<region>.amazonaws.com/fastapi-app:latest

2. Provision Infrastructure
cd infra
terraform init
terraform apply

3. Access Application: Use the ALB DNS output from Terraform:
http://<alb_dns>
If HTTPS is configured:
https://<alb_dns>

HTTPS Configuration
	•	TLS certificates managed via AWS Certificate Manager (ACM)
	•	ALB listener configured on port 443
	•	HTTP (port 80) redirects to HTTPS (if certificate is provided)

⸻

Auto Scaling
	•	ECS Service supports horizontal scaling
	•	Can be configured based on CPU or memory utilisation
	•	ALB distributes traffic across healthy tasks

⸻

CI/CD (Recommended)

This project is designed to integrate with CI/CD pipelines such as GitHub Actions.

Typical workflow:
	1.	Build Docker image
	2.	Push image to Amazon ECR
	3.	Deploy updated task definition to ECS
	4.	(Optional) Run Terraform for infrastructure changes

⸻

Security
	•	ECS tasks run in private subnets
	•	No direct internet exposure for containers
	•	Traffic controlled via Security Groups
	•	HTTPS enforced at the load balancer

⸻

Cost Considerations
	•	NAT Gateway incurs a fixed monthly cost
	•	Suitable for production environments
	•	For development, a simplified public setup may be used

⸻

Future Enhancements
	•	Modular Terraform structure
	•	CloudWatch logging and monitoring
	•	AWS WAF integration
	•	Blue/Green deployments

⸻

Key Concepts Demonstrated
	•	Infrastructure as Code (Terraform)
	•	Container orchestration (ECS Fargate)
	•	AWS networking (VPC, subnets, NAT Gateway)
	•	Load balancing and HTTPS
	•	Secure production architecture

⸻

Author

Nitesh Kumar