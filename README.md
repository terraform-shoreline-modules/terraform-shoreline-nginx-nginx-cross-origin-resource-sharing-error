
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Nginx Cross Origin Resource Sharing Error
---

This incident type refers to errors that occur when attempting to make cross-origin resource sharing (CORS) requests to an Nginx web server. CORS is a security feature implemented by web browsers to prevent unauthorized access to resources on a different domain. When Nginx is misconfigured or not configured to allow CORS requests, web browsers will block the requests, resulting in errors. This can cause issues for web applications that rely on making requests to different domains for data or resources.

### Parameters
```shell
export ORIGIN_DOMAIN="PLACEHOLDER"

export NGINX_SERVER_DOMAIN="PLACEHOLDER"

export PATH_TO_NGINX_CONFIGURATION_FILE="PLACEHOLDER"

export DOMAIN_OR_IP_ADDRESS_TO_ALLOW_CORS_REQUESTS_FROM="PLACEHOLDER"
```

## Debug

### Verify the Nginx server is running
```shell
systemctl status nginx
```

### Check the Nginx configuration files
```shell
nginx -t
```

### Check the Nginx access logs for CORS errors
```shell
grep "cross-origin" /var/log/nginx/access.log
```

### Check the Nginx error logs for CORS errors
```shell
grep "cross-origin" /var/log/nginx/error.log
```

### Verify if the correct CORS headers are present in the response
```shell
curl -I -X GET -H "Origin: ${ORIGIN_DOMAIN}" ${NGINX_SERVER_DOMAIN}
```

### Check the Nginx configuration files for CORS settings
```shell
grep -r "add_header" /etc/nginx/
```

## Repair

### Configure Nginx to allow CORS requests by adding the appropriate headers to HTTP responses. This can be done using the "add_header" directive in Nginx configuration files.
```shell


#!/bin/bash



# Define variables

NGINX_CONF_FILE=${PATH_TO_NGINX_CONFIGURATION_FILE}

CORS_ORIGIN=${DOMAIN_OR_IP_ADDRESS_TO_ALLOW_CORS_REQUESTS_FROM}



# Add CORS headers to Nginx configuration file

sed -i '/server {/a add_header Access-Control-Allow-Origin "$CORS_ORIGIN";' $NGINX_CONF_FILE



# Restart Nginx service

systemctl restart nginx


```