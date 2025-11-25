locals {
  ami_id = data.aws_ami.aminame.id
  sg_id = data.aws_ssm_parameter.sg_id.value  
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  tg_port = "${var.component}" == "frontend" ? 80 : 8080
  health_check_path = "${var.component}" == "frontend" ? "/" : "/health"
  backend_alb_listener_arn = data.aws_ssm_parameter.backend_alb_listener_arn.value
  frontend_alb_listener_arn = data.aws_ssm_parameter.frontend_alb_listener_arn.value
  listener_arn = "${var.component}" == "frontend" ? local.frontend_alb_listener_arn : local.backend_alb_listener_arn
  host_context = "${var.component}" == "frontend" ? "${var.project_name}-${var.environment}.${var.domain}" : "${var.component}.backend-alb-${var.environment}.${var.domain}"
  
  private_subnet_id = split(",", data.aws_ssm_parameter.private_subnet_ids.value)[0]
  
  common_name_suffix = "${var.project_name}-${var.environment}"


  common_tags = {
    Project = var.project_name
    environment = var.environment
    Terraform = "true"
  }
}