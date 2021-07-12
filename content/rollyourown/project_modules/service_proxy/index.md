---
title: "Module: Service Proxy"
tags: [ ]
draft: true
---

The Service Proxy module is a re-usable module for other [rollyourown.xyz](https://rollyourown.xyz) projects which is used to terminate HTTPS and TCP connections, route traffic to the project's containers and also provides a service registry and key-value store for project configuration.

<!--more-->

## Introduction

This module deploys a [Consul](https://www.consul.io/) [service registry](https://www.consul.io/docs/discovery/services) and [key-value store](https://www.consul.io/docs/dynamic-app-config/kv) along with an [HAProxy](https://www.haproxy.org/) loadbalancer / TLS proxy together with [Certbot](https://certbot.eff.org/) for certificate management.

Consul-Template is used to dynamically load HAProxy and Certbot configuration from kev-values in the [Consul](https://www.consul.io/) Key-Value Store and the [Consul](https://www.consul.io/) serivce provides DNS-based routing information for HAProxy's backends.

The Key-Value store and service registry can also be used by other [rollyourown.xyz](https://rollyourown.xyz) projects and project modules to provide key-value based configuration and service discovery.

## Repository links

The [github](https://github.com/) mirror repository for this module is here: [https://github.com/rollyourown-xyz/ryo-service-proxy](https://github.com/rollyourown-xyz/ryo-service-proxy)

The [rollyourown.xyz](https://rollyourown.xyz/) repository for this project is here: [https://git.rollyourown.xyz/ryo-projects/ryo-service-proxy](https://git.rollyourown.xyz/ryo-projects/ryo-service-proxy)

## Dependencies

This module has no dependencies to other [rollyourown.xyz](https://rollyourown.xyz) modules.

## Module components

This project module deploys a container with multiple services as shown in the following diagram:

![Module Overview](Module_Overview.svg)

### Consul

[Consul](https://www.consul.io/) is a [distributed service registry and key-value store](https://www.consul.io/docs/architecture). A Consul agent is deployed on other containers and joins the Consul cluster in client mode. This enables, on the one hand, services on the container to be registered in the service registry and, on the other hand, for the service registry and KV-store to be queried.

The Consul agent provides [service discovery](https://www.consul.io/docs/discovery/dns) for [HAProxy](#haproxy-and-certbot) via DNS and [configuration discovery and update](https://learn.hashicorp.com/tutorials/consul/consul-template) for [Consul-Template](#consul-template) via [key-value lookup](https://www.consul.io/docs/dynamic-app-config/kv).

#### Service registry

The Consul service registry provides a register of available and running services. As a new backend service container is deployed, a consul agent running in client mode on the container registers the presence of the service provided with the Consul service registry along with the container's IP address and the port on which the service is available. Other components can then discover the service (usually via DNS), without having to be configured in advance with the hostname, IP address or port of the service.

This feature is used, for example, by [HAProxy](#haproxy-and-certbot) to distribute traffic to the correct backend server and enables this module to be a generic module that can be used in any project.

#### Key-value store

The key-value store provides a store of configuration data for services that can be provisioned at deploy-time. If a container is dynamically configured, a consul-template agent running on the container retrieves key-values and generates the container service's configuration file(s). This can be done at boot or at a later stage, as the consul-template agent monitors for changes in the specified branches of the key-value tree.

This feature is used, for example, by [Certbot](#haproxy-and-certbot) to dynamically load configuration for the certificates needed for a project and by [HAProxy](#haproxy-and-certbot) to load ACLs and backend configuration for a project's backend servers. A consul-template agent running on the loadbalancer / TLS proxy modifies the Haproxy and Cerbot configuration as project-specific services are added during project deployment.

### HAProxy and Certbot

The [HAProxy](https://www.haproxy.org/) load-balancer / TLS proxy listens on defined ports, terminates incoming connections and distributes this traffic to specified backends, based on rules specified in [Access Control Lists (ACLs)](https://www.haproxy.com/blog/introduction-to-haproxy-acls/). Depending on the project, backends can be scaled across multiple instances.

In addition, HAProxy terminates TLS / SSL connections (typically, HTTPS), using certificates obtained by [Certbot](https://certbot.eff.org/), so that certificates can be provisioned in a single element and do not need to be distributed across backend applications.

The [Certbot](https://certbot.eff.org/) application uses the [ACME protocol](https://tools.ietf.org/html/rfc8555) to request and renew [Let's Encrypt](https://letsencrypt.org/) certificates for the project domain(s). Certificates are stored in persistent storage mounted to the container and are available for HAProxy to terminate HTTPS requests for the project. In addition, other containers requiring certificates (for example, if running non-HTTP services) can also access the certificates via mounted storage.

For [Let's Encrypt](https://letsencrypt.org/) domain validation via the [Let's Encrypt HTTP-01 challenge](https://letsencrypt.org/docs/challenge-types/#http-01-challenge), traffic to the ACME client `.well-known/acme-challenge` link is routed by HAProxy to Certbot. Any other traffic to the project domain(s) is routed to backends or rejected, as defined in the HAProxy ACLs.

HAProxy ACLs and backend rules are dynamically configured based on Key-Values retrieved from the [Consul container](#consul). The domains for which Certbot aquires and manages certificates are also retrieved from the [Consul container](#consul). This allows the Service Proxy to be deployed as a generic module, with the project-specific configuration provisioned to the Consul KV-store during project deployment.

#### Consul-Template

On container start, the [Consul-Template](https://github.com/hashicorp/consul-template/) application obtains service configuration information from the [Consul key-value store](#key-value-store) and uses it to populate configuration files for HAProxy and Certbot. In addition, Consul-Template listens for changes to the configuration key-values and updates configuration files on-the-fly, reloading HAProxy and/or Certbot when configuration has changed.

#### Webhook

The [Webhook](https://github.com/adnanh/webhook) application creates an HTTP endpoint on the container and exposes a web service for triggering HAProxy reloads from external containers.

## How to deploy this module in a project

The [repository for this module](https://github.com/rollyourown-xyz/ryo-service-proxy) contains a number of resources for including the module in a [rollyourown.xyz](https://rollyourown.xyz) project. The steps for including the module are:

1. Add the Service Proxy module to the `get-modules.sh` script in the project:

    ```bash
    ## Service proxy module
    if [ -d "../ryo-service-proxy" ]
    then
       echo "Module ryo-service-proxy already cloned to this control node"
    else
       echo "Cloning ryo-service-proxy repository. Executing 'git clone' for ryo-service-proxy repository"
       git clone https://github.com/rollyourown-xyz/ryo-service-proxy ../ryo-service-proxy
    fi
    ```

2. Add the Service Proxy module to the project's `host-setup.sh` script:

    ```bash
    ## Module-specific host setup for ryo-service-proxy
    if [ -f ""$SCRIPT_DIR"/../ryo-service-proxy/configuration/"$hostname"_playbooks_executed" ]
    then
       echo "Host setup for ryo-service-proxy module has already been done on "$hostname""
       echo ""
    else
       echo "Running module-specific host setup script for ryo-service-proxy on "$hostname""
       echo ""
       "$SCRIPT_DIR"/../ryo-service-proxy/host-setup.sh -n "$hostname"
    fi
    ```

3. Add the Service Proxy module to the project's `build-images.sh` script:

    ```bash
    # Build module images if -m flag is present
    if [ $build_modules == 'true' ]
    then
       echo "Running build-images script for ryo-service-proxy module on "$hostname""
       echo ""
       "$SCRIPT_DIR"/../ryo-service-proxy/build-images.sh -n "$hostname" -v "$version"
    else
       echo "Skipping image build for modules"
       echo ""
    fi
    ```

4. Add the Service Proxy module to the `deploy-project.sh` script in the project:

    ```bash
    # Deploy modules if -m flag is present
    if [ $deploy_modules == 'true' ]
    then
       echo "Deploying ryo-service-proxy module on "$hostname" using images with version "$version""
       echo ""
       "$SCRIPT_DIR"/../ryo-service-proxy/deploy-module.sh -n "$hostname" -v "$version"
       echo ""
    else
       echo "Skipping modules deployment"
       echo ""
    fi
    ```

## How to use this module in a project

Examples for using the Service Proxy module in a project are provided in the [rollyourown.xyz](https://rollyourown.xyz) [project template repository](https://github.com/rollyourown-xyz/ryo-project-template). Configuration of [HAProxy](https://www.haproxy.org/) and Certbot is done by provisioning Consul key-values during project deployment. The Service Proxy module repository includes terraform modules for provisioning configuration to the Consul key-value store in the correct key-value structure.

{{< more "secondary">}}

The modules use the official terraform [consul provider](https://registry.terraform.io/providers/hashicorp/consul/) to provision key-values to the Consul container.

Certbot configuration is provisioned to key-value store in the `/service/certbot/` folder.

HAProxy configuration is provisioned to the key-value store in multiple folders:

- HAProxy backend services are provisioned to the key-value folder `service/haproxy/backends/ssl/` if the backend service is listening on an HTTPS port
- HAProxy backend services are provisioned to the key-value folder `service/haproxy/backends/no-ssl/` if the backend service is listening on a plain HTTP port
- HAProxy TCP Listeners are provisioned to the key-value folder `service/haproxy/tcp-listeners/`
- HAProxy ACLs are provisioned to the key-value folder `service/haproxy/acl/<ACL name>/`
- HAProxy HTTP deny rules are provisioned to the key-value folder `service/haproxy/deny/`
- HAProxy use-backend rules are provisioned to the key-value folder `service/haproxy/use-backend/`

{{< /more >}}

### Image configuration

Ansible roles for installing and setting up a consul agent to register project components with the Consul service registry is provided in the `image-build/playbooks/roles/install-consul` and `image-build/playbooks/roles/set-up-consul` directories. These do not need to be modified.

In the `image-build/playbooks/roles/set-up-TEMPLATE` directory, the file `templates/TEMPLATE-service.hcl.j2` provides an example of a component-specific consul service configuration to register the specific component with the service registry:

```hcl
## Modify for this component's purpose

service {
  name = "{{ host_id }}-{{ project_id }}-TEMPLATE"
  tags = [ "TEMPLATE" ]
  port = SERVICE_PORT
}
```

The service given is then used for providing HAProxy configuration via the consul key-value store.

### General deployment configuration

To configure the Service Proxy module's HAProxy loadbalancer to direct traffic to a project-specific component, configuration parameters for the HAProxy configuration file need to be provisioned to the Consul key-value store on component deployment.

To make the consul container's IP address available within the project's terraform code, add a `terraform_remote_state` data source for the module to the project's Terraform variables and a local variable for the consul container's IP address:

```tf
# Variables from ryo-service-proxy module remote state
data "terraform_remote_state" "ryo-service-proxy" {
  backend = "local"
  config = {
    path = join("", ["${abspath(path.root)}/../../ryo-service-proxy/module-deployment/terraform.tfstate.d/", var.host_id, "/terraform.tfstate"])
  }
}

locals {
  consul_ip_address  = data.terraform_remote_state.ryo-service-proxy.outputs.consul_ip_address
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

### Certbot-related configuration

Certbot configuration is provisioned to key-value store in the `/service/certbot/` folder.

{{< more "secondary">}}
Each key-value pair is of the form `<key,value>` where:

- The `key` is the domain or subdomain for which a Let's Encrypt certificate is required
- The `value` is an administrator email address for requesting the certificate from the Let's Encrypt certificate authority

The Consul-Template application reads the key-values in the `/service/certbot/` folder and generates certbot configuration for each required certificate, along with a deploy script to copy generated certificates into mounted storage for use by other containers:

```bash
certbot certonly -n --standalone --agree-tos --preferred-challenges http --http-01-port 8080 --deploy-hook /usr/local/bin/cert-deploy.sh -m {{.Value}} -d {{.Key}}
```

where `cert-deploy.sh` is:

```bash
cat /etc/letsencrypt/live/{{.Key}}/fullchain.pem /etc/letsencrypt/live/{{.Key}}/privkey.pem > /etc/haproxy/ssl/{{.Key}}.pem
cp /etc/letsencrypt/live/{{.Key}}/cert.pem /var/certs/{{.Key}}.cert.pem
chmod 644 /var/certs/{{.Key}}.cert.pem
cp /etc/letsencrypt/live/{{.Key}}/privkey.pem /var/certs/{{.Key}}.key.pem
chmod 644 /var/certs/{{.Key}}.key.pem
```

{{< /more >}}

{{< highlight "warning">}}
Every domain and sub-domain for which a certificate is required for the project - for example, `example.com`, `www.example.com` and `auth.example.com` should be added **individually** to the configuration.
{{< /highlight >}}

Certbot configuration can be deployed to the consul key-value store using the ryo-service-proxy terraform `deploy-cert-domains` module, for example:

```tf
module "deploy-<PROJECT_ID>-cert-domains" {
  source = "../../ryo-service-proxy/module-deployment/modules/deploy-cert-domains"

  certificate_domains = {
    domain_1 = {domain = local.project_domain_name, admin_email = local.project_admin_email},
    domain_2 = {domain = join("", [ "www.", local.project_domain_name]), admin_email = local.project_admin_email}
  }
}
```

### HAProxy-related configuration

HAproxy configuration is provisioned to key-value store in various folders.

#### Backend services

Using the `deploy-haproxy-backend-services` terraform module, the key-values for HAProxy backend service configuration can be deployed to the Consul key-value store.

{{< more "secondary">}}

Configuration for HAProxy backend services are provisioned to the key-value folder `service/haproxy/backends/ssl/` if the backend service is listening on an HTTPS port and to the key-value folder `service/haproxy/backends/no-ssl/` if the backend service is listening on a plain HTTP port. In both cases, each key-value pair is of the form `<key,value>` where:

- The `key` is the backend service name
- The `value` is empty.

The Consul-Template application reads the key-values in the `service/haproxy/backends/ssl/` folder and generates a backed definition in the HAProxy configuration file for each backend service found:

```bash
backend {{.Key}}
   redirect scheme https code 301 if !{ ssl_fc }
   http-request set-header X-SSL %[ssl_fc]
   balance roundrobin
   server-template {{.Key}} 1 _{{.Key}}._tcp.service.consul resolvers consul resolve-prefer ipv4 init-addr none ssl verify none check
```

For each key-value in the `service/haproxy/backends/no-ssl/` folder, a backend definition is generated as follows:

```bash
backend {{.Key}}
   redirect scheme https code 301 if !{ ssl_fc }
   http-request set-header X-SSL %[ssl_fc]
   balance roundrobin
   server-template {{.Key}} 1 _{{.Key}}._tcp.service.consul resolvers consul resolve-prefer ipv4 init-addr none check
```

{{< /more >}}

HAProxy backend service configuration can be deployed to the consul key-value store using the ryo-service-proxy terraform `deploy-haproxy-backend-services` and `deploy-haproxy-configuration` modules, for example:

For example, a backend service can be deployed with the following code:

```tf
module "deploy-<PROJECT_ID>-haproxy-backend-service" {
  source = "../../ryo-service-proxy/module-deployment/modules/deploy-haproxy-backend-services"

  non_ssl_backend_services = [ join("-", [ var.host_id, local.project_id, "<SERVICE_NAME>" ]) ]
}
```

#### HAProxy TCP listeners

The `deploy-haproxy-configuration` terraform module can be used to deploy key-values to Consul for configuring TCP listeners.

{{< more "secondary">}}

Configuration for HAProxy TCP listeners is provisioned to the key-value folder `service/haproxy/tcp-listeners/`. Each entry is a key-value pair of the form `<key,value>` where:

- the `key` is the TCP port to listen on
- the `value` is the name of the backend service to use.

For each TCP port found in the `service/haproxy/tcp-listeners/` folder in the KV store, the Consul-Template application generates a TCP listener entry in the HAProxy configuration file.

```bash
listen tcp_{{.Key}}
   bind :::{{.Key}} v4v6
   mode tcp
   option tcplog
   option tcpka
   option clitcpka
   option srvtcpka
   timeout connect 5s
   timeout client  60s
   timeout server  60s
   balance leastconn
   server-template {{.Value}} 1 _{{.Value}}._tcp.service.consul resolvers consul resolve-prefer ipv4 init-addr none check
```

{{< /more >}}

For example, TCP listeners can be deployed with the following code:

```tf
module "deploy-<PROJECT_ID>-haproxy-tcp-listener-configuration" {
  source = "./modules/deploy-haproxy-configuration"

  depends_on = [ module.deploy-<PROJECT_ID>-haproxy-backend-service ]

  haproxy_tcp_listeners = {
    22   = {backend_service = join("-", [ local.project_id, "<COMPONENT_NAME>" ])},
    3022 = {backend_service = join("-", [ local.project_id, "<COMPONENT_NAME>" ])}
  }
}
```

#### HAProxy ACLs

The `deploy-haproxy-configuration` terraform module can be used to deploy key-values to Consul for configuring HAProxy ACLs.

{{< more "secondary">}}

Configuration for HAProxy ACLs are provisioned to the key-value folder `service/haproxy/acl/<ACL name>/`. One or two keys are provisioned to each folder:

- If the ACL only includes a host match, then only one key-value pair of the form `<host,value>` is provisioned, where `value` is the host to match
- If the ACL includes both a host an path, then two key-value pairs are provisioned:
  - a key-value pair of the form `<host,value>`, where `value` is the host to match
  - a key-value pair of the form `<path,value>`, where `value` is the path to match

The ACL key-value configuration is then used to generate [HAProxy HTTP deny](#haproxy-http-deny-rules) and [use-backed](#haproxy-use-backed-rules) rules.

{{< /more >}}

{{< highlight "warning">}}
For using the Service Proxy module, all ACLs should include a host match. Path-only ACLs are not supported. If a path is to be used to match traffic for multiple hosts, then each host/path pair should be configured as a single ACL.
{{< /highlight >}}

For example, ACLs can be deployed with the following code:

```tf
module "deploy-<PROJECT_ID>-haproxy-acl-configuration" {
  source = "../../ryo-service-proxy/module-deployment/modules/deploy-haproxy-configuration"

  haproxy_host_only_acls = {
    domain     = {host = local.project_domain_name},
    domain-www = {host = join("", [ "www.", local.project_domain_name])}
  }

  haproxy_host_path_acls = {
    domain-admin = {host = local.project_domain_name, path = "/admin"},
  }
```

#### HAProxy HTTP deny rules

The `deploy-haproxy-configuration` terraform module can be used to deploy key-values to Consul for configuring HTTP deny rules.

{{< more "secondary">}}

Configuration for HAProxy HTTP deny rules is provisioned to the key-value folder `service/haproxy/deny/`. Each entry is a key-value pair of the form `<key,value>` where:

- the `key` is an [ACL name](#haproxy-acls)
- the `value` is empty.

For each `<ACL NAME>` found in the `service/haproxy/deny/` folder in the KV store, the Consul-Template application generates an HTTP deny rule in the HTTPS frontend section of the HAProxy configuration file by looking up the configuration in the `service/haproxy/acl/<ACL NAME>/` folder.

For a host-only ACL:

```bash
http-request deny deny_status 403 if { hdr(host) -i <HOST KEY> }
```

For a host-path ACL:

```bash
http-request deny deny_status 403 if { hdr(host) -i <HOST KEY> } { path_beg -i <PATH KEY>} 
```

{{< /more >}}

For example, HTTP deny rules can be deployed with the following code:

```tf
module "deploy-<PROJECT_ID>-haproxy-http-deny-configuration" {
  source = "../../ryo-service-proxy/module-deployment/modules/deploy-haproxy-configuration"

  depends_on = [ module.deploy-<PROJECT_ID>-haproxy-acl-configuration ]

  haproxy_acl_denys = [ "domain-admin" ]
}
```

#### HAProxy `use-backed` rules

The `deploy-haproxy-configuration` terraform module can be used to deploy key-values to Consul for configuring HAProxy `use-backend` rules.

{{< more "secondary">}}

The configuration for HAProxy use-backend rules is provisioned to the key-value folder `service/haproxy/use-backend/`. Each entry is a key-value pair of the form `<key,value>` where:

- the `key` is an [ACL name](#haproxy-acls)
- the `value` is the name of the backend service to use.

For each `<ACL NAME>` found in the `service/haproxy/use-backend/` folder in the KV store, the Consul-Template application generates a `use-backed` rule in the HTTPS frontend section of the HAProxy configuration file by looking up the configuration in the `service/haproxy/acl/<ACL NAME>/` folder.

For a host-only ACL:

```bash
use_backend <BACKEND SERVICE NAME> if { hdr(host) -i <HOST KEY> }
```

For a host-path ACL:

```bash
use_backend <BACKEND SERVICE NAME> if { hdr(host) -i <HOST KEY> } { path_beg -i <PATH KEY>} 
```

{{< /more >}}

For example, `use-backend` rules can be deployed with the following code:

```tf
module "deploy-<PROJECT_ID>-haproxy-backend-configuration" {
  source = "../../ryo-service-proxy/module-deployment/modules/deploy-haproxy-configuration"

  depends_on = [ module.deploy-<PROJECT_ID>-haproxy-backend-service, module.deploy-<PROJECT_ID>-haproxy-acl-configuration ]

  haproxy_acl_use-backends = {
    domain     = {backend_service = join("-", [ local.project_id, "<COMPONENT_NAME>" ])},
    domain-www = {backend_service = join("-", [ local.project_id, "<COMPONENT_NAME>" ])}
  }
}
```

## Software deployed

The open source components used in this module are:

{{< table tableclass="table table-bordered table-striped" theadclass="thead-dark" >}}

| Project | What is it? | Homepage | License |
| :------ | :---------- | :------- | :------ |
| Certbot | Open source [letsencrypt](https://letsencrypt.org/) certificate manager | [https://certbot.eff.org/](https://certbot.eff.org/) | [Apache 2.0](https://raw.githubusercontent.com/certbot/certbot/master/LICENSE.txt) |
| Consul | Open source service registry and key-value store | [https://www.consul.io/](https://www.consul.io/) | [Mozilla Public License 2.0](https://github.com/hashicorp/consul/blob/master/LICENSE) |
| Consul-Template | Tool to create dynamic configuration files based on Consul Key-Value store or service registry queries | [https://github.com/hashicorp/consul-template/](https://github.com/hashicorp/consul-template/) | [Mozilla Public License 2.0](https://github.com/hashicorp/consul-template/blob/master/LICENSE) |
| HAProxy | Open source load balancer, TCP and HTTP proxy | [https://www.haproxy.org/](https://www.haproxy.org/) | [GPL/LGPL](https://github.com/haproxy/haproxy/blob/master/LICENSE) |
| Webhook | Open source, light-weight, general purpose webhook server | [https://github.com/adnanh/webhook](https://github.com/adnanh/webhook) | [MIT](https://github.com/adnanh/webhook/blob/master/LICENSE) |

{{< /table >}}

The integration of haproxy with consul to provide dynamic haproxy configuration was inspired by [this](https://www.haproxy.com/blog/haproxy-and-consul-with-dns-for-service-discovery/), [this](https://www.haproxy.com/blog/dns-service-discovery-haproxy/) and [this](https://learn.hashicorp.com/tutorials/consul/load-balancing-haproxy).
