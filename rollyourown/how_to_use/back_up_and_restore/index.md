---
title: "How to Back Up and Restore"
weight: 3
tags: [ ]
draft: false
---
<!--
SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
SPDX-License-Identifier: CC-BY-SA-4.0
-->

The rollyourown [host server](/rollyourown/how_to_use/host_server) repository includes automation scripts for backing up and restoring all projects and modules deployed to a host server.

The rollyourown [project repositories](/rollyourown/projects/) include automation scripts for backing up and restoring an individual project and its modules.

It is recommended to regularly back up your project and module data from a host server.

<!--more-->

## Introduction

Each rollyourown project and module deploys various containers to a [host server](/rollyourown/how_to_use/host_server). The containers are *ephemeral*, which means that their filesystem is destroyed whenever the container is destroyed. Persistent data (for example configuration files, a user's media files or databases) are stored in directories on the host server that are mounted in a container when the container is launched from an image. This means that only the persistent storage directories from the host server need to be backed up and containers can be restored simply by building new container images, deploying them to the host server and then restoring their persistent data from a backup.

{{< highlight "danger" "Regular backups">}}

Although server failures are uncommon, they cannot be discounted altogether. It is recommended to back up your host servers regularly in case of disaster and loss of your host server.

Backing up a project or the entire host server before [upgrading a project](/rollyourown/how_to_use/maintain/#upgrading-a-project-deployment) is also recommended.

Your hosting provider may offer a backup service for your host server. You may prefer to also use this service to back up and restore your rollyourown projects. However, we recommend also backing up your projects and modules using the project or host server automation scripts.

{{< /highlight >}}

## How to back up

### How to back up a host server

A host server backup will back up the persistent storage of all projects and modules deployed on the host server.

To back up a host server, log in to the [control node](/rollyourown/how_to_use/control_node) and run the `host-backup.sh` script from the `/ryo-projects/ryo-host` directory (or the directory you chose during [control node setup](/rollyourown/how_to_use/control_node/#automated-control-node-configuration)). As input parameters, specify the name of the host server and a "stamp" to identify the backup (for example, a date and time stamp such as 20220107-1835):

```bash
cd ~/ryo-projects/ryo-host/
./host-backup.sh -n <HOSTNAME> -s <STAMP>
```

The `host-backup.sh` script offers the ability to back up all projects and modules in one go, or back up individual projects or modules. Generally, the `host-backup.sh` script performs the following steps:

- Stops all containers (from all projects and modules deployed to the host server or for the chosen project or module)
- Archives the persistent data directories for each project and module and copies the archives to the control node
- Restarts all containers (from all projects and modules deployed to the host or for the chosen project or module)

Depending on the data stored in your projects, the archiving and copying procedure may take some time and the services running on the host server will not be available during this time.

### How to back up an individual project

A project backup will back up the persistent storage of a project and its modules.

To back up a project, log in to the [control node](/rollyourown/how_to_use/control_node) and run the `backup.sh` script from the project's directory. As input parameters, specify the name of the host server and a "stamp" to identify the backup (for example, a date and time stamp such as 20220107-1835):

```bash
cd ~/ryo-projects/<PROJECT_NAME>/
./backup.sh -n <HOSTNAME> -s <STAMP>
```

The `backup.sh` script offers the ability to back up the projects and all its modules in one go, or select modules to back up individually. Generally, the `backup.sh` script performs the following steps:

- Stops all containers (from the project and all modules, or for the project and the selected modules)
- Archives the persistent data directories for the project and modules and copies the archives to the control node
- Restarts all containers (from the project and all modules, or for the project and the selected modules)

Depending on the data stored in your projects, the archiving and copying procedure may take some time and the associated services running on the host server will not be available during this time.

## How to restore

### How to restore a host server

The restoration of a host server is usually only needed after either a failure of the host server or to move all projects / modules from one host server to another -- e.g. if moving to a different hosting provider or moving projects to a server with higher resources (if your provider does not allow an upgrade in place).

{{< highlight "danger" "Only restore to a freshly set-up host server with no projects deployed">}}

A restore should not be carried out on a host server with functioning projects!

A restore should normally only be carried out on a newly-configured host server. A restore will re-deploy all project and module components on the host server, with a previous state from a backup. If the host server is currently in a working state, then the current state will be lost and may not be able to be recovered.

{{< /highlight >}}

If a host server has failed or projects are to be moved to a new host server, then the first step of the restoration procedure is to set up a new host server from scratch, with the [same procedure](/rollyourown/how_to_use/host_server/#automated-host-server-setup) followed as when setting up the host server in the first place. The new host server should have **the same name as the host server from which the backup was made**.

If the public IP address of the host server has changed, then the host server's configuration file will need to be updated with the new IP address in `/ryo-projects/ryo-host/configuration/configuration_<HOST NAME>.yml` and `/ryo-projects/ryo-host/configuration/inventory_<HOST NAME>`.

Once the host server is set up, then the restoration is carried our by running the `host-restore.sh` script, providing the name of the host and the "stamp" (e.g. date, time) identifying the backup to restore.

```bash
./host-restore.sh -n <HOST NAME> -s <BACKUP STAMP>
```

{{< highlight "warning" >}}

Backups are stored in `/ryo-projects/ryo-host/backup-restore/backups` on the control-node.

{{< /highlight >}}

If the backup stamps are different for different projects to be restored, then **do not** select 'y' when asked whether to restore **ALL** projects and modules. Instead, select 'n', in which case you will be asked per project for the stamp for the individual backups to use for restoring.

Since a restore is destructive and will delete the persistent storage of any projects and modules already running on the host, you will be asked to confirm the restore process multiple times and confirm the "stamp" for the backup to restore.

If all projects and modules are to be restored, then the `host-restore.sh` script will now:

- Build new images and deploy the module and project components previously deployed to the host server in a "fresh" state
- Stop all containers on the host server
- Copy the backup archives to the host server and unpack them to the persistent data directories for each project and module
- Start all containers on the host server

If individual projects are selected, then the `host-restore.sh` script will use the [individual restore scripts](/rollyourown/how_to_use/back_up_and_restore/#how-to-restore-an-individual-project) for each project.

After this process has completed, the services on the host server should be running.

### How to restore an individual project

To restore an individual project, for example after a failed upgrade, use the `restore.sh` script in the individual project's repository. These scripts provide a restoration of a project with all its modules, or a restoration of the project with only selected modules.

{{< highlight "danger" "Restoring modules shared by multiple projects">}}

If a project uses a module that is shared with another project, then the restoration of a module may impact the other project(s) using it by, for example, replacing database content with previous content.

For this reason, it is recommended to always back up **all** the projects sharing a module on a host server before upgrading any one of those projects, so that if a module needs to be restored, then the module's backup contains recent data for all projects using it.

{{< /highlight >}}

If you need to restore a project, then the restoration is carried our by running the `restore.sh` script from the project's directory, providing the name of the host and the "stamp" (e.g. date, time) identifying the backup to restore.

```bash
./restore.sh -n <HOST NAME> -s <BACKUP STAMP>
```

{{< highlight "warning" >}}

Backups are stored in `/ryo-projects/ryo-host/backup-restore/backups` on the control-node.

{{< /highlight >}}

If the backup stamps are different for one or modules to be restored, then **do not** select 'y' when asked whether to restore all modules. Instead, select 'n', in which case you will be asked per module whether to restore the module and for the stamp for the individual backup to use for restoring.

Since a restore is destructive and will delete the persistent storage of the project and any selected modules, you will be asked to confirm the restore process multiple times and confirm the "stamp" for the backup to restore.

For the project and the selected modules to be restored, the `restore.sh` script will now:

- Stop the containers for the project or module
- Delete the persistent storage for the project or module on the host server
- Copy the relevant backup archives to the host server and unpack them to the persistent data directories for the project or module
- Start the containers for the project or module

After this process has completed, the applicable services on the host server should be running again.
