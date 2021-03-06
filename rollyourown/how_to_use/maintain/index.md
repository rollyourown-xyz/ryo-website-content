---
title: "How to Maintain"
weight: 2
tags: [ ]
draft: false
---
<!--
SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
SPDX-License-Identifier: CC-BY-SA-4.0
-->

Each rollyourown project provides automation resources to minimise the number of manual steps needed to keep a project's components up to date.

<!--more-->

This page describes how to use these resources to build new project images with upgraded software and deploy them to the host server.

Information on maintaining a control node can be found [here](/rollyourown/how_to_use/control_node/#control-node-maintenance). Information on maintaining a host server can be found [here](/rollyourown/how_to_use/host_server/#host-server-maintenance).

## How to maintain a project (tl;dr)

Follow these steps to upgrade your deployed rollyourown project:

1. Enter the project's directory on your [control node](/rollyourown/how_to_use/control_node/)
2. Run `./upgrade.sh` from the project directory to build new images for deployment
3. Select whether to upgrade modules used by the project

## Introduction

Following the principles of Configuration-as-Code, Infrastructure-as-Code and Immutable infrastructure described on the [How to Deploy page](/rollyourown/how_to_use/deploy/), project components are **never** upgraded in place. Rather, a new component image is built from an updated configuration and the component container is **replaced** with the new version.

Upgrading a rollyourown project consists of:

- Updating the code (either for the configuration of the nodes deployed or for the deployment itself) from the project's repository
- Optionally, making a backup of the persistent storage for the project's containers (and its modules' containers)
- Building new images for each node from the updated configuration code
- Deploying **new** containers (launching from the new images) to **replace** the containers deployed previously

{{< more "secondary">}}

Following the principle of [immutable infrastructure](https://www.digitalocean.com/community/tutorials/what-is-immutable-infrastructure), a live deployment is **never** modified manually. This means, for example:

- No manual changes to the deployed servers / containers - e.g. no SSH in to the server or container, no `apt ugrade`, no changes to configuration files in place
- No manual changes to the deployed architecture - e.g. no manual networking changes, no manual firewall changes, no manual load-balancer re-configuration

Instead, changes are made in version-controlled code. The code can be tested in a replica of the deployed environment and rolled out via automated processes.

Instead of re-configuring or updating a server/container in place, the old version of the server/container is "thrown away" and replaced with a new version. By doing this, we guarantee that the components running in a live deployment always reflect exactly the state we have defined in a specific version of our code and never diverge from it.

Furthermore, by including further configuration in our code - e.g. network structure, firewall rules, etc. - and also never changing these manually, we can also be sure that the end-to-end architecture of our deployment is exactly known and also never diverges from the state we have defined in code.

If something needs to be changed, then changes are made in the code. The new version of the code is tested by deploying to a test environment (possibly even using a snapshot of data from the production environment), to make sure that the new version works as expected. After testing, exactly this new version is deployed to production.

These techniques are used to manage very large deployments in commercial situations (e.g. in enterprise data centres, telecommunications networks and large-scale internet services). They enable and go hand-in-hand with modern development practices such as [CI/CD](https://www.redhat.com/en/topics/devops/what-is-ci-cd), [blue-green deployments](https://martinfowler.com/bliki/BlueGreenDeployment.html) and [canary releases](https://martinfowler.com/bliki/CanaryRelease.html).

With rollyourown, we bring a subset of these practices within the reach of private users and smaller organisations. We aim to lower the knowledge and effort needed to use and maintain self-hosted, open-source projects by providing the configuration and infrastructure code needed to deploy and upgrade them. By doing this, we aim to promote the use and propagation of open-source software.

{{< /more >}}

## Before upgrading a project

Although unrecoverable failures during upgrades are uncommon, they cannot be discounted altogether. rollyourown is an open source project and cannot *guarantee* that the code published in a project or module repository is fully working.

It is recommended to always [back up the project](/rollyourown/how_to_use/back_up_and_restore/#how-to-back-up-an-individual-project) or [back up your host server](/rollyourown/how_to_use/back_up_and_restore/#how-to-back-up-a-host-server) before upgrading a project, in case the upgrade procedure fails and you are unable to roll back to the previous version of the container images.

## Upgrading a project deployment

Upgrading a rollyourown project deployment consists of a few steps:

1. Log in to the [control node](/rollyourown/how_to_use/control_node/) and run the `upgrade.sh` script in your project's directory:

    ```bash
    cd ~/ryo-projects/<project_to_upgrade>/
    ./upgrade.sh -n <HOSTNAME> -v <NEW VERSION>
    ```

2. The script will ask whether to back up the project before upgrading. It is recommended to do this.

3. The script will ask whether modules used by the project should also be upgraded. This is recommended, but can be skipped.

4. The `upgrade.sh` script will now pull up-to-date code from the [rollyourown repositories](/collaborate/repositories), optionally back up the project, build new images for the selected components and deploy them to the host server.

After this process, your project deployment has been upgraded.

## Rollback

If, after an upgrade, one or more component fails to launch, or the service is disrupted for some reason, the `rollback.sh` script allows you to roll back to a previous working version.

Before starting the rollback procedure, identify the version stamps of the images to roll back to. To see the images available on the [host server](/rollyourown/how_to_use/host_server), enter the following on the [control node](/rollyourown/how_to_use/control_node):

```bash
lxc image list <HOST_NAME>:
```

Here, `<HOST_NAME>` is the name you gave to your host server, which is used when calling the `deploy.sh` and `upgrade.sh` scripts. The output of the command provides a list of images on the host server, identified by their project, module and component names.

As an example, the following diagram shows the project and module components for a [Grav CMS deployment](/rollyourown/projects/ryo-grav-cms), with two versions of the ingress-proxy module image and three versions of the grav-webserver project component image:

{{< image src="lxc_image_list_example.png" title="lxc image list example">}}

Typically, you will want to restore the image of the previous working version and only for the components which failed to upgrade. So, for example, if the `upgrade.sh` script was called with the version stamp `TEST03` and upgrading modules was not selected, then rolling back to the previous working version would mean rolling back the project components to version `TEST02` in the above example.

Once the versions to roll back to have been identified, log in to the [control node](/rollyourown/how_to_use/control_node) and run the `rollback.sh` script in your project's directory, passing the name of the host server via the `-n` flag:

```bash
cd ~/ryo-projects/<project_to_roll_back>/
./rollback.sh -n <HOSTNAME>
```

The `rollback.sh` script will ask whether modules need to be rolled back and will ask for the version to use for each module (if applicable) and for the project.

## Manual changes

{{< highlight "danger" "Warning!">}}

If you have made manual changes to a deployed component (configuration, software etc.) - e.g. via SSH - then these will be thrown away with the component's container when an upgrade takes place. There should be no need to manually change a deployed component.

{{< /highlight >}}

You are welcome to use the project code from the rollyourown repositories as the basis of your own projects and make your own changes in your local copy of the repository. The `deploy.sh` and `upgrade.sh` scripts will still work (if you haven't made mistakes in the code). However, be aware that your repository will have diverged from the rollyourown repository, and you will probably no longer be able to simply `git pull` a new version from rollyourown and benefit from any improvements made.

If you want to improve the project or have found a bug and need to change something to get things working, then please consider [collaborating with us](/collaborate) so that your improvements are available for everyone.
