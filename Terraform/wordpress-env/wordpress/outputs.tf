# インスタンスにアクセスするためのURLを出力
output "instance_url" {
  value = "http://${aws_instance.wordpress_instance.public_ip}"
}
