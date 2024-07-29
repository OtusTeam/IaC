resource "yandex_iam_service_account" "cluster_sa" {
  name        = "cluster-sa"
  description = "Service account for Kubernetes cluster"
}

resource "yandex_resourcemanager_folder_iam_binding" "cluster_sa_binding" {
  folder_id = var.yc_folder
  role       = "editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.cluster_sa.id}",
  ]
}

resource "yandex_iam_service_account" "node_sa" {
  name        = "node-sa"
  description = "Service account for Kubernetes nodes"
}

resource "yandex_resourcemanager_folder_iam_binding" "node_sa_binding" {
  folder_id = var.yc_folder
  role       = "editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.node_sa.id}",
  ]
}

resource "yandex_kubernetes_cluster" "example" {
  name        = "example-cluster"
  network_id  = yandex_vpc_network.example.id
#  subnet_ids = [yandex_vpc_subnet.example.id]
  service_account_id = yandex_iam_service_account.cluster_sa
  node_service_account_id = yandex_iam_service_account.node_sa.id
  
  master {
    public_ip = true
    version   = "1.21.5"
#    service_account_id = yandex_iam_service_account.cluster_sa.id
  }
  node_pool {
    name               = "example-node-pool"
    instance_template {
      platform_id = "standard-v2"
      resources {
        cores  = 2
        memory = 4
      }
      boot_disk {
        size = 50
      }
    }
    scale_policy {
      fixed_scale {
        size = 1
      }
    }
    service_account_id = yandex_iam_service_account.node_sa.id
  }
}

resource "yandex_kubernetes_node_pool" "example" {
  cluster_id = yandex_kubernetes_cluster.example.id
  name               = "example-node-pool"
  instance_template {
    platform_id = "standard-v2"
    resources {
      cores  = 2
      memory = 4
    }
    boot_disk {
      size = 50
    }
  }
  scale_policy {
    fixed_scale {
      size = 1
    }
  }
  service_account_id = yandex_iam_service_account.node_sa.id
}


resource "yandex_vpc_network" "example" {
  name = "example-network"
}

resource "yandex_vpc_subnet" "example" {
  name           = "example-subnet"
  network_id     = yandex_vpc_network.example.id
  v4_cidr_blocks = ["10.1.0.0/24"]
  zone           = "ru-central1-a"
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "4.3.0"
  namespace  = "argocd"

  set {
    name  = "server.insecure"
    value = "true"
  }

  depends_on = [yandex_kubernetes_cluster.example]
}

output "argocd_server" {
  value = "https://${helm_release.argocd.name}-argocd-server.${yandex_kubernetes_cluster.example.id}.k8s.yandexcloud.net"
}
