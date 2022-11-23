module "nginx_bucket" {
  source      = "../../modules/bucket"
  bucket_name = var.bucket_name
}