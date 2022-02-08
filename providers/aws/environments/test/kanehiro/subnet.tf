# Subnet
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
resource "aws_subnet" "public_1a" {
  # 先程作成したVPCを参照し、そのVPC内にSubnetを立てる
  vpc_id = aws_vpc.main.id # 🐱 先ほど作ったVPCのIDを動的に指定しています

  # Subnetを作成するAZ
  availability_zone = "ap-northeast-1a"

  cidr_block        = "10.0.1.0/24"

  tags = {
    Name = "handson-public-1a"
  }
  depends_on = [aws_vpc.main] # 🐱 依存関係を指定しています。vpcがある前提であることを明示しています。同時にリソースを作る際に重要
}

resource "aws_subnet" "public_1c" {
  vpc_id = aws_vpc.main.id

  availability_zone = "ap-northeast-1c"

  cidr_block        = "10.0.2.0/24"

  tags = {
    Name = "handson-public-1c"
  }
}