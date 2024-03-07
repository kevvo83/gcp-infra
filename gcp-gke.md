# GKE

## Connect to GKE via `kubectl`

```cmd
# Have to authenticate via gmail
gcloud container clusters get-credentials $my_cluster --zone $my_zone
kubectl config view

# Creds and configs are in ~/.kube/ folder - in ~/.kube.config text file
```

## GKE vs. Cloud Run

Cloud Run is analogous to AWS Fargate or Azure Container Services - i.e. serverless K8s server


## Get `kubectl` contexts

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


## Create deployment using `kubectl`