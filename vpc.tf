resource "aws_vpc" "vpn" {
  cidr_block = "10.0.0.0/16"

  tags {
    Name = "Vpn"
  }
}

resource "aws_route" "r" {
  route_table_id         = "${aws_vpc.vpn.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpn.id}"

  tags {
    Name = "Vpn"
  }
}
