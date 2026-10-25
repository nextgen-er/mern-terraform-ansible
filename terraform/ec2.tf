resource "aws_key_pair" "deployer" {
  key_name   = "travelmemory-key"
  public_key = file(var.public_key_path)
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = aws_key_pair.deployer.key_name

  tags = { Name = "travelmemory-web" }
}

resource "aws_instance" "database" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  key_name               = aws_key_pair.deployer.key_name

  tags = { Name = "travelmemory-db" }
}
