# Networking

## VPCs vs. Subnets

* VPCs are Global
* Subnets are Regional
* Subnets can be sized up by increasing the subnet ip range
  * No downtime for VMs in the subnet
* Subnets can't be down-sized - only up-sized

### Redundancy

* You have global redundancy by setting up global VPC
  * Subnets in specific regions
    * Compute in multiple AZs within the Subnet

## Private Networking

### Private Google Access

* This is a setting in the Subnet when you create it
* When enabled:
  * VMs without public IPs can access the public IPs of public Google Apps, APIs and services
  * This isn't the same as using Cloud NAT

**TO CHECK - How can private services access Google services/apis via non-public internet?**

**I.e. - what is the equivalent of Private Link?**

