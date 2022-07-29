terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.76.0"
    }
  }



  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "tfdiplom"
    region     = "ru-central1"
    key        = "v1/terraform.tfstate"
    profile    = "s3_yc"
    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1ghq301023687quik6d/etn40brqf9854br7ndea"
    dynamodb_table = "tfdiplom"
    skip_region_validation      = true
    skip_credentials_validation = true
  }

}