resource "aws_iam_role" "ec2_role" {
  name = format("%s-ec2-role", var.project_name) 

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonElasticFileSystemClientFullAccess"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = format("%s-ec2-instance-profile", var.project_name) 
  role = aws_iam_role.ec2_role.name
}