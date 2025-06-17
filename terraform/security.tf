resource "aws_security_group" "allow_all_security_group" {
  name        = "self_route_security_group"
  description = "Allows all inbound TCP traffic from any IPv4 address"

  vpc_id = aws_vpc.self_route_vpc.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All TCP ports open to the world"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "SelfRouteSecurityGroup"
  }
} 