terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "wordpress" {
  name         = "wordpress:latest"
  keep_locally = false
}

resource "docker_container" "wordpress" {
  image = docker_image.wordpress.latest
  name  = "wordpress"
  ports {
    internal = 80
    external = 8081
  }
  env = [
    "WORDPRESS_DB_HOST=mysql:3306",
    "WORDPRESS_DB_USER=wordpress",
    "WORDPRESS_DB_PASSWORD=wordpress",
    "WORDPRESS_DB_NAME=wordpress",
    "WORDPRESS_DEBUG=0"
  ]
  networks_advanced {
    name = "wordpress"
  }
}
resource "docker_image" "mysql" {
  name         = "mysql:5.7"
  keep_locally = false
}
resource "docker_container" "mysql" {
  image = docker_image.mysql.latest
  name  = "mysql" 
  env  = [
        "MYSQL_ROOT_PASSWORD=somewordpress",
        "MYSQL_DATABASE=wordpress",
        "MYSQL_USER=wordpress",
        "MYSQL_PASSWORD=wordpress"
    ]
  networks_advanced {
    name = "wordpress"
  }
}
resource "docker_network" "wordpress_network" {
  name = "wordpress"
}
