# vpcיצירת ה
resource "aws_vpc" "myvpc" {
  cidr_block = "101.121.0.0/16"
  tags = {
    Name = "vpc-terraform"
  }  
}

resource "aws_subnet" "subnets" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "101.121.${var.cider_subnets[count.index]}.0/24"
  availability_zone =  "${var.vpc_region}${var.order_alphabet[count.index]}"
  tags = {
    Name = "Public-${upper(var.order_alphabet[count.index])}"
    # מייצר את השם של הרשת לפי הרשימה עם אותיות גדולות
  }
  count = var.counter_resources
}

resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "IGW-Terraform"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }

  tags = {
    Name = "RT-Terraform"
  }
}

resource "aws_route_table_association" "rt-to-subnet" {
  subnet_id      = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.rt.id
  count = var.counter_resources
  # מקצה לכל רשת ניתוב החוצה לאינטרנט
}