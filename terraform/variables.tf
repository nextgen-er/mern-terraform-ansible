variable "aws_region" {
  default = "ap-southeast-2"
}

variable "public_key_path" {
  default = "~/.ssh/travelmemory_key.pub"
}

variable "ami_id" {
  type        = string
  description = "Amazon Linux 2023 AMI ID"
  default     = "ami-07887b6789db08b82"
}
