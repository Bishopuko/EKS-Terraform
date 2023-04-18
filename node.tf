resource "aws_eks_node_group" "private-nodes" {
  cluster_name    = aws_eks_cluster.mycluster.name
  node_group_name = "private-nodes"
  node_role_arn   = aws_iam_role.nodes.arn

  subnet_ids = flatten([aws_subnet.public.id, aws_subnet.private.id])

    capacity_type  = "ON_DEMAND"
    instance_types = ["t3.small"]

    scaling_config {
        desired_size = 1
        max_size     = 2
        min_size     = 1
    }




}