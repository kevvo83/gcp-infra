# Encryption on GCP

## Cloud KMS

* Cloud KMS = Cloud Key Management System
* KMS is a fully managed service that allows you to encrypt data at rest with your own encryption keys
* By using Cloud KMS you can
  * Encrypt sensitive data stored in GCP
  * Manage your own encryption keys
    * Without the operational overhead of managing your own key management system
* Google Default Encryption - a note on:
  * Default encryption is a feature on GCP
  * Used to encrypt data in case no other option is specified
    * Protects against data loss
  * However, if you want to manage your keys - you can't do that using Default Encryption