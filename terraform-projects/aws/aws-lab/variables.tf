variable "region_name" {
  type    = string
  default = "ap-southeast-2"
}
variable "az" {
  type    = list(string)
  default = ["ap-southeast-2a", "ap-southeast-2b"]
}

variable "instance_names" {
  default = "devops"
}


