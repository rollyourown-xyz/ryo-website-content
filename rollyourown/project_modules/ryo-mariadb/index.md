---
title: "Module: MariaDB Database"
tags: [ "module" ]
draft: true
---
<!--
SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
SPDX-License-Identifier: CC-BY-SA-4.0
-->

The MariaDB Database module is a re-usable module for other rollyourown projects. The module provides a MariaDB [relational database](https://en.wikipedia.org/wiki/Relational_database) server.

<!--more-->

This documentation is intended for developers of rollyourown projects.

## Introduction

This module deploys [MariaDB](https://mariadb.org/). [MariaDB](https://mariadb.org/) is an open source, MySQL-compatible relational database system.

## Repository links

The [Codeberg](https://codeberg.org/) mirror repository for this module is here: [https://codeberg.org/rollyourown-xyz/ryo-mariadb](https://codeberg.org/rollyourown-xyz/ryo-mariadb)

The [Github](https://github.com/) mirror repository for this module is here: [https://github.com/rollyourown-xyz/ryo-mariadb](https://github.com/rollyourown-xyz/ryo-mariadb)

The rollyourown repository for this project is here: [https://git.rollyourown.xyz/ryo-projects/ryo-mariadb](https://git.rollyourown.xyz/ryo-projects/ryo-mariadb) (not publicly accessible)

## Dependencies

This module has no dependencies.

## Module components

This project module deploys a container with multiple services as shown in the following diagram:

{{< image src="Module_Overview.svg" title="Module Overview">}}

The MariaDB database module contains two applications, together providing a mariadb database server to be used in other rollyourown projects.

### MariaDB

The mariadb application is deployed from the [mariadb.org](https://mariadb.org) repositories and [`mysql_secure_installation`](https://mariadb.com/kb/en/mysql_secure_installation/) configuration is carried out to prevent root account access from outside the local host, remove anonymous user accounts and remove the test database. A dedicated database user is created so that further databases and users can be provisioned by terraform scripts from the control node as part of rollyourown project deployment.

### Consul

A Consul agent is deployed on the MariaDB database module and joins the Consul server on the host in client mode. The Consul agent registers mariadb as a service in the Consul service registry, so that other containers can discover its internal network IP address.

## How to deploy this module in a project or module

The [repository for this module](https://github.com/rollyourown-xyz/ryo-mariadb) contains a number of resources for including the module in a rollyourown project. The steps for including the module are:

1. Add the MariaDB Database module to the `get-modules.sh` script in the project:

    ```bash
    ## MariaDB Database module
    if [ -d "../ryo-mariadb" ]
    then
       echo "Module ryo-mariadb already cloned to this control node"
    else
       echo "Cloning ryo-mariadb repository. Executing 'git clone' for ryo-mariadb repository"
       git clone https://github.com/rollyourown-xyz/ryo-mariadb ../ryo-mariadb
    fi
    ```

2. Add the MariaDB Database module to the project's `host-setup.sh` script:

    ```bash
    ## Module-specific host setup for ryo-mariadb
    if [ -f ""$SCRIPT_DIR"/../ryo-mariadb/configuration/"$hostname"_playbooks_executed" ]
    then
       echo "Host setup for ryo-mariadb module has already been done on "$hostname""
       echo ""
    else
       echo "Running module-specific host setup script for ryo-mariadb on "$hostname""
       echo ""
       "$SCRIPT_DIR"/../ryo-mariadb/host-setup.sh -n "$hostname"
    fi
    ```

3. Add the MariaDB Database module to the project's `build-images.sh` script:

    ```bash
    # Build MariaDB Database module images if -m flag is present
    if [ $build_modules == 'true' ]
    then
       echo "Running build-images script for ryo-mariadb module on "$hostname""
       echo ""
       "$SCRIPT_DIR"/../ryo-mariadb/build-images.sh -n "$hostname" -v "$version"
    else
       echo "Skipping image build for the MariaDB Database module"
       echo ""
    fi
    ```

4. Add the MariaDB Database module to the `deploy-project.sh` script in the project:

    ```bash
    # Deploy MariaDB Database module if -m flag is present
    if [ $deploy_modules == 'true' ]
    then
       echo "Deploying ryo-mariadb module on "$hostname" using images with version "$version""
       echo ""
       "$SCRIPT_DIR"/../ryo-mariadb/deploy-module.sh -n "$hostname" -v "$version"
       echo ""
    else
       echo "Skipping MariaDB Database module deployment"
       echo ""
    fi
    ```

## How to use this module in a project

A project component needing a MySQL database needs to be configured to discover and access the mariadb database provided by this module.

### Image configuration

To connect to the MariaDB database server, an application needs to be able to communicate with the server.  The database server is registered in the Consul service registry with the name `mariadb` and the (dynamic, private) IP address of the server is available to the connecting application via the DNS name `mariadb.service.ryo` via a Consul agent deployed with the application.

The [ryo-project-template repository](https://github.com/rollyourown-xyz/ryo-project-template) includes Ansible roles for deploying and configuring the Consul agent:

- The role `install-consul` installs the consul agent
- The role `set-up-consul` configures the consul agent to join the Consul server running on the host and enable local application name resolution via Consul
- The role `set-up-firewall` configures IP tables rules to map DNS port 53 to the local Consul listening port

The project application configuration can then include the DNS name `mariadb.service.ryo` in its database configuration.

{{< more "secondary" "Example">}}

As an example, the database configuration for the nextcloud service component in the [ryo-nextcloud](https://github.com/rollyourown-xyz/ryo-nextcloud) project includes the configuration:

```php
<?php
$AUTOCONFIG = array (
  ...
  "dbhost"        => "mariadb.service.ryo:3306",
  ...
);
```

{{< /more >}}

### General deployment configuration

Configuration of mariadb databases and database users is done during the project deployment step.

#### Terraform configuration for provisioning MariaDB

During a rollyourown project deployment, the terraform [mysql provider](https://github.com/hashicorp/terraform-provider-mysql/) is used to provision databases and database users to the mariadb module.

The MariaDB Database module uses a special 'terraform' user to provision databases and users to the mariadb database for use by project components. The terraform user password for the MariaDB database is generated when building the mariadb container image and is stored in the file `/ryo-projects/ryo-mariadb/configuration/mariadb_terraform_user_password_<HOST_ID>.yml` on the control node.

To use this secret in configuring the mysql provider, the configuration terraform user password needs to be added as a terraform variable. This is done by adding the following to the project's terraform files:

```tf
# MariaDB module variables
locals {
  mariadb_terraform_user_password_file = join("", ["${abspath(path.root)}/../../ryo-mariadb/configuration/mariadb_terraform_user_password_", var.host_id, ".yml"])
  mariadb_terraform_user_password      = sensitive(yamldecode(file(local.mariadb_terraform_user_password_file))["mariadb_terraform_user_password"])
}
```

Then the mysql provider is added to the project's terraform configuration:

```tf
terraform {
  required_version = ">= 0.15"
  required_providers {
    lxd = {
      source  = "terraform-lxd/lxd"
      version = "~> 1.5.0"
    }
    mysql = {
      source  = "terraform-providers/mysql"
      version = ">= 1.5"
    }
  }
}
```

Finally, the `mariadb_terraform_user_password` variable is used to configure the provider, along with the DNS name `mariadb.service.<HOST_ID>.ryo`:

```tf
provider "mysql" {
  endpoint = join("", [ "mariadb.service.", var.host_id, ".ryo", ":3306" ])
  username = "terraform"
  password = local.mariadb_terraform_user_password
}
```

#### Terraform modules for provisioning MariaDB

The MariaDB module repository includes a terraform module `deploy-mysql-db-and-user` for provisioning databases and database users to the mariadb server.

For example:

```tf
module "deploy-COMPONENT-database-and-user" {
  source = "../../ryo-mariadb/module-deployment/modules/deploy-mysql-db-and-user"
  
  mysql_db_name = "COMPONENT"
  mysql_db_default_charset = "utf8mb4"
  mysql_db_default_collation = "utf8mb4_unicode_ci"
  mysql_db_user = "COMPONENT-db-user"
  mysql_db_user_hosts = [ "localhost", join(".", [ local.lxd_host_network_part, "%" ])]
  mysql_db_user_password = "COMPONENT_user_password"
  mysql_db_table = "*"
  mysql_db_privileges = [ "ALL" ]
}
```

## Software deployed

The open source components deployed by this module are:

{{< table tableclass="table table-bordered table-striped" theadclass="table-primary" >}}

| Project | What is it? | Homepage | License |
| :------ | :---------- | :------- | :------ |
| Consul | Service registry and key-value store | [https://www.consul.io/](https://www.consul.io/) | [MPL 2.0](https://github.com/hashicorp/consul/blob/master/LICENSE) |
| MariaDB | Relational database system | [https://mariadb.org/](https://mariadb.org/) | [GPL v2 / LGPL](https://mariadb.com/kb/en/mariadb-license/) |

{{< /table >}}
