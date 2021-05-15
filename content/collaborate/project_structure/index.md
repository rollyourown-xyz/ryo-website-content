---
title: "Project Structure"
tags: [ ]
draft: true
---

To maximise code reuse, a rollyourown.xyz project has a modular structure... (_more here_)

<!--more-->

## Project directory structure

Link to project template repository...

A rollyourown.xyz project **must** be structured with the following top-level directories and scripts:

```console
project_id
|-- configuration
|   |-- ...
|-- host-setup-project
|   |-- ...
|-- image-build
|   |-- ...
|-- modules
|   |-- ...
|-- project-deployment
|   |-- ...
|-- build-images.sh
|-- deploy-project.sh
|-- get-modules.sh
|-- host-setup.sh
|-- LICENSE
|-- README.md
```

### The configuration directory

```console
|-- configuration
|   |-- configuration.yml
|   |-- inventory
```

### The host-setup-project directory

```console
|-- host-setup-project
|   |-- roles
|   |   |-- ansible-role
|   |   |-- ansible-role
|   |   |-- ...
|   |-- ansible-playbook.yml
|   |-- ansible-playbook.yml
|   |-- ...
|   |-- master.yml
```

### The image-build directory

```console
|-- image-build
|   |-- playbooks
|   |   |-- roles
|   |   |   |-- ansible-role
|   |   |   |-- ansible-role
|   |   |   |-- ...
|   |   |-- inventory.yml
|   |   |-- ansible-playbook.yml
|   |   |-- ansible-playbook.yml
|   |   |-- ...
|   |-- packer-template.pkr.hcl
|   |-- packer-template.pkr.hcl
|   |-- ...
```

### The modules directory

```console
|-- modules   <<-- TODO!!!
|   |-- 
|   |-- 
```

### The project-deployment directory

```console
|-- project-deployment
|   |-- cloud-init
|   |   |-- cloud-init-file.yml
|   |   |-- cloud-init-file.yml
|   |   |-- ...
|   |-- modules
|   |   |-- terraform-module
|   |   |-- terraform-module
|   |   |-- ...
|   |-- terraform-file.tf
|   |-- terraform-file.tf
|   |-- ...
```

### The scripts

```console
|-- build-images.sh
|-- deploy-project.sh
|-- get-modules.sh
|-- host-setup.sh
|-- LICENSE
|-- README.md
```
