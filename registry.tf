resource "yandex_container_registry" "registry-diplom" {
  name      = "registry-diplom"
  folder_id = local.folder_id
}
