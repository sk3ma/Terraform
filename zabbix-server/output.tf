/* Revealing IP address */
output "zabbix_server_public_ip" {
  value = aws_instance.zabbix_server.public_ip
}
