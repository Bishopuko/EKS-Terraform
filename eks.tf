resource "aws_eks_cluster" "mycluster" {
  name = "${var.name}-cluster"
  role_arn = aws_iam_role.cluster.arn
    vpc_config {
    subnet_ids              = flatten([aws_subnet.public.id, aws_subnet.private.id])
    #endpoint_private_access = true
    #endpoint_public_access  = true
    #public_access_cidrs     = ["0.0.0.0/0"]
  }

  depends_on =  [aws_iam_role_policy_attachment.eksClusterPolicy]
}
