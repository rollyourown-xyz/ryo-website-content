---
title: "Module Structure"
tags: [ ]
draft: true
---

A rollyourown.xyz module has a defined structure and every rollyourown.xyz module is structured in the same way. The structure is provided by the [project module repository](https://git.rollyourown.xyz/ryo-projects/ryo-module-template) and the template [can be forked to form the basis of a new rollyourown.xyz module](/LINK/TO/WORKFLOW/DESCRIPTION).

<!--more-->

## Module directory structure

A rollyourown.xyz module is structured in the following top-level directories and scripts:

```console
module_id
|-- configuration
|   |-- ...
|-- host-setup
|   |-- ...
|-- image-build
|   |-- ...
|-- module-deployment
|   |-- ...
|-- build-images.sh
|-- deploy-project.sh
|-- host-setup.sh
|-- LICENSE
|-- README.md
```

## The module_id

The `module_id` is a unique name for a rollyourown.xyz module and is also the name of the module repository on the rollyourown.xyz [Gitea server](https://git.rollyourown.xyz/ryo-projects) and on the rollyourown.xyz [Github mirror](https://github.com/rollyourown-xyz).

The `module_id` is always of the form `ryo-<NAME>` where `<NAME>` usually identifies the open source software to be deployed.

The `module_id` is also added to the module's [configuration template](/collaborate/module_structure/#the-configuration-directory).

## Licence and Readme

The top-level directory of a rollyourown.xyz module includes a `LICENSE` and `README.md` file:

- LICENSE: Describes the licence under which the code in the repository may be copied or used. Only [open source](https://opensource.org/osd) licences (e.g. the [MIT](https://opensource.org/licenses/MIT) licence) may be used for a rollyourown.xyz module
- README.md: Provides a high-level description of the module and how to use it

## Scripts

The top-level directory of a rollyourown.xyz module includes three scripts for [deploying the module](/rollyourown/projects/how_to_deploy/):

- host-setup.sh: Performs module-specific configuration of the host server
- build-images.sh: Creates an image for each of the module’s components
- deploy-module.sh: Launches the module's containers and provides configuration parameters to the environment

### The `host-setup.sh` script

Generic host setup and configuration has already been done by the `host-setup.sh` script in the [host server](rollyourown/project_modules/host_server/) [repository](https://github.com/rollyourown-xyz/ryo-host). Additional host configuration is performed for the individual module by the `host-setup.sh` script in the module's repository. This usually consists of setting up directories on the host server to provide persistent storage for the module's containers to enable component configuration and data to persist across container re-starts and replacements. Additional host setup steps may be needed, depending on the module.

The `host-setup.sh` script is called by the `host-setup.sh` script of a project that uses the module.

### The `build-images.sh` script

The `build-images.sh` script calls [Packer](https://www.packer.io/) to create an image for each of the module's components and upload them to the host server ready to be deployed in the `deploy-module.sh` script. A version stamp (e.g. 20210301) needs to be passed to the `build-images.sh` script, which will be used in the name of each image created and uploaded and which will be used in the `deploy-module.sh` script to launch the correct container image version and later to upgrade containers in-life.

The `build-images.sh` script is called by the `build-images.sh` script of a project that uses the module.

For each image to be built, [Packer](https://www.packer.io/) uses [LXD](https://linuxcontainers.org/lxd/) to launch a base container on the control node (using an [ubuntu-minimal](https://wiki.ubuntu.com/Minimal) cloud image), executes a component-specific [Ansible](https://www.ansible.com/) playbook to provision the container with the necessary software and configuration, and then creates a container image from the fully provisioned container. Finally, packer triggers LXD to upload the container image to the remote host server ready for deployment.

### The `deploy-module.sh` script

The `deploy-module.sh` script uses [Terraform](https://www.terraform.io/) and the [Terraform LXD Provider](https://registry.terraform.io/providers/terraform-lxd/lxd/) to launch the module's containers on the host machine. The version stamp provided to the `build-images.sh` script also needs to be provided to the `deploy-module.sh` script so that Terraform can identify the container images to launch.

The `deploy-module.sh` script is called by the `deploy-project.sh` script of a project that uses the module.

Component containers are launched as specified in the Terraform configuration. Terraform reads the current state on the host machine and makes changes to bring the host machine into the desired state. On the first execution of the `deploy-module.sh` script, no resources have been deployed to the host machine so that Terraform deploys the entire project. On a later execution, changes are only made where necessary (e.g. to upgrade a container to a newer version, built in a later build-images step).

## Directories

### The configuration directory

```console
|-- configuration
|   |-- configuration.yml
```

The `configuration` directory contains a template configuration file for the module. In addition to the `module_id`, this [YAML](https://en.wikipedia.org/wiki/YAML) file includes any module-specific configuration parameters that need to be set.

### The host-setup directory

```console
|-- host-setup
|   |-- roles
|   |   |-- ansible-role
|   |   |-- ansible-role
|   |   |-- ...
|   |-- ansible-playbook.yml
|   |-- ansible-playbook.yml
|   |-- ...
|   |-- main.yml
```

The `host-setup` directory contains [Ansible](https://www.ansible.com/) playbooks for configuring the [host server](/rollyourown/projects/host_server/) for module deployment. Generic host service configuration is done during the host setup step of a project deployment, but additional configuration may be needed (creating host directories for mounting to module containers, for example).

### The image-build directory

```console
|-- image-build
|   |-- playbooks
|   |   |-- roles
|   |   |   |-- ansible-role
|   |   |   |-- ansible-role
|   |   |   |-- ...
|   |   |-- inventory.yml
|   |   |-- ansible-playbook.yml
|   |   |-- ansible-playbook.yml
|   |   |-- ...
|   |-- packer-template.pkr.hcl
|   |-- packer-template.pkr.hcl
|   |-- ...
```

The `image-build` directory contains [Packer](https://www.packer.io/) templates and [Ansible](https://www.ansible.com/) playbooks for building container images to be deployed on the host server.

### The module-deployment directory

```console
|-- module-deployment
|   |-- cloud-init
|   |   |-- cloud-init-file.yml
|   |   |-- cloud-init-file.yml
|   |   |-- ...
|   |-- modules
|   |   |-- terraform-module
|   |   |-- terraform-module
|   |-- terraform-file.tf
|   |-- terraform-file.tf
|   |-- ...
```

The `module-deployment` directory contains the [Terraform](https://www.terraform.io/) code to deploy the module on the host server and [cloud-init](https://cloud-init.io/) files for providing boot-time commands to container instances, if necessary. In addition, Terraform modules are provided to simplify the use of the module in a rollyourown.xyz project deployment.
