resource "yandex_kubernetes_cluster" "cluster-kube" {
  name        = "cluster-kube"
  description = "Кластер для диплома"

  network_id = yandex_vpc_network.network-diplom.id

  cluster_ipv4_range = "10.10.0.0/16"
  service_ipv4_range = "10.20.0.0/16"

  master {
    regional {
      region = "ru-central1"

      location {
        zone      = yandex_vpc_subnet.subnet-public-a.zone
        subnet_id = yandex_vpc_subnet.subnet-public-a.id
      }

      location {
        zone      = yandex_vpc_subnet.subnet-public-b.zone
        subnet_id = yandex_vpc_subnet.subnet-public-b.id
      }

      location {
        zone      = yandex_vpc_subnet.subnet-public-c.zone
        subnet_id = yandex_vpc_subnet.subnet-public-c.id
      }
    }

    version   = "1.20"
    public_ip = true


    maintenance_policy {
      auto_upgrade = true

      maintenance_window {
        day        = "monday"
        start_time = "15:00"
        duration   = "3h"
      }

      maintenance_window {
        day        = "friday"
        start_time = "10:00"
        duration   = "4h30m"
      }
    }
  }

  #kms_provider {
   # key_id = yandex_kms_symmetric_key.kms-bucket.id
  #}

  service_account_id      = yandex_iam_service_account.kube-admin.id
  node_service_account_id = yandex_iam_service_account.kube-admin.id

  release_channel = "STABLE"

  network_policy_provider = "CALICO"

  depends_on              = [
    yandex_resourcemanager_folder_iam_binding.editor_netology-kube,
    yandex_resourcemanager_folder_iam_binding.images-puller,
    yandex_resourcemanager_folder_iam_binding.load-balancer-admin,
    yandex_iam_service_account.kube-admin
  ]

}

resource "yandex_kubernetes_node_group" "node-diplom-a" {
  cluster_id = yandex_kubernetes_cluster.cluster-kube.id
  name       = "node-diplom-a"

  version = "1.20"


  instance_template {
    platform_id = "standard-v1"

    network_interface {
      nat        = true
      subnet_ids = [
        "${yandex_vpc_subnet.subnet-public-a.id}"
      ]
    }

    metadata = { ssh-keys = "maxn:${file(var.ssh-keys)}" }

    resources {
      memory = 4
      cores  = 2
      core_fraction = 20
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    scheduling_policy {
      preemptible = false
    }

    container_runtime {
      type = "docker"
    }
  }

  scale_policy {
    auto_scale {
      initial = 1
      max     = 2
      min     = 1
    }
  }

  allocation_policy {
    location {
      zone      = "ru-central1-a"
      #subnet_id = yandex_vpc_subnet.subnet-public.id
    }

  }

  maintenance_policy {
    auto_upgrade = false
    auto_repair  = true

    maintenance_window {
      day        = "monday"
      start_time = "15:00"
      duration   = "3h"
    }

    maintenance_window {
      day        = "friday"
      start_time = "10:00"
      duration   = "4h30m"
    }
  }
}

resource "yandex_kubernetes_node_group" "node-diplom-b" {
  cluster_id = yandex_kubernetes_cluster.cluster-kube.id
  name       = "node-diplom-b"

  version = "1.20"


  instance_template {
    platform_id = "standard-v1"

    network_interface {
      nat        = true
      subnet_ids = [
        "${yandex_vpc_subnet.subnet-public-b.id}"
      ]
    }

    metadata = { ssh-keys = "maxn:${file(var.ssh-keys)}" }

    resources {
      memory = 2
      cores  = 2
      core_fraction = 20
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    scheduling_policy {
      preemptible = false
    }

    container_runtime {
      type = "docker"
    }
  }

  scale_policy {
    auto_scale {
      initial = 1
      max     = 2
      min     = 1
    }
  }

  allocation_policy {
    location {
      zone      = "ru-central1-b"
      #subnet_id = yandex_vpc_subnet.subnet-public.id
    }

  }

  maintenance_policy {
    auto_upgrade = false
    auto_repair  = true

    maintenance_window {
      day        = "monday"
      start_time = "15:00"
      duration   = "3h"
    }

    maintenance_window {
      day        = "friday"
      start_time = "10:00"
      duration   = "4h30m"
    }
  }
}


resource "yandex_kubernetes_node_group" "node-diplom-c" {
  cluster_id = yandex_kubernetes_cluster.cluster-kube.id
  name       = "node-diplom-c"

  version = "1.20"


  instance_template {
    platform_id = "standard-v1"

    network_interface {
      nat        = true
      subnet_ids = [
        "${yandex_vpc_subnet.subnet-public-c.id}"
      ]
    }

    metadata = { ssh-keys = "maxn:${file(var.ssh-keys)}" }

    resources {
      memory = 2
      cores  = 2
      core_fraction = 20
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    scheduling_policy {
      preemptible = false
    }

    container_runtime {
      type = "docker"
    }
  }

  scale_policy {
    auto_scale {
      initial = 1
      max     = 2
      min     = 1
    }
  }

  allocation_policy {
    location {
      zone      = "ru-central1-c"
      #subnet_id = yandex_vpc_subnet.subnet-public.id
    }

  }

  maintenance_policy {
    auto_upgrade = false
    auto_repair  = true

    maintenance_window {
      day        = "monday"
      start_time = "15:00"
      duration   = "3h"
    }

    maintenance_window {
      day        = "friday"
      start_time = "10:00"
      duration   = "4h30m"
    }
  }
}