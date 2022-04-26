---
title: "Module: Well-known URI Server"
tags: [ "module" ]
draft: false
---
<!--
SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
SPDX-License-Identifier: CC-BY-SA-4.0
-->

The Well-known URI Server module is a re-usable module for other rollyourown projects. The module provides a webserver to host [well-known locations](https://www.rfc-editor.org/rfc/rfc8615) for returning site-wide metadata for services.

<!--more-->

This documentation is intended for developers of rollyourown projects.

## Introduction

This module deploys and configures an [nginx](https://nginx.org/) webserver to respond to [well-known Uniform Resource Identifiers](https://en.wikipedia.org/wiki/Well-known_URI). This provides a central module for hosting well-known URIs for any rollyourown project.

[Consul-Template](https://github.com/hashicorp/consul-template/) is used to dynamically load well-known configuration from kev-values in the [Consul Key-Value Store](https://www.consul.io/docs/dynamic-app-config/kv) running on the [host server](/rollyourown/projects/host_server/).

## Repository links

The [Codeberg](https://codeberg.org/) mirror repository for this module is here: [https://codeberg.org/rollyourown-xyz/ryo-wellknown](https://codeberg.org/rollyourown-xyz/ryo-wellknown)

The [Github](https://github.com/) mirror repository for this module is here: [https://github.com/rollyourown-xyz/ryo-wellknown](https://github.com/rollyourown-xyz/ryo-wellknown)

The rollyourown repository for this project is here: [https://git.rollyourown.xyz/ryo-projects/ryo-wellknown](https://git.rollyourown.xyz/ryo-projects/ryo-wellknown) (not publicly accessible)

## Dependencies

This module has no dependencies.

## Module components

This project module deploys a container with multiple services as shown in the following diagram:

{{< image src="Module_Overview.svg" title="Module Overview">}}

The Well-known Server module contains three applications, together providing a well-known server to be used in other rollyourown projects.

### nginx

The [nginx](https://nginx.org/) webserver is deployed to return requests to well-known URIs.

### Consul

A Consul agent is deployed on the well-known server module and joins the Consul server on the host in client mode. The Consul agent registers the well-known server as a service in the Consul service registry, so that other containers can discover its internal network IP address.

### Consul-Template

On container start, the [Consul-Template](https://github.com/hashicorp/consul-template/) application obtains service configuration information from the [Consul key-value store](#key-value-store) and uses it to populate the nginx configuration file for the specified well-known URIs. In addition, Consul-Template listens for changes to the configuration key-values and updates configuration files on-the-fly, reloading nginx when configuration has changed.

After configuration has changed, consul-template triggers an update of HAProxy configuration parameters in the Consul key-value store, so that the Ingress Proxy can send traffic for the specified well-known URIs to the well-known service container.

## How to deploy this module in a project or module

The [repository for this module](https://github.com/rollyourown-xyz/ryo-wellknown) contains a number of resources for including the module in a rollyourown project. The steps for including the module are:

1. Add the Well-known Server module to the `get-modules.sh` script in the project:

    ```bash
    ## Wellknown Server module
    if [ -d "../ryo-wellknown" ]
    then
       echo "Module ryo-wellknown already cloned to this control node"
    else
       echo "Cloning ryo-wellknown repository. Executing 'git clone' for ryo-wellknown repository"
       git clone https://github.com/rollyourown-xyz/ryo-wellknown ../ryo-wellknown
    fi
    ```

2. Add the Well-known Server module to the project's `host-setup.sh` script:

    ```bash
    ## Module-specific host setup for ryo-wellknown
    if [ -f ""$SCRIPT_DIR"/../ryo-wellknown/configuration/"$hostname"_playbooks_executed" ]
    then
       echo "Host setup for ryo-wellknown module has already been done on "$hostname""
       echo ""
    else
       echo "Running module-specific host setup script for ryo-wellknown on "$hostname""
       echo ""
       "$SCRIPT_DIR"/../ryo-wellknown/host-setup.sh -n "$hostname"
    fi
    ```

3. Add the Well-known Server module to the project's `build-images.sh` script:

    ```bash
    # Build ryo-wellknown module images if -m flag is present
    if [ $build_modules == 'true' ]
    then
       echo "Running build-images script for ryo-wellknown module on "$hostname""
       echo ""
       "$SCRIPT_DIR"/../ryo-wellknown/build-images.sh -n "$hostname" -v "$version"
    else
       echo "Skipping image build for modules"
       echo ""
    fi
    ```

4. Add the Well-known Server module to the `deploy-project.sh` script in the project:

    ```bash
    # Deploy ryo-wellknown if -m flag is present
    if [ $deploy_modules == 'true' ]
    then
       echo "Deploying ryo-wellknown module on "$hostname" using images with version "$version""
       echo ""
       "$SCRIPT_DIR"/../ryo-wellknown/deploy-module.sh -n "$hostname" -v "$version"
       echo ""
    else
       echo "Skipping modules deployment"
       echo ""
    fi
    ```

## How to use this module in a project

The Well-known Server module can be used to serve Well-known URIs for a project.

### Image configuration

No specific image configuration is needed to utilise the well-known server module in a project.

### General deployment configuration

Configuration of well-known URIs to be served by the Well-known Server module is done during the project deployment step by provisioning Consul key-values.

#### Terraform configuration for provisioning Consul key-values

During a rollyourown project deployment, the official terraform [consul provider](https://registry.terraform.io/providers/hashicorp/consul/) is used to provision key-value configuration for HAProxy and Certbot to the Consul server running on the host.

To enable this, the consul server's IP address must be made available within the project's terraform code. This is done by adding a Terraform variable for the consul server's IP address on the host:

```tf
# Consul variables
locals {
  consul_ip_address  = join("", [ local.lxd_host_network_part, ".1" ])
}
```

Then the terraform consul provider is added to the project's terraform configuration:

```tf
terraform {
  required_version = ">= 0.14"
  required_providers {
    lxd = {
      source  = "terraform-lxd/lxd"
      version = "~> 1.5.0"
    }
    consul = {
      source = "hashicorp/consul"
      version = "~> 2.12.0"
    }
  }
}
```

Finally, the IP address variable is used to configure the provider:

```tf
provider "consul" {
  address    = join("", [ local.consul_ip_address, ":8500" ])
  scheme     = "http"
  datacenter = var.host_id
}
```

#### Terraform modules for provisioning Consul key-values

The Well-known server module repository includes a terraform module `deploy-wellknown-configuration` for provisioning the necessary configuration to the Consul key-value store in the correct key-value structure for use by the Well-known Server module.

{{< more "secondary">}}

The configuration for well-known URIs is provisioned the the key-value store in multiple folders, depending on the required response.

The domain or subdomain for which a well-known URI is required is provisioned to the `service/wellknown/domains` folder. Each key-value pair is of the form `<key,value>` where:

- The `key` is the domain or subdomain
- The `value` is empty

If a re-direct response is required for a domain `<domain>`, then a subfolder with two key-value pairs is provisioned in the `service/wellknown/redirects/` folder:

- The subfolder is `service/wellknown/redirects/<domain>`
- The key `service/wellknown/redirects/<domain>/location` is provisioned with the required well-known path as `value`
- The key `service/wellknown/redirects/<domain>/url` is provisioned with the URL to return as re-direct target as `value`

If the response for a well-known path should be a JSON payload, then a subfolder with two key-value pairs is provisioned in the `service/wellknown/json/` folder:

- The subfolder is `service/wellknown/redirects/<domain>`
- The key `service/wellknown/json/<domain>/location` is provisioned with the required well-known path as `value`
- The key `service/wellknown/json/<domain>/payload` is provisioned with the JSON payload to return as `value`

The Consul-Template application reads the key-values in the `service/wellknown/domains`, `service/wellknown/redirects/<domain>` and `service/wellknown/json/<domain>` folders and generates the nginx configuration for each well-known URI.

```conf
{{ range ls "service/wellknown/domains" }}{{ $domain := printf .Key }}server {
    listen [::]:80;
    listen 80;
    server_name {{ .Key }};
    
    root /var/www;
    index index.html;
    
    default_type application/json;

    # Redirects
    {{ range tree (print "service/wellknown/redirects/" $domain) | explode }}
    location {{ .location }} {
        return 301 {{ .url }};
    }
    {{ end }}

    # JSON payloads
    {{ range tree (print "service/wellknown/json/" $domain) | explode }}
    location {{ .location }} {
        return 200 {{ .payload }};
        add_header access-control-allow-origin *;
        add_header content-type application/json;
    }
    {{ end }}
}
{{ end }}
```

{{< /more >}}

As an example, redirect responses for the well-known paths `https://example.com/.well-known/carddav` and `https://example.com/.well-known/caldav` for a [Nextcloud server](/rollyourown/projects/single_server_projects/ryo-nextcloud/) are deployed with the following code:

```tf
module "deploy-nextcloud-wellknown-configuration" {
  source = "../../ryo-wellknown/module-deployment/modules/deploy-wellknown-configuration"
  
  wellknown_redirect_rules = {
  
    nextcloud-carddav = {
      wellknown_domain       = "example.com",
      wellknown_path         = "/.well-known/carddav",
      wellknown_redirect_url = "https://example.com/remote.php/dav"
    },
    
    nextcloud-caldav = {
      wellknown_domain       = "example.com",
      wellknown_path         = "/.well-known/caldav",
      wellknown_redirect_url = "https://example.com/remote.php/dav"
    }
  }
}
```

As a further example, JSON responses for the well-known URIs `https://example.com/.well-known/matrix/client` and `https://example.com/.well-known/matrix/server` for a [Matrix server](/rollyourown/projects/single_server_projects/ryo-matrix/) [discovery](https://github.com/matrix-org/synapse/blob/develop/docs/setup/installation.md#client-well-known-uri) and [delegation](https://github.com/matrix-org/synapse/blob/develop/docs/delegate.md) are deployed with the following code:

```tf
module "deploy-matrix-wellknown-configuration" {
  source = "../../ryo-wellknown/module-deployment/modules/deploy-wellknown-configuration"
  
  wellknown_json_rules = {
  
    matrix-client = {
      wellknown_domain       = "example.com",
      wellknown_path         = "/.well-known/matrix/client",
      wellknown_json_payload = "'{ "m.homeserver": { "base_url": "https://matrix.example.com" } }'"
    },

    matrix-server = {
      wellknown_domain       = "example.com",
      wellknown_path         = "/.well-known/matrix/server",
      wellknown_json_payload = '{ "m.server": "https://matrix.example.com:443" }'
    }
  }
}
```

## Software deployed

The open source components deployed by this module are:

{{< table tableclass="table table-bordered table-striped" theadclass="table-primary" >}}

| Project | What is it? | Homepage | License |
| :------ | :---------- | :------- | :------ |
| Consul | Service registry and key-value store | [https://www.consul.io/](https://www.consul.io/) | [MPL 2.0](https://github.com/hashicorp/consul/blob/master/LICENSE) |
| Consul-Template | Tool to create dynamic configuration files based on Consul Key-Value store or service registry queries | [https://github.com/hashicorp/consul-template/](https://github.com/hashicorp/consul-template/) | [MPL 2.0](https://github.com/hashicorp/consul-template/blob/master/LICENSE) |
| nginx | Web server | [https://nginx.org/](https://nginx.org/) | [2-clause BSD license](http://nginx.org/LICENSE) |

{{< /table >}}
