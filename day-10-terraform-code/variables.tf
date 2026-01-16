variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}

variable "instance_type" {
  default = "t2.micro"
}
