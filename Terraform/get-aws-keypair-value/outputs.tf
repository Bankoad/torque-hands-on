output "ssm_parameter_value" {
  value = data.aws_ssm_parameter.example.value
}
