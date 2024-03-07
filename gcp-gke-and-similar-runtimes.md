# GKE, Cloud Run and App Engine

## Contents
1. GKE vs. Cloud Run vs. App Engine
2. GKE
3. App Engine

## GKE vs. Cloud Run vs. App Engine

* Cloud Run is analogous to AWS Fargate or Azure Container Services - i.e. serverless K8s server

## GKE

### Connect to GKE via `kubectl`

```cmd
# Have to authenticate via gmail
gcloud container clusters get-credentials $my_cluster --zone $my_zone
kubectl config view

# Creds and configs are in ~/.kube/ folder - in ~/.kube.config text file
```

### Get `kubectl` contexts

```cmd
## Check contexts
kubectl cluster-info
kubectl config current-context
kubectl config get-contexts
kubectl config use-context <context name> # same as kubectx <context name>

## 
kubectl config view # View the current context infomation - same as in ./kube/config file
kubectl cluster-info
```

### GKE Preemptible nodes

* Preemptible nodes are like Spot EC2 instances:
  * Can be taken away at any time - no guarantee of availability
  * App should be able to recover


### Anthos
* Anthos provides a central management and monitoring solution for GKE clusters
* Can be used to manage and monitor all GKE clusters in your project

### Pod Autoscaling
TODO: Read about Horizontal and Vertical Pod Autoscaling

### Regional GKE cluster

* Default number of Zones for a regional gke cluster is 3


## App Engine

### Standard vs. Flexible

TODO: Read on App Engine

### Notes

* Rollback:
  * It's easy to set previous version of an application as 'default'- which will cause App Engine to route all traffic to the previous version
* Traffic splitting feature:
  * App Engine is able to split traffic across multiple versions of an application