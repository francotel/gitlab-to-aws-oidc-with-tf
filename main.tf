data "tls_certificate" "gitlab" {
  url = "${var.gitlab-url}/oauth/discovery/keys"
}

resource "aws_iam_openid_connect_provider" "gitlab" {
  thumbprint_list = [data.tls_certificate.gitlab.certificates.0.sha1_fingerprint]

  client_id_list = [var.gitlab-url]
  url            = var.gitlab-url
}

data "aws_iam_policy_document" "assume-role-policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.gitlab.arn]
    }
    condition {
      test     = "StringEquals"
      variable = "${aws_iam_openid_connect_provider.gitlab.url}:${var.match-field}"
      values   = var.match-value
    }
  }
}

resource "aws_iam_role" "gitlab-ci" {
  name               = "gitlab-role-cicd-${var.project}"
  assume_role_policy = data.aws_iam_policy_document.assume-role-policy.json
}

resource "aws_iam_role_policy_attachment" "gitlab-policy-attach" {
  role       = aws_iam_role.gitlab-ci.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
