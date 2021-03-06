---
title: "Host Server"
weight: 5
tags: [ "module", "host" ]
draft: false
---
<!--
SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
SPDX-License-Identifier: CC-BY-SA-4.0
-->

A host server is needed to run the various containers that make up a project deployment. A single host server can host multiple projects, or a dedicated host server can be used per project.

<!--more-->

## Host server introduction

The components of a rollyourown project need to run on a host server. A host server may be a [virtual private server (VPS)](https://en.wikipedia.org/wiki/Virtual_private_server) or dedicated server rented from a [hosting provider](https://en.wikipedia.org/wiki/Internet_hosting_service), or may be a server or virtual machine hosted in your home or office.

The host server should be running [Ubuntu](https://ubuntu.com/) 20.04 LTS or 22.04 LTS as operating system. Our projects are written and tested to set up and deploy to Ubuntu 20.04 LTS or 22.04 LTS Linux servers.

A rollyourown host server is controlled by a [control node](/rollyourown/how_to_use/control_node/) via a secure [wireguard](https://www.wireguard.com/) tunnel. Usually, no manual management of the host server is needed and the host server command line does not need to be accessed. However, users familiar with the Linux command line can log in to the server *from the control node*, for example for advanced diagnostics. A few useful commands can be found [here](/rollyourown/how_to_use/host_server_advanced/).

## Host server IP address

Your host server will need to be reachable via a public [IP address](https://en.wikipedia.org/wiki/IP_address). This allows access to your project's services via the internet and allows [Let's Encrypt](https://letsencrypt.org/) certificates to be requested for securing your services via [HTTPS / TLS](https://en.wikipedia.org/wiki/HTTPS) encryption.

If you are hosting your own host server within your home or office network, then the host server may also be reachable via a private IP address. In this case the control node can manage the host server directly via this private IP address.

Depending on your server hosting provider or, in case you are hosting a server within your home or office network, depending on your internet service provider, your host server may be assigned a public IPv4 address and/or a public IPv6 prefix.

{{< highlight "warning" "IPv4 and IPv6">}}

Both IPv4-only host servers and dual stack host servers (with both public IPv4 address and public IPv6 prefix assigned) are supported by rollyourown projects.

IPv6-only host servers are currently not supported.

{{< /highlight >}}

### Host server components

The basic components of a host server are illustrated in the following diagram:

{{< image src="Host_Server.svg" title="Host_Server">}}

On top of the base operating system, the rollyourown [automated host server setup script](#automated-host-server-setup) configures the server, installs basic packages and installs two key components for enabling a rollyourown project deployment:

- [Consul](https://www.consul.io/) is installed to support service discovery and dynamic configuration of project components
- [LXD](https://linuxcontainers.org/lxd/) is installed as container management system to launch and manage project components

The project build and deployment scripts run on the control node can then build project container images, upload them to the host server, launch them and provide configuration via the Consul Key-Value store.

{{< more "secondary">}}

#### Consul

[Consul](https://www.consul.io/) is a [distributed](https://www.consul.io/docs/architecture) [service registry](https://www.consul.io/docs/discovery/services) and [key-value store](https://www.consul.io/docs/dynamic-app-config/kv).

A Consul agent is deployed on project containers and joins the Consul server in client mode. This enables, on the one hand, services on the container to be registered in the service registry and, on the other hand, for the service registry and KV-store to be queried.

#### Service registry

The Consul service registry provides a register of available and running services on the host server. As a new project container is deployed, a consul agent running in client mode on the container registers the presence of the service provided by the container with the Consul service registry, along with the container's IP address and the port on which the service is available. Other components can then discover the service (usually via DNS), without needing prior static configuration of the hostname or IP address of the service.

This feature is used, for example, by [the Ingress Proxy module](/rollyourown/project_modules/ryo-ingress-proxy) to distribute traffic to backend servers and enables the module to be a generic module that can be used in any project.

#### Key-value store

The Consul key-value store provides a store of configuration data for services that can be provisioned at deploy-time. If a container is dynamically configured, then a consul-template agent running on the container retrieves key-values and generates the container service's configuration file(s). This can be done at boot or at a later stage, as the consul-template agent monitors for changes in the specified branches of the key-value tree.

This feature is used, for example, to dynamically load the [Certbot](/rollyourown/project_modules/ryo-ingress-proxy/#certbot) configuration for the certificates needed for a project and to load ACLs and backend configuration for [HAProxy](/rollyourown/project_modules/ryo-ingress-proxy/#haproxy) backend servers. A consul-template agent running on the [Ingress Proxy module](/rollyourown/project_modules/ryo-ingress-proxy) modifies the HAProxy and Cerbot configuration as and when project-specific services are added during project deployment.

{{< /more >}}

## Repository links

The [Codeberg](https://codeberg.org/) mirror repository for the host server automation scripts is here: [https://codeberg.org/rollyourown-xyz/ryo-host](https://codeberg.org/rollyourown-xyz/ryo-host)

The [Github](https://github.com/) mirror repository for the host server automation scripts is here: [https://github.com/rollyourown-xyz/ryo-host](https://github.com/rollyourown-xyz/ryo-host)

The rollyourown repository for the host server automation scripts is here: [https://git.rollyourown.xyz/ryo-projects/ryo-host](https://git.rollyourown.xyz/ryo-projects/ryo-host) (not publicly accessible)

## Host server setup

The recommended way to run a rollyourown project is on a dedicated server or virtual private server (VPS) hosted by a hosting provider.

### Host server resources

The "size" of the host server needed for a rollyourown project depends on a number of parameters:

- The number of different projects you intend to deploy on the host server
- The complexity of the project(s) you want to deploy - the project page should give you an idea of the minimum resources the project needs to run well
- The number of users of the service deployed by your project. A project providing a service for a family or small group of friends will need fewer resources than a large deployment for hundreds or even thousands of people
- The traffic you expect. This will depend on the number of people you want to support or, for a blog or internet site, on the number of visitors you expect

The first projects published on rollyourown are simple projects intended for a small number of users. In future, we plan to publish more complex projects with architectures that can scale up, by using multiple servers, to larger numbers of users or for higher traffic.

With most hosting providers, you can start small and upgrade your VPS if needed.

### A hosted server or Virtual Private Server (VPS)

There are many, many hosting providers in different countries offering servers and VPS at varying cost, starting at a couple of Euros or Dollars per month (or whatever your local currency may be). The cost usually depends on the resources available (CPUs, RAM, storage).

We cannot provide any hosting provider recommendations at this time, so if you don't already have a preferred hosting provider in your region, do an internet search for "VPS" and your country to find providers and compare prices.

{{< highlight "warning" "Hosting provider specifics">}}

#### External firewall

Some hosting providers operate a [firewall](https://en.wikipedia.org/wiki/Firewall_(computing)) function in front of their VPS offerings. If this is the case, make sure that the necessary ports are opened before running the rollyourown automation scripts.

For communication between the control node and the host server, these are:

- TCP Port 22 for initial SSH connections (this can be removed after host server setup)
- TCP Port 2222 for SSH connections after initial host server setup
- UDP Port 52222 for the wireguard tunnel between control node and host server

TCP port 22 is the default port for SSH and configured by default by most hosting providers. If a different initial SSH port is needed, this can be set in the host server configuration file.

TCP ports 2222 and 52222 are the default port numbers used by rollyourown projects. Change these if you have made manual changes in your configuration files.

Additional ports (e.g. TCP ports 80 and 443 for HTTP/HTTPS) will also need to be opened for the specific project you are deploying - see the project description for further details.

#### Initial root user

Some hosting providers require that a server's initial root password is changed on first login. This step will prevent the rollyourown [host setup script](#automated-host-server-setup) from executing. To avoid this, log in once to the server (via SSH or via the hosting provider's web-based console) and change the initial root password before running the [host setup script](#automated-host-server-setup).

{{< /highlight >}}

### Your own server

Rollyourown projects can run on a server hosted in your home or office. However, the server must be reachable via a public IP address.

{{< highlight "danger" "Warning!">}}

Unless you know what you are doing, it is **not recommended** to expose servers or computers in your home or office network on the open internet as this can open your network and computers to attack by various malicious actors. In an office environment, you may be violating company policy by doing so, even if you do find a way around the technical defenses put in place by your employer's IT department.

{{< /highlight >}}

{{< more "secondary">}}

If your internet connection has a **static** public IP address, then you can set up your internet router to direct traffic to the relevant ports to your server.

If your internet connection has a **dynamic** public IP address that changes at regular intervals, then you will additionally need to set up Dynamic DNS (DynDNS) to keep your service available when the IP address changes.

If your internet connection does not have a public IP address (e.g. your provider uses Carrier Grade NAT), then you could, for example, set up a VPN server on a hosted VPS and proxy traffic via a VPN from the VPS public IP address to your home/office network. However, in this case you would need a VPS from a hoster and could just as well deploy your project there.

{{< /more >}}

### Operating system

Unless stated otherwise on the project page, all rollyourown projects are written and tested to deploy to an Ubuntu Linux server, so unless you are sure you know what you are doing, make sure that your host server is running **Ubuntu 20.04 LTS or 22.04 LTS**.

## Automated host server setup

Once a host server has been set up, you should have a public IP address for the server and an initial root login (either provided to you by your hosting provider when the host server was ordered or configured by you during the operating system installation procedure on your own machine). The host server now needs to be prepared for the deployment of rollyourown projects. The control node needs to be configured to communicate securely with the host server and the host server needs to be set up with all necessary software and configuration to host your project.

Server configuration and software installation is automated by the `host-setup.sh` script in the rollyourown host server repository [on Codeberg](https://codeberg.org/rollyourown-xyz/ryo-host) or [on GitHub](https://github.com/rollyourown-xyz/ryo-host).

{{< more "secondary">}}

The `host-setup.sh` script uses the host server's initial root password to secure the server and then set it up to be controlled by the control node and to host [LXD](https://linuxcontainers.org/lxd/) containers for a project deployment. This script calls [Ansible](https://www.ansible.com/) playbooks that execute tasks on the host server.

In detail, the following tasks are performed by the host-setup playbooks:

- A non-root user account is created. The SSH public key created on the control machine during [control node setup](/rollyourown/how_to_use/control_node/) is added to the non-root user account, the account is added to the sudo group and the account is configured for password-less sudo. The non-root user account is then used with [SSH public key authetication](https://help.ubuntu.com/community/SSH/OpenSSH/Keys) for all further communication to the server and all further setup steps

- All packages on the system are upgraded

- [Wireguard](https://www.wireguard.com/) is installed on the system, wireguard configuration files for both control node and host server are generated and wireguard interfaces are enabled to start automatically so that the wireguard tunnel can be used as a permanent, logical direct network connection between control node and the host server. All further host setup steps and project deployment are then carried out via the wireguard tunnel

- The hostname is set (to the name defined in the host server's configuration file)

- [Chrony](https://en.wikipedia.org/wiki/Chrony) is installed to keep the host server's clocks synchronised and [nano](https://www.nano-editor.org/) and [glances](https://github.com/nicolargo/glances/) are installed to allow basic manual system administration and observation if needed by advanced users

- IPv4 and IPv6 packet forwarding is enabled

- The SSH daemon is configured to change the internet-facing port, disallow root login and allow only the non-root user account to log in only via SSH public key authentication

- The host server's firewall is configured to allow communication between control node and host server with no other internet-facing ports opened. Ports required by a rollyourown project are opened, when needed, by the LXD container management agent during project deployment. Also, NAT is enabled for outbound IPv4 communication from [LXD containers](https://linuxcontainers.org/lxd/) deployed on the server and DNS resolution via Consul is enabled

- [LXD](https://linuxcontainers.org/lxd/) is installed and configured on the host server so that container images can be uploaded to the host server and launched by project automation scripts. Snapd channel pinning is used to avoid unexpected upgrading of LXD in a running project

- Host kernel settings are configured for LXD as [recommended by the LXD project](https://linuxcontainers.org/lxd/docs/master/production-setup)

- Directories are created on the host, so that project containers can be launched with mounted storage to enable component configuration and data to persist across container re-starts and replacements

- To enable image uploading and and container management from the control node, the project host is configured as an [LXD remote server](https://linuxcontainers.org/lxd/advanced-guide/#remote-servers) for the control node, using [PKI-based TLS certificate authentication and authorization](https://linuxcontainers.org/lxd/docs/master/security#adding-a-remote-with-a-tls-client-in-a-pki-based-setup) and with the [control node as trusted TLS client](https://linuxcontainers.org/lxd/docs/master/security#managing-trusted-tls-clients)

- Finally, [Consul](https://www.consul.io/) is installed on the host server and configured as a server in the host server "datacenter". In addition, the [Consul](https://www.consul.io/) servers on the host and on the control node are configured as federated remote data centers

For some projects, further project-specific host configuration may be performed by the project's automation scripts

{{< /more >}}

### Step-by-step host server setup

{{< highlight "warning" "IP addresses">}}

If you are using a VPS or server from a hosting provider, the two configuration parameters `host_control_ip` and `host_public_ip` in Step 3 below will **both** be set to the public IPv4 address of the server from your hosting provider. In case you are running the host server in your own network, the `host_public_ip` parameter will be the public IPv4 address of the server from your hosting provider and the `host_control_ip` parameter will be the server's private IPv4 address in your home or office network.

If your VPS or server is assigned a public IPv6 prefix and address, then the configuration parameter `host_public_ipv6` should be set to "true" and configuration parameters `host_public_ipv6_prefix` and `host_public_ipv6_address` set.

{{< /highlight >}}

1. Log in to the **control node** as the non-root user, enter the `ryo-projects` directory and clone the host server repository to your control node:

    ```bash
    cd ~/ryo-projects
    git clone https://github.com/rollyourown-xyz/ryo-host
    ```

2. Choose a name (e.g. "host1") for the host server, enter the `ryo-host` directory and copy the file `configuration/configuration_TEMPLATE.yml` to a new file `configuration/configuration_<HOST_NAME>.yml`, replacing <HOST_NAME> with the name chosen:

    ```bash
    cd ~/ryo-projects/ryo-host
    cp configuration/configuration_TEMPLATE.yml configuration/configuration_<HOST_NAME>.yml
    ```

    **NOTE:** The host name should be a combination of ONLY upper and lower case letters and numbers, with no spaces, dashes or other symbols

3. Edit the new file `configuration_<HOST_NAME>.yml` and add the host server's IP address information (see note above), the root username and password provided by your hosting provider (or configured yourself if you have set up your own server). Also choose a non-root username and password to be configured on the host server.

    If you aren???t familiar with a different Linux editor, use nano to edit the file with:

    ```bash
    cd ~/ryo-projects/ryo-host
    nano configuration/configuration_<HOST_NAME>.yml
    ```

4. In the `ryo-host` directory, copy the file `configuration/inventory_TEMPLATE` to a new file `configuration/inventory_<HOST_NAME>`, replacing <HOST_NAME> with the name chosen above:

    ```bash
    cd ~/ryo-projects/ryo-host
    cp configuration/inventory_TEMPLATE configuration/inventory_<HOST_NAME>
    ```

5. Edit the new file `inventory_<HOST_NAME>` and add the host server's IPv4 address:

    ```bash
    cd ~/ryo-projects/ryo-host
    nano configuration/inventory_<HOST_NAME>
    ```

6. If this is not the first host server configured with the control node, then check additional settings in `configuration_<HOST_NAME>.yml` and `inventory_<HOST_NAME>` and change as described in the comments in those files

7. Run the host server setup automation script `host-setup.sh` from the ryo-host directory, passing the name of the host chosen above via the flag `-n`, to set up a secure connection from the control node to the host server and to set up the host server for deploying rollyourown projects:

    ```bash
    cd ~/ryo-projects/ryo-host
    ./host-setup.sh -n <HOST_NAME>
    ```

After setting up the host server, you are now ready to [deploy a rollyourown project](/rollyourown/how_to_use/deploy) on the server.

{{< highlight "info" "Advanced">}}

After setting up a [control node](/rollyourown/how_to_use/control_node/) and [host server](/rollyourown/how_to_use/host_server), you now have a permanent, secure connection from the control node to the host server via a wireguard tunnel. Users familiar with the Linux command line can log in to the server for advanced diagnostics. A few useful commands can be found [here](/rollyourown/how_to_use/host_server_advanced/).

{{< /highlight >}}

## Host server maintenance

Along with the `host-setup.sh` script, the host server repository also contains a `host-upgrade.sh` script to automate host server maintenance. This script upgrades a host server and the software installed on it. Note: This script does **not** upgrade the containers deployed by rollyourown projects on the host server. To upgrade these, see [How to Maintain](/rollyourown/how_to_use/maintain/#upgrading-a-project-deployment).

To upgrade a host server, run the `host-upgrade.sh` script from the `ryo-host` directory, passing the name of the host chosen above via the flag `-n`:

```bash
cd ~/ryo-projects/ryo-host/
./host-upgrade.sh -n <HOST_NAME>
```

It is recommended to upgrade a host server on a regular basis, to ensure that patches to the operating system and new versions of software are applied.

## Host server backup and restore

A host server is a runtime for multiple project and module containers and provides no services to your users. Using the [host server setup automation scripts](#host-server-setup), a host server can be replicated / re-deployed at any time and therefore does not need any specific backup.

Backing up a host server therefore means backing up the projects and modules deployed to it, so that these can be restored to a freshly-deployed host server if needed.

The general backup and restore approach for rollyourown projects is described on a [dedicated page](/rollyourown/how_to_use/back_up_and_restore/).
