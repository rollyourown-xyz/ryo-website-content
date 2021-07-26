---
title: "Roll Your Own Jitsi Videoconferencing"
tags: [ ]
draft: true
---

This project deploys a [jitsi](https://jitsi.org/) video conferencing server, together with a [coturn](https://github.com/coturn/coturn) TURN-server, and with [HAProxy](https://www.haproxy.org/) for TLS/SSL termination and [Certbot](https://certbot.eff.org/) for managing your letsencrypt certificates.

<!--more-->

## TODOs on this page

{{< highlight "primary" "ToDo">}}

- [ ] Links on the page
- [ ] Add screenshots
- [ ] Project requirements
- [ ] Software deployed

{{< /highlight >}}

[Jitsi](https://jitsi.org/) is set of open source components that together provide a web-based video conferencing solution. The components of a jitsi server are described in the [jitsi documentation](https://jitsi.github.io/handbook/docs/architecture). This project installs an [nginx](https://nginx.org/) web server and uses the [jitsi-meet installer](https://jitsi.github.io/handbook/docs/devops-guide/devops-guide-quickstart#install-jitsi-meet) to install the different jitsi components:

- A [Prosody XMPP server](https://prosody.im/) that jitsi uses for inter-component signalling
- The [jitsi-meet](https://github.com/jitsi/jitsi-meet) WebRTC front-end web application, providing the conference user interface
- The [jitsi videobridge](https://github.com/jitsi/jitsi-videobridge) video stream router
- The [jicofo](https://github.com/jitsi/jicofo) conference focus server, that manages sessions within conferences

Components **not** installed by this project are:

- The [jigasi](https://github.com/jitsi/jigasi) SIP gateway
- The [jibri](https://github.com/jitsi/jibri) broadcasting server

In additiona to the components of the jitsi video conferencing system, the project deploys the [rollyourown.xyz coturn module](/rollyourown/project_modules/turn_server/) to enable [NAT traversal](https://en.wikipedia.org/wiki/NAT_traversal) for conference participants and the [rollyourown.xyz service proxy module](/rollyourown/project_modules/service_proxy/) to provide TLS termination and certificate management.

{{< highlight "info" "Control machine">}}
A terminal-based [control machine](/rollyourown/tech_building_blocks/control_machine/) is sufficient for this project, as the jitsi conferencing server is configurable only via command line.
{{< /highlight >}}

## Repository links

The [github](https://github.com/) mirror repository for this project is here: [https://github.com/rollyourown-xyz/ryo-jitsi](https://github.com/rollyourown-xyz/ryo-jitsi)

The [rollyourown.xyz](https://rollyourown.xyz/) repository for this project is here: [https://git.rollyourown.xyz/ryo-projects/ryo-jitsi](https://git.rollyourown.xyz/ryo-projects/ryo-jitsi)

## Project components

The components deployed in this project are shown in the following diagram:

![Project Overview](Project_Overview.svg)

### Host server

The host server is configured to run [LXD containers](https://linuxcontainers.org/lxd/) and is controlled from your control machine via a [wireguard](https://www.wireguard.com/) tunnel. Each container deployed performs a specific task in the installation.

Further details about the host server building block can be found [here](/rollyourown/tech_building_blocks/host_server/).

### Containers

The project installation consists of a number of containers deployed on the host server.

#### Coturn container

The coturn container hosts an [coturn](https://github.com/coturn/coturn/) TURN server, providing NAT traversal for jitsi conference users. This component is provided by the [rollyourown.xyz](https://rollyourown.xyz) TURN server module and is a building block for other rollyourown.xyz projects providing p2p communications services. Further details can be found [here](/rollyourown/project_modules/turn_server/).

#### Loadbalancer / TLS proxy container

The loadbalancer / TLS proxy container terminates HTTP and HTTPS connections and distributes traffic to other containers. This component is provided by the [rollyourown.xyz](https://rollyourown.xyz) Service Proxy module and is a key building block for rollyourown.xyz projects. Further details can be found [here](/rollyourown/project_modules/service_proxy/).

#### Consul container

The consul container provides a service registry for loadbalancer / TLS proxy backends and a key-value store for configuration of other containers. The Consul container is provided by the [rollyourown.xyz](https://rollyourown.xyz) Service Proxy module and is a key building block for rollyourown.xyz projects. Further details can be found [here](rollyourown/project_modules/service_proxy/).

#### Jitsi server container

The Jitsi server container hosts an [nginx](https://nginx.org/) web server with the [jitsi-meet](https://github.com/jitsi/jitsi-meet) WebRTC video conferencing front-end as well as the jitsi video conferencing suite components [prosody]((https://prosody.im/)), [jitsi videobridge](https://github.com/jitsi/jitsi-videobridge) and [jicofo](https://github.com/jitsi/jicofo).

## How to use this project

### Deploying the project

To deploy the project, follow the generic [project deployment instructions](/rollyourown/tech_projects/how_to_deploy/), using the project's github mirror repository at [https://github.com/rollyourown-xyz/ryo-jitsi/](https://github.com/rollyourown-xyz/ryo-jitsi/).

### After deployment

For a full overview of how to use [jitsi video conferencing](https://jitsi.org/), see the Jitsi [user guide](https://jitsi.github.io/handbook/docs/user-guide/user-guide-start).

Before using the conferencing service, user accounts need to be configured. The [rollyourown.xyz](https://rollyourown.xyz) jitsi project deployment is configured as a private deployment with a [Secure domain setup](https://jitsi.github.io/handbook/docs/devops-guide/secure-domain). This allows only authenticated and authorised users to create conferences and prevents the service from being used by anyone on the internet.

#### Jitsi user management

User accounts can only be configured via the command line. This can be done directly from the control node, using `lxc exec` to the remote host server:

- Add user

    ```bash
    lxc exec <HOST_ID>:<HOST_ID>-ryo-jitsi-jitsi -- prosodyctl register <USERNAME> <DOMAIN> <PASSWORD>
    ```

- Delete user:

    ```bash
    lxc exec <HOST_ID>:<HOST_ID>-ryo-jitsi-jitsi -- prosodyctl deluser <USERNAME>@<DOMAIN>
    ```

- Change a user's password:

    ```bash
    lxc exec <HOST_ID>:<HOST_ID>-ryo-jitsi-jitsi -- prosodyctl passwd <USERNAME>@<DOMAIN>
    ```

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
