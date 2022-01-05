---
title: "Project Structure"
weight: 2
tags: [ ]
draft: true
---

A rollyourown.xyz project has a defined, modular structure and every rollyourown.xyz project is structured in the same way. The structure is provided by the [project template repository](https://git.rollyourown.xyz/ryo-projects/ryo-project-template) and the template [can be forked to form the basis of a new rollyourown.xyz project](/LINK/TO/WORKFLOW/DESCRIPTION).

<!--more-->

## Project directory structure

A rollyourown.xyz project is structured with the following top-level directories and scripts:

```console
project_id
|-- configuration
|   |-- ...
|-- host-setup
|   |-- ...
|-- image-build
|   |-- ...
|-- project-deployment
|   |-- ...
|-- scripts-modules
|   |-- ...
|-- scripts-project
|   |-- ...
|-- backup.sh (**TODO**)
|-- deploy.sh
|-- LICENSE
|-- README.md
|-- upgrade.sh
```

## The project_id

The `project_id` is a unique name for a rollyourown.xyz project and is also the name of the project repository on the rollyourown.xyz [Gitea server](https://git.rollyourown.xyz/ryo-projects) and on the rollyourown.xyz [Github mirror](https://github.com/rollyourown-xyz).

The `project_id` is always of the form `ryo-<NAME>` where `<NAME>` usually identifies the open source software to be deployed and, if relevant, the variation of the project (for example, `ryo-nextcloud-standalone` or `ryo-gitea-with-sso`).

The `project_id` is also added to the project's [configuration template](/collaborate/project_structure/#the-configuration-directory) and `deploy.sh` script.

## Licence and Readme

The top-level directory of a rollyourown.xyz project includes a `LICENSE` and `README.md` file:

- LICENSE: Describes the licence under which the code in the repository may be copied or used. Only [open source](https://opensource.org/osd) licences (e.g. the [MIT](https://opensource.org/licenses/MIT) licence) may be used for a rollyourown.xyz project
- README.md: Provides a high-level description of the project and how to use it

## The `deploy.sh` script

The top-level directory of a rollyourown.xyz project includes a script `deploy.sh` for the user to execute in order to [deploy the project](/rollyourown/projects/how_to_deploy/).

Only the variables `PROJECT_ID` and `MODULES` in the `deploy.sh` script need to be modified for a specific project.

- The `PROJECT_ID` variable should be set as described [above](#the-project_id)
- The `MODULES` variable should be set to a space-separated list of all the modules that are required to be deployed for the project - e.g. in the form "module_1 module_2 module_3"

The `deploy.sh` script manages any modules required by the project, and builds and deploys the containers for the project itself.

If the user selects `y` to include module deployment, then the `deploy.sh` script calls the four scripts in the [`/scripts-modules` directory](#the-scripts-modules-directory) to manage host setup, image build and deployment for any modules included in the project. These scripts are executed before the project's images and built and deployed.

After (optional) module management, the `deploy.sh` script calls the three scripts in the [`/scripts-project` directory](#the-scripts-project-directory) to perform project-specific host setup, image build and deployment.

## The `upgrade.sh` script

The top-level directory of a rollyourown.xyz project includes a script `upgrade.sh` for the user to execute in order to [maintain the project](/rollyourown/projects/how_to_maintain/).

Only the variables `PROJECT_ID` and `MODULES` in the `upgrade.sh` script need to be modified for a specific project, in the same way as for the [`deploy.sh` script](#the-deploysh-script).

- The `PROJECT_ID` variable should be set as described [above](#the-project_id)
- The `MODULES` variable should be set to a space-separated list of all the modules that are deployed for the project - e.g. in the form "module_1 module_2 module_3"

The `upgrade.sh` script (optionally) manages the upgrade of any modules used by the project, and builds and deploys new containers for the project.

For each module used in the project, the user is asked whether the module should also be upgraded. If the user selects `y` to upgrade a module, then the `upgrade.sh` script calls scripts in the [`/scripts-modules` directory](#the-scripts-modules-directory) to manage image build and deployment for the module. Modules are upgraded before the project's components are upgraded.

After (optional) module upgrades, the `upgrade.sh` script calls scripts in the [`/scripts-project` directory](#the-scripts-project-directory) to perform project-specific image build and deployment.

## The `backup.sh` script

!!!TODO!!!

## The configuration directory

```console
|-- configuration
|   |-- configuration_TEMPLATE.yml
```

The `configuration` directory contains a template configuration file for the project. In addition to the `project_id`, this [YAML](https://en.wikipedia.org/wiki/YAML) file includes any configuration parameters that the end-user of a project can set (such as the domain name or an administrator username).

## The host-setup directory

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

The `host-setup` directory contains [Ansible](https://www.ansible.com/) playbooks for configuring the [host server](/rollyourown/projects/host_server/) for project deployment. Generic host service configuration is done during the host setup step of project deployment, but additional configuration may be needed (creating host directories for mounting to project containers, for example).

## The image-build directory

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

## The project-deployment directory

```console
|-- project-deployment
|   |-- cloud-init
|   |   |-- cloud-init-file.yml
|   |   |-- cloud-init-file.yml
|   |   |-- ...
|   |-- terraform-file.tf
|   |-- terraform-file.tf
|   |-- ...
```

The `project-deployment` directory contains the [Terraform](https://www.terraform.io/) code to deploy the project on the host server and [cloud-init](https://cloud-init.io/) files for providing boot-time commands to container instances, if necessary.

## The scripts-modules directory

```console
|-- scripts-modules
|   |-- build-image-module.sh
|   |-- deploy-module.sh
|   |-- get-module.sh
|   |-- host-setup-module.sh
```

The `deploy.sh` script calls these scripts in turn for each of the modules defined in the variable `MODULES`. These scripts do not need to be changed in a specific project.

### The `get-module.sh` script

The `get-module.sh` script clones (or updates) the module's dedicated [rollyourown.xyz](https://rollyourown.xyz) repository.

### The `host-setup-module.sh` script

The `host-setup-module.sh` script calls the `host-setup.sh` script [for the module](/collaborate/module_structure/#the-host-setupsh-script).

### The `build-image-module.sh` script

The `build-image-module.sh` script calls the `build-images.sh` script [for the module](/collaborate/module_structure/#the-build-imagessh-script).

### The `deploy-module.sh` script

The `deploy-module.sh` script calls the `deploy-module.sh` script [for the module](/collaborate/module_structure/#the-deploy-modulesh-script).

## The scripts-project directory

```console
|-- scripts-project
|   |-- build-images-project.sh
|   |-- deploy-project.sh
|   |-- host-setup-project.sh
```

The `deploy.sh` script calls these scripts, which may need to be modified for the specific project. These scripts are useful during project development, but the project user will not normally need to interact directly with the scripts.

### The `host-setup-project.sh` script

This script typically does not need to be modified for the specific project.

Generic host setup and configuration has already been done by the `host-setup.sh` script in the [host server](rollyourown/project_modules/host_server/) [repository](https://github.com/rollyourown-xyz/ryo-host).

The `host-setup-project.sh` script executes Ansible playbooks in the [/host-setup directory](#the-host-setup-directory) to perform additional host configuration for the individual project. This usually consists of setting up directories on the host server to provide persistent storage for the project's containers to enable component configuration and data to persist across container re-starts and replacements. Additional host setup steps may be needed, depending on the project.

### The `build-images-project.sh` script

This script **will need to be modified** for the specific project.

The `build-images-project.sh` script calls [Packer](https://www.packer.io/) to build an image for each of the project's components and upload them to the host server ready to be deployed in the `deploy-project.sh` script. The version stamp (e.g. 20210301) passed to the `deploy-sh` script is passed to the `build-images-project.sh` script, which is used in the name of each image created and uploaded and which will be used in the `deploy-project.sh` script to launch the correct container image version.

For each image to be built, [Packer](https://www.packer.io/) uses [LXD](https://linuxcontainers.org/lxd/) to launch a base container on the control node (using an [ubuntu-minimal](https://wiki.ubuntu.com/Minimal) cloud image), executes a component-specific [Ansible](https://www.ansible.com/) playbook to provision the container with the necessary software and configuration, and then creates a container image from the fully provisioned container. Finally, packer triggers LXD to upload the container image to the remote host server ready for deployment.

### The `deploy-project.sh` script

This script typically does not need to be modified for the specific project.

The `deploy-project.sh` script uses [Terraform](https://www.terraform.io/) and the [Terraform LXD Provider](https://registry.terraform.io/providers/terraform-lxd/lxd/) to launch the project's containers on the host machine. The version stamp provided to the `build-images.sh` script also needs to be provided to the `deploy-project.sh` script so that Terraform can identify the container images to launch.

Component containers are launched as specified in the Terraform configuration. Terraform reads the current state on the host machine and makes changes to bring the host machine into the desired state. On the first execution of the `deploy-project.sh` script, no resources have been deployed to the host machine so that Terraform deploys the entire project. On a later execution, changes are only made where necessary (e.g. to upgrade a container to a newer version, built in a later build-images step).
