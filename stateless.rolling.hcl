variable "version" {
  type = string
  default = "NOT_SET"
}

job "stateless-rolling" {
  datacenters = ["local"]

  # Rolling
  update {
    max_parallel = 1
  }

  group "container" {
    count = 3

    network {
      port "http" {}
    }

    task "server" {
      driver = "docker"

      config {
        image = "hashicorp/http-echo"
        ports = ["http"]
        args = [
          "-listen",
          ":${NOMAD_PORT_http}",
          "-text",
          "version: ${var.version}",
        ]
      }
    }
  }
}
