# TODOs

- Create public bucket
  - Signed URL
  - ACLs (`allUsers` in the scope - verify that for objects, `Public access` setting is set to `Public Link`)
- Setup App Loadbalancer to the VM Instance Group backend
- Look into BigTable and where it should be used
- Setup IAP authZ/authN to the LoadBalancer
  - May have to update the backend flask server for scopes?
- Setup the same Docker application to run on GKE backend
  - Update the App Loadbalancer backend to be GKE
  - Setup GKE service/ingress, etc. all of that
- Terraform Infrastructure tests
- Setup my GCP Organization 
  - Shared VPC setup in my Org - including:
    - Host `shared-services` project, and
    - Service `nonprod` project with VM/GKE instances