# Professional Cloud Architect Certification

1. Notes
2. Infrastructure build and investigation


## 2. Infrastructure build and investigation

### Step 1 - Execute the GitHub Actions pipeline to build out the dev environment in GCP

### Step 2 - Manually create an Artifact Registry and push App Repository (image)

[GitHub repo used is here](https://github.com/GoogleCloudPlatform/python-docs-samples/tree/f832838969ab0de16ac8a458e6bb8c3c78845cfc)

```cmd
git clone https://github.com/GoogleCloudPlatform/python-docs-samples.git
cd python-docs-samples/run/helloworld/
gcloud builds submit --tag australia-southeast1-docker.pkg.dev/lrn-nonprod/docker-repo1/helloworld:tag1
```

### Step 3 - Create Instance Template of VMs to run in the Private subnet

* Create a Compute Engine VM
* Click the section that allows you to add and run a Docker container on startup
  * Configure this setting with `australia-southeast1-docker.pkg.dev/lrn-nonprod/docker-repo1/helloworld:tag1`
* Navigate to `Compute Engine > Instance templates` and create an Instance template
  * I did this via the Console - attached the `gcloud` command here for reference:
  ```cmd
  gcloud compute instance-templates create-with-container 
  private-backend-server-template --project=lrn-nonprod --machine-type=e2-micro 
  --network-interface=subnet=private-subnet1,no-address --maintenance-policy=MIGRATE
  --provisioning-model=STANDARD
  --service-account=1090706332184-compute@developer.gserviceaccount.com
  --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --region=australia-southeast1 --container-image=australia-southeast1-docker.pkg.dev/lrn-nonprod/docker-repo1/helloworld:tag1 --container-restart-policy=always --container-env=PORT=8080 --create-disk=auto-delete=yes,boot=yes,device-name=private-backend-server-template,image=projects/cos-cloud/global/images/cos-stable-109-17800-147-22,mode=rw,size=10,type=pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=container-vm=cos-stable-109-17800-147-22
  ```
  * Key notes:
    * Created the instance template in the private subnet
    * Set external ip to None
    * Added config to create a Docker container to be run at bootup
* Create an Instance Group (via console) that can be configured to be the backend of the App LB!

### Step 4 - Create App Loadbalancer with a public Anycast Ip - route traffic to the private backend 

