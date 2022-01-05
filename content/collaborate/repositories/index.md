---
title: "Repositories"
weight: 7
tags: [ ]
draft: true
---

The code for all rollyourown.xyz projects and project modules, as well as the content of the rollyourown.xyz website itself, is hosted in repositories on [our Gitea server](https://git.rollyourown.xyz/) and mirrored to [Github](https://github.com/rollyourown-xyz).

Other repositories are hosted only on [our Gitea server](https://git.rollyourown.xyz/).

<!--more-->

## TODOs on this page

{{< highlight "primary" "ToDo">}}

- [ ] ryo-organization repositories
- [ ] ryo-infrastructure repositories

{{< /highlight >}}

## Organisation structure

Our [Gitea server](https://git.rollyourown.xyz/) repositories are structured in four organisations:

- ryo-infrastructure: Code repositories for deploying and managing the infrastructure behind rollyourown.xyz
- ryo-organization: Repositories for managing assets related to the rollyourown.xyz project organisation
- ryo-projects: Repositories for rollyourown.xyz projects and project modules
- ryo-test: Repositories for rollyourown.xyz project and project module testing
- ryo-website: Repositories for the content of the rollyourown.xyz website and its Hugo theme

## Repositories: ryo-infrastructure

{{< highlight "info">}}

Our infrastructure repositories are not yet public, not mirrored to [Github](https://github.com), and are only accessible for authorised users. We plan to make these repositories public at a later date.

{{< /highlight >}}

{{< table tableclass="table table-bordered table-striped" theadclass="thead-dark" >}}

| Repository | Content | Private or public | Github |
| :--------- | :------ | :---------------- | :----- |
| TODO | TODO | private | not yet mirrored |
| TODO | TODO | private | not yet mirrored |

{{< /table >}}

## Repositories: ryo-organization

{{< highlight "info">}}

Our organisation repositories are not yet public, not mirrored to [Github](https://github.com), and are only accessible for authorised users. We may make some of these repositories public at a later date.

{{< /highlight >}}

{{< table tableclass="table table-bordered table-striped" theadclass="thead-dark" >}}

| Repository | Content | Private or public | Github |
| :--------- | :------ | :---------------- | :----- |
| TODO | TODO | private | not yet mirrored |
| TODO | TODO | private | not yet mirrored |

{{< /table >}}

## Repositories: ryo-projects

{{< highlight "info">}}

Our project and module repositories are generally public and mirrored to [Github](https://github.com) unless they are still under development.

{{< /highlight >}}

{{< table tableclass="table table-bordered table-striped" theadclass="thead-dark" >}}

| Repository | Content | Private or public | Github |
| :--------- | :------ | :---------------- | :----- |
| [ryo-control-node](https://git.rollyourown.xyz/ryo-projects/ryo-control-node) | Playbooks for setup of a rollyourown.xyz [control node](/rollyourown/projects/control_node/) | public | [Link](https://github.com/rollyourown-xyz/ryo-control-node) |
| [ryo-coturn](https://git.rollyourown.xyz/ryo-projects/ryo-coturn) | rollyourown.xyz [module](/rollyourown/project_modules/ryo-coturn/) for deploying a [coturn](https://github.com/coturn/coturn) server | public | [Link](https://github.com/rollyourown-xyz/ryo-coturn) |
| [ryo-gitea-standalone](https://git.rollyourown.xyz/ryo-projects/ryo-gitea-standalone) | rollyourown.xyz [project](/rollyourown/projects/single_server_projects/ryo-gitea/) for deploying a standalone [Gitea](https://gitea.io/) [git](https://git-scm.com/) server | public | [Link](https://github.com/rollyourown-xyz/ryo-gitea-standalone) |
| [ryo-gitea-with-sso](https://git.rollyourown.xyz/ryo-projects/ryo-gitea-with-sso) | (WiP - not yet published) rollyourown.xyz [project](/rollyourown/projects/single_server_projects/ryo-gitea/) for deploying an SSO-enabled [Gitea](https://gitea.io/) [git](https://git-scm.com/) server | private | not yet mirrored |
| [ryo-grav-cms](https://git.rollyourown.xyz/ryo-projects/ryo-grav-cms) | rollyourown.xyz [project](/rollyourown/projects/single_server_projects/ryo-grav-cms/) for deploying a simple [Grav CMS](https://getgrav.org/) | public | [Link](https://github.com/rollyourown-xyz/ryo-grav-cms) |
| [ryo-host](https://git.rollyourown.xyz/ryo-projects/ryo-host) | Playbooks for generic setup of a rollyourown.xyz [project host](/rollyourown/projects/host_server/) | public | [Link](https://github.com/rollyourown-xyz/ryo-host) |
| [ryo-jitsi](https://git.rollyourown.xyz/ryo-projects/ryo-jitsi) | (WiP - not yet published) rollyourown.xyz [project](/rollyourown/projects/single_server_projects/ryo-jitsi/) for deploying a [jitsi](https://jitsi.org/) video conferencing service | private | not yet mirrored |
| [ryo-keycloak](https://git.rollyourown.xyz/ryo-projects/ryo-keycloak) | (WiP - not yet published) rollyourown.xyz [project](/rollyourown/projects/single_server_projects/ryo-keycloak/) for deploying a [Keycloak](https://www.keycloak.org/) IAM server | private | not yet mirrored |
| [ryo-mariadb](https://git.rollyourown.xyz/ryo-projects/ryo-mariadb) | rollyourown.xyz [module](/rollyourown/project_modules/ryo-mariadb/) for deploying a [MariaDB](https://mariadb.org/) relational database | public | [Link](https://github.com/rollyourown-xyz/ryo-mariadb) |
| [ryo-matrix-standalone](https://git.rollyourown.xyz/ryo-projects/ryo-matrix-standalone) | rollyourown.xyz [project](/rollyourown/projects/single_server_projects/ryo-matrix/) for deploying a standalone [Matrix](https://matrix.org/) homeserver | public | [Link](https://github.com/rollyourown-xyz/ryo-matrix-standalone) |
| [ryo-matrix-with-sso](https://git.rollyourown.xyz/ryo-projects/ryo-matrix-with-sso) | (WiP - not yet published) rollyourown.xyz [project](/rollyourown/projects/single_server_projects/ryo-matrix/) for deploying an SSO-enabled [Matrix](https://matrix.org/) homeserver | private | not yet mirrored |
| [ryo-module-template](https://git.rollyourown.xyz/ryo-projects/ryo-module-template) | Template [folder structure](/collaborate/module_structure/) for a rollyourown.xyz module | public | [Link](https://github.com/rollyourown-xyz/ryo-module-template) |
| [ryo-nextcloud-standalone](https://git.rollyourown.xyz/ryo-projects/ryo-nextcloud-standalone) | rollyourown.xyz [project](/rollyourown/projects/single_server_projects/ryo-nextcloud/) for deploying a standalone [Nextcloud](https://nextcloud.com/) server | public | [Link](https://github.com/rollyourown-xyz/ryo-nextcloud-standalone) |
| [ryo-postgres](https://git.rollyourown.xyz/ryo-projects/ryo-postgres) | rollyourown.xyz [module](/rollyourown/project_modules/ryo-postgres/) for deploying a [PostgreSQL](https://www.postgresql.org/) relational database | public | [Link](https://github.com/rollyourown-xyz/ryo-postgres) |
| [ryo-project-template](https://git.rollyourown.xyz/ryo-projects/ryo-project-template) | Template [folder structure](/collaborate/project_structure/) for a rollyourown.xyz project | public | [Link](https://github.com/rollyourown-xyz/ryo-project-template) |
| [ryo-service-proxy](https://git.rollyourown.xyz/ryo-projects/ryo-service-proxy) | rollyourown.xyz [module](/rollyourown/project_modules/ryo-service-proxy/) for deploying a loadbalancer / TLS proxy | public | [Link](https://github.com/rollyourown-xyz/ryo-service-proxy) |
| [ryo-wellknown](https://git.rollyourown.xyz/ryo-projects/ryo-wellknown) | rollyourown.xyz [module](/rollyourown/project_modules/ryo-wellknown/) for deploying a webserver to respond to [well-known URIs](https://en.wikipedia.org/wiki/Well-known_URI) | public | [Link](https://github.com/rollyourown-xyz/ryo-wellknown) |

{{< /table >}}

## Repositories: ryo-test

{{< highlight "info">}}

Our test repositories are not yet public, not mirrored to [Github](https://github.com), and are only accessible for authorised users. We may make these repositories public at a later date.

{{< /highlight >}}

{{< table tableclass="table table-bordered table-striped" theadclass="thead-dark" >}}

| Repository | Content | Private or public | Github |
| :--------- | :------ | :---------------- | :----- |
| [ryo-test-gitea](https://git.rollyourown.xyz/ryo-test/ryo-test-gitea) | Code for creating test infrastructure for the [ryo-gitea-standalone](https://git.rollyourown.xyz/ryo-projects/ryo-gitea-standalone) and [ryo-gitea-with-sso](https://git.rollyourown.xyz/ryo-projects/ryo-gitea-with-sso) projects | private | not mirrored |
| [ryo-test-grav-cms](https://git.rollyourown.xyz/ryo-test/ryo-test-grav-cms) | Code for creating test infrastructure for the [ryo-grav-cms](https://git.rollyourown.xyz/ryo-projects/ryo-grav-cms) project | private | not mirrored |
| [ryo-test-matrix](https://git.rollyourown.xyz/ryo-test/ryo-test-matrix) | Code for creating test infrastructure for the [ryo-matrix-standalone](https://git.rollyourown.xyz/ryo-projects/ryo-matrix-standalone) and [ryo-matrix-with-sso](https://git.rollyourown.xyz/ryo-projects/ryo-matrix-with-sso) projects | private | not mirrored |
| [ryo-test-nextcloud](https://git.rollyourown.xyz/ryo-test/ryo-test-nextcloud) | Code for creating test infrastructure for the [ryo-nextcloud-standalone](https://git.rollyourown.xyz/ryo-projects/ryo-nextcloud-standalone) and [ryo-nextcloud-with-sso](https://git.rollyourown.xyz/ryo-projects/ryo-nextcloud-with-sso) projects |private | not mirrored |
| [ryo-test-template](https://git.rollyourown.xyz/ryo-test/ryo-test-template) | Template project for creating test infrastructure for rollyourown.xyz projects | private | not mirrored |

{{< /table >}}

## Repositories: ryo-website

{{< highlight "info">}}

The repository containing our website content is public and mirrored to GitHub.

The repositories for our website theme and forms server are private, not mirrored to [Github](https://github.com), and are only accessible for authorised users.  We may make these repositories public at a later date.

{{< /highlight >}}

{{< table tableclass="table table-bordered table-striped" theadclass="thead-dark" >}}

| Repository | Content | Private or public | Github |
| :--------- | :------ | :---------------- | :----- |
| [form-server-content-and-theme](https://git.rollyourown.xyz/ryo-website/form-server-content-and-theme) | [Grav](https://getgrav.org/) content and theme for the rollyourown.xyz forms server | private | not mirrored |
| [hugo-content](https://git.rollyourown.xyz/ryo-website/hugo-content) | Content and configuration for [Hugo](https://gohugo.io/) static site generation of the rollyourown.xyz website | public | [Link](https://github.com/rollyourown-xyz/ryo-website-hugo-content) |
| [hugo-theme](https://git.rollyourown.xyz/ryo-website/hugo-theme) | The [Hugo](https://gohugo.io/) [theme](https://gohugo.io/hugo-modules/theme-components/) for the rollyourown.xyz website | private | not mirrored |

{{< /table >}}
