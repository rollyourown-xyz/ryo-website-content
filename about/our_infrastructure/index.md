---
title: "Our Infrastructure"
weight: 9
tags: []
draft: false
---
<!--
SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
SPDX-License-Identifier: CC-BY-SA-4.0
-->

This section gives an overview of how we use our own projects to run our infrastructure. As our project grows, we aim to keep this up to date.

<!--more-->

## Control node

Our [control node](/rollyourown/how_to_use/control_node/) is a Virtual Machine, running on a small server and running [Ubuntu Server 20.04](https://xubuntu.org/) with [XFCE desktop](https://xfce.org/) installed. We access the control node via [xrdp](http://xrdp.org/), using the [Remmina](https://remmina.org/) client.

The virtual machine is over-dimensioned, being assigned 6 vCPUS, 16 GB RAM and a 100 GB virtual disk.

Other than XFCE and xrdp, all software installed on the control node was installed via our [ryo-control-node](/rollyourown/how_to_use/control_node/) automation project.

## Host servers

Our infrastructure is currently hosted on a single virtual server -- with 4 CPUs, 16 GB RAM and a 320 GB SSD -- hosted at [netcup](https://www.netcup.de/) in Germany.

We use the [ryo-host](http://localhost:1313/rollyourown/how_to_use/host_server/) automation project to manage our host server from our control node.

If we need to move services to additional host servers, we will use our [backup and restore](/rollyourown/how_to_use/back_up_and_restore/) procedures. We already used these procedures once to move our services to the current host server (and, of course, we use them to back up the host server regularly to the control node).

## Deployed projects and modules

The projects and modules deployed to our host server are:

{{< image src="Our_Infrastructure.svg" title="Our Infrastructure">}}

### Projects

- [ryo-hugo-website](/rollyourown/projects/ryo-hugo-website/): Deployed twice - in public mode for the [rollyourown.xyz](https://rollyourown.xyz) website and with authentication for the development website at [dev.rollyourown.xyz](https://dev.rollyourown.xyz) accessible only to organisation members
- [ryo-grav-cms](/rollyourown/projects/ryo-grav-cms/): Providing our contact forms
- [ryo-gitea](/rollyourown/projects/ryo-gitea/): Providing our Git repositories at [git.rollyourown.xyz](https://git.rollyourown.xyz) and serving as identity provider for other services
- [ryo-matrix](/rollyourown/projects/ryo-matrix/): Providing our communication servcies

### Modules

- [ryo ingress-proxy](/rollyourown/project_modules/ryo-ingress-proxy/): Used by all projects for certificate management and TLS termination
- [ryo-mariadb](/rollyourown/project_modules/ryo-mariadb/): Used to provide the database for ryo-gitea
- [ryo-postgres](/rollyourown/project_modules/ryo-postgres/): Used to provide the database for ryo-matrix
- [ryo-coturn](/rollyourown/project_modules/ryo-coturn/): Used by the ryo-matrix project for VoIP/Video communications
- [ryo-wellknown](/rollyourown/project_modules/ryo-wellknown/): Used by the ryo-matrix project for service discovery
