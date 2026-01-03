resource "aws_instance" "terraform" {
    #count = 4
    #count = length(var.instance_name)
    #for_each = var.instance_name
    #instance_type = each.value
    #instance_type = var.environment == "Dev" ? "t3.medium" : "t2.medium"
    ami = var.image
    for_each = toset(var.instance_name)
    instance_type = var.instance
    
    vpc_security_group_ids = [aws_security_group.allow-all.id]
    tags = local.common_tags
    # tags = {
    #   #Name = each.key
    #   Name = each.value
    #   Terraform = true
    # }
  # provisioner local-exec
  provisioner "local-exec" {
    command = "echo ${self.private_ip}"
    on_failure = continue
  }

  provisioner "local-exec" {
    command = "echo instance destroyed"
    when = destroy
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = self.public_ip
  }
  # provisioner remote-exec
  provisioner "remote-exec" {
    inline = [ 
      "sudo dnf install nginx -y",
      "sudo systemctl start nginx"
    ]
  }  
  provisioner "remote-exec" {
    inline = [ 
      "sudo systemctl stop nginx",
      "echo 'successfully stopped  nginx server'"
     ]
    when = destroy
  }
}

# creating security groups
resource "aws_security_group" "allow-all" {
    name = "${local.common_name}-allow-all"
    description = "creating sg for ec2"
    
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }
    #using dynamic loop
    dynamic "ingress" {
      for_each = toset(var.ingress_ports)
      content {
        from_port        = ingress.value
        to_port          = ingress.value
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
      }
      
    }
    tags = merge(
    var.ec2_tags,
    {
      Name ="${local.common_name}-allow-all"
    }
    )
}