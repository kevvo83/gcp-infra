# Cloud Build & Artifact Registry

### Look into these in the near future

* Connect & run image from local terminal instead of cloud shell
* Private pools and how do these work with:
  * VPC peering
  * Shared VPCs
* Containerd runtimes - how do these work?

### Artifact Registry
Artifact Registry repository name is in the format:
`<region>-docker.pkg.dev/<gcp-projectname>/<repository-name>`.

Artifact Registry server name is in the format: `<region>-docker.pkg.dev`.

#### Create Repository in the Artifact Registry

```cmd
export REGION=us-west1
export PROJECT_ID=qwiklabs-gcp-02-38ee24b1861f

gcloud artifacts repositories \
    create hello-repo \
    --repository-format=docker \
    --location=${REGION} \
    --description="Docker repository"
```


### Create `Dockerfile`

```docker
FROM alpine
COPY quickstart.sh /
CMD ["/quickstart.sh"]
```

### Build via `gcloud builds submit`

```cmd
gcloud builds submit --tag us-east1-docker.pkg.dev/${DEVSHELL_PROJECT_ID}/quickstart-docker-repo/quickstart-image:tag1
```

### Build via `docker` CLI - from Cloud Shell or Local terminal
Refer: https://cloud.google.com/artifact-registry/docs/docker/store-docker-container-images
I've done this successfully from Cloud Shell.

### Build & Run via `Cloudbuild.yaml` - declarative instead of imperative

#### 1.1 First `cloudbuild.yaml` example - just build only
```yaml
steps:
- name: 'gcr.io/cloud-builders/docker'
  args: [ 'build', '-t', 'us-east1-docker.pkg.dev/$PROJECT_ID/quickstart-docker-repo/quickstart-image:tag1', '.' ]
images:
- 'us-east1-docker.pkg.dev/$PROJECT_ID/quickstart-docker-repo/quickstart-image:tag1'
```

#### 1.2 Second `cloudbuild.yaml` example - with build and then test
```yaml
steps:
- name: 'gcr.io/cloud-builders/docker'
  args: [ 'build', '-t', 'us-east1-docker.pkg.dev/$PROJECT_ID/quickstart-docker-repo/quickstart-image:tag1', '.' ]
- name: 'us-east1-docker.pkg.dev/$PROJECT_ID/quickstart-docker-repo/quickstart-image:tag1'
  args: ['fail']
images:
- 'us-east1-docker.pkg.dev/$PROJECT_ID/quickstart-docker-repo/quickstart-image:tag1'
```

#### 2.0 Execute the `cloudbuild.yaml` to build and run the image
```cmd
gcloud builds submit --config cloudbuild2.yaml
```

### View Artifact Repository via CLI

#### Cloud Shell

```cmd
gcloud artifacts docker images list us-east1-docker.pkg.dev/qwiklabs-gcp-04-f8a95dc1fd95/quickstart-docker-repo --include-tags
```

#### Local terminal
**TO TRY THIS OUT** 
Refer: https://cloud.google.com/artifact-registry/docs/docker/store-docker-container-images





