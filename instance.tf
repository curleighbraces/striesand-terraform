provider "aws" {
  region = "eu-west-1"
}


data "template_file" "local-site" {
  template = "${file("templates/local-site.yml")}"

  vars {
    domain = "${local.domain}"
  }
}

data "template_file" "striesand-bootstrap" {
  template = "${file("templates/striesand-bootstrap.sh")}"

  vars {
    local_site = "${data.template_file.local-site.rendered}"
  }
}

resource "aws_instance" "vpn" {
  ami = "ami-4d46d534"
  instance_type = "t2.micro"
  key_name = "curleigh-braces"

  subnet_id = "${aws_subnet.public.id}"

  user_data = "${data.template_file.striesand-bootstrap.rendered}"

  tags {
    Name = "Vpn"
  }
}
