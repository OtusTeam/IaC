locals {
  dbuser = tolist(yandex_mdb_mysql_cluster.wp_mysql.user.*.name)[0]
  dbpassword = tolist(yandex_mdb_mysql_cluster.wp_mysql.user.*.password)[0]
  dbhosts = yandex_mdb_mysql_cluster.wp_mysql.host.*.fqdn
  dbname = tolist(yandex_mdb_mysql_cluster.wp_mysql.database.*.name)[0]
}

resource "yandex_mdb_mysql_cluster" "wp_mysql" {
  name        = "wp-mysql"
  folder_id   = var.yc_folder
  environment = "PRODUCTION"
  network_id  = yandex_vpc_network.wp-network.id
  version     = "8.0"

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 16
  }

  database {
    name  = "db"
  }

  user {
    name     = "user"
    password = var.db_password
    authentication_plugin = "MYSQL_NATIVE_PASSWORD"
    permission {
      database_name = "db"
      roles         = ["ALL"]
    }
  }

  host {
    zone      = "ru-central1-b"
    subnet_id = yandex_vpc_subnet.wp-subnet-b.id
    assign_public_ip = true
  }
  host {
    zone      = "ru-central1-c"
    subnet_id = yandex_vpc_subnet.wp-subnet-c.id
    assign_public_ip = true
  }
}
