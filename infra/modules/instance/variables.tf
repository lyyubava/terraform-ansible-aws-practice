variable "name" {
  type        = string
}

variable "volume_size" {
  type = number
  default = 64
}
variable "ec2_security_group" {
  type        = string
  description = "security group id for ec2 instance"
  default = ""
}

variable "create_ec2_security_group" {
  type = bool
  default = true
}

variable "ec2_subnet" {
  type        = string
  description = "subnet id for ec2 instance placement"
}

variable "ssh_keys" {
  type        = list(string)
  description = "list of ssh public keys"
}

variable "vpc_id" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "instance_type" {
  type = string
  default = "t3.micro"
}

variable "ami_id" {
  type = string
}

variable "stateful" {
  type = bool
  default = true
}

variable "attach_public_ip" {
  type = bool
  default = false
}

variable "mountpoint" {
  type = string
  default = ""
}

variable "tags" {
  type=map(string)
  default = {

  }
}
