variable node_groups {
  description = "Name of the EKS node group"
  type        = map(object({
    instance_type = list(string)
    capacity_type = string
    scaling_config = object({
      desired_size = number
      max_size     = number
      min_size     = number
    })
  }))
    default     = {
        general= {
            instance_type = ["t3.medium"]
            capacity_type = "ON_DEMAND"
            scaling_config = {
                desired_size = 2
                max_size     = 4
                min_size     = 1
            }
        }
    }

}