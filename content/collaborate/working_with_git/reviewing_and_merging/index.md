---
title: "Reviewing and Merging"
tags: [ ]
draft: true
---

This page gives and overview of the reviewing and merging steps taken by a maintainer after a contributor has submitted a Pull Request to a rollyourown.xyz repository.

Please contact us if you would consider becoming a maintainer for one of our repositories.

<!--more-->

## TODOs on this page

{{< highlight "primary" "ToDo">}}

- [ ] Links

{{< /highlight >}}

## Maintainer accounts

Our project maintainers have an account on [our Gitea server](https://git.rollyourown.xyz), where the "source-of-truth" repositories are hosted and where project maintainers have write access to the repository/ies they maintain.

rollyourown.xyz project repositories are mirrored to GitHub. We have a GitHub organization [rollyourown-xyz](https://github.com/rollyourown-xyz) for this and the GitHub accounts of our repository maintainers are members of this organization.

On GitHub, a maintainer of a rollyourown-xyz project has "Triage" access rights on their repository/ies, which allows the maintainer to work with issues and PRs submitted on GitHub, but **does not** give write access to the GitHub mirror. This is to avoid accidental merges taking place on GitHub, which would cause the GitHub mirrors to be out of sync with the repositories on our own [Gitea](https://gitea.io/) server.

## Reviewing and discussing Issues

Before receiving a Pull Request, the maintainer will ideally have interacted with the developer and discussed the changes, e.g. via an Issue submitted or in one of our [public matrix rooms](https://rollyourown.xyz/about/public_matrix_rooms).

### Reviewing a Pull Request

The procedure for reviewing a pull request submitted on GitHub is as follows:

1. The maintainer is notified of a pull request for the project via Github

2. The maintainer reviews the change, possibly including other developers in the review process or asking for information from the contributor submitting the pull request. The review process is public and can be followed from the pull request in the project repository

3. When the review is completed and the maintainer is satisfied that the pull request can be merged, then we move to the next step

### Merging a Pull Request

{{< highlight "primary">}}

Since the source-of-truth repository for all rollyourown.xyz projects is [our own Gitea server](https://git.rollyourown.xyz), merging is **not** done directly on the GitHub mirror repository. Instead, the feature branch in the forked repository is merged by the maintainer into the Gitea repository and mirrored back to GitHub.

{{< /highlight >}}

The maintainer performs the following steps:

1. The maintainer works with a local copy (cloned) of the [rollyourown.xyz project repository](https://git.rollyourown.xyz) using, for example:

    ```bash
    git clone ssh://gitea@git.rollyourown.xyz:3022/ryo-projects/ryo-example.git
    ```

2. The maintainer makes sure that the main branch of the repository is checked out and up-to-date using, for example:

    ```bash
    git checkout main` and `git pull
    ```

3. The maintainer then creates and checks out a new feature branch with the name of the feature branch from the forked repository using, for example:

    ```bash
    git checkout -b 123-add-something
    ```

4. The feature branch of the forked repository is then pulled to the maintainer's local copy from the forked repository in the contributor's GitHub account using, for example:

    ```bash
    git pull https://github.com/<USERNAME>/ryo-example.git 123-add-something
    ```

5. The maintainer switches back to the main branch with:

    ```bash
    git checkout main
    ```

6. The feature branch is then merged into the main branch of the maintainer's local repository using, for example:

    ```bash
    git merge 123-add-something
    ```

    The maintainer does **not** perform a squash-merge, so that GitHub automatically recognises that the Pull Request has been merged when the changes are mirrored to GitHub

7. The maintainer then pushes to the [rollyourown.xyz project repository](https://git.rollyourown.xyz) using, for example:

    ```bash
    git push origin main
    ```

    The changes are then mirrored to GitHub, and GitHub automatically recognises that the pull request has been merged.

8. Finally, the maintainer cleans up by deleting the feature branch in the project's repository on the local machine using, for example:

    ```bash
    git branch -D 123-add-something
    ```

When the merge process is completed, the contributor can either delete the forked repository in their account or (if they would like to use the fork to make further contributions) delete the feature branch to clean up.
