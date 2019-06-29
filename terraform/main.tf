variable "do_token" {}
variable "pub_key" {
  default = "/home/ozlevka/mydocs/do.pub"
}
variable "pvt_key" {
  default = "/home/ozlevka/mydocs/do"
}

variable "ssh_fingerprint" {
   default = "36:27:83:ef:65:45:28:5a:5d:bd:59:8a:ac:7d:f7:23"
}

provider "digitalocean" {
  token = "${var.do_token}"
}


resource "digitalocean_droplet" "server" {
  image = "rancheros"
  name = "syte-server-${count.index}"
  count = 3
  region = "fra1"
  size = "2gb"
  private_networking = true
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]
}

resource "null_resource" "configure-server" {
  count = 3
  connection {
      host = "${element(digitalocean_droplet.server.*.ipv4_address, count.index)}"
      user = "rancher"
      type = "ssh"
      private_key = "${file(var.pvt_key)}"
      timeout = "5m"
  }

    provisioner "remote-exec" {
      inline = [
        "docker run -d -p 8080:8080 --restart=unless-stopped ozlevka/syte-server:0.0.1"
      ]
  }

  depends_on = [
       "digitalocean_droplet.server",
  ]
}

resource "digitalocean_loadbalancer" "public" {
  name = "cyte-loadbalancer"
  region = "fra1"

  forwarding_rule {
    entry_port = 80
    entry_protocol = "http"

    target_port = 8080
    target_protocol = "http"
  }

  healthcheck {
    port = 22
    protocol = "tcp"
  }

  algorithm   = "round_robin"
  droplet_ids = digitalocean_droplet.server.*.id
  depends_on = [
    "null_resource.configure-server",
  ]
}
