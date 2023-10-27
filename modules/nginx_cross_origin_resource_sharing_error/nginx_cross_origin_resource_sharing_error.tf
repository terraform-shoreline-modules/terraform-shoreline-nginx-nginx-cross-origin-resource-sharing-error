resource "shoreline_notebook" "nginx_cross_origin_resource_sharing_error" {
  name       = "nginx_cross_origin_resource_sharing_error"
  data       = file("${path.module}/data/nginx_cross_origin_resource_sharing_error.json")
  depends_on = [shoreline_action.invoke_cors_nginx_restart]
}

resource "shoreline_file" "cors_nginx_restart" {
  name             = "cors_nginx_restart"
  input_file       = "${path.module}/data/cors_nginx_restart.sh"
  md5              = filemd5("${path.module}/data/cors_nginx_restart.sh")
  description      = "Configure Nginx to allow CORS requests by adding the appropriate headers to HTTP responses. This can be done using the "add_header" directive in Nginx configuration files."
  destination_path = "/tmp/cors_nginx_restart.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_cors_nginx_restart" {
  name        = "invoke_cors_nginx_restart"
  description = "Configure Nginx to allow CORS requests by adding the appropriate headers to HTTP responses. This can be done using the "add_header" directive in Nginx configuration files."
  command     = "`chmod +x /tmp/cors_nginx_restart.sh && /tmp/cors_nginx_restart.sh`"
  params      = ["DOMAIN_OR_IP_ADDRESS_TO_ALLOW_CORS_REQUESTS_FROM","PATH_TO_NGINX_CONFIGURATION_FILE"]
  file_deps   = ["cors_nginx_restart"]
  enabled     = true
  depends_on  = [shoreline_file.cors_nginx_restart]
}

