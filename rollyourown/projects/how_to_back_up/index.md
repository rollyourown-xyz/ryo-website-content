---
title: "How to Back Up"
weight: 3
tags: [ ]
draft: true
---

Each [rollyourown.xyz](https://rollyourown.xyz) project provides automation resources to minimise the number of manual steps needed to back up the components of a project.

This page describes how to use these resources.

<!--more-->

## TODOs on this page

{{< highlight "primary" "ToDo">}}

- [ ] Write all sections
- [ ] Add links in the text

{{< /highlight >}}

## NOTES

- Snapshots / images of host server (depends on hosting provider)
- Container snapshots
- Backing up persistent storage
- Databases

## How to back up a project (tl;dr)

Follow these steps to back up your deployed [rollyourown.xyz](https://rollyourown.xyz) project:

1. A
2. B
3. C

## Introduction

ABC

Something about not needing to back up the containers themselves - can always be re-deployed by the automation scripts and CaC/IaC code, persistent storage, database backups, ...

## Backing up a project deployment

Backing up a rollyourown.xyz project deployment consists of a few steps:

1. Log in to the control node and run the `backup.sh` script:

    ```bash
    cd ~/ryo-projects/<project_to_upgrade>/
    ./backup.sh -n <HOSTNAME>
    ```

2. ABC

3. ABC

After this process, your project deployment has been backed up.

## Manual backups

ABC
