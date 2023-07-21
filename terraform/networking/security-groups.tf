resource "aws_security_group" "allow_cluster_access" {
  name        = "allowClusterAccess"
  description = "Allow access to the kubernetes cluster from the internet"

  ingress {
    description = "Allow traffic from Guilherme home ip"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["200.34.227.118/32"]
  }
}

output "allow_cluster_access_id" {
  value       = aws_security_group.allow_cluster_access.id
  description = "Id of the eksctl cluster security group"
}
