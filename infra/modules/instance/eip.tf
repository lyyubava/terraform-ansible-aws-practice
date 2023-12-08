resource "aws_eip" "this" {
    count = var.attach_public_ip ? 1 : 0
    instance = aws_instance.this.id
}
