provider "yandex" {
  service_account_key_file = file("~/.yckey/sadiplom-key.json")
  cloud_id = "b1g0tj31dcl7m7mdnbkf"
  folder_id = "b1gcetfa5k75tcn9b9lr"
  zone = "ru-central1-a"
}

locals {
  folder_id = "b1gcetfa5k75tcn9b9lr"
}



