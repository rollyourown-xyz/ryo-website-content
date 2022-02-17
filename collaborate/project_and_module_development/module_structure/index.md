---
title: "Module Structure"
weight: 3
tags: [ ]
draft: false
---

A rollyourown.xyz module has a defined structure and every rollyourown.xyz module is structured in the same way. The structure is provided by the [module template repository](https://git.rollyourown.xyz/ryo-projects/ryo-module-template) and the template [can be forked](/collaborate/working_with_git/forking_and_pull_requests/#forking) to form the basis of a [new rollyourown.xyz module](/collaborate/project_and_module_development).

The rollyourown.xyz module template repository is mirrored [on Codeberg](https://codeberg.org/rollyourown-xyz/ryo-module-template) and [on GitHub](https://github.com/rollyourown-xyz/ryo-module-template).

<!--more-->

## Module directory structure

A rollyourown.xyz module is structured in the following top-level directories and scripts:

```console
module_id
├─ backup-restore
│   └─ ...
├─ configuration
│   └─ ...
├─ host-setup
│   └─ ...
├─ image-build
│   └─ ...
├─ module-deployment
│   └─ ...
├─ scripts-module
│   └─ ...
├─ CONTRIBUTING.md
├─ LICENSE
├─ README.md
├─ SECURITY.md
├─ backup.sh
├─ deploy.sh
├─ restore.sh
└─ upgrade.sh
```

## The module_id

The `module_id` is a unique name for a rollyourown.xyz module and is also the name of the module repository on the rollyourown.xyz Git server and on the rollyourown.xyz [Codeberg](https://codeberg.org/rollyourown-xyz) and [Github](https://github.com/rollyourown-xyz) mirrors.

The `module_id` is always of the form `ryo-<NAME>` where `<NAME>` usually identifies the open source software to be deployed.

The `module_id` is also added as the default value to the module's [configuration template](/collaborate/module_structure/#the-configuration-directory).

## Licence and information

The top-level directory of a rollyourown.xyz module includes a `LICENSE`, `CONTRIBUTING.md`, `README.md` and `SECURITY.md` file:

- LICENSE: Describes the licence under which the code in the repository may be copied or used. Only [open source](https://opensource.org/osd) licences (e.g. the [MIT](https://opensource.org/licenses/MIT) licence) may be used for a rollyourown.xyz module
- CONTRIBUTING.md: Provides information on how to collaborate on the module
- README.md: Provides a high-level description of the module and how to use it
- SECURITY.md: Provides information on how to report security vulnerabilities in the module

## Top-level scripts

The top-level directory of a rollyourown.xyz module includes a number of scripts to deploy, upgrade, back up and restore the module:

```console
├─ backup.sh
├─ deploy.sh
├─ restore.sh
└─ upgrade.sh
```

### The `deploy.sh` script

The `deploy.sh` script automates the deployment of the module. The script builds and deploys the containers for the module by running the `host-setup.sh`, `build-images.sh` and `deploy-module.sh` scripts from the [/scripts-module directory](#the-scripts-module-directory).

### The `upgrade.sh` script

The `upgrade.sh` script automates the maintenance of the project module, specifically the upgrade of module containers. The script builds and deploys new containers for the module by calling the `build-images.sh` and `deploy-module.sh` scripts in the [/scripts-module directory](#the-scripts-module-directory).

### The `backup.sh` script

The `backup.sh` script automates the backup of a module, specifically the backup of module persistent data:

- The script calls the `stop-module-containers.sh` script in the [/scripts-module directory](#the-scripts-module-directory) to stop the module's containers
- The script then calls the `backup-module.sh` script in the [/scripts-module directory](#the-scripts-module-directory) to perform the backup
- Finally, the script calls the `start-module-containers.sh` script in the [/scripts-module directory](#the-scripts-module-directory) to restart the module's containers

### The `restore.sh` script

The `restore.sh` script automates the restoration of a module from a backup, specifically restoring the module persistent data:

- The script calls the `stop-module-containers.sh` script in the [/scripts-module directory](#the-scripts-module-directory) to stop the module's containers
- The script then calls the `restore-module.sh` script in the [/scripts-module directory](#the-scripts-module-directory) to perform the restoration
- Finally, the script calls the `start-module-containers.sh` script in the [/scripts-module directory](#the-scripts-module-directory) to restart the module's containers

{{< highlight "warning" "User interaction">}}

Due to the destructive nature of restoring a project, the user is asked multiple times to confirm that the restoration should take place and is also asked to confirm which backup to use.

{{< /highlight >}}

## The configuration directory

```console
¦
├─ configuration
¦   └─ configuration.yml
```

The `configuration` directory contains a template configuration file for the module. In addition to the `module_id`, this [YAML](https://en.wikipedia.org/wiki/YAML) file includes any module-specific configuration parameters that need to be set.

## The host-setup directory

```console
├─ host-setup
│   ├─ roles
│   │   ├─ ansible-role
│   │   ├─ ansible-role
│   │   └─ ...
│   ├─ ansible-playbook.yml
│   ├─ ansible-playbook.yml
│   ├─ ...
¦   └─ main.yml
```

The `host-setup` directory contains [Ansible](https://www.ansible.com/) playbooks for configuring the [host server](/rollyourown/projects/host_server/) for module deployment. Generic host service configuration is done during the host setup step of a project deployment, but additional configuration may be needed (creating host directories for mounting to module containers, for example).

## The image-build directory

```console
├─ image-build
│   ├─ playbooks
│   │   ├─ roles
│   │   │   ├─ ansible-role
│   │   │   ├─ ansible-role
│   │   │   └─ ...
│   │   ├─ inventory.yml
│   │   ├─ ansible-playbook.yml
│   │   ├─ ansible-playbook.yml
│   │   └─ ...
│   ├─ packer-template.pkr.hcl
│   ├─ packer-template.pkr.hcl
¦   └─ ...
```

The `image-build` directory contains [Packer](https://www.packer.io/) templates and [Ansible](https://www.ansible.com/) playbooks for building container images to be deployed on the host server.

## The module-deployment directory

```console
├─ module-deployment
│   ├─ cloud-init
│   │   ├─ cloud-init-file.yml
│   │   ├─ cloud-init-file.yml
│   │   └─ ...
│   ├─ modules
│   │   ├─ terraform-module
│   │   ├─ terraform-module
│   │   └─ ...
│   ├─ terraform-file.tf
│   ├─ terraform-file.tf
¦   └─ ...
```

The `module-deployment` directory contains the [Terraform](https://www.terraform.io/) code to deploy the module on the host server and [cloud-init](https://cloud-init.io/) files for providing boot-time commands to container instances, if necessary. In addition, Terraform modules are provided to simplify the use of the module in a rollyourown.xyz project deployment.

## The backup-restore directory

```console
├─ backup-restore
¦  └─ backup-module.yml
¦  └─ delete-module-persistent-storage.yml
¦  └─ restore-module.yml
```

The `backup-restore` directory contains three [Ansible](https://www.ansible.com/) playbooks used in backup and restore procedures:

- `backup-module.yml` archives the persistent storage for the module on the host server
- `delete-module-persistent-storage.yml` deletes the persistent storage for the module on the host server
- `restore-module.yml` uploads a backup of the persistent storage for the module to the host server and unarchives it into place

## The scripts-module directory

```console
├─ scripts-modules
│   ├─ backup-module.sh
│   ├─ build-images.sh
│   ├─ delete-module-containers.sh
│   ├─ delete-terraform-state.sh
│   ├─ deploy-module.sh
│   ├─ host-setup.sh
│   ├─ restore-module.sh
│   ├─ start-module-containers.sh
¦   └─ stop-module-containers.sh
```

The `deploy.sh`, `upgrade.sh`, `backup.sh` and `restore.sh` scripts call these scripts, which do not need to be changed for a specific project. The project user will not normally need to interact directly with these scripts, but they are useful during project development to run parts of the automation.

### The `host-setup.sh` script

This script typically does not need to be modified for the specific module.

Generic host setup and configuration has already been done by the `host-setup.sh` script in the [host server](rollyourown/project_modules/host_server/) repository.

Additional host configuration is performed for the individual module by the `host-setup.sh` script in the module's repository. This usually consists of setting up directories on the host server to provide persistent storage for the module's containers to enable component configuration and data to persist across container re-starts and replacements. Additional host setup steps may be needed, depending on the module.

The `host-setup-project.sh` script executes Ansible playbooks in the [/host-setup directory](#the-host-setup-directory) to perform additional host configuration for the individual project.

### The `build-images.sh` script

This script **will need to be modified** for the specific module.

The `build-images.sh` script calls [Packer](https://www.packer.io/) to create an image for each of the module's components and upload them to the host server ready to be deployed in the `deploy-module.sh` script. A version stamp (e.g. 20210301) needs to be passed to the `build-images.sh` script, which will be used in the name of each image created and uploaded and which will be used in the `deploy-module.sh` script to launch the correct container image version and later to upgrade containers in-life.

For each image to be built, [Packer](https://www.packer.io/) uses [LXD](https://linuxcontainers.org/lxd/) to launch a base container on the control node (using an [ubuntu-minimal](https://wiki.ubuntu.com/Minimal) cloud image), executes a component-specific [Ansible](https://www.ansible.com/) playbook to provision the container with the necessary software and configuration, and then creates a container image from the fully provisioned container. Finally, packer triggers LXD to upload the container image to the remote host server ready for deployment.

### The `deploy-module.sh` script

This script typically does not need to be modified for the specific module.

The `deploy-module.sh` script uses [Terraform](https://www.terraform.io/) and the [Terraform LXD Provider](https://registry.terraform.io/providers/terraform-lxd/lxd/) to launch the module's containers on the host machine. The version stamp provided to the `build-images.sh` script also needs to be provided to the `deploy-module.sh` script so that Terraform can identify the container images to launch.

The `deploy-module.sh` script is called by the `deploy-module.sh` script of a project that uses the module.

Component containers are launched as specified in the Terraform configuration. Terraform reads the current state on the host machine and makes changes to bring the host machine into the desired state. On the first execution of the `deploy-module.sh` script, no resources have been deployed to the host machine so that Terraform deploys the entire module. On a later execution, changes are only made where necessary (e.g. to upgrade a container to a newer version, built in a later build-images step).

### The `stop-module-containers.sh` script

This script will need to modified for a particular module and stops each module container in turn. The script is used during backup and restore procedures and should otherwise never be needed.

### The `start-module-containers.sh` script

This script will need to modified for a particular module and starts each module container in turn. The script is used during backup and restore procedures and should otherwise never be needed.

### The `delete-module-containers.sh` script

This script will need to modified for a particular module and stops and deletes a module's containers. The script also deletes the module container persistent storage. This script is used only in a restore process and should otherwise never be used.

### The `delete-terraform-state.sh` script

The script deletes the terraform state for the module on the control-node, so that a new deployment can be started from scratch. This script is used only in a restore process during disaster recovery and should otherwise never be used.

### The `backup-module.sh` script

This script calls the `backup-module.yml` [Ansible](https://www.ansible.com/) playbook in the [/backup-restore directory](#the-backup-restore-directory) to back up module container persistent storage to the control node. This script is used in a backup process and should otherwise never be used.

### The `restore-module.sh` script

This script calls the `restore-module.yml` [Ansible](https://www.ansible.com/) playbook in the [/backup-restore directory](#the-backup-restore-directory) to copy a backup from the control node to a host server and restore the module container persistent storage. This script is used in a backup process and should otherwise never be used.
