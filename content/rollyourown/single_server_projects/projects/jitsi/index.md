---
title: "Roll Your Jitsi Videoconferencing"
tags: [ ]
draft: true
---

This project deploys a XXX with an [nginx](https://nginx.org/) web server, [coturn](LINK HERE) TURN-server and with [HAProxy](https://www.haproxy.org/) for TLS/SSL termination and [Certbot](https://certbot.eff.org/) for managing your letsencrypt certificate.

<!--more-->

ABC

{{< highlight "info" "Control machine">}}
A terminal-based [control machine](/rollyourown/tech_building_blocks/control_machine/) is sufficient for this project, as the Grav admin interface is reachable via the public internet.
{{< /highlight >}}

## TODOs on this page

{{< highlight "primary" "ToDo">}}

- [ ] ToDo

{{< /highlight >}}

## Repository links

The [rollyourown.xyz](https://rollyourown.xyz/) repository for this project is here: [https://git.rollyourown.xyz/ryo-projects/ryo-jitsi.git](https://git.rollyourown.xyz/ryo-projects/ryo-jitsi.git)

The [github](https://github.com/) mirror repository for this project is here: [https://github.com/rollyourown-xyz/ryo-jitsi.git](https://github.com/rollyourown-xyz/ryo-jitsi.git)

## Project components

The components deployed in this project are shown in the following diagram:

![Project Overview](Project_Overview.svg) !!! TODO

### Host server

The host server is configured to run [LXD containers](https://linuxcontainers.org/lxd/) and is controlled from your control machine via a [wireguard](https://www.wireguard.com/) tunnel. Each container deployed performs a specific task in the installation.

Further details about the host server building block can be found [here](/rollyourown/tech_building_blocks/host_server/).

### Containers

The project installation consists of a number of containers deployed on the host server.

#### A

ABC

#### B

ABC

## How to use this project

### Deploying the project

To deploy the project, follow the generic [project deployment instructions](/rollyourown/tech_projects/how_to_deploy/), using the [project's github mirror repository](https://github.com/rollyourown-xyz/ryo-jitsi/)

### After deployment

For a full overview of how to use ... , see the excellent documentation at ....

For example, your first steps after deployment could be:

- A

- B

- C


### Maintaining the installation

After deploying the project, the installation needs to be maintained over time as, for example, new versions of the project's components are released.

Maintentance is automated via the rollyourown.xyz project scripts. See [here](/rollyourown/single_server_projects/how_to_maintain/) for details.

## Project requirements

ABC

## Software deployed

The open source software deployed by the project is:

{{< table tableclass="table table-bordered table-striped" theadclass="thead-dark" >}}

| Project | What is it? | Homepage | License |
| :------ | :---------- | :------- | :------ |
| TODO | TODO | TODO | TODO |
| TODO | TODO | TODO | TODO |

{{< /table >}}
