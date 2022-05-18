---
title: "What Git is and how we use it"
weight: 1
tags: [ ]
draft: false
---
<!--
SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
SPDX-License-Identifier: CC-BY-SA-4.0
-->

[Git](https://git-scm.com/) is a software tool which can be used in different ways. This page explains the basic concepts of Git and how we use it to collaborate on the rollyourown project.

<!--more-->

## Git

[Git](https://git-scm.com/) is a free and open source software program that enables collaboration by tracking changes to files and managing versions of projects distributed across multiple computers. It has become the de-facto standard tool used for developing open source software, but may be used to manage anything that can be stored as text and is developed by a community over time.

{{< more "secondary">}}

A good overview of Git can be found [on Wikipedia](https://en.wikipedia.org/wiki/Git) and a more detailed explanation of how it works and how to use it can be found [here](https://jwiegley.github.io/git-from-the-bottom-up/) and [here](http://www-cs-students.stanford.edu/~blynn/gitmagic/).

The full Git documentation is [here](https://git-scm.com/doc).

{{< /more >}}

## Git-based workflow

Depending on the context, [various workflows](https://www.atlassian.com/git/tutorials/comparing-workflows) can be applied when using Git to organise collaboration.

Git is commonly used for organising collaborative software development, but is also a good tool for organising other kinds of project. Anything that can be represented in text form, that changes over time and that needs some kind of review and merge process to manage multiple contributors working independently, can benefit from Git and a Git-based workflow.

A Git-based workflow revolves around a **repository**, which stores the files making up a project. Different states of the project (e.g., 'current' and 'draft' for website content, or 'stable' and 'development' for software), are managed in **branches** within the repository.

Git is a _distributed_ system for collaborating on a shared project. Collaborators **clone** (i.e. copy) the repository to their own computers, work on parts of the project and then **commit** their changes to their local copy. Since multiple collaborators may be working on the project in multiple places at the same time, a collaborator can **pull** the latest version from a remote repository and **push** changes back from their local repository. In this way, changes are synchronised between the various copies of the repository.

These basic concepts are described in more detail in the following sections.

## Basic Git concepts

### Repositories

A **repository** is where the files making up a project are stored along with a record of all changes made to those files. The number, format and content of these files depend on what the project actually is.

{{< more "secondary">}}

#### Repositories for different kinds of project

A Git repository (or multiple repositories) can be used to manage anything that can be stored as one or more text-based files. For example:

- Software projects of any size, such as: Operating systems (such as the [Linux kernel](https://git.kernel.org/)); data centre virtualization management systems (such as [kubernetes](https://kubernetes.io/) or [open stack](https://www.openstack.org/)); programming languages (such as [go](https://go.dev/) or [rust](https://www.rust-lang.org/)); myriad other components and systems (see, for example, the open source software [we use to run our infrastructure and services](/about/credits))

- The designs, plans, components and instructions for an [open source hardware](https://www.oshwa.org/definition/) project, for example: A [satellite](https://upsat.gr/); a [self-driving (model) car](https://www.donkeycar.com/); a [robot](https://github.com/alex8411/minicat); an [aeroplane](https://www.venusaircraft.org/); a [robotic submarine](https://github.com/OpenROV/); a [security key](https://solokeys.com/); [VR glasses](https://github.com/relativty/Relativty); a [single-board computer](https://github.com/OLIMEX/OLINUXINO); a [computer processor](https://riscv.org/)

- Text-based projects, such as: [Website content and documentation](/collaborate/website_content); books -- such as [here](https://joebuhlig.com/writing-a-book-with-github/) or [here](https://github.com/cosmicpython/book); [legal documents](https://docs.openlaw.io/); [songs and music mixing](https://www.lorenzosmusic.com/2019/05/how-we-came-up-with-way-to-use-github.html); [general writing](https://opensource.com/article/19/4/write-git)

#### Repositories for the rollyourown project

At the rollyourown project, we use a number of repositories for different purposes:

- We manage the code for our [projects](/rollyourown/projects) and [modules](/rollyourown/project_modules) in dedicated public repositories (one for each project or module)

- We manage test automation code (for validating changes made in our projects and modules) in private repositories

- We manage code for automating the deployment of our own infrastructure and services (like our communication systems, our web servers or our collaboration tools) in private repositories

- We manage the content (i.e. text) of this website, including the documentation for our projects and modules, in a public repository mirrored [to Codeberg](https://codeberg.org/rollyourown-xyz/ryo-website-hugo-content) and [to GitHub](https://github.com/rollyourown-xyz/ryo-website-hugo-content)

- We manage the theme (i.e. design) of this website in a (currently) private repository

- We manage our internal organisation documents in private repositories

Each of these artefacts can then be treated as a community project in itself -- developed further either internally or in public.

{{< /more >}}

### Cloning

**Cloning** a repository means duplicating it (including all files and the record of changes to those files) to a different computer, usually for the purpose of doing work to contribute back to the project.

{{< more "secondary">}}

Cloning allows a contributor in a collaborative project to obtain a copy of the project on their private computer. The contributor can then work offline on the project and make as few or many changes as needed, without affecting the stable project code or the work of other collaborators.

When finished, changes are contributed back to the original project. After the changes are incorporated, the cloned repository can be deleted.

[The forking workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/forking-workflow) is commonly used for open source projects and we [use it for collaboration on the rollyourown project](#rollyourown-workflow). In this workflow, a **fork** is a server-side clone, which then _itself_ is cloned by a contributor as basis for their work. In combination with [branching](#branching-and-merging) and [pull requests](#pull-request), this enables project maintainers to manage multiple, independent contributions to a project. For more details on this workflow, see [below](#rollyourown-workflow)

{{< /more >}}

### Committing

When a contributor has made a change, then the change is **committed** back to the repository. Until the commit has taken place, changes made are 'outside' the repository. When a commit is made, only the aggregate change is recorded in the repository.

An overall change to a project may consist of one or more commits, depending on the scope of the change, the number of files that need to be modified and the number of steps that need to be taken.

{{< more "secondary">}}

A contributor typically makes many changes -- saving work, taking breaks, testing the changes, reworking the changes, etc. -- until a state has been reached that embodies a satisfactory 'unit' that can be submitted to the repository. Recording commits means that the repository records only meaningful 'units of change' and not every keystroke, experiment and mistake that a contributor makes on the way to the result.

Git records each commit to the repository along with a short message from the contributor documenting and explaining the changes made in the commit. This enables other contributors to reconstruct, understand and follow changes that have been made by others. This also allows a roll-back (or 'revert') to a previous state, if needed at any time.

{{< /more >}}

### Branching and merging

Within a Git repository, different versions of the content can be managed in **branches**. Typically, one branch -- the 'default' or 'main' branch -- forms the base for all other branches. Other branches can be used for making changes, developing new features or representing new versions of the content.

When a branch is used to make a change, a point will be reached when it makes sense to modify the 'main' branch of the project -- i.e. when the change is ready. The branch is then **merged** back into the 'main' branch. This combines the commits in the feature branch into the 'main' branch to achieve a new 'official' state. Other contributors can then build on the change.

During a merge, Git manages conflicts which may arise if the 'main' branch has been updated in the meantime with changes from other contributors. The contributor can then make further changes (and commits) to resolve these conflicts before merging.

{{< more "secondary">}}

The way Git manages branches is described [in the Git documentation](https://git-scm.com/book/en/v2/Git-Branching-Branches-in-a-Nutshell).

Depending on how an organisation sets itself up and publishes its work, branches can be used for different things. Using branches to make changes is good practice for organising multiple contributors making changes in parallel.

With this approach, a new branch is created whenever a change is to be made (e.g., a new feature is to be added or a page on a website is to be re-written). A contributor makes changes within this new branch and can review and test them independently of the main branch. Changes are only merged into the 'main' branch after work is completed. During development, changes made by one contributor do not affect changes being made by another as they are worked on in separate branches

The model we use for rollyourown repositories is the
[trunk-based model with short-lived feature branches](https://trunkbaseddevelopment.com/short-lived-feature-branches/). The **main** branch in a rollyourown repository represents the current 'official' or 'stable' version of the project. Each 'unit of change' is done in a **feature branch** and merged back to the main branch when finished (and after review). This way, the main branch develops over time.

{{< /more >}}

### Pushing and pulling

Git enables distributed development in multiple copies of a repository. It also provides the tools to keep these different copies in sync so that changes are compatible with each other and the project remains in a consistent and useful state. A **pull** synchronises a local repository with a remote one. A **push** does the opposite, by synchonising the remote repository with the local one.

{{< more "secondary">}}

With distributed copies of a repository and multiple changes being made in parallel, there is a good chance that changes made by one contributor are incompatible with changes made by another. This will prevent a contributor from merging their changes.

To keep the different copies of the repository in sync, Git enables 'pulling' and 'pushing' changes from one repository to another. Before a merge is attempted, a contributor 'pulls' the up-to-date 'main' branch and checks that the changes made are still compatible with it. After a successful merge, the contributor then 'pushes' the main branch so that others can 'pull' the updates and make sure that their changes are compatible.

{{< /more >}}

## Additional concepts

### Primary and mirror repositories

Git itself does not include the concept of a 'primary' repository that is more 'important' than any other, instead relying on collaborators to work together to resolve conflicts between their repositories. This can be difficult to manage if a repository is duplicated many times, if multiple contributors are working in parallel, and if cloning, pushing and pulling is done arbitrarily between any pairs of repositories.

To address this within a project, one copy of a repository is typically deemed to be the "source of truth" and is typically hosted on a central server. This **primary repository** is considered to be the definitive source of the project's content (code, documents, etc.). Collaborators usually clone only the primary repository and pull/push changes only to/from it.

In some situations, it can be useful to set up other repositories as a **mirror** of the primary repository. A mirror repository is a clone of the primary repository and **all** changes in the primary repository (and only in the primary repository) are pushed automatically to the mirror. No changes are ever made in the mirror repository, so that the mirror always reliably reflects the canonical version of the project and all its history.

{{< more "secondary">}}

#### rollyourown primary repositories

Following [our own aim](/about/manifesto/#our-aims) to promote and enable the self-hosting of open source software as much as possible, we maintain our primary repositories on our own Git repository servers. For our project, these repositories are the "source of truth" and we use them, for example, as the source of the content for generating this website.

Members of our organisation have accounts on our own Git repository servers. If you would like to join our project, please [contact us](/about/contact/).

#### rollyourown mirror repositories

[Another goal](/about/manifesto/#our-approach) of our project is to lower the barriers to using open source solutions, and this extends to lowering the barriers to _collaborating_ on our project by enabling collaboration where our collaborators already work.

To make our project and its repositories available for collaboration in a wider community, we maintain mirrors of our public repositories on [Codeberg](https://codeberg.org/) and [GitHub](https://github.com/). Specifically, these are:

- The repositories for our [projects](/rollyourown/projects) and [modules](/rollyourown/project_modules)
- The repository for the content of the rollyourown website

Further repositories may be made public and mirrored at a later date, such as the repositories containing the deployment code for our infrastructure.

#### Collaboration on Codeberg

[Codeberg](https://codeberg.org/) is our preferred collaboration space for the wider community. If you don't already have an account on Codeberg, we would encourage you to [open an account](https://codeberg.org/) to collaborate with us there.

We maintain mirrors of our primary repositories [on Codeberg](https://codeberg.org/rollyourown-xyz) so that the developer community on Codeberg can collaborate on our project without needing an account for our own servers.

Codeberg is a [relatively new](https://blog.codeberg.org/codebergorg-launched.html), non-profit registered society [providing a non-commercial alternative for open source project hosting and collaboration](https://docs.codeberg.org/getting-started/what-is-codeberg/#our-mission).

#### Collaboration on GitHub

Although Codeberg is our preferred public collaboration space, we recognise that many, many open source projects are maintained and managed on [GitHub](https://github.com/) and many, many developers have an account there. This makes GitHub the current de-facto standard destination for creating and collaborating on open source projects, even though GitHub is a closed-source, for-profit venture.

We therefore also maintain mirrors of our public repositories in [our rollyourown-xyz organisation account on GitHub](https://github.com/rollyourown-xyz) so that collaborators can also support us there.

{{< /more >}}

### Project maintainer

With the ability for many people to clone a repository, simultaneously create branches and make changes in their local copies and push them back to the primary repository, some method is needed to avoid complete chaos in the project's content.

In an open source project, this is usually managed by a project **maintainer**, who is a person (or persons) that has the right to push changes to the **primary** repository. Other contributors may clone the repository and make changes in their own copy, but they **cannot** push those changes back into the primary repository.

In order for contributor's changes to be accepted into the primary repository, the maintainer needs to accept the changes and perform the merge. The contributor does not submit changes to the repository itself, but instead issues a ["Pull Request"](#pull-request).

A project maintainer therefore has a key role in an open source project. The maintainer is responsible for the content of the primary repository (and the quality of this content) -- and is therefore responsible for the 'official' version of the project. The maintainer is also responsible for managing contributions from the community that is collaborating on the project.

### Pull Request

As [discussed above](#cloning), the collaboration workflow for the rollyourown project follows the [forking workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/forking-workflow).

When a contributor would like to make a change, then the first step is to fork the repository to their own account. Changes are then made in this copy (either directly or via cloning the fork to their local computer).

When the change is ready to be merged, the contributor cannot simply push or merge it back into the primary repository (because only the [maintainer has the right to do this](#project-maintainer)).

Therefore, the contributor opens a "Pull Request" to the original repository, which notifies the maintainer that a change is ready for merging. The maintainer (and optionally other project members) can then review the change. If the change is accepted, then the maintainer pulls the changes from the contributor's clone repository (hence the name "Pull Request"), and merges them into the 'main' branch of the primary repository.

This procedure is described in more detail [here](/collaborate/working_with_git/forking_and_pull_requests/).

## rollyourown workflow

For open source projects using a public repository hosting service like Codeberg or GitHub, the hosted repository is often the primary repository for the project.

As [described above](#primary-and-mirror-repositories), we follow a different approach and host our primary repositories ourselves, with _mirrors_ [on Codeberg](https://codeberg.org/rollyourown-xyz) and [on GitHub](https://github.com/rollyourown-xyz).

Issues and Pull Requests from the community are managed on the respective hosting service, as these are the places where collaborators already have their account. This means that the merging workflow involves an interaction between our own repositories and the mirror repositories. This is made possible by the distributed nature of Git.

A typical forking workflow is illustrated in the following diagram:

{{< image src="Forking_Workflow.svg" title="Forking Workflow">}}

{{< more "secondary">}}

1. A contributor forks a repository to their account (e.g. on Codeberg)
2. The contributor clones the repository fork to their local computer
3. The contributor makes changes in a new feature branch in their local copy of the repository fork
4. The contributor pushes the new feature branch (with the changes) to the remote repository fork
5. The contributor submits a Pull Request (e.g. on Codeberg), which is then visible in the origin repository
6. The change is reviewed in the Pull Request
7. When the change is accepted and ready to be merged, the maintainer clones the origin repository to their local computer and creates a new feature branch
8. The maintainer pulls the feature branch from the contributor's fork to the local clone of the origin repository
9. The maintainer merges the feature branch into the 'main' branch in their local clone of the origin repository
10. The maintainer commits the change and pushes the (changed) 'main' branch back to the origin repository. This commit **must not be** a squash commit (which would combine the contributor's commits into a single one), so that all the contributor's commits are recorded in the origin repository
11. Because **all the contributor's commits are included**, the Pull Request on Codeberg (or GitHub) is automatically recognised as merged

{{< /more >}}

With the addition of mirroring, our workflow is illustrated in the following diagram:

{{< image src="RYO_Workflow.svg" title="RYO Workflow">}}

{{< more "secondary">}}

1. A contributor forks the **mirror** repository to their account (e.g. on Codeberg)
2. The contributor clones the repository fork to their local computer
3. The contributor makes changes in a new feature branch in their local copy of the repository fork
4. The contributor pushes the new feature branch (with the changes) to the remote repository fork
5. The contributor submits a Pull Request (e.g. on Codeberg), which is then visible in the **mirrored** repository
6. The change is reviewed in the Pull Request
7. When the change is accepted and ready to be merged, the maintainer clones **the primary repository (not the mirror)** to their local computer and creates a new feature branch
8. The maintainer pulls the feature branch from the contributor's **fork (of the mirror)** to the local **clone of the primary** repository
9. The maintainer merges the feature branch into the 'main' branch in their local copy of the **primary** repository
10. The maintainer commits the change and pushes the (changed) 'main' branch back to the **primary** repository. This commit **must not be** a squash commit (which would combine the contributor's commits into a single one), so that all the contributor's commits are recorded in the **primary** repository
11. **The change in the primary repository is then automatically pushed to the mirrors on Codeberg and GitHub**
12. Because **all the contributor's commits are included**, the Pull Request on Codeberg (or GitHub) is automatically recognised as merged

The procedure for forking and submitting Pull Requests is described in more detail [here](/collaborate/working_with_git/forking_and_pull_requests/). The merging procedure is described in more detail [here](/collaborate/working_with_git/reviewing_and_merging/).

{{< /more >}}

For this procedure to work, project [maintainers](#project-maintainer) require a rollyourown account to have write-access to the primary repository. If you would like to join our organisation, maintain a project or otherwise help us with managing the project, please [contact us](/about/contact/).
