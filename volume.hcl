id        = "hostvol[%VOLID%]"
name      = "vol%VOLID%"
type      = "csi"
plugin_id = "hostpath-plugin0"

capacity_min = "1MB"
capacity_max = "1GB"

capability {
  access_mode     = "single-node-reader-only"
  attachment_mode = "file-system"
}

capability {
  access_mode     = "single-node-writer"
  attachment_mode = "file-system"
}

secrets {
  somesecret = "1312"
}

# mount_options {
#   mount_flags = ["ro"]
# }
