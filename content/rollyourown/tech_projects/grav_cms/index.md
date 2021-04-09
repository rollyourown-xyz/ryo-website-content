---
title: "Roll Your Own Grav CMS"
date: "2021–04–08"
draft: "false"
---

## About this project

This project deploys a [Grav](https://getgrav.org) flat-file content management system on an [nginx](https://nginx.org/) web server, with [HAProxy](https://www.haproxy.org/) for TLS/SSL termination and [Certbot](https://certbot.eff.org/) for managing your letsencrypt certificate.

<!--more-->

[Grav](https://getgrav.org) is an open source flat-file content management system (CMS), based on PHP, that uses only files and folders and no database for managing content. Grav provides a fast, more lightweight alternative to database-driven CMSs like [Wordpress](https://wordpress.org/) or [Drupal](https://www.drupal.org/), especially for simpler websites and blogs. Content can either be written directly in [Markdown](https://daringfireball.net/projects/markdown/) format and uploaded to the web server or via Grav's [web-based editor](https://learn.getgrav.org/17/admin-panel/page/editor) front-end.

## Repository links

The [rollyourown.xyz](https://rollyourown.xyz/) repositry for this project is here: [https://git.rollyourown.xyz/ryo-projects/ryo-grav-cms](https://git.rollyourown.xyz/ryo-projects/ryo-grav-cms)

The [github](https://github.com/) mirror repository for this project is here: [https://github.com/rollyourown-xyz/ryo-projects-grav-cms/](https://github.com/rollyourown-xyz/ryo-projects-grav-cms/)

## Components deployed

TODO: Diagram and description of the components deployed by the project and what they do. Links to building blocks section for more detailed explanation.

## How to use this project

TODO: Link to generic instructructions for deployment and how to maintain the installation.

For a full overview of how to use [Grav](https://getgrav.org), see the excellent documentation at [https://learn.getgrav.org/](https://learn.getgrav.org/).

TODO: In short, after deployment, you can ... (log in as admin, create editor user(s), add content manually via host or via web front-end, use Grav's admin interface to change the theme of the site and add additional plugins, backup directly from host or with Grav's built-in backup tool). - See https://getgrav.org/features for links

* [Manage content](https://learn.getgrav.org/17/admin-panel/page)
* [Themes](https://learn.getgrav.org/17/admin-panel/themes)
* [Plugins](https://learn.getgrav.org/17/admin-panel/plugins)


## Project requirements

As a flat-file CMS, [Grav](https://getgrav.org) does not need huge resources to run, so that this project can be deployed on smaller, cheaper entry-level virtual servers or home servers.

TODO: mention successful deployment on Strato entry-level server (only mention specs)

## Software deployed

The open source software deployed by the project is:

{{< table tableclass="table table-bordered table-striped" theadclass="thead-dark" >}}

| Project | What is it? | Homepage | License |
| :------ | :---------- | :------- | :------ |
| Certbot | Open source [letsencrypt](https://letsencrypt.org/) certificate manager | [https://certbot.eff.org/](https://certbot.eff.org/) | [Apache 2.0](https://raw.githubusercontent.com/certbot/certbot/master/LICENSE.txt) |
| Grav | Open source flat-file CMS | [https://getgrav.org/](https://getgrav.org/) | [MIT](https://github.com/getgrav/grav/blob/develop/LICENSE.txt) |
| HAProxy | Open source load balancer, TCP and HTTP proxy | [https://www.haproxy.org/](https://www.haproxy.org/) | [GPL/LGPL](https://github.com/haproxy/haproxy/blob/master/LICENSE) |
| nginx | Open source webserver for the [Grav](https://getgrav.org/) installation | [https://nginx.org/](https://nginx.org/) | [2-clause BSD license](http://nginx.org/LICENSE) |
| Webhook | Open source, light-weight, general purpose webhook server | [https://github.com/adnanh/webhook](https://github.com/adnanh/webhook) | [MIT](https://github.com/adnanh/webhook/blob/master/LICENSE) |

{{< /table >}}
