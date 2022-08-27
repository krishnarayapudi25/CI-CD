data "civo_size" "xsmall" {
    filter {
        key = "name"
        values = ["g4s.kube.xsmall"]
        match_by = "re"
    }
}

resource "civo_kubernetes_cluster" "react-application" {
    name = "react-application"
    applications = ""
    pools {
        
        size = element(data.civo_size.xsmall.sizes, 0).name
        node_count = 3
    }
    
    firewall_id = civo_firewall.fw_demo_1.id
  
}

resource "civo_firewall" "fw_demo_1" {
    name = "fw_demo_1"
    
    
  
}

resource "civo_firewall_rule" "k8s_http" {
    firewall_id = civo_firewall.fw_demo_1.id
    protocol = "tcp"
    start_port = "80"
    end_port = "80"
    cidr = ["0.0.0.0/0"]
    direction = "ingress"
    action = "allow"
    label = "k8s_http"
  
}

resource "civo_firewall_rule" "k8s_https" {
    firewall_id = civo_firewall.fw_demo_1.id
    protocol = "tcp"
    start_port = "443"
    end_port = "443"
    cidr = ["0.0.0.0/0"]
    direction = "ingress"
    action = "allow"
    label = "k8s_https"
  
}

resource "civo_firewall_rule" "k8s_api" {
    firewall_id = civo_firewall.fw_demo_1.id
    protocol = "tcp"
    start_port = "6443"
    end_port = "6443"
    cidr = ["0.0.0.0/0"]
    direction = "ingress"
    action = "allow"
    label = "k8s_api"
  
}