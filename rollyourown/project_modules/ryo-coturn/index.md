---
title: "Module: STUN/TURN Server"
tags: [ "module" ]
draft: false
---
<!--
SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
SPDX-License-Identifier: CC-BY-SA-4.0
-->

The STUN/TURN Server module is a re-usable module for other rollyourown projects and is used to provide [STUN](https://en.wikipedia.org/wiki/STUN), [TURN](https://en.wikipedia.org/wiki/Traversal_Using_Relays_around_NAT) and [ICE](https://en.wikipedia.org/wiki/Interactive_Connectivity_Establishment) services to enable peer-to-peer commmunications (such as [WebRTC](https://webrtc.org/) services or internet voice and video calls) for devices behind a [NAT](https://en.wikipedia.org/wiki/Network_address_translation).

<!--more-->

This documentation is intended for developers of rollyourown projects.

## Introduction

This module deploys a [coturn](https://github.com/coturn/coturn) server.

Coturn is an open source [STUN](https://en.wikipedia.org/wiki/STUN) and [TURN](https://en.wikipedia.org/wiki/Traversal_Using_Relays_around_NAT) server that is used by other services, including those deployed by other rollyourown projects, to enable [NAT traversal](https://en.wikipedia.org/wiki/NAT_traversal) for peer-to-peer communications.

## Repository links

The [Codeberg](https://codeberg.org/) mirror repository for this module is here: [https://codeberg.org/rollyourown-xyz/ryo-coturn](https://codeberg.org/rollyourown-xyz/ryo-coturn)

The [Github](https://github.com/) mirror repository for this module is here: [https://github.com/rollyourown-xyz/ryo-coturn](https://github.com/rollyourown-xyz/ryo-coturn)

The rollyourown repository for this project is here: [https://git.rollyourown.xyz/ryo-projects/ryo-coturn](https://git.rollyourown.xyz/ryo-projects/ryo-coturn) (not publicly accessible)

## Dependencies

This module depends on the rollyourown [Ingress Proxy](/rollyourown/project_modules/ryo-ingress-proxy/) module to provide certificate management by [Certbot](https://certbot.eff.org/).

## Module components

This project module deploys a container with multiple services as shown in the following diagram:

{{< image src="Module_Overview.svg" title="Module Overview">}}

The STUN/TURN Server module contains three applications, together providing a dynamically-configurable [STUN](https://en.wikipedia.org/wiki/STUN) and [TURN](https://en.wikipedia.org/wiki/Traversal_Using_Relays_around_NAT) server to be used in other rollyourown projects.

### Coturn

Coturn is and open source [STUN](https://en.wikipedia.org/wiki/STUN) and [TURN](https://en.wikipedia.org/wiki/Traversal_Using_Relays_around_NAT) server enabling [NAT traversal](https://en.wikipedia.org/wiki/NAT_traversal) for peer-to-peer communications.

Coturn's configuration is dynamically configured based on Key-Values retrieved from the [Consul server deployed on the host](/rollyourown/how_to_use/host_server/#host-server-components). For TLS-encrypted connections, Coturn uses certificates obtained by the [Certbot application deployed by the Ingress Proxy module](/rollyourown/project_modules/ryo-ingress-proxy/#haproxy-and-certbot).

### Consul

A [Consul](https://www.consul.io/) agent is deployed on the Coturn module and joins the Consul cluster in client mode. The Consul agent provides [configuration discovery and update](https://learn.hashicorp.com/tutorials/consul/consul-template) for [Consul-Template](#consul-template) via [key-value lookup](https://www.consul.io/docs/dynamic-app-config/kv), so that [Consul-Template](#consul-template) can create and update the coturn configuration.

### Consul-Template

On container start, the [Consul-Template](https://github.com/hashicorp/consul-template/) application obtains service configuration information from the [consul key-value store](/rollyourown/how_to_use/host_server/#host-server-components) and uses it to populate configuration files for Coturn. In addition, Consul-Template listens for changes to the configuration key-values and updates configuration files on-the-fly, reloading [coturn](#coturn) when configuration has changed.

## How to deploy this module in a project

The [repository for this module](https://github.com/rollyourown-xyz/ryo-coturn) contains a number of resources for including the module in a rollyourown project. The steps for including the module are:

1. Add the STUN/TURN Server module as well as the [Ingress Proxy module](/rollyourown/project_modules/ryo-ingress-proxy/) dependency to the `get-modules.sh` script in the project:

    ```bash
    ## Ingress proxy module
    if [ -d "../ryo-ingress-proxy" ]
    then
       echo "Module ryo-ingress-proxy already cloned to this control node"
    else
       echo "Cloning ryo-ingress-proxy repository. Executing 'git clone' for ryo-ingress-proxy repository"
       git clone https://github.com/rollyourown-xyz/ryo-ingress-proxy ../ryo-ingress-proxy
    fi
    ## STUN/TURN Server module
    if [ -d "../ryo-coturn" ]
    then
       echo "Module ryo-coturn already cloned to this control node"
    else
       echo "Cloning ryo-coturn repository. Executing 'git clone' for ryo-coturn repository"
       git clone https://github.com/rollyourown-xyz/ryo-coturn ../ryo-coturn
    fi
    ```

2. Add the STUN/TURN Server module as well as the [Ingress Proxy module](/rollyourown/project_modules/ryo-ingress-proxy/) dependency to the project's `host-setup.sh` script:

    ```bash
    ## Module-specific host setup for ryo-ingress-proxy
    if [ -f ""$SCRIPT_DIR"/../ryo-ingress-proxy/configuration/"$hostname"_playbooks_executed" ]
    then
       echo "Host setup for ryo-ingress-proxy module has already been done on "$hostname""
       echo ""
    else
       echo "Running module-specific host setup script for ryo-ingress-proxy on "$hostname""
       echo ""
       "$SCRIPT_DIR"/../ryo-ingress-proxy/host-setup.sh -n "$hostname"
    fi
    ## Module-specific host setup for ryo-coturn
    if [ -f ""$SCRIPT_DIR"/../ryo-coturn/configuration/"$hostname"_playbooks_executed" ]
    then
       echo "Host setup for ryo-coturn module has already been done on "$hostname""
       echo ""
    else
       echo "Running module-specific host setup script for ryo-coturn on "$hostname""
       echo ""
       "$SCRIPT_DIR"/../ryo-coturn/host-setup.sh -n "$hostname"
    fi
    ```

3. Add the STUN/TURN Server module as well as the [Ingress Proxy module](/rollyourown/project_modules/ryo-ingress-proxy/) dependency to the project's `build-images.sh` script:

    ```bash
    # Build Ingress Proxy module images if -m flag is present
    if [ $build_modules == 'true' ]
    then
       echo "Running build-images script for ryo-ingress-proxy module on "$hostname""
       echo ""
       "$SCRIPT_DIR"/../ryo-ingress-proxy/build-images.sh -n "$hostname" -v "$version"
    else
       echo "Skipping image build for the Ingress Proxy module"
       echo ""
    fi
    # Build STUN/TURN Server module images if -m flag is present
    if [ $build_modules == 'true' ]
    then
       echo "Running build-images script for ryo-coturn module on "$hostname""
       echo ""
       "$SCRIPT_DIR"/../ryo-coturn/build-images.sh -n "$hostname" -v "$version"
    else
       echo "Skipping image build for the Coturn module"
       echo ""
    fi
    ```

4. Add the STUN/TURN Server module as well as the [Ingress Proxy module](/rollyourown/project_modules/ryo-ingress-proxy/) dependency to the `deploy-project.sh` script in the project (with the Ingress Proxy module **before** the STUN/TURN Server module):

    ```bash
    # Deploy Ingress Proxy module if -m flag is present
    if [ $deploy_modules == 'true' ]
    then
       echo "Deploying ryo-ingress-proxy module on "$hostname" using images with version "$version""
       echo ""
       "$SCRIPT_DIR"/../ryo-ingress-proxy/deploy-module.sh -n "$hostname" -v "$version"
       echo ""
    else
       echo "Skipping Ingress Proxy module deployment"
       echo ""
    fi
    # Deploy STUN/TURN Server module if -m flag is present
    if [ $deploy_modules == 'true' ]
    then
       echo "Deploying ryo-coturn module on "$hostname" using images with version "$version""
       echo ""
       "$SCRIPT_DIR"/../ryo-coturn/deploy-module.sh -n "$hostname" -v "$version"
       echo ""
    else
       echo "Skipping TURN Server module deployment"
       echo ""
    fi
    ```

## How to use this module in a project

A (sub)domain for the coturn server should be configured with the DNS A record for the (sub)domain pointing to the host server. [Coturn](https://github.com/coturn/coturn) configuration is done by provisioning Consul key-values during project deployment. The STUN/TURN Server module repository includes terraform modules `deploy-coturn-domain-configuration` and `deploy-coturn-ports-configuration` for provisioning configuration to the Consul key-value store in the correct key-value structure.

{{< more "secondary">}}

The module uses the official terraform [consul provider](https://registry.terraform.io/providers/hashicorp/consul/) to provision key-values to the Consul container.

Coturn configuration is provisioned to key-value store in the `/service/coturn/` folder.

{{< /more >}}

### Image configuration

The STUN/TURN Server module uses a shared static authentication secret to prevent unauthorized use of the STUN/TURN server. This static authentication secret also needs to be provisioned to a project component that uses the STUN/TURN server.

The coturn static authentication secret is generated when building the coturn container image and is stored in the file `/ryo-projects/ryo-coturn/configuration/coturn_static_auth_secret_<HOST_ID>.yml` on the control node.

To use this secret in a project container image, the configuration file needs to be added to `vars_files` in the container's Ansible playbook, by adding the following line:

```yml
vars_files:
  # Project configuration
  - "{{ playbook_dir }}/../../configuration/configuration_{{ host_id }}.yml"
  # Host configuration
  - "{{ playbook_dir }}/../../../ryo-host/configuration/configuration_{{ host_id }}.yml"
  # Coturn configuration
  - "{{ playbook_dir }}/../../../ryo-coturn/configuration/coturn_static_auth_secret_{{ host_id }}.yml"
```

Then the variable `coturn_static_auth_secret` is availabe in Ansible roles for the project component image.

### General deployment configuration

To configure the STUN/TURN Server module, configuration parameters for the Coturn configuration file need to be provisioned to the Consul key-value store on component deployment.

To make the consul server's IP address available within the project's terraform code, add a Terraform variable for the consul server's IP address:

```tf
# Consul variables
locals {
  consul_ip_address  = join("", [ local.lxd_host_network_part, ".1" ])
}
```

The terraform consul provider is added to the project's terraform configuration:

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

...

provider "consul" {
  address    = join("", [ local.consul_ip_address, ":8500" ])
  scheme     = "http"
  datacenter = var.host_id
}
```

### Coturn-related configuration

Coturn configuration is provisioned to key-value store in the `/service/coturn/` folder.

{{< more "secondary">}}
Each key-value pair is of the form `<key,value>` where:

- The `key` is the name of the parameter in `turnserver.conf` to configure
- The `value` is the value to be provisioned for the key in `turnserver.conf`

Key-values provisioned in this way are:

- /service/coturn/coturn-domain
- /service/coturn/ip-addr-host-part
- /service/coturn/listening-port
- /service/coturn/tls-listening-port
- /service/coturn/min-port
- /service/coturn/max-port

The Consul-Template application reads the key-values in the `/service/coturn/` folder and generates coturn configuration for each configuration parameter in `turnserver.conf`, for example, the `turnserver.conf` parameter `realm` is provisioned by:

```bash
{{ if keyExists "service/coturn/coturn-domain" }}
realm={{ key "service/coturn/coturn-domain" }}
{{ end }}
```

or the `turnserver.conf` parameters `min-port` and `max-port` are provisioned by:

```bash
{{ if keyExists "service/coturn/min-port" }}
min-port={{ key "service/coturn/min-port" }}
{{ else }}
min-port=50000
{{ end }}
{{ if keyExists "service/coturn/max-port" }}
max-port={{ key "service/coturn/max-port" }}
{{ else }}
max-port=50000
{{ end }}
```

After (re-)configuring `turnserver.conf`, Consul-Template calls the script `restart-coturn.sh` to restart coturn and apply the configuration.
{{< /more >}}

Coturn configuration can be deployed to the consul key-value store using the ryo-coturn terraform `deploy-coturn-domain-configuration` and `deploy-coturn-ports-configuration` modules, for example:

```tf
module "deploy-<PROJECT_ID>-coturn-domain-configuration" {
  source = "../../ryo-coturn/module-deployment/modules/deploy-coturn-domain-configuration"

  coturn_domain             = <(Sub-)domain on which the STUN/TURN server shall be reachable>
  coturn_domain_admin_email = <Administrative email address for request of letsencrypt certificates for the (sub-)domain>
}
```

or

```tf
module "deploy-<PROJECT_ID>-coturn-ports-configuration" {
  source = "../../ryo-coturn/module-deployment/modules/deploy-coturn-ports-configuration"

  coturn_ip_addr_host_part  = <Host part of the IP address of the coturn container>
  coturn_listening_port     = <TURN listener port for UDP and TCP>
  coturn_tls_listening_port = <TURN listener port for TLS and DTLS>
  coturn_min_port           = <Lower bound of the coturn TURN server UDP relay endpoints>
  coturn_max_port           = <Upper bound of the coturn TURN server UDP relay endpoints>
}
```

Note that default values for coturn port configuration are deployed when the Coturn module is deployed, so that the terraform `deploy-coturn-ports-configuration` module only needs to be used in a project if the default values need to be overridden.

## Software deployed

The open source components deployed by this module are:

{{< table tableclass="table table-bordered table-striped" theadclass="table-primary" >}}

| Project | What is it? | Homepage | License |
| :------ | :---------- | :------- | :------ |
| Consul | Service registry and key-value store | [https://www.consul.io/](https://www.consul.io/) | [MPL 2.0](https://github.com/hashicorp/consul/blob/master/LICENSE) |
| Consul-Template | Tool to create dynamic configuration files based on Consul Key-Value store or service registry queries | [https://github.com/hashicorp/consul-template/](https://github.com/hashicorp/consul-template/) | [MPL 2.0](https://github.com/hashicorp/consul-template/blob/master/LICENSE) |
| Coturn  | [STUN](https://en.wikipedia.org/wiki/STUN) and [TURN](https://en.wikipedia.org/wiki/Traversal_Using_Relays_around_NAT) server | [https://github.com/coturn/coturn](https://github.com/coturn/coturn) | [https://github.com/coturn/coturn/blob/master/LICENSE](https://github.com/coturn/coturn/blob/master/LICENSE) |

{{< /table >}}
