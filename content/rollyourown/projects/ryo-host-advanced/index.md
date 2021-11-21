---
title: "Host Server - Advanced"
tags: [ "module", "host" ]
draft: true
---

Users familiar with the Linux command line can log in to a host server from a control node via the wireguard tunnel set up by the rollyourown.xyz automation scripts.

<!--more-->

## TODOs on this page

{{< highlight "primary" "ToDo">}}

- [ ] Add links in the text
- [ ] Add text and commands to the various sections

{{< /highlight >}}

## Prerequisite

The connection between the control node and the host server depends on a wireguard tunnel and SSH key-based authentication, both of which are set up by the rollyourown.xyz automation scripts.

 The following assumes that:

- The control node has been [set up using the `local-setup.sh` script](/rollyourown/projects/ryo-control-node/)
- The host server has been [set up using the `host-setup.sh`script](/rollyourown/projects/how_to_deploy/)

## Logging in to the host server

Log in (note: port, host non-root username, ... as set in configuration.yml)

## Observing host server resource usage

Glances

## Managing containers

Note that container deployment and update are controlled by the rollyourown.xyz automation scripts so that there is usually no need to manipulate containers manually. Note about immutable infrastructure.

### When logged in to the host server

Using LXD commands... list, stop, start, image list, image delete

### When logged in to the control node

Using the LXD remote connection set up by the rollyourown.xyz automation scripts... list, stop, start, image list, image delete

## Mounted directories

### Location of mounted containers

/var/containers - can be backed up in its entirity to back up all running containers (stop containers first)

### Backing up mounted containers

Stop containers, rsync to control node

## More???

Anything else?
