

#!/bin/bash



# Define variables

NGINX_CONF_FILE=${PATH_TO_NGINX_CONFIGURATION_FILE}

CORS_ORIGIN=${DOMAIN_OR_IP_ADDRESS_TO_ALLOW_CORS_REQUESTS_FROM}



# Add CORS headers to Nginx configuration file

sed -i '/server {/a add_header Access-Control-Allow-Origin "$CORS_ORIGIN";' $NGINX_CONF_FILE



# Restart Nginx service

systemctl restart nginx