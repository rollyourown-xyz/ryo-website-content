---
title: "How to Deploy"
tags: [ ]
draft: false
---

Each [rollyourown.xyz](https://rollyourown.xyz) project provides automation resources to minimise the number of manual steps needed to deploy a project.

This page describes how to use these resources to prepare a control machine, set up the host server, build container images and deploy containers to the host server.

<!--more-->

## TODOs on this page

{{< highlight "primary" "ToDo">}}

- [ ] Consider moving some details to dedicated pages / maybe a dedicated section on How to Use
- [ ] Add links in the text

{{< /highlight >}}

## How to deploy a project (tl;dr)

When you have chosen your [rollyourown.xyz](https://rollyourown.xyz) project to deploy, these are the steps to deploy the project:

1. Prepare a [control node](#a-control-node) to deploy and manage your projects
2. Order or set up a server to host your project, with Ubuntu 20.04 LTS installed
3. Set up the [host server](#a-host-server) ready to deploy your project to
4. Clone the [project's repository](https://github.com/rollyourown-xyz/) to the control machine
5. Run `./get-modules.sh` from the project directory
6. Copy the project configuration files and add settings
7. Run `./host-setup.sh` from the project directory
8. Run `./build-images.sh` from the project directory
9. Run `./deploy-project.sh` from the project directory

Now read on to understand each of these steps in more detail.

## Introduction

Every [rollyourown.xyz](https://rollyourown.xyz) project follows the principles of **Configuration as code**, **Infrastructure as code** and **Immutable infrastructure**.

{{< more "secondary">}}

**Configuration as code**: so that the software and configuration of each element is described in code and under version control, allowing repeatable and automated setup of each element.

**Infrastructure as code**: so that the desired installation (e.g. networks, IP addresses, number and type of instances deployed) is described in code and under version control, allowing exactly repeatable, automated deployments and automated changes over time.

**Immutable infrastructure**: so that, once deployed, no running container is ever modified in place but is rather *replaced* with a new version, allowing exact knowledge of the state of the deployed infrastucture and the ability to roll-back to a known working version in case of a failed upgrade.

{{< /more >}}

Deploying a [rollyourown.xyz](https://rollyourown.xyz) project to a host server consists of a few steps:

1. Prepare a [control node](#a-control-node) with the basic software to run the [rollyourown.xyz](https://rollyourown.xyz) automation scripts, or use an existing control node you have previously set up

2. If you are setting up a new [control node](#a-control-node), clone the [control node repository](https://github.com/rollyourown-xyz/ryo-control-node) to the control node and run the `local-setup.sh` script. This installs further software and prepares the control node for managing [rollyourown.xyz](https://rollyourown.xyz) projects. This step can be skipped if you are using an existing control node that has already been set up for a different [rollyourown.xyz](https://rollyourown.xyz) project

3. Order or prepare a [host server](#a-host-server) for deploying the project on, or use an existing host server you have previously set up

4. If you are setting up a new [host server](#a-host-server), clone the [host server repository](https://github.com/rollyourown-xyz/ryo-host) to the control node and run the `host-setup.sh` script. This sets up secure communication between the control node and the host server, configures the host server and installs software needed for deploying a [rollyourown.xyz](https://rollyourown.xyz) project. This step can be skipped if you are using an existing host server that has already been set up for a different [rollyourown.xyz](https://rollyourown.xyz) project

5. Clone the [project's repository](https://github.com/rollyourown-xyz/) to the control node to obtain scripts, configuration code and infrastructure code needed to deploy the project

6. Run the `get-modules.sh` script on the control node to fetch additional modules needed for the project. This script clones the necessary [rollyourown.xyz](https://rollyourown.xyz) module repositories to the control node

7. Run the project's `host-setup.sh` script on the control node to configure project-specific settings on the host server, if needed by the project

8. Run the `build-images.sh` script on the control node to prepare the various container images needed for the project (and its modules) and to upload them to the host server ready for deployment

9. Finally, run the `deploy-project.sh` script on the control node to deploy the various containers on the host server

{{< highlight "info">}}

These steps are described in more detail in the following. For more information about the [rollyourown.xyz](https://rollyourown.xyz) automation scripts, see the section ["What do these scripts do?"](#what-do-these-scripts-do) below.

{{< /highlight >}}

## Prerequisites

### A control node

You will need a control node to run the automation scripts to deploy your [rollyourown.xyz](https://rollyourown.xyz) project and, later, to perform automated upgrades of your installation. A control node can manage multiple projects on multiple host servers.

A control node should be run as a virtual machine (VM) on your personal computer or as a dedicated machine. In both cases, the control node should be running Ubuntu 20.04 LTS as operating system. The `local-setup.sh` scripts are written and tested for Ubuntu 20.04 LTS and will set up all needed software for you.

{{< highlight "info" "Setting up a control node">}}

A detailed guide for setting up a control node, with step-by-step instructions, can be found [here](/rollyourown/project_modules/control_node/).

{{< /highlight >}}

{{< highlight "warning" "Control node using WSL or as an LXD container?">}}

If you consider running a control node on [Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/about) or as an [LXD container](https://linuxcontainers.org/lxd/) on Linux, please be aware that **this is unsupported**, due to current limitations of the two technologies.

It is our goal to eventually support a control node running as a WSL app on Windows or as an LXD container on Linux, in order to provide a simpler and faster setup of a control node. We will revisit this if and when the technologies have been updated to resolve the relevant limitations.

{{< /highlight >}}

As an alternative to a virtual machine, a dedicated computer (e.g. laptop, desktop, Intel NUC) running Ubuntu 20.04 LTS can be used. The `local-setup.sh` scripts are written and tested on this operating system and will set up all needed software for you.

### A host server

A host server is needed to run the various containers making up a [rollyourown.xyz](https://rollyourown.xyz) project deployment. A host server can host multiple projects, or a dedicated host server per project can be used.

The recomended host server is a server or virtual private server (VPS) provided by a hosting provider. A host server can also be a server or virtual machine hosted in your home or office.

The host server must be reachable via a public IP address and should be running **Ubuntu 20.04 LTS** as operating system. [Rollyourown.xyz](https://rollyourown.xyz) projects are written and tested to set up and deploy to a Ubuntu 20.04 LTS Linux server.

{{< highlight "danger" "Warning!">}}

Unless you know what you are doing, it is **not recommended** to expose servers or computers in your home or office network on the open internet as this can open your network and computers to attack by various malicious actors. In an office environment, you may be violating company policy by doing so, even if you do find a way around the technical defenses put in place by your employer's IT department.

{{< /highlight >}}

{{< highlight "info">}}

More details and a step-by-step guide for setting up a host server can be found [here](/rollyourown/project_modules/host_server/).

{{< /highlight >}}

### A domain

To run a [rollyourown.xyz](https://rollyourown.xyz) project, you will need a domain. There are many top level domains (TLDs) available - e.g. .com, .net, .org, .xyz, .info and many others - and many domain registrars in different countries from which you can purchase a domain. Often, a domain is included in a VPS package from a hoster.

If you acquire your domain from a different provider than your host server, make sure that your domain provider allows you to manage DNS records for the domain so that you can configure the A and/or AAAA record to "point" to your host server.

## Preparing to deploy the project

After a [control node](rollyourown/project_modules/control_node/) and [host server](rollyourown/project_modules/host_server/) have been set up, then container images for the project need to be built and uploaded to the host and the project's components need to be deployed on the host.

### Getting the project repositories

The first step is to fetch the automation code for the project.

First, log in to the **control node** as the non-root user, enter the `ryo-projects` directory and clone the **project repository** to your control node. The repository used depends on the project to deploy and is linked from the project's page. For example:

```bash
cd ~/ryo-projects
git clone https://github.com/rollyourown-xyz/<PROJECT_TO_DEPLOY>
```

Then use the `get-modules.sh` script in the project directory to fetch additional modules. This script clones further [rollyourown.xyz](https://rollyourown.xyz) repositories to the control node.

```bash
cd ~/ryo-projects/<PROJECT_TO_DEPLOY>
./get-modules.sh
```

The project can now be configured.

### Configuring the project

Before running the project's automation scripts, some configuration is needed.

First, enter the project directory `~/ryo-projects/<PROJECT_TO_DEPLOY>` and copy the file `configuration/configuration_TEMPLATE.yml` to `configuration/configuration_<HOST_NAME>.yml`, where `<HOST_NAME>` is the name you chose for your host server [when setting it up](rollyourown/project_modules/host_server/)

```bash
cd ~/ryo-projects/<PROJECT_TO_DEPLOY>/
cp configuration/configuration_TEMPLATE.yml configuration/configuration_<HOST_NAME>.yml
```

Then, edit the project's configuration file `configuration_<HOST_NAME>.yml` and enter any configuration settings needed for the project (e.g. domain name, email addresses, etc.). If you aren't familiar with a different linux editor, use nano to edit the file.

```bash
cd ~/ryo-projects/<PROJECT_TO_DEPLOY>/
nano configuration/configuration_<HOST_NAME>.yml
```

Now you are ready to run the project's automation scrips to complete any project-specific setup of the host server, build images and deploy the project.

{{< highlight "info" "Multiple project deployments">}}

So that a control node can be used to manage multiple deployments of the same project on different host servers (so that, for example, different host servers can be used for different domains), the project configuration is always stored in a file called `configuration_<HOST_NAME>.yml`. Each configuration file in the project's configuration directory corresponds to the deployment of the project on a different host.

{{< /highlight >}}

## Running the automation scripts

All further steps are done using the automation scripts in the project's directory that was cloned to the control machine.

### Project-specific host setup

In this step, the host server is configured with any project-specific settings.

Log in to the control node as the non-root user, enter the project's directory and run the `host-setup.sh` script, passing the name of the host on which to deploy the project via the flag `-n`:

```bash
cd ~/ryo-projects/<PROJECT_TO_DEPLOY>/
./host-setup.sh -n <HOST_NAME>
```

The next step is to build container images for the project deployment.

### Building container images

In this step, container images are built on the control node, one for each component in the project's deployment, and uploaded to the host server ready to be deployed.

Log in to the control node as the non-root user, enter the project's directory and run the `build-images.sh` script. The host name for the project's deployment and a version stamp for the images (for example, the date) need to be passed to the script using the flags `-n` and `-v`. For the first deployment, images for the modules used by the project should also be built on the control node, by passing the flag `-m`.

```bash
cd ~/ryo-projects/<PROJECT_TO_DEPLOY>/
./build-images.sh -m -n <HOST_NAME> -v <VERSION>
```

Depending on the number of components to be deployed and the network speed between your control node and the remote host server, this process may take some time. Once the process is completed, you are ready to deploy the project.

### Deploying the project

In this step, the various project component containers are launched on the host server.

Log in to the control node as the non-root user, enter the project's directory and run the `deploy-project.sh` script.

The host name for the project's deployment needs to be passed to the script using the flag `-n` and the **same version stamp** used in the previous step needs to be passed using the flag `-v`. For the first deployment, modules needed for the project should also be deployed by passing the flag `-m`.

```bash
cd ~/ryo-projects/<PROJECT_TO_DEPLOY>/
./deploy-project.sh -m -n <HOST_NAME> -v <VERSION>
```

After the project has been deployed, you are ready to perform any needed project-specific setup and use the components deployed for your project.

## After deployment

Further information on further steps to take and how to use the project are given on the project's page.

Over time, the software packages used for the project deployment need to be kept up to date, as security patches are released for the software or underlying operating systemss or when new versions of the software packages are released. The two automation scripts `build-images.sh` and `deploy-project.sh` are used to update the containers and deployment. More information can be found at ["Tech Projects: How to maintain"](/rollyourown/tech_projects/how_to_maintain/).

## What do these scripts do?

### The `get-modules.sh` script

The `get-modules.sh` script loads additional modules needed by the project, which are retrieved from dedicated [rollyourown.xyz](https://rollyourown.xyz) repositories.

### The `host-setup.sh` script

Generic host setup and configuration has already been done by the `host-setup.sh` script in the [host server](rollyourown/project_modules/host_server/) [repository](https://github.com/rollyourown-xyz/ryo-host). Additional host configuration is performed for the individual project by the `host-setup.sh` script in the project's repository. This usually consists of setting up directories on the host server to provide persistent storage for the project's containers to enable component configuration and data to persist across container re-starts and replacements. Additional host setup steps may be needed, depending on the project.

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
