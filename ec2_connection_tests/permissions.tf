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