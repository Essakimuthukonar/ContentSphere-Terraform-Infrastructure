resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  vpc_security_group_ids = [
    var.security_group_id
  ]

  key_name = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl enable httpd
              systemctl start httpd

              cat > /var/www/html/index.html <<HTML
              <!DOCTYPE html>
              <html>
              <head>
                <title>ContentSphere</title>
              </head>
              <body>
                <h1>ContentSphere</h1>
                <h2>Infrastructure Provisioned using Terraform</h2>
                <p>Student: Essakimuthu Shanmugam Konar</p>
                <p>Batch: IT Vedant</p>
                <p>Region: ap-south-1</p>
                <p>Environment: dev</p>
              </body>
              </html>
              HTML
              EOF

  tags = {
    Name        = "${var.project_name}-ec2"
    Project     = var.project_name
    Environment = var.environment
  }
}
resource "aws_eip" "this" {
  domain = "vpc"

  tags = {
    Name        = "${var.project_name}-eip"
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_eip_association" "this" {
  instance_id   = aws_instance.this.id
  allocation_id = aws_eip.this.id
}