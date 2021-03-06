---
title: "Credits"
weight: 6
tags: []
draft: false
---
<!--
SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
SPDX-License-Identifier: CC-BY-SA-4.0
-->

This project builds on and would not be possible without a number of other open source projects. We are intensely grateful to the communities developing and maintaining these amazing projects.

<!--more-->

In alphabetical order, the projects powering rollyourown are:

{{< table tableclass="table table-bordered table-striped" theadclass="table-primary" >}}

| Project | Used for... | Project homepage | Licence |
| :------ | :---------- | :--------------- | :------ |
| Ansible | Configuring our host servers and container images | [https://www.ansible.com/](https://www.ansible.com/) | [GPL v3](https://github.com/ansible/ansible/blob/devel/COPYING) |
| Bootstrap | Layout and responsive design for the rollyourown website | [https://getbootstrap.com/](https://getbootstrap.com/) | [MIT](https://github.com/twbs/bootstrap/blob/main/LICENSE) |
| Certbot | Managing our [Let's Encrypt](https://letsencrypt.org/) certificates | [https://certbot.eff.org/](https://certbot.eff.org/) | [Apache 2.0](https://raw.githubusercontent.com/certbot/certbot/master/LICENSE.txt) |
| Codeberg | Hosting our mirror repositories and enabling public collaboration | [https://codeberg.org](https://codeberg.org) | [Non-profit association](https://docs.codeberg.org/getting-started/what-is-codeberg/) |
| Consul | Providing service discovery and configuration for project component nodes | [https://www.consul.io/](https://www.consul.io/) | [MPL 2.0](https://github.com/hashicorp/consul/blob/master/LICENSE) |
| Consul-Template | Dynamic, run-time configuration of various services | [https://github.com/hashicorp/consul-template/](https://github.com/hashicorp/consul-template/) | [MPL 2.0](https://github.com/hashicorp/consul-template/blob/master/LICENSE) |
| Coturn  | Enabling our voice/video calls and conferences | [https://github.com/coturn/coturn](https://github.com/coturn/coturn) | [https://github.com/coturn/coturn/blob/master/LICENSE](https://github.com/coturn/coturn/blob/master/LICENSE) |
| Element-Web | Web-based Matrix client for our chatrooms and messaging | [https://element.io/](https://element.io/) | [Apache 2.0](https://github.com/vector-im/element-web/blob/develop/LICENSE) |
| Feather | Icons for the rollyourown website | [https://feathericons.com/](https://feathericons.com/) | [MIT](https://github.com/feathericons/feather/blob/master/LICENSE) |
| Git | Version control for everything we do | [https://git-scm.com/](https://git-scm.com/) | [GPL v2](https://github.com/git/git/blob/master/COPYING) |
| Gitea | Our Git repository hosting service | [https://gitea.io/](https://gitea.io/) | [MIT](https://github.com/go-gitea/gitea/blob/main/LICENSE) |
| HAProxy | TLS termination, reverse proxying and loadbalancing | [https://www.haproxy.org/](https://www.haproxy.org/) | [GPL / LGPL](https://github.com/haproxy/haproxy/blob/master/LICENSE) |
| Grav | Dynamic pages on the rollyourown website, such as contact forms | [https://getgrav.org/](https://getgrav.org/) | [MIT](https://github.com/getgrav/grav/blob/develop/LICENSE.txt) |
| Hugo | Static site generation for the rollyourown website | [https://gohugo.io/](https://gohugo.io/) | [Apache 2.0](https://github.com/gohugoio/hugo/blob/master/LICENSE) |
| LXD/LXC | Deploying system containers to our servers | [https://linuxcontainers.org/lxd/](https://linuxcontainers.org/lxd/) | [Apache 2.0](https://github.com/lxc/lxd/blob/master/COPYING) |
| MariaDB | A database behind various services | [https://mariadb.org/](https://mariadb.org/) | [GPL v2 / LGPL](https://mariadb.com/kb/en/mariadb-license/) |
| nginx | The web server for various parts of our website and services | [https://nginx.org/](https://nginx.org/) | [2-clause BSD Licence](http://nginx.org/LICENSE) |
| oauth2-proxy | Proxy for enabling OAuth2 login for our development website | [https://oauth2-proxy.github.io/oauth2-proxy/](https://oauth2-proxy.github.io/oauth2-proxy/) | [MIT](https://github.com/oauth2-proxy/oauth2-proxy/blob/master/LICENSE) |
| Pac???er | Building container images for all of our services | [https://www.packer.io/](https://www.packer.io/) | [MPL 2.0](https://github.com/hashicorp/packer/blob/master/LICENSE) |
| PostgreSQL | A databases behind various services | [https://www.postgresql.org/](https://www.postgresql.org/) | [PostgreSQL Licence](https://www.postgresql.org/about/licence/) |
| Synapse | Homeserver for our [Matrix](https://matrix.org/) chatrooms and messaging system for our team and collaborators | [https://matrix-org.github.io/synapse/](https://matrix-org.github.io/synapse/) | [Apache 2.0](https://github.com/matrix-org/synapse/blob/develop/LICENSE) |
| Terraform | Deploying our services | [https://www.terraform.io/](https://www.terraform.io/) | [MPL 2.0](https://github.com/hashicorp/terraform/blob/main/LICENSE) |
| Ubuntu Linux | Operating system for our servers and system containers | [https://ubuntu.com/](https://ubuntu.com/) | [Canonical IPRights Policy](https://ubuntu.com/legal/intellectual-property-policy) |
| Webhook | Triggering automatic website updates | [https://github.com/adnanh/webhook](https://github.com/adnanh/webhook) | [MIT](https://github.com/adnanh/webhook/blob/master/LICENSE) |
| Wireguard | Secure networking between our control machines and servers | [https://www.wireguard.com/](https://www.wireguard.com/) | [GPL v2](https://www.wireguard.com/#license) |

{{< /table >}}

Gratitude is also due for the tutorial at [https://retrolog.io/blog/creating-a-hugo-theme-from-scratch/](https://retrolog.io/blog/creating-a-hugo-theme-from-scratch/) for helping us get started with our hugo website theme.
