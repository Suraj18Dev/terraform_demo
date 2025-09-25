




resource "aws-vpc" "vpc" {
   cidr_block  = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {

        name = "vpc-${var.cluster_name}-vpc"
        "kubernetes.io/cluster/${var.cluster_name}" = "shared"

    }
}


resource "aws_subnet" "public_subnet" {
    count = length(var.public_subnet_cidrs)
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidrs[count.index]
    availability_zone = element(var.availability_zones, count.index)
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.cluster_name}-public-subnet-${count.index + 1}"
        "kubernetes.io/role/elb" = 1
    }
}
resource "aws_subnet" "private_subnet" {
    count = length(var.private_subnet_cidrs)
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_cidrs[count.index]
    availability_zone = element(var.availability_zones, count.index)
    tags = {
        Name = "${var.cluster_name}-private-subnet-${count.index + 1}"
        "kubernetes.io/role/internal-elb" = 1
    }
}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "${var.cluster_name}-igw"}


    }




resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
    route {         
        cidr_block = "0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }
    tags = {
        Name = "${var.cluster_name}-public_subnet"
    }
resource "aws_route_table_association" "public" {
    count = length(var.public_subnet_cidrs)
    subnet_id = aws_subnet.public_subnet[count.index].id
    route_table_id = aws_route_table.public.id
}
 
resource "aws_route_table" "private" {
    count = length(var.private_subnet_cidrs)
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0/0"
        nat_gateway_id = aws_nat_gateway.main.id
    }
    tags = {
        Name = "${var.cluster_name}-private_subnet"
    }
}


resource "aws_route_table_association" "private" {
    count = length(var.private_subnet_cidrs)
    subnet_id = aws_subnet.private_subnet[count.index].id
    route_table_id = aws_route_table.private.id


}




}
    