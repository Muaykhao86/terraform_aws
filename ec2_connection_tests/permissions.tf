resource "aws_iam_role" "session_manager" {
  name               = "SessionManagerRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy" "AmazonSSMManagedInstanceCore" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

data "aws_iam_policy" "AmazonSSMPatchAssociation" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
}

resource "aws_iam_role_policy_attachment" "session_manager" {
  for_each = {
    AmazonSSMManagedInstanceCore = data.aws_iam_policy.AmazonSSMManagedInstanceCore.arn
    AmazonSSMPatchAssociation    = data.aws_iam_policy.AmazonSSMPatchAssociation.arn
  }

  role       = aws_iam_role.session_manager.name
  policy_arn = each.value
}

resource "aws_iam_instance_profile" "session_manager" {
  name = "SessionManagerInstanceProfile"
  role = aws_iam_role.session_manager.name
}

# IAM Group for SSM users
resource "aws_iam_group" "ssm_users_group" {
  name = "SSMUsers"
}

# IAM Policy for SSM session management
data "aws_iam_policy_document" "ssm_users_policy_document" {
  statement {
    actions = [
      "ssm:StartSession",
      "ssm:TerminateSession",
      "ssm:DescribeSessions",
      "ssm:DescribeInstanceInformation",
    ]
    resources = [
      "arn:aws:ec2:eu-west-2:827496304918:instance/*",
      "arn:aws:ssm:eu-west-2:827496304918:session/*",
      "arn:aws:ssm:eu-west-2:827496304918:document/*"
    ]
  }
}

resource "aws_iam_policy" "ssm_users_policy" {
  name        = "SSMUsersPolicy"
  description = "Allows SSM session management for SSMUsers group"
  policy      = data.aws_iam_policy_document.ssm_users_policy_document.json
}

# Attach policy to IAM group
resource "aws_iam_group_policy_attachment" "ssm_users_policy_attachment" {
  group      = aws_iam_group.ssm_users_group.name
  policy_arn = aws_iam_policy.ssm_users_policy.arn
}