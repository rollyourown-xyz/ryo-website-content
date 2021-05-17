---
title: "Single Server Projects: How to maintain"
tags: [ ]
draft: false
---

The rollyourown.xyz automation scrupts used to build images and deploy your project can also be used to maintain the project deployment.

This page describes how to use these resources to build new images with updated software and deploy them to the host server.

<!--more-->

## TODOs on this page

{{< highlight "primary" "ToDo">}}

- [ ] Section on backing up a project
- [ ] Add links in the text
- [ ] Update needed after modularising - e.g. add `get-modules.sh`?

{{< /highlight >}}

## How to maintain a project (tl;dr)

Follow these steps to update your deployed [rollyourown.xyz](https://rollyourown.xyz) project:

1. Pull the up to date project repository to your control node
2. Run `./build-images.sh` from the project directory to build new images for deployment
3. Run `./deploy-project.sh` from the project directory to deploy the new images and update the deployment

Back up the directory `/var/containers/<project_id>` on your host server to backup all project components.

Now read on to understand each of these steps.

## Introduction

Following the principles of **Configuration as code**, **Infrastructure as code** and **Immutable infrastructure** described on the [How to Deploy page](/rollyourown/single_server_projects/how_to_deploy/#introduction), updating a rollyour own project consists of:

- Updating the code (either for the configuration of the nodes deployed or for the deployment itself)
- Building new images for each node from the updated configuration code
- Deploying **new** containers (launching from the new images) to **replace** the containers deployed previously

{{< more "secondary">}}

Following the principle of [immutable infrastructure](https://www.digitalocean.com/community/tutorials/what-is-immutable-infrastructure), a live deployment is **never** modified manually. This means, for example:

- No manual changes to the deployed servers / containers - e.g. no SSH in to the server or container, no `apt ugrade`, no changes to configuration files in place
- No manual changes to the deployed architecture - e.g. no manual networking changes, no manual firewall changes, no manual load-balancer re-confinguration

Instead, changes are made in version-controlled code, can be tested in a replica of the deployed environment and are rolled out via automated processes.

Instead of re-configuring or updating a server/container in place, the old version of the server/container is "thrown away" and replaced with a new version. By doing this, we guarantee that the components running in a live deployment always reflect exactly the state we have defined in a specific version of our code and never diverge from it.

Furthermore, by including further configurtion in our code - e.g. network structure, firewall rules, etc. - and also never changing these manually, we can also be sure that the end-to-end architecture of our deployment is exactly known and also never diverges from the state we have defined in code.

If we want to change something, then we make our changes in the code, deploy the new version of the deployment in a test environment (even using a snapshot of data from our production environment), make sure that the new version works as expected and then deploy exactly this new version to production.

These techniques are used to manage very large deployments in commercial situations - e.g. in enterprise data centres, telecommunications networks and large-scale internet services - and enable and go hand-in-hand with modern development practices such as [CI/CD](https://www.redhat.com/en/topics/devops/what-is-ci-cd), [blue-green deployments](https://martinfowler.com/bliki/BlueGreenDeployment.html) and [canary releases](https://martinfowler.com/bliki/CanaryRelease.html).

With rollyourown.xyz, we bring a subset of these practices within the reach of private users and smaller organisations. We aim to lower the knowledge and effort needed to use self-hosted, open-source projects by providing the configuration and infrastructure code needed to deploy them. By doing this, we aim to promote the use and propagation of open-source software.

{{< /more >}}

## Updating a project deployment

Updating a rollyourown.xyz project deployment consists of a few steps:

1. Log in to the control node and update the project's code by pulling changes and updates from the project repository

    ```bash
    cd ~/ryo-projects/<project_to_upgrade>/
    git pull
    ```

2. Run the the `build-images.sh` script, passing a **new** version stamp (e.g. the date) to the script (as for the initial deployment, this process may take some time depending on the number of components in the project):

    ```bash
    cd ~/ryo-projects/<project_to_upgrade>/
    ./build-images.sh -v <NEW VERSION>
    ```

3. Run the `deploy-project.sh` script, passing the **same new verion stamp** to the script:

    ```bash
    cd ~/ryo-projects/<project_to_upgrade>/
    ./deploy-project.sh -v <NEW VERSION>
    ```

After this process, your project deployment has been upgraded.

## Manual changes

{{< highlight "danger" "Warning!">}}

If you have made manual changes to a deployed component (configuration, software etc.) - e.g. via SSH - then these will be thrown away with the component's container when an upgrade takes place.

{{< /highlight >}}

You are welcome to use the project code from the rollyourown.xyz repositories as the basis of your own projects and make your own changes in your local copy of the repository. The `build-images.sh` and `deploy-project.sh` scripts will still work (if you haven't made mistakes in the code). However, be aware that your repository will have diverged from the rollyourown.xyz repository and you will probably no longer be able to simply `git pull` a new version from rollyourown.xyz and benefit from any improvements made

If you want to improve the project or have found a bug and need to change something to get things working, then please consider collaborating with us [LINK HERE] so that your improvements are available for everyone.

## Project backups

ToDo...

Mention:

- Snapshots / images of host server (depends on hosting provider)
- Container snapshots
- Backing up persistent storage
