variable "instace_type" {
    description = "The type of instance to start"
    type        = string
    default     = "t3.micro"
}

variable "aws_region" {
    description = "The AWs region to deploy the ec2 instance"
    type = string
    default = "us-east-2"
}

variable "ami_id" {
    description = "The AMI ID to use for the instance"
    type        = string
    default     = "ami-051de6a4e7ae45f77"
}

variable "server_count" {
    description = "The number of instances to create"
    type        = number
    default     = 1
}