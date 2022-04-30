---
title: "Host Server - Advanced"
weight: 6
tags: [ "module", "host" ]
draft: false
---
<!--
SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
SPDX-License-Identifier: CC-BY-SA-4.0
-->

Users familiar with the Linux command line can log in to a [host server](/rollyourown/how_to_use/host_server) from a [control node](/rollyourown/how_to_use/control_node) via the wireguard tunnel set up by the rollyourown automation scripts. This should not be necessary for normal usage but may be useful during development when [improving existing projects or modules](/collaborate/existing_projects_and_modules), or when [developing new projects or modules](/collaborate/new_projects_and_modules).

<!--more-->

## Prerequisite

The connection between the control node and the host server depends on a [wireguard](https://www.wireguard.com/) tunnel and [SSH](https://en.wikipedia.org/wiki/Secure_Shell) public key authentication, both of which are set up by the rollyourown automation scripts.

 The following assumes that:

- The [control node](/rollyourown/how_to_use/control_node/) has been set up using the `local-setup.sh` script
- The [host server](/rollyourown/how_to_use/host_server/) has been set up using the `host-setup.sh` script

## Logging in to the host server

SSH log in to the host server is only possible from the control node via the wireguard tunnel established between the control node and the host server. The port number and non-root username specified in the host server configuration file, and the SSH key authentication identity generated automatically during control node setup are needed to log in.

Log in to the host server from the control node, using either the IPv4 or IPv6 wireguard address of the host server. Enter the following on the command line:

```bash
ssh -p 2222 -i ~/.ssh/ryo_id_ssh_rsa <USERNAME>@10.0.1.2
```

or

```bash
ssh -p 2222 -i ~/.ssh/ryo_id_ssh_rsa <USERNAME>@fd10:10:0:1::2
```

{{< highlight "warning">}}

Note that, if the variables `wireguard_network_part` and `wireguard_network_ipv6_prefix` in the host server configuration file have been changed from the default values, then the IPv4 or IPv6 addresses shown in the above commands also need to be modified

{{< /highlight >}}

## Observing host server resource usage

Once logged in to the host server, resource usage can be observed with the [`glances`](https://nicolargo.github.io/glances/) application that is installed by the `host-setup.sh` automation script.

To start glances, enter `glances` at the command line on the host server:

```bash
glances
```

A guide to the information shown by the application is here: [https://glances.readthedocs.io/en/latest/](https://glances.readthedocs.io/en/latest/).

To terminate the application, use `<CTRL>+C`.

## Managing containers

Container deployment and update are controlled by the rollyourown automation scripts so that there is usually no need to manipulate containers manually. Rollyourown deployments use [Immutable Infrastructure](https://www.hashicorp.com/resources/what-is-mutable-vs-immutable-infrastructure), so that software upgrades or configuration changes to running containers are not needed and any changes made will be discarded at the next upgrade.

However, containers can be stopped and started, and you can log in to the command line of a container, if necessary. You can also list the container image versions stored on the host server and delete old ones if needed.

### When logged in to the host server

When logged in to the host server:

- A list of running containers can be displayed using the command:

    ```bash
    lxc list
    ```

- A container with the name `<CONTAINER_NAME>` can be stopped with the command:

    ```bash
    lxc stop <CONTAINER_NAME>
    ```

- A stopped container with the name `<CONTAINER_NAME>` can be started with the command:

    ```bash
    lxc start <CONTAINER_NAME>
    ```

- A shell on a container with the name `<CONTAINER_NAME>` can be started with the command:

    ```bash
    lxc exec <CONTAINER_NAME> -- /bin/bash
    ```

- A list of the different container images present on the host server can be displayed with the command:

    ```bash
    lxc image list
    ```

- A specific container image can be deleted using the command:

    ```bash
    lxc image delete <FINGERPRINT>
    ```

  where the `<FINGERPRINT>` is shown in the output of `lxc image list`

### When logged in to the control node

The same operations can also be carried out from the command line on the control node, without first logging in to the host server. The host server is configured as an [LXD remote server](https://linuxcontainers.org/lxd/docs/master/remotes/) during the host setup automation scripts. In each case, the command is modified to specify the remote server on which to perform the operation. In the rollyourown automation scripts, the name of the LXD remote configured is the same as the hostname specified in the host server configuration file `configuration_<HOST_NAME>.yml` and used in the host setup command `./host-setup.sh -n <HOST_NAME>`.

From the control node:

- A list of running containers on the remote host server can be displayed using the command:

    ```bash
    lxc list <HOST_NAME>:
    ```

- A container on the remote host server with the name `<CONTAINER_NAME>` can be stopped with the command:

    ```bash
    lxc stop <HOST_NAME>:<CONTAINER_NAME>
    ```

- A stopped container on the remote host server with the name `<CONTAINER_NAME>` can be started with the command:

    ```bash
    lxc start <HOST_NAME>:<CONTAINER_NAME>
    ```

- A shell on a container with the name `<CONTAINER_NAME>` on the remote host server can be started with the command:

    ```bash
    lxc exec <HOST_NAME>:<CONTAINER_NAME> -- /bin/bash
    ```

- A list of the different container images present on the remote host server can be displayed with the command:

    ```bash
    lxc image list <HOST_NAME>:
    ```

- A specific container image can be deleted from the remote host server using the command:

    ```bash
    lxc image delete <HOST_NAME>:<FINGERPRINT>
    ```

  where the `<FINGERPRINT>` is shown in the output of `lxc image list`

## Mounted directories

Containers are provided with persistent storage by mounting directories from the host server.

Container persistent storage is located in the directory `/var/containers` on the host server, organised in subdirectories named according to the projects or modules deployed.

These are the directories backed up by the rollyourown backup automation scripts and there should normally be no reason to back these up manually.
