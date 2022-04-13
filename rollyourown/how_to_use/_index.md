---
title: "How to use"
weight: 1
tags: [ ]
draft: false
---
<!--
SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
SPDX-License-Identifier: CC-BY-SA-4.0
-->

Each [rollyourown.xyz](https://rollyourown.xyz) project provides automation resources to deploy and manage open source software, using Configuration-as-Code, Infrastructure-as-Code and Immutable infrastructure.

<!--more-->

After choosing a [rollyourown.xyz](https://rollyourown.xyz) project to deploy:

1. Prepare a [control node](/rollyourown/how_to_use/control_node/) to deploy and manage your projects
2. Order or set up a server to host your project, with Ubuntu 20.04 LTS or 22.04 LTS installed
3. Prepare the [host server](/rollyourown/how_to_use/host_server/) to be ready to deploy your project
4. Clone the [project's repository](/rollyourown/projects/) to the control machine
5. Add your project's settings (e.g. the domain name) to the project configuration files
6. Run the `deploy.sh` script from the project directory to set up and deploy the different components for your project

After a project is deployed, [maintenance](/rollyourown/how_to_use/maintain/) is carried out via the `upgrade.sh` script, [backups](/rollyourown/how_to_use/back_up_and_restore/) are made via the `backup.sh` script and, if needed, restored via the `restore.sh` script.

The pages in this section describe these steps in more detail:

* Set up and configuration of a control node is described [here](/rollyourown/how_to_use/control_node/)
* Set up and configuration of a host server is described [here](/rollyourown/how_to_use/host_server/)
* Project deployment is described [here](/rollyourown/how_to_use/deploy/)
* Project maintenance is described [here]/rollyourown/how_to_use/maintain/)
* Backing up and restoring is described [here](/rollyourown/how_to_use/back_up_and_restore/)

For an example of how to use rollyourown.xyz project to provide different services, see how we use our own projects to run [our own infrastructure](/about/our_infrastructure/).
