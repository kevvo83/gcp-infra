# GCP Migration Strategies

## References:
https://cloud.google.com/architecture/migration-to-gcp-getting-started#lift_and_shift
https://cloud.google.com/architecture/migration-to-gcp-getting-started#improve_and_move

## Descriptions:
* Lift-and-shift - lowest complexity - no refactoring of the application
* Improve-and-move:
  * For eg:
    * Containerize the application
    * Then host on the best applicable GCP service:
      * Cloud Run, or
      * GKE
  * In general - optimize the workloads and then move to the right service on GCP
* Remove-and-replace:
  * Decommission an existing application
  * Rebuild it so that it's ready for the cloud
  * Host it on GCP

## Data Privacy policies

* EU: GDPR
* Singapore: PDPA
* US: CCPA (California Consumer Privacy Act)

## Hybrid (cloud / on-prem) architectures
1. Mirrored pattern
   * Replicating the design of 1 environment to another
     * Example - running dev on-prem and Prod in GCP
     * Intention of the 2 environments not communicating with each other
     * Could be a disaster recovery use-case as well
2. Meshed pattern
  * Intent to build a hybrid architecture of cloud and on-prem
  * Possible intentions are:
    * Tiered multi-cloud/on-prem where all Workloads can communicate with each other
    * Bursting support - i.e. scale onto cloud/on-prem when needed
3. Gated pattern
   * Gated egress
     * Workloads are exposed to cloud services behind a load balancer
     * Cloud workloads can't reach other on-premise workloads/systems apart from the load balancer
     * Gated ingress
       * Opposite of the Gated egress pattern
     * Gated egress and ingress
       * As the name suggests
4. Handover pattern
  * Facilitates Analytics
  * On-premise workloads upload data to cloud storage
  * Cloud workloads run analytics and other services that consume this data

## Cloud Foundation Toolkit

# TODO: Read up on Cloud Foundation toolkit