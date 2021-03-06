---
title: "Project Modules"
weight: 3
tags: [ ]
draft: false
---
<!--
SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
SPDX-License-Identifier: CC-BY-SA-4.0
-->

A rollyourown project module contains automation code to configure, build, deploy, maintain, back up and restore a module for use by other rollyourown projects.

<!--more-->

In itself, a project module doesn't provide a full end-to-end service, but rather provides a reusable building block that is used in a full [rollyourown project](/rollyourown/projects/) as part of the end-to-end solution, for example:

* An [ingress proxy](/rollyourown/project_modules/ryo-ingress-proxy/) for the solution to manage TLS certificates and route incoming traffic to the correct project component
* A backend database - either [MySQL/MariaDB](/rollyourown/project_modules/ryo-mariadb/) or [PostgreSQL](/rollyourown/project_modules/ryo-postgres/)
* A [STUN/TURN server](/rollyourown/project_modules/ryo-coturn/) to support voice or video communications

For an example of how rollyourown modules are used together with rollyourown projects to provide end-to-end services, see how we use our projects and modules to run [our own infrastructure](/about/our_infrastructure/).
