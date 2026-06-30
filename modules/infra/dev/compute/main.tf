# --- IAM Role for EC2 ---

resource "aws_iam_role" "collector" {
  name = "${var.common_project}-${var.common_environment}-collector"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })

  tags = {
    Name        = "${var.common_project}-${var.common_environment}-collector-role"
    Environment = var.common_environment
    Project     = var.common_project
  }
}

resource "aws_iam_instance_profile" "collector" {
  name = "${var.common_project}-${var.common_environment}-collector"
  role = aws_iam_role.collector.name
}

resource "aws_iam_role_policy" "s3_access" {
  name = "s3-access"
  role = aws_iam_role.collector.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "s3:PutObject",
        "s3:GetObject",
        "s3:ListBucket"
      ]
      Resource = [
        var.compute_s3_bucket_arn,
        "${var.compute_s3_bucket_arn}/*"
      ]
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.collector.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy" "cloudwatch_logs" {
  name = "cloudwatch-logs"
  role = aws_iam_role.collector.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Resource = "arn:aws:logs:${var.common_region}:*:log-group:/${var.common_project}/${var.common_environment}/*"
    }]
  })
}

# --- Launch Template ---

resource "aws_launch_template" "collector" {
  name_prefix   = "${var.common_project}-${var.common_environment}-collector-"
  image_id      = var.compute_ami_id
  instance_type = var.compute_instance_type

  iam_instance_profile {
    arn = aws_iam_instance_profile.collector.arn
  }

  network_interfaces {
    security_groups             = [var.compute_security_group_id]
    associate_public_ip_address = var.compute_assign_public_ip
  }

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size           = var.compute_ebs_volume_size
      volume_type           = var.compute_ebs_volume_type
      encrypted             = true
      delete_on_termination = true
    }
  }

  user_data = base64encode(templatefile("${path.module}/user_data.sh.tpl", {
    environment = var.common_environment
    project     = var.common_project
    region      = var.common_region
  }))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "${var.common_project}-${var.common_environment}-collector"
      Environment = var.common_environment
      Project     = var.common_project
    }
  }

  tag_specifications {
    resource_type = "volume"
    tags = {
      Name        = "${var.common_project}-${var.common_environment}-collector-vol"
      Environment = var.common_environment
      Project     = var.common_project
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

# --- Auto Scaling Group ---

resource "aws_autoscaling_group" "collector" {
  name_prefix         = "${var.common_project}-${var.common_environment}-collector-"
  desired_capacity    = var.compute_asg_desired
  min_size            = var.compute_asg_min
  max_size            = var.compute_asg_max
  vpc_zone_identifier = var.compute_subnet_ids

  launch_template {
    id      = aws_launch_template.collector.id
    version = "$Latest"
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 0
    }
  }

  tag {
    key                 = "Name"
    value               = "${var.common_project}-${var.common_environment}-collector"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.common_environment
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = var.common_project
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
