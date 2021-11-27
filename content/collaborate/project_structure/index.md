---
title: "Project Structure"
tags: [ ]
draft: true
---

A rollyourown.xyz project has a defined, modular structure and every rollyourown.xyz project is structured in the same way. The structure is provided by the [project template repository](https://git.rollyourown.xyz/ryo-projects/ryo-project-template) and the template [can be forked to form the basis of a new rollyourown.xyz project](/LINK/TO/WORKFLOW/DESCRIPTION).

<!--more-->

## Project directory structure

A rollyourown.xyz project is structured with the following top-level directories and scripts:

```console
project_id
|-- configuration
|   |-- ...
|-- host-setup
|   |-- ...
|-- image-build
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

## The project_id

The `project_id` is a unique name for a rollyourown.xyz project and is also the name of the project repository on the rollyourown.xyz [Gitea server](https://git.rollyourown.xyz/ryo-projects) and on the rollyourown.xyz [Github mirror](https://github.com/rollyourown-xyz).

The `project_id` is always of the form `ryo-<NAME>` where `<NAME>` usually identifies the open source software to be deployed and, if relevant, the variation of the project (for example, `ryo-nextcloud-standalone` or `ryo-gitea-with-sso`).

The `project_id` is also added to the project's [configuration template](/collaborate/project_structure/#the-configuration-directory).

## License and Readme

The top-level directory of a rollyourown.xyz project includes a `LICENSE` and `README.md` file:

- LICENSE: Describes the licence under which the code in the repository may be copied or used. Only [open source](https://opensource.org/osd) licences (e.g. the [MIT](https://opensource.org/licenses/MIT) licence) may be used for a rollyourown.xyz project
- README.md: Provides a high-level description of the project and how to use it

## Scripts

The top-level directory of a rollyourown.xyz project includes four scripts for the user to execute in order to [deploy the project](/rollyourown/projects/how_to_deploy/):

- get-modules.sh: Loads additional modules needed for the project
- host-setup.sh: Performs project-specific configuration of the host server
- build-images.sh: Creates an image for each of the project’s components
- deploy-project.sh: Launches project's containers and provides configuration parameters to the environment

## Directories

### The configuration directory

```console
|-- configuration
|   |-- configuration_TEMPLATE.yml
```

The `configuration` directory contains a template configuration file for the project. In addition to the `project_id`, this [YAML](https://en.wikipedia.org/wiki/YAML) file includes any configuration parameters that the end-user of a project can set (such as the domain name or an administrator username).

### The host-setup directory

```console
|-- host-setup
|   |-- roles
|   |   |-- ansible-role
|   |   |-- ansible-role
|   |   |-- ...
|   |-- ansible-playbook.yml
|   |-- ansible-playbook.yml
|   |-- ...
|   |-- main.yml
```

The `host-setup` directory contains [Ansible](https://www.ansible.com/) playbooks for configuring the [host server](/rollyourown/projects/host_server/) for project deployment. Generic host service configuration is done during the host setup step of project deployment, but additional configuration may be needed (creating host directories for mounting to project containers, for example).

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

The `image-build` directory contains [Packer](https://www.packer.io/) templates and [Ansible](https://www.ansible.com/) playbooks for building container images to be deployed on the host server.

### The project-deployment directory

```console
|-- project-deployment
|   |-- cloud-init
|   |   |-- cloud-init-file.yml
|   |   |-- cloud-init-file.yml
|   |   |-- ...
|   |-- terraform-file.tf
|   |-- terraform-file.tf
|   |-- ...
```

The `project-deployment` directory contains the [Terraform](https://www.terraform.io/) code to deploy the project on the host server and [cloud-init](https://cloud-init.io/) files for providing boot-time commands to container instances, if necessary.
