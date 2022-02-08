resource "aws_instance" "web1" {
    ami                    = var.ami_id_demo
    instance_type          = "t2.nano"
    monitoring             = true
    vpc_security_group_ids = [aws_security_group.http.id]
    subnet_id              = aws_subnet.public_1a.id
}

resource "aws_instance" "web2" {
    ami                    = var.ami_id_demo
    instance_type          = "t2.nano"
    monitoring             = true
    vpc_security_group_ids = [aws_security_group.http.id]
    subnet_id              = aws_subnet.public_1c.id
}