---
title: "How to Back Up and Restore"
weight: 3
tags: [ ]
draft: true
---

The rollyourown.xyz [host server](/rollyourown/projects/host_server) repository includes automation scripts for backing up and restoring all projects and modules deployed to a host server. It is recommended to regularly back up the project and module data from a host server.

<!--more-->

## Introduction

Each [rollyourown.xyz](https://rollyourown.xyz) project and module deploys various containers to a [host server](/rollyourown/projects/host_server). The containers are *ephemeral*, which means that their filesystem is destroyed whenever the container is destroyed. Persistent data (for example configuration files, a user's media files or databases) are stored in directories on the host server that are mounted in a container when the container is launched from an image. This means that only the persistent storage directories from the host server need to be backed up and containers can be restored simply by building new container images, deploying them to the host server and then restoring their persistent data from a backup.

{{< highlight "danger" "Regular backups">}}

Although server failures are uncommon, they cannot be discounted altogether. It is recommended to back up your host servers regularly in case of disaster and loss of your host server.

Backing up your host server before [upgrading a project](/rollyourown/projects/how_to_maintain/#upgrading-a-project-deployment) is also recommended.

Your hosting provider may offer a backup service for your host server. You may prefer to also use this service to back up and restore your rollyourown.xyz projects. However, we recommend also backing up your projects using the host server automation scripts.

{{< /highlight >}}

## How to back up

To back up a host server, log in to the [control node](/rollyourown/projects/control_node) and run the `backup.sh` script from the `/ryo-projects/ryo-host` directory (or the directory you chose during [control node setup](/rollyourown/projects/control_node/#automated-control-node-configuration)). As input parameters, specify the name of the host server and a "stamp" to identify the backup (for example, a date and time stamp such as 20220107-1835):

```bash
cd ~/ryo-projects/ryo-host/
./host-backup.sh -n <HOSTNAME> -s <STAMP>
```

The `host-backup.sh` script performs the following steps:

- Stops all containers (from all projects and modules deployed to the host server)
- Archives the persistent data directories for each project and module and copies the archives to the control node
- Restarts all containers (from all projects and modules deployed to the host)

Depending on the data stored in your projects, the archiving and copying procedure may take some time and the services running on the host server will not be available during this time.

## How to restore

The restoration of a host server is usually only needed after either a failure of the host server or to move projects / modules from one host server to another -- e.g. if moving to a different hosting provider or moving projects to a server with higher resources (if your provider does not allow an upgrade in place).

{{< highlight "danger" "Only restore to a freshly set-up host server with no projects deployed">}}

A restore should not be carried out on a host server with functioning projects!

A restore should normally only be carried out on a newly-configured host server. A restore will re-deploy all project and module components on the host server, with a previous state from a backup. If the host server is currently in a working state, then the current state will be lost and may not be able to be recovered.

{{< /highlight >}}

If a host server has failed or projects are to be moved to a new host server, then the first step of the restoration procedure is to set up a new host server from scratch, with the [same procedure](/rollyourown/projects/host_server/#automated-host-server-setup) followed as when setting up the host server in the first place. The new host server should have **the same name as the host server from which the backup was made**.

If the public IP address of the host server has changed, then the host server's configuration file will need to be updated with the new IP address in `/ryo-projects/ryo-host/configuration/configuration_<HOST NAME>.yml` and `/ryo-projects/ryo-host/configuration/inventory_<HOST NAME>`.

Once the host server is set up, then the restoration is carried our by running the `host-restore.sh` script, providing the name of the host, a version name for the new images that will be built (this does not need to be the same as the previous version name used) and the "stamp" (e.g. date, time) identifying the backup to restore.

```bash
./host-restore.sh -n <HOST NAME> -v <VERSION> -s <BACKUP STAMP>
```

{{< highlight "warning" >}}

Backups are stored in `/ryo-projects/ryo-host/backup-restore/backups` on the control-node.

{{< /highlight >}}

Since a restore is destructive and will delete the persistent storage of any projects and modules already running on the host, you will be asked to confirm the restore process multiple times and confirm the "stamp" for the backup to restore.

The `host-restore.sh` script will now

- Build new images and deploy the module and project components previously deployed to the host server in a "fresh" state
- Stop all containers on the host server
- Copy the backup archives to the host server and unpack them to the persistent data directories for each project and module
- Start all containers on the host server

After this process has completed, the services running on the host server should be running.
