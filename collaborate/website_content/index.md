---
title: "Website Content"
weight: 5
tags: [ ]
draft: false
---
<!--
SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
SPDX-License-Identifier: CC-BY-SA-4.0
-->

Our website content is managed from our own Git server repository and mirrored [to Codeberg](https://codeberg.org/rollyourown-xyz/ryo-website-hugo-content) and [to GitHub](https://github.com/rollyourown-xyz/ryo-website-hugo-content). Collaboration on our website content follows a similar pattern to collaboration on the code of our projects and modules. Your collaboration on improving, translating or extending our website will be much appreciated.

<!--more-->

## Suggesting changes

The easiest way to contribute to our website is to suggest an improvement or tell us about typos, bad phrasing etc. This can be done via the Issues in the mirror repositories [on Codeberg](https://codeberg.org/rollyourown-xyz/ryo-website-hugo-content) or [on GitHub](https://github.com/rollyourown-xyz/ryo-website-hugo-content).

[Codeberg](https://codeberg.org/) is our preferred collaboration space for the wider community. If you don't already have an account on Codeberg, we would encourage you to [open an account](https://codeberg.org/) to collaborate with us there.

In your issue, please provide a link to the relevant page on our website or, ideally, a link to the content in the repository.

## Making small changes

If you would like to submit smaller changes yourself (e.g. correcting typos, improving phrasing etc.), then this can be done by forking the mirror repository [on Codeberg](https://codeberg.org/rollyourown-xyz/ryo-website-hugo-content) or [on GitHub](https://github.com/rollyourown-xyz/ryo-website-hugo-content) and submitting a Pull Request. Follow the workflow described in our section on [Forking and Pull Requests](/collaborate/working_with_git/forking_and_pull_requests/).

Your proposed changes will be reviewed and feedback given before merging takes place.

## Making larger or structural changes

If you would like to propose larger changes or suggest structural changes to the website, please first submit an Issue [on Codeberg](https://codeberg.org/rollyourown-xyz/ryo-website-hugo-content/issues) or [on GitHub](https://github.com/rollyourown-xyz/ryo-website-hugo-content/issues) describing what you would like to change and why. The website maintainer can then provide feedback on the proposal in advance of you doing any work. There may be a reason why your proposal would not be accepted, or should be realised differently, so this avoids you doing work which will end up not being accepted and merged

If, after discussing the change, you would like to proceed and implement it, then please fork the mirror repository [on Codeberg](https://codeberg.org/rollyourown-xyz/ryo-website-hugo-content) or [on GitHub](https://github.com/rollyourown-xyz/ryo-website-hugo-content) and submit a Pull Request. Follow the workflow described in our section on [Forking and Pull Requests](/collaborate/working_with_git/forking_and_pull_requests/).

## Translating the website

Our site is currently available only in the English language, with [translation](/collaborate/website_translation/) into German in progress. If you would like to help us translate the site, please [contact us](/about/contact/#website-translation) to discuss how to do this.

## Format of content in the repository

Our website content is written in [Markdown](https://en.wikipedia.org/wiki/Markdown) format in a structure that can be processed by our [Hugo](https://gohugo.io/) static site generator. For more details on this, see the [documentation for the website content structure](/collaborate/website_development/content_structure/).

## Licensing

Please be aware that all rollyourown.xyz website content is released under a [Creative Commons licence](https://codeberg.org/rollyourown-xyz/ryo-website-hugo-content/src/branch/main/LICENSE). If you are not comfortable with this, then we unfortunately cannot include your contribution.

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
