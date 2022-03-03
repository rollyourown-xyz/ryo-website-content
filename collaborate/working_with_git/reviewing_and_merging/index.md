---
title: "Reviewing and Merging"
weight: 3
tags: [ ]
draft: false
---
<!-- SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz> -->
<!-- SPDX-License-Identifier: CC-BY-SA-4.0 -->

This page gives and overview of the reviewing and merging steps taken by a maintainer after a contributor has submitted a Pull Request to a rollyourown.xyz repository.

Please [contact us](/about/contact) if you would consider becoming a maintainer for one of our repositories.

<!--more-->

## Maintainer accounts

Our project maintainers have an account on our own Git servers, where the "source-of-truth" repositories are hosted and where project maintainers have "write" access to the repository/ies they maintain.

Our maintainers also have accounts at [Codeberg](https://codeberg.org) and [GitHub](https://github.com) to be able to manage Issues and Pull Requests submitted on those platforms. Public repositories are mirrored to our [Codeberg]((https://codeberg.org/rollyourown-xyz)) and [GitHub](https://github.com/rollyourown-xyz) organization accounts and our repository maintainers' accounts have "write" access to the Issues and Pull Requests there. A maintainer **does not** have "write" access to the _code_ in the Codeberg and GitHub mirror repositories, to prevent accidental merges on these platforms. These would cause the mirrors to be out of sync with the primary repositories on our own Git server.

## Reviewing and discussing Issues

Before receiving a Pull Request, the maintainer will ideally have interacted with the developer and discussed the changes, e.g. via an Issue or in one of our [public matrix rooms](https://rollyourown.xyz/about/public_matrix_rooms).

### Reviewing a Pull Request

The procedure for reviewing a pull request submitted on Codeberg (or GitHub) is as follows:

1. The maintainer is notified of a pull request for the project via Codeberg (or GitHub)

2. The maintainer reviews the change, possibly including other developers in the review process or asking for further information from the contributor pull request contributor. The review process is public and can be followed from the pull request on Codeberg (or GitHub)

3. When the review is completed and the maintainer is satisfied that the pull request can be merged, then we move to the next step

### Merging a Pull Request

{{< highlight "primary">}}

Since the source-of-truth for all rollyourown.xyz projects is the primary repository on our own Git servers, merging is **not** done directly on the Codeberg (or GitHub) mirror repository. Instead, the feature branch is merged into the primary repository on our servers and mirrored back to Codeberg and GitHub.

{{< /highlight >}}

The maintainer performs the following steps:

1. The maintainer works with a local copy (cloned) of the **primary** repository using, for example:

    ```bash
    git clone ssh://gitea@git.rollyourown.xyz:3022/ryo-projects/ryo-example.git
    ```

2. The maintainer makes sure that the main branch of the repository is checked out and up-to-date using, for example:

    ```bash
    git checkout main
    git pull
    ```

3. The maintainer then creates and checks out a new feature branch locally -- for the changes submitted in the pull request. For example:

    ```bash
    git checkout -b 123-add-something
    ```

4. The feature branch in the contributor's repository fork on Codeberg (or GitHub) is then pulled to the maintainer's local repository from the contributor's Codeberg (or GitHub) account using, for example:

    ```bash
    git pull https://codeberg.org/<CONTRIBUTOR>/ryo-example.git 123-add-something
    ```

    or

    ```bash
    git pull https://github.com/<CONTRIBUTOR>/ryo-example.git 123-add-something
    ```

5. The maintainer switches back to the main branch and makes sure it is up-to-date with:

    ```bash
    git checkout main
    git pull
    ```

6. The feature branch is then merged into the main branch in the maintainer's local repository, for example:

    ```bash
    git merge --no-ff 123-add-something main
    ```

    The maintainer does **not** perform a squash-merge, so that Codeberg and GitHub can recognise automatically that the Pull Request has been merged. With the `--no-ff option`, the maintainer can add a commit message, in which the Pull Request can be referenced

7. The maintainer then pushes to the **primary** repository using, for example:

    ```bash
    git push origin main
    ```

    The changes are then mirrored automatically to the Codeberg and GitHub mirror repositories. Codeberg and GitHub automatically recognise that the pull request has been merged.

8. Finally, the maintainer can clean up by deleting the feature branch in the local repository by using, for example:

    ```bash
    git branch -D 123-add-something
    ```

After the merge process is completed, the contributor may delete their repository fork or (if they would like to use the fork to make further contributions) delete the feature branch to clean up.
