variable "version" {
  type = string
  default = "NOT_SET"
}

job "stateful-immediate" {
  datacenters = ["local"]

  # Immediate
  update {
    max_parallel = 3
  }

  group "container" {
    count = 3

    network {
      port "http" {}
    }

    volume "persistency" {
      type = "csi"
      source = "hostvol"
      attachment_mode = "file-system"
      access_mode = "single-node-writer"
      per_alloc = true
    }

    task "server" {
      driver = "docker"

      env {
        PORT = "${NOMAD_PORT_http}"
      }

      config {
        image = "torrefatto/ghfs"
        ports = ["http"]
        args = [
          "--global-header",
          "X-Nomad-Version:${var.version}",
        ]
      }

      volume_mount {
        volume = "persistency"
        destination = "/data"
      }
    }
  }
}
