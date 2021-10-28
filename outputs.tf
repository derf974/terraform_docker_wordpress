output "mysql_container_ip" {
  description = "IP of mysql container"
  value       = docker_container.mysql.ip_address
}

output "wordpress_container_ip" {
  description = "IP of wordpress container"
  value       = docker_container.wordpress.ip_address
}
