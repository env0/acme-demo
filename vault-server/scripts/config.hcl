ui = true
disable_mlock = true

storage "raft" {
  path    = "/home/ubuntu/vault/data"
  node_id = "node1"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = "true"
}

api_addr = "XXX_IP:8200"
cluster_addr = "XXX_IP:8201"