---
title: "Single Server Projects: How to deploy"
tags: [ ]
draft: false
---

Each rollyourown.xyz project provides automation resources to minimise the number of manual steps needed to deploy a project.

This page describes how to use these resources to prepare a control machine, set up the host server, build container images and deploy containers to the host server.

<!--more-->

## TODOs on this page

{{< highlight "primary" "ToDo">}}

- [ ] Consider moving some details to dedicated pages / maybe a dedicated section on How to Use
- [ ] Add links in the text

{{< /highlight >}}

## How to deploy a project (tl;dr)

When you have chosen your [rollyourown.xyz](https://rollyourown.xyz) project to deploy, these are the steps to deploy the project:

1. Order or set up a server to host your project, running Ubuntu 20.04 LTS
2. [Prepare a control node](/rollyourown/project_modules/control_node/) to deploy and manage your projects
3. Clone the [project's repository](https://github.com/rollyourown-xyz/) to the control machine
4. Run `./get-modules.sh` from the project directory
5. Copy the project configuration files and add settings
6. Run `./host-setup.sh` from the project directory
7. Run `./build-images.sh` from the project directory
8. Run `./deploy-project.sh` from the project directory

Now read on to understand each of these steps.

## Introduction

Every rollyourown.xyz project follows the principles of **Configuration as code**, **Infrastructure as code** and **Immutable infrastructure**.

{{< more "secondary">}}

**Configuration as code**: so that the software and configuration of each element is described in code and under version control, allowing repeatable and automated setup of each element.

**Infrastructure as code**: so that the desired installation (e.g. networks, IP addresses, number and type of instances deployed) is described in code and under version control, allowing exactly repeatable, automated deployments and automated changes over time.

**Immutable infrastructure**: so that, once deployed, no running container is ever modified in place but is rather *replaced* with a new version, allowing exact knowledge of the state of the deployed infrastucture and the ability to roll-back to a known working version in case of a failed upgrade.

{{< /more >}}

Deploying a rollyourown.xyz project to a host server consists of a few steps:

1. Preparing a [control node](/rollyourown/project_modules/control_node/) with the basic software to run the automation scripts, or use an existing control node you have previously set up

2. If you are [setting up a new control node](/rollyourown/project_modules/control_node/), cloning the [control node setup repository](https://github.com/rollyourown-xyz/ryo-control-node) to the control node and running the `local-setup.sh` script to install further software and prepare the machine to securely connect to the host server. This setp can be skipped if you have already set up a control node (e.g. for a different project)

3. Cloning the [project's repository](https://github.com/rollyourown-xyz/) to the control node to obtain all scripts, configuration code and infrastructure code needed to deploy the project

4. Running the `get-modules.sh` script on the control node fetches additional modules needed for the project by cloning their rollyourown.xyz repositories into the project's directory

5. Running the `host-setup.sh` script on the control node to prepare the host server for running containers and to set up the server to be securely controlled by the control node

6. Running the `build-images.sh` script on the control node to prepare the various container images needed for the project and to upload them to the host server ready for deployment

7. Finally, running the `deploy-project.sh` script on the control node to deploy the various containers on the host server

{{< highlight "info">}}

These steps are described in more detail in the following. For more information about the rollyourown.xyz automation scripts, see the section ["What do these scripts do?"](#what-do-these-scripts-do) below.

{{< /highlight >}}

## Prerequisites

### A server to host your project deployment

A rollyourown.xyz project needs to run on a server and the server needs to be reachable via a public IP address.

#### A hosted server or Virtual Private Server (VPS)

The recomended way of running a rollyourown.xyz project is on a server or virtual private server (VPS) hosted by a hosting provider.

There are many, many hosting providers in different countries offering servers and VPS at varying cost, starting at a couple of Euros or Dollars per month (or whatever your local currency may be) with the cost usually depending on the country and the resources available (CPUs, RAM, storage).

We cannot provide any hoster recommendations at this time, so if you don't already have a preferred hoster in your region, do an internet search for "VPS" and your country to find providers and compare prices.

{{< highlight "warning" "External firewall">}}

Some hosting providers operate a firewall function in front of their VPS offerings. If this is the case, make sure that the necessary ports are opened before running the rollyourown.xyz automation scripts.

For communication between the control node and the host server, these are:

- TCP Port 22 for initial SSH connections (this can be removed after host server setup)
- TCP Port 2222 for SSH connections after host server setup (default port number - change if you configure your project differently)
- UDP Port 52222 for the wireguard tunnel between control node and host server (default port number - change if you configure your project differently)

Additional ports (e.g. TCP ports 80 and 443 for HTTP/HTTPS) will need to be opened for the specific project you are deploying - see the project description for further details

{{< /highlight >}}

#### Your own server

{{< highlight "danger" "Warning!">}}

Unless you know what you are doing, it is **not recommended** to expose servers or computers in your home or office network on the open internet as this can open your network and computers to attack by various malicious actors. In an office environment, you may be violating company policy by doing so, even if you do find a way around the technical defenses put in place by your employer's IT department.

{{< /highlight >}}

The "smaller" rollyourown.xyz projects can run on a server with low resources hosted in your home or office. However, the server must be reachable via a public IP address.

{{< more "secondary">}}

If your internet connection has a **static** public IP address, then you can set up your internet router to direct traffic to the relevant ports to your server.

If your internet connection has a **dynamic** public IP address that changes at regular intervals, then you will additionally need to set up Dynamic DNS (DynDNS) to keep your service available when the IP address changes.

If your internet connection does not have a public IP address (e.g. your provider uses Carrier Grade NAT), then you could, for example, set up a VPN server on a hosted VPS and proxy traffic via a VPN from the VPS public IP address to your home/office network. However, in this case you would need a VPS from a hoster and could just as well deploy your project there.

{{< /more >}}

#### Size of the server

The "size" of the server needed depends on a number of parameters:

- The complexity of the project you want to deploy - the project page should give you an idea of the minimum resources the project needs to run well
- For a project providing a service for multiple people (e.g. a messaging server, a cloud service), the resources needed will depend on the number of persons you want to support with your deployment. A project providing a service for a family or small group of friends will need fewer resources than a large deployment for hundreds or thousands of people.
- The traffic you expect. This will depend on the number of people you want to support or, for a blog or internet site, on the number of visitors you expect

The first projects published on rollyourown.xyz are simple projects intended for a small number of users. In future, we plan to publish more complex projects with architectures that can scale up to larger numbers of users or higher traffic by using multiple servers.

With most hosting providers, you can start small and upgrade your VPS if needed.

#### Operating system

Unless stated otherwise on the project page, all rollyourown.xyz projects are written and tested to deploy to an Ubuntu Linux server, so unless you are sure you know what you are doing, make sure that your server is running **Ubuntu 20.04 LTS**.

### A domain

To run a rollyourown.xyz project, you will need a domain. There are many top level domains (TLDs) available - e.g. .com, .net, .org, .xyz, .info and many others - and many domain registrars in different countries from which you can purchase a domain. Often, a domain is included in a VPS package from a hoster.

If you acquire your domain from a different provider than your server, make sure that your domain provider allows you to specify the DNS record for the domain so that you can configure the A and/or AAAA record to "point" to your server.

### A control node

You will need a control node to run the automation scripts to deploy your rollyourown.xyz project and, later, to perform automated upgrades of your installation.

A control node should be run as a virtual machine (VM), running Ubuntu 20.04 LTS, on your personal computer or on a dedicated machine running Ubuntu 20.04 LTS. The `local-setup.sh` scripts are written and tested for Ubuntu 20.04 LTS and will set up all needed software for you.

A guide to setting up a control node is [here](/rollyourown/project_modules/control_node/).

{{< highlight "warning" "Control node as LXD container?">}}

If you consider running a control node on [Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/about) or as an [LXD container](https://linuxcontainers.org/lxd/) on Linux, please be aware that **this is unsupported**, due to limitations of the two technologies.

It is our goal to eventually support a control node running as a WSL app on Windows or as an LXD container on Linux, to provide a simple and fast setup of a control node. We will revisit this if and when the technologies have been updated to resolve these problems.

{{< /highlight >}}

As an alternative to a virtual machine, a dedicated computer (e.g. laptop, desktop, Intel NUC) running Ubuntu 20.04 LTS can be used. The `local-setup.sh` scripts are written and tested on this operating system and will set up all needed software for you

## Preparing to deploy the project

After a [control node has been set up](rollyourown/project_modules/control_node/), then the host server needs to be set up, container images for the project need to be built and uploaded to the host and, finally, the project's components need to be deployed on the host.

### Getting the project repositories

Log in to the control node as the non-root user, enter the `ryo-projects` directory and clone the **project repository** to your control node. The repository used depends on the project to deploy and is linked from the project's page. For example:

```bash
cd ~/ryo-projects
git clone https://github.com/rollyourown-xyz/<project_to_deploy>.git
```

Then use the `get-modules.sh` script in the project directory to fetch additional modules. This script clones the relevant rollyourown.xyz repositories into the `modules` directory.

```bash
cd ~/ryo-projects/<project_to_deploy>
./get-modules.sh
```

The project can now be configured.

### Configuring the project

Before running the project's automation scripts, some configuration is needed.

First, log in to the control node as the non-root user, copy and edit the inventory template file and enter your host server's public and private wireguard IP addresses.

```bash
cd ~/ryo-projects/<project_to_deploy>/
cp configuration/inventory_TEMPLATE configuration/inventory
nano configuration/inventory
```

Then, copy and edit the project's configuration template and enter host and project settings. These include the initial root password for your host server (provided by your hoster), a new non-root username and password for the host server and various project-specific parameters that depend on the project being deployed. If you aren't familiar with a different linux editor, use nano to edit the file.

```bash
cd ~/ryo-projects/<project_to_deploy>/
cp configuration/configuration_TEMPLATE.yml configuration/configuration.yml
nano configuration/configuration.yml
```

Now you are ready to run the automation scrips to complete the setup of the control node, set up the host server, build images and deploy the project.

## Running the automation scripts

All further steps are done using the automation scripts in the project's directory that was cloned to the control machine.

### Setting up the host

In this step, the control node is configured to communicate securely with the project's host server and the host server is set up with all necessary software and configuration.

Log in to the control node as the non-root user, enter the project's directory and run the `host-setup.sh` script.

```bash
cd ~/ryo-projects/<project_to_deploy>/
./host-setup.sh
```

The next step is to build container images for the project deployment.

{{< highlight "info" "Advanced">}}

After setting up a control node with the script `local-setup.sh` and adding a project host server with `host-setup.sh`, you now have a permanent, secure connection from the control node to the host server via a wireguard tunnel. Users familiar with the Linux command line can log in to the server for advanced diagnostics. A few useful commands can be found [here](/rollyourown/project_modules/control_node_advanced/).

{{< /highlight >}}

### Building container images

In this step, container images are built on the control node, one for each component in the project's deployment, and uploaded to the host server ready to be deployed.

Log in to the control node as the non-root user, enter the project's directory and run the `build-images.sh` script. A version stamp (for example, the date) needs to be passed to the script.

```bash
cd ~/ryo-projects/<project_to_deploy>/
./build-images.sh -v <VERSION>
```

Depending on the number of components to be deployed and the network speed between your control node and the remote host server, this process may take some time. Once the process is completed, you are ready to deploy the project.

### Deploying the project

In this step, the various project component containers are launched on the host server.

Log in to the control node as the non-root user, enter the project's directory and run the `deploy-project.sh` script. The **same version stamp** used in the previous step needs to be passed to the script.

```bash
cd ~/ryo-projects/<project_to_deploy>/
./deploy-project.sh -v <VERSION>
```

After the project has been deployed, you are ready to perform any needed project-specific setup and use the components deployed for your project.

## After deployment

Further information on further steps to take and how to use the project are given on the project's page.

Over time, the software packages used for the project deployment need to be kept up to date, as security patches are released for the software or underlying operating systemss or when new versions of the software packages are released. The two automation scripts `build-images.sh` and `deploy-project.sh` are used to update the containers and deployment. More information can be found at ["Tech Projects: How to maintain"](/rollyourown/tech_projects/how_to_maintain/).

## What do these scripts do?

### The `get-modules.sh` script

The `get-modules.sh` script loads additional modules needed by the project, which are retrieved from dedicated rollyourown.xyz repositories.

{{< more "secondary">}}

In detail, the following tasks are performed by the get-modules script:

- For all projects, the repository [https://github.com/rollyourown-xyz/ryo-host-setup-generic](https://github.com/rollyourown-xyz/ryo-host-setup-generic) is added as a git submodule and cloned to the modules directory. This repository contains generic setup scripts for any rollyourown.xyz host

- Depending on the project, additional re-usable modules are fetched from dedicated rollyourown.xyz repositories

{{< /more >}}

### The `host-setup.sh` script

The `host-setup.sh` uses the host server's initial root password to secure the server, set it up to be controlled by the control node and to host [LXD](https://linuxcontainers.org/lxd/) containers for the project deployment. This script simply calls generic and project-specific [ansible](https://www.ansible.com/) playbooks that execute tasks on the host server.

{{< more "secondary">}}

In detail, the following tasks are performed by the host-setup playbooks:

- A non-root user account is created, the SSH public key created on the control machine by the [local-setup playbook](#the-local-setupsh-script) is added to the user's account and the account is added to the sudo group and configured for password-less sudo. The non-root user account is then used with [SSH public key authetication](https://help.ubuntu.com/community/SSH/OpenSSH/Keys) for all further communication to the server and all further setup steps

- All packages on the system are upgraded

- [Wireguard](https://www.wireguard.com/) is installed on the system, wireguard configuration files for both control node and host server are generated and wireguard interfaces are enabled to start automatically so that the wireguard tunnel can be used as a permanent, logical direct network connection between control node and host server. All further host setup steps are then carried out via the wireguard tunnel

- The hostname is set (to the name defined in the project's configuration file)

- [Chrony](https://en.wikipedia.org/wiki/Chrony) is installed to keep the host server's clocks synchronised and [nano](https://www.nano-editor.org/) and [glances](https://github.com/nicolargo/glances/) are installed to allow basic manual system administration and observation if needed

- If the project requires it, IPv4 packet forwarding and a virtual network interface are set up

- The SSH daemon is set up to change the internet-facing port, disallow root login and allow  the non-root user added above to log in only via SSH public key authentication. If set in the project's configuration file, [two-factor authetication (2FA)](https://en.wikipedia.org/wiki/Multi-factor_authentication) with [time-based one-time passwords (TOTP)](https://en.wikipedia.org/wiki/Multi-factor_authentication) is configured for access via the public internet. Login via the wireguard tunnel is excluded from 2FA so that automation scripts run on the control node can manage the host via the tunnel without manual intervention

- The host server's firewall is configured to only open ports needed for the project

- [LXD](https://linuxcontainers.org/lxd/) is installed and configured on the host so that container images can be uploaded in the `build-images.sh` step and containers can be launched in the `deploy-project.sh` step. Snapd channel pinning is used to avoid unexpected upgrading in a running project

- Host kernel settings are configured for LXD as [recommended by the LXD project](https://linuxcontainers.org/lxd/docs/master/production-setup)

- Directories are created on the host so that project containers can be launched with mounted storage to enable component configuration and data to persist across container re-starts and replacements

- To enable image uploading and and container management from the control node, the project host is configured as an [LXD remote server](https://linuxcontainers.org/lxd/advanced-guide/#remote-servers) for the control node, using [PKI-based TLS certificate authentication and authorization](https://linuxcontainers.org/lxd/docs/master/security#adding-a-remote-with-a-tls-client-in-a-pki-based-setup), with the [control node as trusted TLS client](https://linuxcontainers.org/lxd/docs/master/security#managing-trusted-tls-clients)

- In some projects, additional host configuration is performed as needed

{{< /more >}}

### The `build-images.sh` script

The `build-images.sh` script calls [Packer](https://www.packer.io/) to create an image for each of the project's components and upoad them to the host server ready to be deployed in the `deploy-project.sh` script. A version stamp (e.g. 20210301) needs to be passed to the `build-images.sh` script, which will be used in the name of each image created and uploaded and which will be used in the `deploy-project.sh` script to launch the correct container image version and later to upgrade containers in-life.

{{< more "secondary">}}

For each image, [Packer](https://www.packer.io/) uses [LXD](https://linuxcontainers.org/lxd/) to launch a base container on the control node (using an [ubuntu-minimal](https://wiki.ubuntu.com/Minimal) cloud image), executes a component-specific [ansible](https://www.ansible.com/) playbook to provision the container with the necessary software and configuration and then creates a container image from the fully provisioned container. Finally, packer triggers LXD to upload the container image to the remote host server.

Container images created in this step are specific to the project and depend on the components used. Details can be found on the project's page.

{{< /more >}}

### The `deploy-project.sh` script

The `deploy-project.sh` script uses [Terraform](https://www.terraform.io/) and the [Terraform LXD Provider](https://registry.terraform.io/providers/terraform-lxd/lxd/) to launch (and later upgrade) the containers needed for the project on the host machine. The version stamp provided to the `build-images.sh` script also needs to be provided to the `deploy-project.sh` script so that Terraform can identify the container images to launch.

{{< more "secondary">}}

Component containers are launched as specified in the Terraform configuration. Terraform reads the current state on the host machine and makes changes to bring the host machine into the desired state. On the first execution of the `deploy-project.sh` script, no resources have been deployed to the host machine so that Terraform deploys the entire project. On a later execution, changes are only made where necessary (e.g. to upgrade a container to a newer version, built in a later build-images step).

{{< /more >}}
