---
title: "New Projects or Modules"
weight: 4
tags: [ ]
draft: true
---

The rollyourown.xyz projects and modules are the heart of our project and improving or adding to them is one of the most valuable contributions you can make.

If you would like to contribute a new project or module to the rollyourown.xyz project, then before all else: Thank you!

<!--more-->

## Anatomy of a project or module

We aim for maximum re-usability and expect our projects and modules to follow a consistent pattern.

Before starting work, please familiarise yourself with the structure of a rollyourown.xyz project or module by reading the [documentation on project and module development](/collaborate/project_and_module_development/) and looking at the template repositories for projects and/or for modules:

- Template repositories for projects can be found [on Codeberg](https://codeberg.org/rollyourown-xyz/ryo-project-template) and [on GitHub](https://github.com/rollyourown-xyz/ryo-project-template)
- Template repositories for modules can be found [on Codeberg](https://codeberg.org/rollyourown-xyz/ryo-module-template) and [on GitHub](https://github.com/rollyourown-xyz/ryo-module-template)

## Planning a new project or module

When you are familiar with the [anatomy of a project or module](#anatomy-of-a-project-or-module), then please submit an Issue in the general-feedback repository [on Codeberg](https://codeberg.org/rollyourown-xyz/general-feedback/issues) or [on GitHub](https://github.com/rollyourown-xyz/general-feedback/issues) to describe your proposal and discuss your ideas with us.

[Codeberg](https://codeberg.org/) is our preferred collaboration space for the wider community. If you don't already have an account on Codeberg, we would encourage you to [open an account](https://codeberg.org/) to collaborate with us there.

We will discuss, for example:

- The open source software you plan to deploy with your project
- Whether a similar project or module is already under development, in which case we'll invite you to collaborate on this
- The structure of the project including, for example, which already-existing modules can be re-used in the project
- Whether new re-usable modules should be developed to support your idea
- The documentation on the [rollyourown.xyz website](https://rollyourown.xyz) that will also need to be created for the project
- Which other rollyourown.xyz collaborators would like to work with you on your project

We will also discuss whether you would like to join the rollyourown.xyz [organisation](/about/about_us) and become the [maintainer](/collaborate/working_with_git/what_is_git/#project-maintainer) for your project. This would be recommended and highly appreciated.

## Creating a new project or module

If your proposal is approved, then administrators will create new repositories for your project, based on our templates for [projects](/collaborate/project_and_module_development/project_structure) and [modules](/collaborate/project_and_module_development/module_structure), and give you the necessary permissions to submit code. The level of access you have will depend on whether you will be the [maintainer](/collaborate/working_with_git/what_is_git/#project-maintainer) of the project in the long-run:

- If you would like to be the maintainer, then you will be given a rollyourown.xyz account and write access to the repositories on our own Git servers. You can develop your code and push it to the primary repository.
- If you do not intend to be the maintainer, then you fork the Codeberg or GitHub mirror repositories (after the administrators have set them up) and develop your code in your personal Codeberg or GitHub account. As development takes place, you will submit your contributions via Pull Requests in the [same way as contributors to existing projects or modules](/collaborate/existing_projects_and_modules/). The workflow for this is described in our section on [Forking and Pull Requests](/collaborate/working_with_git/forking_and_pull_requests/).

In both cases, the repositories will initially be private/non-public so that you can take your time developing. If you want to collaborate with other developers at this stage, they can be invited to contribute. When the project is ready (and deployable), we will switch the repositories to public so that you can begin receiving feedback and inputs from the wider community.

During development, you can discuss your work with other developers using either the tools available on our Git repository servers, on Codeberg or on GitHub, or in a Matrix room we can set up for this.

## Licencing

Please be aware that all rollyourown.xyz projects are released under the open source [MIT licence](https://codeberg.org/rollyourown-xyz/general-feedback/src/branch/main/LICENSE). If you are not comfortable with this, then we unfortunately cannot include your contribution.
