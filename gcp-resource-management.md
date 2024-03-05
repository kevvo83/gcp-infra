# Resource Management

## Contents

* Notes
* Scope of resources (Global vs. Regional vs. Zonal)
* Quotas/Limits
* Labels vs. Tags

## Notes
* Each Project is associated with 1 Billing Account
* An Organization contains All billing accounts
* Projects are identified by:
  * Project ID (unique ID generated from project name)
  * Project Name (human readable - not used by Google APIs)
  * Project Number (number that is automatically generated & assigned to my project)

## Scope of resources (Global vs. Regional vs. Zonal)

1. Global - VPCs, Snapshots (Disk images), Images (Compute EMIs)
2. Regional - Subnets, Externel IP addresses, 
3. Zonal - Compute Instances, disks

## Quotas/Limits
* Quotas can be changed
* Can be used to prevent runaway bills in case of human/machine error or malicious attacks
* Quotas force sizing and periodic reviews
* Even if you have the quota, it depends on Regional availability

## Labels vs. Tags

* Tags are applied ONLY to compute instances - used mainly for Networking, such as applying firewall rule based on tags
* Labels are used for billing, to identify projects and owning persons/teams - examples below:
  * Teams or Cost Center - could be used for accounting
  * Components - <front-end>, <back-end>
  * Enviroment - <prod>, <dev>
  * Owner - <PersonA>
  * State - <tobedel>, <inuse>, etc.



