# AWS EKS with Grafana Monitoring

## Introduction:
* 👋 Hey everyone! Welcome back to my GitHub.
* 🎥 This repo shows you how to set up Grafana with Docker Compose and integrate it with an Amazon EKS Cluster for monitoring.
* 📊 Grafana is a powerful tool for data visualization, and with this guide, you'll be able to monitor your Kubernetes clusters with ease.

## Prerequisites:
* 💻 A computer with Docker and Docker Compose installed.
* 📁 Basic knowledge of Terraform, AWS CLI, Docker, and Kubernetes.
* 🛠 AWS CLI configured with access to create EKS clusters and associated resources.
* 🔧 Terraform installed on your local machine.

## Steps:
**1. Set Up Grafana using Docker Compose:**
   * Open your terminal and create a new directory for your Grafana setup.
   * Inside the directory, create a file named `docker-compose.yml` 📝.

**2. Define Grafana Service in Docker Compose:**
   * Open `docker-compose.yml` and define the Grafana service with the following configuration:
     ```yaml
     version: '3'
     services:
       grafana:
         image: grafana/grafana:latest
         container_name: grafana
         ports:
           - "3000:3000"
         environment:
           - GF_SECURITY_ADMIN_USER=admin
           - GF_SECURITY_ADMIN_PASSWORD=admin
         volumes:
           - grafana-storage:/var/lib/grafana
     volumes:
       grafana-storage:
     ```

**3. Launch Grafana:**
   * In your terminal, navigate to the directory with your `docker-compose.yml` file.
   * Run `docker-compose up -d 🐳` to start Grafana.
   * Grafana will be available on `http://localhost:3000`, with the default credentials `admin/admin`.

**4. Set Up the EKS Cluster using Terraform:**
   * Navigate to the `eks-cluster` directory in this repository. This directory contains all the necessary Terraform files (`main.tf`, `outputs.tf`, `variables.tf`, and `terraform.tfvars`) to set up an EKS cluster on AWS.
   * Modify the `terraform.tfvars` file to include your AWS credentials, preferred region, and any additional configuration variables needed for your environment.

   **Steps to Deploy EKS with Terraform:**
   
   1. **Initialize Terraform:**  
      Run the following command to initialize the Terraform configuration in the `eks-cluster` directory:
      ```bash
      terraform init
      ```

   2. **Plan the Deployment:**  
      Review the changes Terraform will make to your AWS account by running:
      ```bash
      terraform plan
      ```

   3. **Apply the Configuration:**  
      Deploy the EKS Cluster using:
      ```bash
      terraform apply
      ```
      Confirm the action when prompted. Terraform will create the necessary infrastructure, including the EKS cluster, VPC, and worker nodes.

   4. **Obtain Cluster Details:**  
      After the setup completes, Terraform will output important information about your EKS cluster, such as the Kubernetes endpoint and cluster role ARN.

**5. Configure `kubectl` to Access the EKS Cluster:**
   * After the Terraform deployment is complete, update your `kubeconfig` file to access the EKS cluster:
     ```bash
     aws eks update-kubeconfig --region <your-region> --name <your-cluster-name>
     ```
   * This allows you to manage the EKS cluster using `kubectl`.

**6. Add EKS Monitoring with Grafana and Prometheus:**
   * Install Prometheus on the EKS cluster (using Helm is recommended):
     ```bash
     helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
     helm repo update
     helm install prometheus prometheus-community/prometheus
     ```
   * Open Grafana at `http://localhost:3000` and log in.
   * Go to **Configuration > Data Sources** in Grafana, and add **Prometheus** as a data source using the Prometheus endpoint.
   * Import Kubernetes monitoring dashboards (ID **315** for Kubernetes cluster monitoring) to view EKS metrics.

## Troubleshooting:
* 🚨 Make sure Docker and Docker Compose are running properly on your system.
* 🛠 Verify IAM roles, security groups, and subnet configurations if any issues arise with EKS deployment.
* 🔍 Use `terraform show` or `terraform state list` to inspect Terraform-managed resources if there are configuration issues.

## Outro:
* 🎉 Congrats! You've successfully set up Grafana with Docker Compose and integrated it with your Amazon EKS Cluster using Terraform.
* 💬 Feel free to leave any questions or comments. Happy monitoring!
