variable "AWS_ACCESS_KEY_ID" {
  type = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  type = string
}

variable "AWS_SESSION_TOKEN" {
  type    = string
  default = null
}

variable "AWS_REGION" {
  type = string
}

variable "cluster_name" {
  type        = string
  description = "(Required) Name of the EKS Cluster. Must be between 1-100 characters in length. Must begin with an alphanumeric character, and must only contain alphanumeric characters, dashes and underscores (^[0-9A-Za-z][A-Za-z0-9\\-_]+$)."
}

variable "node_group_name" {
  type        = string
  description = "(Optional) Name of the EKS Node Group. If omitted, Terraform will assign a random, unique name. Conflicts with node_group_name_prefix. The node group name can't be longer than 63 characters. It must start with a letter or digit, but can also include hyphens and underscores for the remaining characters."
}

variable "node_role_arn" {
  type        = string
  description = "(Required) Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Node Group."
}

variable "scaling_config" {
  type = object({
    desired_size = number
    max_size     = number
    min_size     = number
  })

  default = {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  description = "(Required) Configuration block with scaling settings."
}

variable "subnet_ids" {
  type        = list(string)
  description = "(Required) Identifiers of EC2 Subnets to associate with the EKS Node Group. These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME (where CLUSTER_NAME is replaced with the name of the EKS Cluster)."
}

variable "update_config" {
  type = object({
    max_unavailable_percentage = optional(number)
    max_unavailable            = optional(number)
  })
}

variable "cluster_version" {
  type        = string
  description = "(Optional) Kubernetes version. Defaults to EKS Cluster Kubernetes version. Terraform will only perform drift detection if a configuration value is provided."
  default     = null
}

variable "ami_type" {
  type        = string
  description = "(Optional) Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Valid values are: AL2_x86_64 | AL2_x86_64_GPU | AL2_ARM_64 | CUSTOM | BOTTLEROCKET_ARM_64 | BOTTLEROCKET_x86_64 | BOTTLEROCKET_ARM_64_NVIDIA | BOTTLEROCKET_x86_64_NVIDIA | WINDOWS_CORE_2019_x86_64 | WINDOWS_FULL_2019_x86_64 | WINDOWS_CORE_2022_x86_64 | WINDOWS_FULL_2022_x86_64 | AL2023_x86_64_STANDARD | AL2023_ARM_64_STANDARD"
  default     = "AL2023_x86_64_STANDARD"
}

variable "capacity_type" {
  type        = string
  description = "(Optional) Type of capacity associated with the EKS Node Group. Valid values: ON_DEMAND, SPOT."
  default     = "ON_DEMAND"
}

variable "disk_size" {
  type        = number
  description = "(Optional) Disk size in GiB for worker nodes. Defaults to 20."
  default     = 20
}

variable "instance_types" {
  type        = list(string)
  description = "(Required) Set of instance types associated with the EKS Node Group. Defaults to [\"t3.medium\"]."
  default     = ["t3.medium"]
}
