output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.collector.name
}

output "launch_template_id" {
  description = "ID of the launch template"
  value       = aws_launch_template.collector.id
}

output "iam_role_arn" {
  description = "ARN of the collector IAM role"
  value       = aws_iam_role.collector.arn
}

output "iam_instance_profile_arn" {
  description = "ARN of the collector instance profile"
  value       = aws_iam_instance_profile.collector.arn
}
