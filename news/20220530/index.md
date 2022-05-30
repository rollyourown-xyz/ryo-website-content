---
title: "Remote image build enabled"
date: 2022-05-30
author: "W. Nicoll"
draft: false
tags: []
---
<!--
SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
SPDX-License-Identifier: CC-BY-SA-4.0
-->

We have added an option to all projects and modules to build container images on the host server rather than the control node. This utilises a [new feature in the packer LXD builder](https://github.com/hashicorp/packer-plugin-lxd/pull/40).

Remote builds are activated by setting the new parameter `remote_build` to `true` in a project configuration file.

This feature avoids container images being uploaded from the control node to the host server, so improving project deployment times for users with slow internet connections.

The build procedure, however, may take longer on a remote host server than on a local machine, so that deployment times are not improved (and may even by longer) for users with fast internet connections. The option is therefore not activated by default.
