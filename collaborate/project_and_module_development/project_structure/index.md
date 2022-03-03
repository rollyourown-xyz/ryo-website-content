---
title: "Project Structure"
weight: 2
tags: [ ]
draft: false
---
<!-- SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz> -->
<!-- SPDX-License-Identifier: CC-BY-SA-4.0 -->

A rollyourown.xyz project has a defined, modular structure and every rollyourown.xyz project is structured in the same way. The structure is provided by the [project template repository](https://git.rollyourown.xyz/ryo-projects/ryo-project-template) and the template [can be forked](/collaborate/working_with_git/forking_and_pull_requests/#forking) to form the basis of a [new rollyourown.xyz project](/collaborate/project_and_module_development).

The rollyourown.xyz project template repository is mirrored [on Codeberg](https://codeberg.org/rollyourown-xyz/ryo-project-template) and [on GitHub](https://github.com/rollyourown-xyz/ryo-project-template).

<!--more-->

## Project directory structure

A rollyourown.xyz project is structured with the following top-level directories and scripts:

```console
project_id
├─ backup-restore
│   └─ ...
├─ configuration
│   └─ ...
├─ host-setup
│   └─ ...
├─ image-build
│   └─ ...
├─ project-deployment
│   └─ ...
├─ scripts-project
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

## The project_id

The `project_id` is a unique name for a rollyourown.xyz project and is the name of the project repository on the rollyourown.xyz Git server and on the rollyourown.xyz [Codeberg](https://codeberg.org/rollyourown-xyz) and [Github](https://github.com/rollyourown-xyz) mirrors.

The `project_id` is always of the form `ryo-<NAME>` where `<NAME>` usually identifies the open source software or service to be deployed (for example, `ryo-nextcloud` or `ryo-gitea`).

The `project_id` is also added as default value to the project's [configuration template](/collaborate/project_structure/#the-configuration-directory).

## Licence and information

The top-level directory of a rollyourown.xyz project includes a `LICENSE`, `CONTRIBUTING.md`, `README.md` and `SECURITY.md` file:

- LICENSE: Describes the licence under which the code in the repository may be copied or used. Only [open source](https://opensource.org/osd) licences (e.g. the [MIT](https://opensource.org/licenses/MIT) licence) may be used for a rollyourown.xyz project
- CONTRIBUTING.md: Provides information on how to collaborate on the project
- README.md: Provides a high-level description of the project and how to use it
- SECURITY.md: Provides information on how to report security vulnerabilities in the project

## Top-level scripts

The top-level directory of a rollyourown.xyz project includes a number of scripts to deploy, upgrade, back up and restore the project:

```console
├─ backup.sh
├─ deploy.sh
├─ restore.sh
└─ upgrade.sh
```

### The `deploy.sh` script

The `deploy.sh` script automates the [deployment of the project](/rollyourown/how_to_use/deploy/).

Only the variable `MODULES` in the `deploy.sh` script needs to be modified for a specific project and should be set to a space-separated list of all the modules required to be deployed for the project - e.g. in the form "module_1 module_2 module_3"

The `deploy.sh` script manages any modules required by the project, and builds and deploys the containers for the project itself.

If the user selects `y` to include module deployment, then the project's `deploy.sh` script calls the [`deploy.sh` script](/collaborate/project_and_module_development/module_structure/#the-deploysh-script) for each module to be deployed.

After (optional) module deployment, the `deploy.sh` script calls the `host-setup-project.sh`, `build-image-project.sh` and `deploy-project.sh` scripts in the [`/scripts-project` directory](#the-scripts-project-directory) to perform project-specific host setup, image build and deployment.

### The `upgrade.sh` script

The `upgrade.sh` script automates the [maintenance the project](/rollyourown/how_to_use/maintain/), specifically the upgrade of project and (optionally) module containers.

Only the variable `MODULES` in the `upgrade.sh` script needs to be modified for a specific project, in the same way as for the [`deploy.sh` script](#the-deploysh-script). The `MODULES` variable should be set to a space-separated list of all the modules that are deployed for the project - e.g. in the form "module_1 module_2 module_3"

The `upgrade.sh` script (optionally) manages the upgrade of any modules used by the project, and builds and deploys new containers for the project.

For each module used in the project, the user is asked whether the module should also be upgraded. If the user selects `y` to upgrade a module, then the `upgrade.sh` script calls the [`upgrade.sh` script](/collaborate/project_and_module_development/module_structure/#the-upgradesh-script) for the module.

After (optional) module upgrades, the `upgrade.sh` script calls the `build-image-project.sh` and `deploy-project.sh` scripts in the [`/scripts-project` directory](#the-scripts-project-directory) to perform project-specific image build and deployment.

### The `backup.sh` script

The `backup.sh` script automates the [backup of a project](/rollyourown/how_to_use/back_up_and_restore/#how-to-back-up), specifically the backup of project and (optionally) module persistent data.

Only the variable `MODULES` in the `upgrade.sh` script needs to be modified for a specific project, in the same way as for the [`deploy.sh`](#the-deploysh-script) and [`upgrade.sh`](#the-upgradesh-script) scripts. The `MODULES` variable should be set to a space-separated list of all the modules that are deployed for the project - e.g. in the form "module_1 module_2 module_3"

The `backup.sh` script (optionally) manages the backup of any modules used by the project, and backs up the project itself. The first step is to call the `stop-project-containers.sh` script in the [`/scripts-project` directory](#the-scripts-project-directory) to stop the project containers in preparation for backing up.

If the user selects `y` to include module backup, then the project's `backup.sh` script calls the [`backup.sh` script](/collaborate/project_and_module_development/module_structure/#the-backupsh-script) for each module to be deployed.

After (optional) module backup, the `backup.sh` script calls the `backup-project.sh` script in the [`/scripts-project` directory](#the-scripts-project-directory) to perform project-specific backup.

After all backups have been done, the `backup.sh` script calls the `start-project-containers.sh` script in the [`/scripts-project` directory](#the-scripts-project-directory) to restart the project's containers.

{{< highlight "warning" "Backup causes downtime">}}

During the backup procedure, project and (optionally) module containers are stopped, so that persistent data is stable and unchanging during the backup process. As our single-server projects and modules are not (yet) configured as highly-available, this will lead to a short downtime for the services provided by the project.

A backup should therefore be done during quiet times. Informing users in advance that a backup (and short downtime) will be taking place is also recommended.

{{< /highlight >}}

### The `restore.sh` script

The `restore.sh` script automates the [restoration of a project from a backup](/rollyourown/how_to_use/back_up_and_restore/#how-to-back-up), specifically restoring the project and (optionally) module persistent data.

{{< highlight "danger" "Restoration is destructive">}}

A restore should normally only be carried out after a system failure, a failed upgrade or to move projects and modules to a new host server.

The process will **delete** the current persistent storage for the project and (optionally) its modules and replace them with the content of a backup. This will return the project and its modules to a previous state.

**If modules are restored and other projects use the same module, then this may also affect those projects** by, for example, replacing database content with previous content.

For this reason, it is recommended to always back up all the projects sharing a module on a host server before upgrading any one of those projects, so that if a module needs to be restored, then the module’s backup contains recent data for all projects using it.

{{< /highlight >}}

Only the variable `MODULES` in the `restore.sh` script needs to be modified for a specific project, in the same way as for the [`deploy.sh`](#the-deploysh-script), [`upgrade.sh`](#the-upgradesh-script) and [`backup.sh`](#the-backupsh-script) scripts. The `MODULES` variable should be set to a space-separated list of all the modules that are deployed for the project - e.g. in the form "module_1 module_2 module_3"

The `restore.sh` script (optionally) manages the restoration of any modules used by the project, and restores the project itself. The first step is to call the `stop-project-containers.sh` script in the [`/scripts-project` directory](#the-scripts-project-directory) to stop the project containers in preparation for restoration.

{{< highlight "warning" "User interaction">}}

Due to the destructive nature of restoring a project, the user is asked multiple times to confirm that the restoration should take place and is also asked to confirm which backup to use.

{{< /highlight >}}

If the user selects `y` to include restoration of all modules, then the project's `restore.sh` script stops each module container, via the `stop-module-containers.sh` script. The module is then restored via the `restore-module.sh` script and the module's container started again via the `sart-module-containers.sh` script. These scripts are contained in the module's [`/scripts-module` directory](/collaborate/project_and_module_development/module_structure/#the-scripts-module-directory).

If the user selects `n` to include restoration of all modules, then the project's `restore.sh` script asks the user whether to restore each module in turn.

After (optional) module restoration, the `restore.sh` script calls the `restore-project.sh` script in the [`/scripts-project` directory](#the-scripts-project-directory) to perform project-specific restoration.

After all restoration is completed, the `restore.sh` script calls the `start-project-containers.sh` script in the [`/scripts-project` directory](#the-scripts-project-directory) to restart the project's containers.

## The configuration directory

```console
├─ configuration
¦  └─ configuration_TEMPLATE.yml
```

The `configuration` directory contains a template configuration file for the project. In addition to the `project_id`, this [YAML](https://en.wikipedia.org/wiki/YAML) file includes any configuration parameters that the end-user of a project can set (such as the domain name or administrator credentials).

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

The `host-setup` directory contains [Ansible](https://www.ansible.com/) playbooks for configuring the [host server](/rollyourown/projects/host_server/) for project deployment. Generic host service configuration is done during the host setup step of project deployment, but additional configuration may be needed (creating host directories for mounting to project containers, for example).

## The image-build directory

```console
├─ image-build
|  ├─ playbooks
|  |   ├─ roles
|  |   |   ├─ ansible-role
|  |   |   ├─ ansible-role
|  |   |   └─ ...
|  |   ├─ inventory.yml
|  |   ├─ ansible-playbook.yml
|  |   ├─ ansible-playbook.yml
|  |   └─ ...
|  ├─ packer-template.pkr.hcl
|  ├─ packer-template.pkr.hcl
¦  └─ ...
```

The `image-build` directory contains [Packer](https://www.packer.io/) templates and [Ansible](https://www.ansible.com/) playbooks for building container images to be deployed on the host server.

## The project-deployment directory

```console
├─ project-deployment
│   ├─ cloud-init
│   │   ├─ cloud-init-file.yml
│   │   ├─ cloud-init-file.yml
│   │   └─ ...
│   ├─ terraform-file.tf
│   ├─ terraform-file.tf
¦   └─ ...
```

The `project-deployment` directory contains the [Terraform](https://www.terraform.io/) code to deploy the project on the host server and [cloud-init](https://cloud-init.io/) files for providing boot-time commands to container instances, if necessary.

## The backup-restore directory

```console
├─ backup-restore
¦  └─ backup-project.yml
¦  └─ delete-project-persistent-storage.yml
¦  └─ restore-project.yml
```

The `backup-restore` directory contains three [Ansible](https://www.ansible.com/) playbooks used in backup and restore procedures:

- `backup-project.yml` archives the persistent storage for the project on the host server
- `delete-project-persistent-storage.yml` deletes the persistent storage for the project on the host server
- `restore-project.yml` uploads a backup of the persistent storage for the project to the host server and unarchives it into place

## The scripts-project directory

```console
├─ scripts-project
│   ├─ backup-project.sh
│   ├─ build-images-project.sh
│   ├─ delete-project-containers.sh
│   ├─ delete-terraform-state.sh
│   ├─ deploy-project.sh
│   ├─ host-setup-project.sh
│   ├─ restore-project.sh
│   ├─ start-project-containers.sh
¦   └─ stop-project-containers.sh
```

The `deploy.sh`, `upgrade.sh`, `backup.sh` and `restore.sh` scripts call these scripts, which may need to be modified for the specific project. The project user will not normally need to interact directly with these scripts, but they are useful during project development to run parts of the automation.

### The `host-setup-project.sh` script

This script typically does not need to be modified for the specific project.

Generic host setup and configuration has already been done by the `host-setup.sh` script in the [host server](rollyourown/project_modules/host_server/) repository.

The `host-setup-project.sh` script executes Ansible playbooks in the [/host-setup directory](#the-host-setup-directory) to perform additional host configuration for the individual project. This usually consists of setting up directories on the host server to provide persistent storage for the project's containers to enable component configuration and data to persist across container re-starts and replacements. Additional host setup steps may be needed, depending on the project.

### The `build-images-project.sh` script

This script **will need to be modified** for the specific project.

The `build-images-project.sh` script calls [Packer](https://www.packer.io/) to build an image for each of the project's components and upload them to the host server ready to be deployed in the `deploy-project.sh` script. The version stamp (e.g. 20210301) passed to the `deploy-sh` script is passed to the `build-images-project.sh` script, which is used in the name of each image created and uploaded and which will be used in the `deploy-project.sh` script to launch the correct container image version.

For each image to be built, [Packer](https://www.packer.io/) uses [LXD](https://linuxcontainers.org/lxd/) to launch a base container on the control node (using an [ubuntu-minimal](https://wiki.ubuntu.com/Minimal) cloud image), executes a component-specific [Ansible](https://www.ansible.com/) playbook to provision the container with the necessary software and configuration, and then creates a container image from the fully provisioned container. Finally, packer triggers LXD to upload the container image to the remote host server ready for deployment.

### The `deploy-project.sh` script

This script typically does not need to be modified for the specific project.

The `deploy-project.sh` script uses [Terraform](https://www.terraform.io/) and the [Terraform LXD Provider](https://registry.terraform.io/providers/terraform-lxd/lxd/) to launch the project's containers on the host machine. The version stamp provided to the `build-images.sh` script also needs to be provided to the `deploy-project.sh` script so that Terraform can identify the container images to launch.

Component containers are launched as specified in the Terraform configuration. Terraform reads the current state on the host machine and makes changes to bring the host machine into the desired state. On the first execution of the `deploy-project.sh` script, no resources have been deployed to the host machine so that Terraform deploys the entire project. On a later execution, changes are only made where necessary (e.g. to upgrade a container to a newer version, built in a later build-images step).

### The `stop-project-containers.sh` script

This script will need to modified for a particular project and stops each project container in turn. The script is used during backup and restore procedures and should otherwise never be needed.

### The `start-project-containers.sh` script

This script will need to modified for a particular project and starts each project container in turn. The script is used during backup and restore procedures and should otherwise never be needed.

### The `delete-project-containers.sh` script

This script will need to modified for a particular project and stops and deletes a project's containers. The script also deletes the project container persistent storage. This script is used only in a restore process and should otherwise never be used.

### The `delete-terraform-state.sh` script

The script deletes the terraform state for the project on the control-node, so that a new deployment can be started from scratch. This script is used only in a restore process during disaster recovery and should otherwise never be used.

### The `backup-project.sh` script

This script calls the `backup-project.yml` [Ansible](https://www.ansible.com/) playbook in the [/backup-restore directory](#the-backup-restore-directory) to back up project container persistent storage to the control node. This script is used in a backup process and should otherwise never be used.

### The `restore-project.sh` script

This script calls the `restore-project.yml` [Ansible](https://www.ansible.com/) playbook in the [/backup-restore directory](#the-backup-restore-directory) to copy a backup from the control node to a host server and restore the project container persistent storage. This script is used in a backup process and should otherwise never be used.
