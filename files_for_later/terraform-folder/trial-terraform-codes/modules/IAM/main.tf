resource "aws_iam_group" "devops_group" {
  name = var.group_name
  # Additional configurations for the group if needed
}




resource "aws_iam_user" "eks_user" {
  name = var.eks_user_name
  # Specify additional user configuration if needed
}



resource "aws_iam_group_membership" "example_membership" {
  name = aws_iam_user.eks_user.name
  users = [aws_iam_user.eks_user.name]
  group = aws_iam_group.devops_group.name
}


resource "aws_iam_role" "group_role" {
  name = var.group_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action    = "sts:AssumeRole"
      }
    ]
  })


  # Attach policies as needed for Group
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
  # Attach other policies if required
}

resource "aws_iam_role_policy_attachment" "eks_node_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_cluster_role.name
  # Attach other policies if required
}




