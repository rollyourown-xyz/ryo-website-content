---
title: "How to Deploy"
weight: 1
tags: [ ]
draft: false
---
<!--
SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
SPDX-License-Identifier: CC-BY-SA-4.0
-->

Each rollyourown project provides automation resources to minimise the number of manual steps needed to deploy a project.

This page describes the process of preparing a [control node](/rollyourown/how_to_use/control_node), setting up a [host server](/rollyourown/how_to_use/host_server), and deploying a [rollyourown project](/rollyourown/projects) to the host server.

<!--more-->

## Introduction

Every rollyourown project follows the principles of **Configuration-as-Code**, **Infrastructure-as-Code** and **Immutable infrastructure**.

- **Configuration-as-Code** (CaC): so that the software and configuration of each element is described in code and under version control, allowing repeatable and automated setup of each element.
- **Infrastructure-as-Code** (IaC): so that the desired installation (e.g. networks, IP addresses, number and type of instances deployed) is described in code and under version control, allowing exactly repeatable, automated deployments and automated changes over time.
- **Immutable infrastructure**: so that, once deployed, no running container is ever modified in place but is rather *replaced* with a new version, allowing exact knowledge of the state of the deployed infrastructure and the ability to roll back to a known working version in case of a failed upgrade.

Deploying a rollyourown project to a host server consists of a few steps:

1. Prepare a [control node](#a-control-node) with the basic software to run the rollyourown automation scripts, or use an existing control node you have previously set up

2. If you are setting up a new [control node](#a-control-node), clone the [control node repository](https://github.com/rollyourown-xyz/ryo-control-node) to the control node, set configuration parameters and run the `local-setup.sh` script. This installs further software and prepares the control node for managing rollyourown projects. This step can be skipped if you are using an existing control node that has already been set up for a different rollyourown project. Full, step-by-step instructions for setting up a control node can be found on [a dedicated page](/rollyourown/how_to_use/control_node)

3. Order or prepare a [host server](#a-host-server) for deploying the project on, or use an existing host server you have previously set up

4. If you are setting up a new [host server](#a-host-server), clone the [host server repository](https://github.com/rollyourown-xyz/ryo-host) to the control node, set configuration parameters and run the `host-setup.sh` script. This sets up secure communication between the control node and the host server, configures the host server and installs software needed for deploying a rollyourown project. This step can be skipped if you are using an existing host server that has already been set up for a different rollyourown project. Full, step-by-step instructions for setting up a host server can be found on [a dedicated page](/rollyourown/how_to_use/host_server)

5. Clone the [project's repository](https://github.com/rollyourown-xyz/) to the control node to obtain scripts, configuration code and infrastructure code needed to deploy the project. Details are [below](#getting-the-project-repository)

6. Edit the project's configuration file to fill in necessary parameters such as admin username, admin password and domain to use for the project Details are [below](#configuring-the-project)

7. Run the `deploy.sh` script (details are [below](#running-the-automation-scripts)) on the control node which:
  
    - Fetches additional modules needed for the project by cloning the necessary rollyourown module repositories to the control node
    - Configures module- and project-specific settings on the host server
    - Prepares the various container images needed for the project (and its modules) and uploads them to the host server ready for deployment
    - Deploys the various containers to the host server

{{< highlight "info">}}

These steps are described in more detail in the following. For more information about the rollyourown automation scripts, see our [collaboration section](/collaborate/project_and_module_development/project_structure).

{{< /highlight >}}

## Prerequisites

### A control node

You will need a [control node](/rollyourown/how_to_use/control_node/) to run the automation scripts to deploy your rollyourown project and, later, to perform automated upgrades of your installation. A control node can manage multiple projects on multiple host servers.

A control node should be run as a virtual machine (VM) on your personal computer or as a dedicated machine. In both cases, the control node should be running Ubuntu 20.04 LTS or 22.04 LTS as operating system. The `local-setup.sh` scripts are written and tested for Ubuntu 20.04 LTS and 22.04 LTS and will install and set up all needed software for you.

{{< highlight "info" "Setting up a control node">}}

A detailed guide for setting up a control node, with step-by-step instructions, can be found [here](/rollyourown/how_to_use/control_node/).

{{< /highlight >}}

{{< highlight "warning" "Control node using WSL or as an LXD container?">}}

If you consider running a control node on [Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/about) or as an [LXD container](https://linuxcontainers.org/lxd/) on Linux, please be aware that **this is unsupported**, due to current limitations of the two technologies.

It is our goal to eventually support a control node running as a WSL app on Windows or as an LXD container on Linux, in order to provide a simpler and faster setup of a control node. We will revisit this if and when the technologies have been updated to resolve the relevant limitations.

{{< /highlight >}}

As an alternative to a virtual machine, a dedicated computer (e.g. laptop, desktop, Intel NUC) running Ubuntu 20.04 LTS or 22.04 LTS can be used. The `local-setup.sh` scripts are written and tested on this operating system and will install and set up all needed software for you.

### A host server

A [host server](/rollyourown/how_to_use/host_server) is needed to run the various containers making up a rollyourown project deployment. A host server can host multiple projects, or a dedicated host server per project can be used.

The recommended host server is a server or virtual private server (VPS) provided by a hosting provider. A host server can also be a server or virtual machine hosted in your home or office.

The host server must be reachable via a public IP address and should be running **Ubuntu 20.04 LTS or 22.04 LTS** as operating system. Rollyourown projects are written and tested to set up and deploy to a Ubuntu 20.04 LTS or 22.04 LTS Linux server.

{{< highlight "danger" "Warning!">}}

Unless you know what you are doing, exposing servers or computers in your home or office network on the open internet is **not recommended** as this can open your network and computers to attack by various malicious actors. In an office environment, you may be violating company policy by doing so, even if you do find a way around the technical defences put in place by your employer's IT department.

{{< /highlight >}}

{{< highlight "info">}}

More details and a step-by-step guide for setting up a host server can be found [here](/rollyourown/how_to_use/host_server/).

{{< /highlight >}}

### A domain

To run a rollyourown project, you will need a [domain](https://en.wikipedia.org/wiki/Domain_name). There are many [top level domains (TLDs)](https://en.wikipedia.org/wiki/Top-level_domain) available -- e.g. .com, .net, .org, .xyz, .info and many others -- and many domain registrars in different countries from which you can purchase a domain. Often, a domain is included in a VPS package from a hosting provider.

If you acquire your domain from a different provider than your host server, make sure that your domain provider allows you to manage DNS records for the domain so that you can configure the [A](https://simple.wikipedia.org/wiki/A_record) and/or [AAAA](https://simple.wikipedia.org/wiki/AAAA_record) record to "point" to your host server.

## Preparing to deploy the project

After a [control node](/rollyourown/how_to_use/control_node/) and [host server](/rollyourown/how_to_use/host_server/) have been set up, container images for the project need to be built and uploaded to the host and the project's components need to be deployed on the host.

### Getting the project repository

The first step is to fetch the automation code for the project.

First, log in to the [**control node**](/rollyourown/how_to_use/control_node/), enter the `ryo-projects` directory and clone the [**project repository**](/rollyourown/projects) to your control node. The repository used depends on the project to deploy and is linked from the project's page. For example:

```bash
cd ~/ryo-projects
git clone https://github.com/rollyourown-xyz/<PROJECT_TO_DEPLOY>
```

The project can now be configured.

### Configuring the project

Before running the project's automation scripts, some configuration is needed.

First, enter the project directory `~/ryo-projects/<PROJECT_TO_DEPLOY>` and copy the file `configuration/configuration_TEMPLATE.yml` to `configuration/configuration_<HOST_NAME>.yml`, where `<HOST_NAME>` is the name you chose for your host server [when setting it up](/rollyourown/how_to_use/host_server/)

```bash
cd ~/ryo-projects/<PROJECT_TO_DEPLOY>/
cp configuration/configuration_TEMPLATE.yml configuration/configuration_<HOST_NAME>.yml
```

Then, edit the project's configuration file `configuration_<HOST_NAME>.yml` and enter any configuration settings needed for the project (e.g. domain name, email addresses, etc.). If you aren't familiar with a different Linux editor, use nano to edit the file or the built-in text editor from the Ubuntu desktop. Using nano from the command line, for example:

```bash
cd ~/ryo-projects/<PROJECT_TO_DEPLOY>/
nano configuration/configuration_<HOST_NAME>.yml
```

Now you are ready to run the project's automation scrips to fetch additional modules, complete the setup of the host server, build images and deploy the project.

{{< highlight "info" "Multiple project deployments">}}

A control node can be used to manage multiple deployments of the same project on different host servers (so that, for example, different host servers can be used for different domains). To enable this, the project configuration is always stored in a file called `configuration_<HOST_NAME>.yml`. Each configuration file in the project's configuration directory corresponds to the deployment of the project on a different host.

{{< /highlight >}}

## Running the automation scripts

All further steps are done using the automation scripts in the project's directory that was cloned to the control machine from the project's repository.

Log in to the control node, enter the project's directory and run the `deploy.sh` script. The host name for the project's deployment and a version stamp for the images (for example, the date) need to be passed to the script using the flags `-n` and `-v`:

```bash
cd ~/ryo-projects/<PROJECT_TO_DEPLOY>/
./deploy.sh -n <HOST_NAME> -v <VERSION>
```

The script will ask whether this is the first project to be deployed on the host. If so, this **must** be answered with `y` (which is the default) so that all required modules will also be deployed. If, however, this is not the first project deployed on this host, then answer `n`.

{{< highlight "warning" "Other projects already deployed?">}}

Modules are deployed once and re-used by multiple projects on a host.

In case other projects have already been deployed to the host, then the `deploy.sh` script will ask whether each module that is required by the new project needs to be deployed. Check with the [documentation for previously-deployed projects](/rollyourown/projects/) whether a module has already been deployed and, if so, answer `n` for the deployment of this module for the new project.

{{< /highlight >}}

The `deploy.sh` then performs the full deployment of the project, including any necessary modules.

{{< more "secondary">}}

The `deploy.sh` script performs the following tasks:

- Code for host configuration, image building and deployment for any modules required by the project is fetched from [rollyourown module](/rollyourown/project_modules/) repositories
- The host server is configured with any module-specific settings
- Container images are built on the control node for any modules required by the project and these are uploaded to the host server ready to be deployed
- Module containers are launched on the host server
- The host server is configured with any project-specific settings
- Container images are built on the control node for the project's components and these are uploaded to the host server ready to be deployed
- Project containers are launched on the host server

Further details can be found [here](/collaborate/project_and_module_development/project_structure/#the-deploysh-script).
{{< /more >}}

After the project has been deployed, you are ready to perform any needed project-specific setup and use the components deployed for your project.

## After deployment

Further information on steps to take after deploying and how to use the project are given on the project's page.

Over time, the software packages used for the project deployment need to be kept up to date, as security patches are released for the software or underlying operating systems or when new versions of the software packages are released. The `upgrade.sh` automation script is used to update the project's containers and deployment. More information can be found at ["How to Maintain"](/rollyourown/how_to_use/maintain/).

{{< highlight "warning" "Regular upgrades">}}

A rollyourown project's components are configured with the [unattended-upgrades](https://wiki.debian.org/UnattendedUpgrades) package **disabled**. Our automation method follows the principle of [Immutable Infrastructure](https://www.hashicorp.com/resources/what-is-mutable-vs-immutable-infrastructure), so that a deployed container is exactly and always described by a version of the configuration and infrastructure code. Allowing a deployed component to run automatic upgrades, changing the version of packages deployed, would violate this principle and may lead to unexpected breakages.

This means that, after deployment, the `upgrade.sh` automation script should be run from time to time to keep the deployed components up to date.

{{< /highlight >}}
