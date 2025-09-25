variable "vpc_cidr" {
  type        = string
  description = "cidr block for the VPC"
}

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}   
variable "private_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDRs for private subnets"
}
variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDRs for public subnets"
}                           
variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones for the VPC"
}