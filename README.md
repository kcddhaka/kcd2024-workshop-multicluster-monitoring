# *Kubernetes Multi-Cluster Monitoring With Prometheus, Thanos & Grafana*

  
## Prerequisites

  
To be able to smoothly perform this workshop make sure your machine contains required software packages.
  

**1. awscli v2** (Version: aws-cli/2.15.45 Preffered )

[https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
  

**2. Kubectl**

[https://kubernetes.io/docs/tasks/tools/](https://kubernetes.io/docs/tasks/tools/)

[https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)

# Steps:


## Step 1: Adding The Cluster

1. Authenticate with the AWS account

  
    `aws configure`

2. Add EKS cluster config

    `aws eks update-kubeconfig --region ap-south-1 --name $CLUSTER_NAME`  

**OUTPUT:**

![empty cluster](./assets/1.png)

  
  
## Step 2: Create Object Storage *(production cluster)*

**OUTPUT:**

![empty cluster](./assets/2.png)



## Step 3: Create Thanos Component Receiver *(staging cluster)*

**OUTPUT:**

![empty cluster](./assets/3.png)


## Step 4: Create Prometheus And Node Exporter *(production cluster)*

**OUTPUT:**

![empty cluster](./assets/4.png)


## Step 5: Create All Thanos Components *(staging cluster)*

**OUTPUT:**

![empty cluster](./assets/5.png)

**Verify**

`count by(instance)(node_cpu_seconds_total)`

## Step 6: Create Prometheus *(staging cluster)*

**OUTPUT:**

![empty cluster](./assets/6.png)

## Step 7: Create Grafana *(staging cluster)*

**OUTPUT:**

![empty cluster](./assets/7.png)