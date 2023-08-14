resource "aws_route53_record" "mongodb-r53" {
  zone_id = data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONEID
  name    = "mongodb-${var.ENV}.${data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONENAME}"
  type    = "CNAME"
  ttl     = 10
  records = [aws_docdb_cluster.docdb.endpoint]
}