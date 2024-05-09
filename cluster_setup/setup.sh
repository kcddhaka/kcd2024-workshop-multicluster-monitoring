#!/bin/bash
AWS_ACC_ID=137440810107
CLUSTER_NAME=beta

# Create Production Cluster

sed -i "0,/name:/ s/name: .*/name: $CLUSTER_NAME-Prod/g" cluster.yaml;
sed -i "0,/- name:/ s/- name: .*/- name: $CLUSTER_NAME-Prod-node/g" cluster.yaml;

sleep 1;

eksctl create cluster -f cluster.yaml
eksctl utils associate-iam-oidc-provider --cluster $CLUSTER_NAME-Prod --approve
eksctl create iamserviceaccount \
    --name ebs-csi-controller-sa \
    --namespace kube-system \
    --cluster $CLUSTER_NAME-Prod \
    --role-name AmazonEKS_EBS_CSI_DriverRole-$CLUSTER_NAME-Prod \
    --role-only \
    --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
    --approve
eksctl create addon --name aws-ebs-csi-driver --cluster $CLUSTER_NAME-Prod --service-account-role-arn arn:aws:iam::$AWS_ACC_ID:role/AmazonEKS_EBS_CSI_DriverRole-$CLUSTER_NAME-Prod --force

sleep 20;

kubectl apply -f ./manifests/storageclass.yaml

sleep 5;

kubectl apply -f ./manifests/claim.yaml -f ./manifests/pod.yaml


#######################################################################################################

# Create Staging Cluster


sed -i "0,/name:/ s/name: .*/name: $CLUSTER_NAME-Staging/g" cluster.yaml;

sed -i "0,/- name:/ s/- name: .*/- name: $CLUSTER_NAME-Staging-node/g" cluster.yaml;

sleep 1;

eksctl create cluster -f cluster.yaml


eksctl utils associate-iam-oidc-provider --cluster $CLUSTER_NAME-Staging --approve

eksctl create iamserviceaccount \
    --name ebs-csi-controller-sa \
    --namespace kube-system \
    --cluster $CLUSTER_NAME-Staging \
    --role-name AmazonEKS_EBS_CSI_DriverRole-$CLUSTER_NAME-Staging \
    --role-only \
    --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
    --approve

eksctl create addon --name aws-ebs-csi-driver --cluster $CLUSTER_NAME-Staging --service-account-role-arn arn:aws:iam::$AWS_ACC_ID:role/AmazonEKS_EBS_CSI_DriverRole-$CLUSTER_NAME-Staging --force

sleep 20;

kubectl apply -f ./manifests/storageclass.yaml
sleep 5;
kubectl apply -f ./manifests/claim.yaml -f ./manifests/pod.yaml
