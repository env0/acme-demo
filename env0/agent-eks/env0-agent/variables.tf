variable "region" {
  type    = string
  default = "us-east-1"
}

variable "cluster_name" {
  type = string
}

variable "localrun" {
  type = bool
  default = false
}

variable "dockerImage" {
  type    = string
  default = ""
}

variable "agentImagePullSecret" {
  type    = string
  default = ""
}

variable "infracostApiKeyEncoded" {
  type        = string
  sensitive   = true
  default     = ""
  description = "Base64 encoded Infracost API key (see infracost.io)"
}

variable "bitbucketServerCredentialsEncoded" {
  type      = string
  sensitive = true
  default   = ""
}

variable "gitlabEnterpriseCredentialsEncoded" {
  type      = string
  sensitive = true
  default   = ""
}

variable "githubEnterpriseAppId" {
  type        = string
  default     = ""
  description = "GitHub Enterprise App Id"
}

variable "githubEnterpriseAppClientId" {
  type        = string
  default     = ""
  description = "GitHub Enterprise Client Id"
}

variable "githubEnterpriseAppInstallationId" {
  type        = string
  default     = ""
  description = "GitHub Enterprise Installation Id (see URL of GitHub App)"
}

variable "githubEnterpriseAppClientSecretEncoded" {
  type        = string
  sensitive   = true
  default     = ""
  description = "Base64 Encoded App Client Secret (note: please remove newlines)"
}

variable "githubEnterpriseAppPrivateKeyEncoded" {
  type        = string
  sensitive   = true
  default     = ""
  description = "Base64 Encoded App Private Key (note: remove newlines)"
}

variable "storageClassName" {
  type        = string
  default     = ""
  description = "Custom storage class that is based on NFS/EFS"
}

variable "deploymentJobServiceAccountName" {
  type        = string
  default     = ""
  description = "Kubernetes Service Account used by the deployer"
}

variable "jobHistoryLimitFailure" {
  type        = string
  default     = 50
  description = "Number of jobs failures to keep in Kubernetes"
}

variable "jobHistoryLimitSuccess" {
  type        = string
  default     = 50
  description = "Number of jobs successes to keep in Kubernetes"
}