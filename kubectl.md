# `kubectl` commands repository

## Important utilities

```cmd
kubectx # to view and set kubectl contexts
kubens # to view and set namespaces
```

## Namespaces, pods, deployments, `kubectl exec` commands

```cmd
## switch namespaces
kubectl get namespaces
##### kubectl config set-context --current --namespace=<namespace>
kubectx <context name>

## Switch namespaces using the kubens utility
kubens default
kubens <namespace name>

kubectl get pods -n default
kubectl get pods -n <namespace>

## Deployments
kubens <namespace name>
kubectl get deployments
kubectl create deployment nginx-1 --image=nginx -r 1
kubectl get pods

## Describe Pod
kubectl describe pod <podname>
# Can see what are the containers running in this Pod

## Copy file to container within a pod
kubectl cp ~/test.html <pod name>:/usr/share/nginx/html/test.html -c <container name>

## Exec stuff within a container in a pod
kubectx <context name>
kubens <namespace name>
kubectl exec -it my-pod-name -n default -- /bin/bash

## Logs
kubectl logs <podname> -n <namespace>

## Expose Pod as a service
kubectl expose pod $my_nginx_pod --port 80 --type LoadBalancer ## Need to read more into this
# Don't know enough about services in K8s
```

## Deploy pods to K8s via manifest

Manifest file example - refer to the `kind: Pod`.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: new-nginx
  labels:
    name: new-nginx
spec:
  containers:
  - name: new-nginx
    image: nginx
    ports:
    - containerPort: 80
```
Apply:
```cmd
kubectx <context name>
kubens <namespace name>
kubectl apply -f manifest.yaml
```

## Port forward from local machine to Pod