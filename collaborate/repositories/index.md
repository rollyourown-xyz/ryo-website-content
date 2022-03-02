---
title: "Repositories"
weight: 8
tags: [ ]
draft: false
---

The code for all rollyourown.xyz projects and project modules, as well as the content of the rollyourown.xyz website itself, is hosted in repositories on our own Git repository servers and mirrored [to Codeberg](https://codeberg.org/rollyourown-xyz) and [to Github](https://github.com/rollyourown-xyz).

Other repositories are hosted only on our own Git repository servers.

<!--more-->

## Organization structure

The repositories on our own Git repository servers are organised in five areas:

- [ryo-infrastructure](https://git.rollyourown.xyz/ryo-infrastructure): Repositories for deploying and managing the infrastructure behind rollyourown.xyz
- [ryo-organisation](https://git.rollyourown.xyz/ryo-organisation): Repositories for managing assets related to the rollyourown.xyz project organisation
- [ryo-projects](https://git.rollyourown.xyz/ryo-projects): Repositories for rollyourown.xyz projects and project modules
- [ryo-test](https://git.rollyourown.xyz/ryo-test): Repositories for rollyourown.xyz project and project module testing
- [ryo-website](https://git.rollyourown.xyz/ryo-website): Repositories for the content of the rollyourown.xyz website, the Hugo theme for the website and the content and theme of our forms server

Currently, the organisation structure and repositories on our own Git repository servers are visible only to members of our organisation. Public repositories are mirrored [to Codeberg](https://codeberg.org/rollyourown-xyz) and [to Github](https://github.com/rollyourown-xyz) for wider collaboration.

## Repositories: ryo-infrastructure

{{< highlight "info">}}

Our infrastructure repositories are not yet public, not mirrored to [Codeberg](https://codeberg.org) or [Github](https://github.com), and are only accessible for authorised users. We plan to make these repositories public at a later date.

{{< /highlight >}}

{{< table tableclass="table table-bordered table-striped" theadclass="table-primary" >}}

| Repository | Content | Private or public | Codeberg / Github links |
| :--------- | :------ | :---------------- | :----- |
| [ryo-xyz-infrastructure](https://git.rollyourown.xyz/ryo-infrastructure/ryo-xyz-infrastructure) | A repository containing the configuration for our host server(s) and deployed projects | private | not yet mirrored |

{{< /table >}}

## Repositories: ryo-organisation

{{< highlight "info">}}

Our organisation repositories are generally not yet public, not mirrored to [Codeberg](https://codeberg.org) or [Github](https://github.com), and are only accessible for authorised users. We may make some of these repositories public at a later date.

{{< /highlight >}}

{{< table tableclass="table table-bordered table-striped" theadclass="table-primary" >}}

| Repository | Content | Private or public | Codeberg / Github links |
| :--------- | :------ | :---------------- | :----- |
| [contact-details](https://git.rollyourown.xyz/ryo-organisation/contact-details) | A repository for documenting rollyourown.xyz email accounts and phone numbers | private | not mirrored |
| [general-feedback](https://git.rollyourown.xyz/ryo-organisation/general-feedback) | An issues-only repository for general feedback for the rollyourown.xyz project and for suggesting new projects or modules | public | [Codeberg](https://codeberg.org/rollyourown-xyz/general-feedback) / [GitHub](https://github.com/rollyourown-xyz/general-feedback) |

{{< /table >}}

## Repositories: ryo-projects

{{< highlight "info">}}

Our project and module repositories are generally public and mirrored to [Codeberg](https://codeberg.org) and [Github](https://github.com) unless they are still under development.

{{< /highlight >}}

{{< table tableclass="table table-bordered table-striped" theadclass="table-primary" >}}

| Repository | Content | Private or public | Codeberg / Github links |
| :--------- | :------ | :---------------- | :----- |
| [ryo-control-node](https://git.rollyourown.xyz/ryo-projects/ryo-control-node) | Playbooks for setup of a rollyourown.xyz [control node](/rollyourown/how_to_use/control_node/) | public | [Codeberg](https://codeberg.org/rollyourown-xyz/ryo-control-node) / [GitHub](https://github.com/rollyourown-xyz/ryo-control-node) |
| [ryo-coturn](https://git.rollyourown.xyz/ryo-projects/ryo-coturn) | rollyourown.xyz [module](/rollyourown/project_modules/ryo-coturn/) for deploying a [coturn](https://github.com/coturn/coturn) server | public | [Codeberg](https://codeberg.org/rollyourown-xyz/ryo-coturn) / [GitHub](https://github.com/rollyourown-xyz/ryo-coturn) |
| [ryo-gitea](https://git.rollyourown.xyz/ryo-projects/ryo-gitea) | rollyourown.xyz [project](/rollyourown/projects/ryo-gitea/) for deploying a [Gitea](https://gitea.io/) [git](https://git-scm.com/) server | public | [Codeberg](https://codeberg.org/rollyourown-xyz/ryo-gitea) / [GitHub](https://github.com/rollyourown-xyz/ryo-gitea) |
| [ryo-grav-cms](https://git.rollyourown.xyz/ryo-projects/ryo-grav-cms) | rollyourown.xyz [project](/rollyourown/projects/ryo-grav-cms/) for deploying a flat-file [Grav](https://getgrav.org/) Content Management System (CMS) | public | [Codeberg](https://codeberg.org/rollyourown-xyz/ryo-grav-cms) / [GitHub](https://github.com/rollyourown-xyz/ryo-grav-cms) |
| [ryo-host](https://git.rollyourown.xyz/ryo-projects/ryo-host) | Playbooks for generic setup of a rollyourown.xyz [project host](/rollyourown/how_to_use/host_server/) | public | [Codeberg](https://codeberg.org/rollyourown-xyz/ryo-host) / [GitHub](https://github.com/rollyourown-xyz/ryo-host) |
| [ryo-hugo-website](https://git.rollyourown.xyz/ryo-projects/ryo-hugo-website) | rollyourown.xyz [project](/rollyourown/projects/ryo-hugo-website/) for deploying a [Hugo](https://gohugo.io/)-generated static website with the content and theme stored in Git repositories | public | [Codeberg](https://codeberg.org/rollyourown-xyz/ryo-hugo-website) / [GitHub](https://github.com/rollyourown-xyz/ryo-hugo-website) |
| [ryo-ingress-proxy](https://git.rollyourown.xyz/ryo-projects/ryo-ingress-proxy) | rollyourown.xyz [module](/rollyourown/project_modules/ryo-ingress-proxy/) for deploying a loadbalancer / TLS proxy | public | [Codeberg](https://codeberg.org/rollyourown-xyz/ryo-ingress-proxy) / [GitHub](https://github.com/rollyourown-xyz/ryo-ingress-proxy) |
| [ryo-jitsi](https://git.rollyourown.xyz/ryo-projects/ryo-jitsi) | (WiP - not yet published) rollyourown.xyz [project](/rollyourown/projects/ryo-jitsi/) for deploying a [jitsi](https://jitsi.org/) video conferencing service | private | not yet mirrored |
| [ryo-keycloak](https://git.rollyourown.xyz/ryo-projects/ryo-keycloak) | (WiP - not yet published) rollyourown.xyz [project](/rollyourown/projects/ryo-keycloak/) for deploying a [Keycloak](https://www.keycloak.org/) IAM server | private | not yet mirrored |
| [ryo-mariadb](https://git.rollyourown.xyz/ryo-projects/ryo-mariadb) | rollyourown.xyz [module](/rollyourown/project_modules/ryo-mariadb/) for deploying a [MariaDB](https://mariadb.org/) relational database | public | [Codeberg](https://codeberg.org/rollyourown-xyz/ryo-mariadb) / [GitHub](https://github.com/rollyourown-xyz/ryo-mariadb) |
| [ryo-matrix](https://git.rollyourown.xyz/ryo-projects/ryo-matrix) | rollyourown.xyz [project](/rollyourown/projects/ryo-matrix/) for deploying a [Matrix](https://matrix.org/) homeserver and [Element-Web](https://github.com/vector-im/element-web) web client | public | [Codeberg](https://codeberg.org/rollyourown-xyz/ryo-matrix) / [GitHub](https://github.com/rollyourown-xyz/ryo-matrix) |
| [ryo-module-template](https://git.rollyourown.xyz/ryo-projects/ryo-module-template) | Template [repository structure](/collaborate/project_and_module_development/module_structure/) for a rollyourown.xyz module | public | [Codeberg](https://codeberg.org/rollyourown-xyz/ryo-module-template) / [GitHub](https://github.com/rollyourown-xyz/ryo-module-template) |
| [ryo-nextcloud](https://git.rollyourown.xyz/ryo-projects/ryo-nextcloud) | rollyourown.xyz [project](/rollyourown/projects/ryo-nextcloud/) for deploying a [Nextcloud](https://nextcloud.com/) server | public | [Codeberg](https://codeberg.org/rollyourown-xyz/ryo-nextcloud) / [GitHub](https://github.com/rollyourown-xyz/ryo-nextcloud) |
| [ryo-postgres](https://git.rollyourown.xyz/ryo-projects/ryo-postgres) | rollyourown.xyz [module](/rollyourown/project_modules/ryo-postgres/) for deploying a [PostgreSQL](https://www.postgresql.org/) relational database | public | [Codeberg](https://codeberg.org/rollyourown-xyz/ryo-postgres) / [GitHub](https://github.com/rollyourown-xyz/ryo-postgres) |
| [ryo-project-template](https://git.rollyourown.xyz/ryo-projects/ryo-project-template) | Template [repository structure](/collaborate/project_and_module_development/project_structure/) for a rollyourown.xyz project | public | [Codeberg](https://codeberg.org/rollyourown-xyz/ryo-project-template) / [GitHub](https://github.com/rollyourown-xyz/ryo-project-template) |
| [ryo-wellknown](https://git.rollyourown.xyz/ryo-projects/ryo-wellknown) | rollyourown.xyz [module](/rollyourown/project_modules/ryo-wellknown/) for deploying a webserver to respond to [well-known URIs](https://en.wikipedia.org/wiki/Well-known_URI) | public | [Codeberg](https://codeberg.org/rollyourown-xyz/ryo-wellknown) / [GitHub](https://github.com/rollyourown-xyz/ryo-wellknown) |

{{< /table >}}

## Repositories: ryo-test

{{< highlight "info">}}

Our test repositories are not yet public, not mirrored to [Codeberg](https://codeberg.org) or [Github](https://github.com), and are only accessible for authorised users. We may make these repositories public at a later date.

{{< /highlight >}}

{{< table tableclass="table table-bordered table-striped" theadclass="table-primary" >}}

| Repository | Content | Private or public | Codeberg / Github links |
| :--------- | :------ | :---------------- | :----- |
| [ryo-test-gitea](https://git.rollyourown.xyz/ryo-test/ryo-test-gitea) | Code for creating test infrastructure for the [ryo-gitea](/rollyourown/projects/ryo-gitea/) project | private | not mirrored |
| [ryo-test-grav-cms](https://git.rollyourown.xyz/ryo-test/ryo-test-grav-cms) | Code for creating test infrastructure for the [ryo-grav-cms](/rollyourown/projects/ryo-grav-cms/) project | private | not mirrored |
| [ryo-test-hugo-website](https://git.rollyourown.xyz/ryo-test/ryo-test-hugo-website) | Code for creating test infrastructure for the [ryo-hugo-website](/rollyourown/projects/ryo-hugo-website/) project | private | not mirrored |
| [ryo-test-matrix](https://git.rollyourown.xyz/ryo-test/ryo-test-matrix) | Code for creating test infrastructure for the [ryo-matrix](/rollyourown/projects/ryo-matrix/) project | private | not mirrored |
| [ryo-test-nextcloud](https://git.rollyourown.xyz/ryo-test/ryo-test-nextcloud) | Code for creating test infrastructure for the [ryo-nextcloud](/rollyourown/projects/ryo-nextcloud/) project |private | not mirrored |
| [ryo-test-template](https://git.rollyourown.xyz/ryo-test/ryo-test-template) | Template repository for creating test infrastructure for rollyourown.xyz projects | private | not mirrored |

{{< /table >}}

## Repositories: ryo-website

{{< highlight "info">}}

The repository containing our website content is public and mirrored to [Codeberg](https://codeberg.org) and [Github](https://github.com).

The repositories for our website theme and forms server are private, not mirrored to [Codeberg](https://codeberg.org) or [Github](https://github.com), and are only accessible for authorised users.  We may make these repositories public at a later date.

{{< /highlight >}}

{{< table tableclass="table table-bordered table-striped" theadclass="table-primary" >}}

| Repository | Content | Private or public | Codeberg / Github links |
| :--------- | :------ | :---------------- | :----- |
| [form-server-content-and-theme](https://git.rollyourown.xyz/ryo-website/form-server-content-and-theme) | [Grav](https://getgrav.org/) content and theme for the rollyourown.xyz forms server | private | not mirrored |
| [hugo-content](https://git.rollyourown.xyz/ryo-website/hugo-content) | Content and configuration for [Hugo](https://gohugo.io/) static site generation of the rollyourown.xyz website | public | [Codeberg](https://codeberg.org/rollyourown-xyz/ryo-website-content) / [GitHub](https://github.com/rollyourown-xyz/ryo-website-content) |
| [hugo-content-template](https://git.rollyourown.xyz/ryo-website/hugo-content-template) | Template repository for generating a content and configuration repository for use with our [ryo-hugo-website](https://git.rollyourown.xyz/ryo-projects/ryo-hugo-website) project | public | [Codeberg](https://codeberg.org/rollyourown-xyz/ryo-hugo-website-content-template) / [GitHub](https://github.com/rollyourown-xyz/ryo-hugo-website-content-template) |
| [hugo-scaffold](https://git.rollyourown.xyz/ryo-website/hugo-scaffold) | Scaffold for [Hugo](https://gohugo.io/) static site generation of the rollyourown.xyz website | private | not mirrored |
| [hugo-scaffold-template](https://git.rollyourown.xyz/ryo-website/hugo-scaffold-template) | Template repository for generating a scaffold repository for use with our [ryo-hugo-website](https://git.rollyourown.xyz/ryo-projects/ryo-hugo-website) project | public | [Codeberg](https://codeberg.org/rollyourown-xyz/ryo-hugo-website-scaffold-template) / [GitHub](https://github.com/rollyourown-xyz/ryo-hugo-website-scaffold-template) |
| [hugo-theme](https://git.rollyourown.xyz/ryo-website/hugo-theme) | The [Bootstrap 5](https://getbootstrap.com/) based [Hugo](https://gohugo.io/) [theme](https://gohugo.io/hugo-modules/theme-components/) for the rollyourown.xyz website | private | not mirrored |

{{< /table >}}
