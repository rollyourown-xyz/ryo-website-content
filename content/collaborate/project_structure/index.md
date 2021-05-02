---
title: "Project Structure"
tags: [ ]
draft: true
---

To maximise code reuse, a rollyourown.xyz project has a modular structure... (_more here_)

<!--more-->

## Project directory structure

A rollyourown.xyz project **must** be structured with the following top-level directories:

```bash
project_name
|-- configuration
|   |-- configuration.yml
|   |-- inventory
|
|-- host-setup (optional)
|   |-- roles
|   |   |-- ansible-role
|   |   |-- ansible-role
|   |   |-- ...
|   |-- ansible-playbook.yml
|   |-- ansible-playbook.yml
|   |-- ...
|   |-- master.yml
|
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
|
|-- modules   <<-- TODO!!!
|   |-- 
|   |-- 
|
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
|
|-- build-images.sh
|-- deploy-project.sh
|-- get-modules.sh
|-- host-setup.sh
|-- LICENSE
|-- README.md
```

Description of each part here...

Link to project template repository...

## Use of modules

Description here...
