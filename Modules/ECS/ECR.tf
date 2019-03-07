/*====
ECR repository to store our Docker images
======*/

resource "aws_ecr_repository" "Vane_ECR_2" {
  name = "vane-${var.ECR_repository}"
}

/*====
ECR policy- just me
======*/

resource "aws_ecr_repository_policy" "ecr_policy2" {
  repository = "${aws_ecr_repository.Vane_ECR_2.name}"

  policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "new policy",
      "Effect": "Allow",
      "Principal": {
       "AWS": "arn:aws:iam::329925270288:user/Vanessa.Celis"
     },
      "Action": [
        "ecr:BatchCheckLayerAvailability",
        "ecr:BatchDeleteImage",
        "ecr:BatchGetImage",
        "ecr:CompleteLayerUpload",
        "ecr:DeleteRepository",
        "ecr:DeleteRepositoryPolicy",
        "ecr:DescribeRepositories",
        "ecr:GetDownloadUrlForLayer",
        "ecr:GetRepositoryPolicy",
        "ecr:InitiateLayerUpload",
        "ecr:ListImages",
        "ecr:PutImage",
        "ecr:SetRepositoryPolicy",
        "ecr:UploadLayerPart"
      ]
    }
  ]
}
EOF
}
