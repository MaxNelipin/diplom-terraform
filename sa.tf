resource "yandex_iam_service_account" "kube-admin" {
 name        = "kube-admin"
 description = "доуступ к клатеру куба и реджистри"
}

resource "yandex_resourcemanager_folder_iam_binding" "editor_netology-kube" {
 # Сервисному аккаунту назначается роль "editor".
 folder_id = local.folder_id
 role      = "editor"
 members   = [
   "serviceAccount:${yandex_iam_service_account.kube-admin.id}"
 ]
}

resource "yandex_resourcemanager_folder_iam_binding" "images-puller" {
 # Сервисному аккаунту назначается роль "container-registry.images.puller".
 folder_id = local.folder_id
 role      = "container-registry.images.puller"
 members   = [
   "serviceAccount:${yandex_iam_service_account.kube-admin.id}"
 ]
}