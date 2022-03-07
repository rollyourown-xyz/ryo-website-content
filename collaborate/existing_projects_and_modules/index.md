---
title: "Improve Existing Projects and Modules"
weight: 3
tags: [ ]
draft: false
---
<!--
SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
SPDX-License-Identifier: CC-BY-SA-4.0
-->

The rollyourown.xyz projects and modules are the heart of our project and improving or adding to them is one of the most valuable contributions you can make.

If you would like to improve an existing project or module to the rollyourown.xyz project, then before all else: Thank you!

<!--more-->

## Before working on the code

If you would like to improve the code yourself for a particular rollyourown.xyz [project](/rollyourown/projects) or [module](/rollyourown/project_modules), please first submit an Issue in our mirror repositories [on Codeberg](/collaborate/bug_reports_feature_requests_ideas/#raising-issues-on-codeberg) or [on GitHub](/collaborate/bug_reports_feature_requests_ideas/#raising-issues-on-github) describing what you would like to change and why.

The project maintainer can then provide feedback on the proposal in advance of you doing any work. There may be a reason why your proposal would not be accepted, or should be realised differently, so this avoids you doing work which will end up not being accepted and merged into the code.

## Making changes

If, after discussing the change, you would like to proceed and implement it, then please fork the GitHub mirror repository and submit a Pull Request. Follow the workflow described in our section on [Forking and Pull Requests](/collaborate/working_with_git/forking_and_pull_requests/).

## Licensing

Please be aware that rollyourown.xyz projects are released under the open source [GPLv3 licence](https://spdx.org/licenses/GPL-3.0-or-later.html). If you are not comfortable with this, then we unfortunately cannot include your contribution.

We use [Software Package Data Exchange (SPDX)](https://spdx.dev/) licensing and copyright information in each source file in our repositories. We request any contributor to add SPDX information to any new file submitted and to include additional copyright information in modified files, where applicable.

In addition, when submitting a Pull Request to our project we ask contributors to agree with the terms of the [Developer Certificate of Origin (DCO)](https://developercertificate.org/) to certify that the contributor has the right to make the contribution to our project. As well as ticking the checkbox in the Pull Request template, we recommend signing off each commit. To do this, configure your Git username and email address for the repository with:

```console
git config user.name "<USERNAME>"
git config user.email "<EMAIL ADDRESS>"
```

or globally with:

```console
git config --global user.name "<USERNAME>"
git config --global user.email "<EMAIL ADDRESS>"
```

Signoff is then automatic when using the `-s` flag with the `git commit` command.
