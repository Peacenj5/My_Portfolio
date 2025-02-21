output "elb_dns" {
  value = aws_lb.web_elb.dns_name
}
