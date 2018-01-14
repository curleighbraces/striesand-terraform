resource "aws_route53_record" "vpn-ns" {
  zone_id = "${data.terraform_remote_state.aws-core.core_zone_id}"
  name = "${local.domain}"
  type = "A"
  ttl = "30"

  records = [
    "${aws_instance.vpn.public_ip}"
  ]
}
