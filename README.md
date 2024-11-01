# AWS EKS with Grafana Monitoring

## Introduction:
* 👋 Hey everyone! Welcome back to my GitHub.
* 🎥 This repo shows you how to set up Grafana with Docker Compose and integrate it with an Amazon EKS Cluster for monitoring.
* 📊 Grafana is a powerful tool for data visualization, and with this guide, you'll be able to monitor your Kubernetes clusters with ease.

## Prerequisites:
* 💻 A computer with Docker and Docker Compose installed.
* 📁 Basic knowledge of AWS CLI, Docker, and Kubernetes.
* 🛠 AWS CLI configured with access to create EKS clusters and associated resources.

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

**4. Create an EKS Cluster using AWS CLI:**
   * Open your terminal and ensure AWS CLI is configured with appropriate permissions.
   * Create an IAM role and EKS Cluster using the commands below:
     ```bash
     aws iam create-role --role-name eksClusterRole --assume-role-policy-document file://eks-trust-policy.json
     aws iam attach-role-policy --role-name eksClusterRole --policy-arn arn:aws:iam::aws:policy/AmazonEKSClusterPolicy
     ```
   * Use the command below to create an EKS Cluster:
     ```bash
     aws eks create-cluster --name my-eks-cluster --role-arn arn:aws:iam::<YOUR_ACCOUNT_ID>:role/eksClusterRole --resources-vpc-config subnetIds=<SUBNET_ID_1>,<SUBNET_ID_2>,securityGroupIds=<SECURITY_GROUP_ID>
     ```

**5. Configure EKS Worker Nodes:**
   * Create a node IAM role:
     ```bash
     aws iam create-role --role-name eksWorkerRole --assume-role-policy-document file://worker-trust-policy.json
     aws iam attach-role-policy --role-name eksWorkerRole --policy-arn arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy
     aws iam attach-role-policy --role-name eksWorkerRole --policy-arn arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly
     aws iam attach-role-policy --role-name eksWorkerRole --policy-arn arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy
     ```
   * Create the node group:
     ```bash
     aws eks create-nodegroup --cluster-name my-eks-cluster --nodegroup-name my-eks-nodes --subnets <SUBNET_ID_1> <SUBNET_ID_2> --node-role arn:aws:iam::<YOUR_ACCOUNT_ID>:role/eksWorkerRole --scaling-config minSize=1,maxSize=3,desiredSize=2 --disk-size 20 --instance-types t3.medium
     ```

**6. Update kubeconfig for Accessing EKS:**
   * Update your local kubeconfig file:
     ```bash
     aws eks update-kubeconfig --region us-east-1 --name my-eks-cluster
     ```
   * This will allow `kubectl` access to your EKS cluster.

**7. Add EKS Monitoring with Grafana and Prometheus:**
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
* 🛠 If you encounter issues with EKS, verify IAM roles and subnet IDs. Use `kubectl` to confirm node and cluster status.
* 🔍 Check logs using `docker logs grafana` or `kubectl logs <pod_name>` if any issues arise with Grafana or EKS components.

## Outro:
* 🎉 Congrats! You've successfully set up Grafana with Docker Compose and integrated it with your Amazon EKS Cluster.
* 💬 Feel free to leave any questions or comments. Happy monitoring!
