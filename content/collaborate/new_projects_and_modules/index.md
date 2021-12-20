---
title: "New Projects or Modules"
tags: [ ]
draft: true
---

The rollyourown.xyz projects and modules are the heart of our project and improving or adding to them is one of the most valuable contributions you can make.

If you would like to contribute a new project or module to the rollyourown.xyz project, then before all else: Thank you!

<!--more-->

## TODOs on this page

{{< highlight "primary" "ToDo">}}

- [ ] Check all links
- [ ] Check/change link to "Forking and Pull Requests"
- [ ] Refer to Issue Templates

{{< /highlight >}}

## Anatomy of a project or module

We aim for maximum re-usability and expect our projects and modules to follow a consistent pattern.

Before starting work, please familiarise yourself with the structure of a rollyourown.xyz project or module by reading the [documentation on project and module development](/collaborate/project_and_module_development/) and looking at the template repositories (for [projects](https://git.rollyourown.xyz/ryo-projects/ryo-project-template) and/or for [modules](https://git.rollyourown.xyz/ryo-projects/ryo-module-template)).

## Planning a new project or module

When you are familiar with the [anatomy of a project or module](#anatomy-of-a-project-or-module), then please [submit an Issue](https://github.com/rollyourown-xyz/general-feedback/issues) in the [general-feedback repository](https://github.com/rollyourown-xyz/general-feedback) on GitHub to describe your proposal and discuss your ideas with us. We will discuss, for example:

- The open source software you plan to deploy with your project
- Whether a similar project or module is already under development, in which case we'll invite you to collaborate on this
- The structure of the project including, for example, which already-existing modules can be re-used in the project
- Whether new re-usable modules should be developed to support your idea
- The documentation on the [rollyourown.xyz website](https://rollyourown.xyz) that will also need to be created for the project
- Which other rollyourown.xyz collaborators would like to work with you on your project

We will also discuss whether you would like to join the rollyourown.xyz organisation [LINK HERE TO A "WHAT YOU GET" SECTION] and become the maintainer for your project. For an idea of what this entails, please see our page on [Maintaining a Repository](/collaborate/maintaining_a_repository/).

## Creating a new project or module

If your proposal is approved, then administrators will create new repositories for your project, based on our templates for [projects](https://git.rollyourown.xyz/ryo-projects/ryo-project-template) and [modules](https://git.rollyourown.xyz/ryo-projects/ryo-module-template), and give you the necessary permissions to submit code. The level of access you have will depend on whether you will be the maintainer of the project in the long-run:

- If you would like to be the maintainer, then you will be given a rollyourown.xyz account and write access to the repositories on [our own Gitea server](https://git.rollyourown.xyz). You can develop your code and push it to the source repository.
- If you do not intend to be the maintainer, then you fork the GitHub mirror repository (after the administrators have set this up) and develop your code in your personal GitHub account. As development takes place, you will submit your contributions via Pull Requests in the [same way as contributors to existing projects or modules](/collaborate/existing_projects_and_modules/). The workflow for this is described in our section on [Forking and Pull Requests](/collaborate/working_with_git/forking_and_pull_requests/).

In both cases, the repositories will initially be private/non-public so that you can take your time developing. If you want to collaborate with other developers at this stage, they can be invited to contribute. When the project is ready (and deployable), we will switch the repositories to public so that you can begin receiving feedback and inputs from the wider community.

During development, you can discuss your work with other developers using either the tools available in GitHub, or a Matrix room we can set up for this.

## Licencing

Please be aware that all rollyourown.xyz projects are released under the open source [MIT licence](https://git.rollyourown.xyz/ryo-projects/general-feedback/src/branch/main/LICENSE). If you are not comfortable with this, then we unfortunately cannot include your contribution.
