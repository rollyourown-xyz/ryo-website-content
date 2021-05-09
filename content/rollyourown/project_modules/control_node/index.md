---
title: "Control node"
tags: [ ]
draft: false
---

A control node is needed to execute automation scripts for setting up a host server, to build container images for the project and to deploy the containers and services on the host server. A control node can be used to deploy multiple projects, or you can set up a control node per project.

<!--more-->

## TODOs on this page

{{< highlight "primary" "ToDo">}}

- [ ] Link to collaboration page for "Guide for control node setup: MacOS" and for Windows 10 VMWare networking issue
- [ ] Add links in the text

{{< /highlight >}}

## Control node introduction

To keep the settings, software and configuration needed for the control node from interfering or otherwise conflicting with the software and configuration of your local computer, a rollyourown.xyz control node should be set up as a virtual machine on your computer, or on a completely separate, dedicated computer such as an old laptop, desktop computer or Intel NUC. This keeps the rollyourown.xyz configuration separate from your other applications and ensures that the automation scripts and configuration of the control node are not affected by system upgrades or other software installation on the host computer. Also, this allows the rollyourown.xyz configuration scripts and guides to be developed and tested on a single operating system (currently Ubuntu 20.04 LTS) and still be able to be used on Windows, other Linux flavours and MacOS (or any other operating system that can run a Linux virtual machine).

![Role of the control node](Role_of_Control_Node.svg)

With the exception of the very first host server configuration steps, which are carried out over a plain SSH connection to the host server's public IP address, the control node interacts with the host server via a wireguard tunnel. This tunnel provides a permanent, logical secure connection to the host server and enables all communication between the container and host server to run via private IP addresses.

## Control node setup

The steps for setting up a control node depend on your computer's operating system. The following sections describe the setup for [Windows](#control-node-setup-windows), [Linux](#control-node-setup-linux) and [MacOS](#control-node-setup-macos).

{{< highlight "info" "Terminal or desktop?">}}

Based on the rollyourown.xyz project (or projects) you want to deploy, consider whether to use a terminal-based control node or a control node with a graphical desktop.

The terminal-based control node is suitable for projects which either do not include any browser-based administrative interfaces for project components, or where the adminsitrative interfaces are exposed on the public internet. The terminal-based control node is more resource-friendly and may be faster to set up.

For some more advanced projects, a control node with a graphical desktop is needed, since administrative interfaces for project components are typically only accessible via the wireguard tunnel between control node and host server, so that they do not need to be exposed on the public internet.

Using virtual machines for the control node, it is possible to have a dedicated control node for each project deployed, starting each control node only when the project needs to be managed or administered. However, it is also possible to have a single control node for multiple projects, in which case a control node with a graphical desktop would be recommended so that projects requiring a control node with a graphical interface are supported even if the first project doesn't require one.

The individual project pages indicate whether a control node with a graphical desktop is required.

{{< /highlight >}}

### Control node setup: Linux

A terminal-based control node or a control node with a graphical desktop can be run on a Linux computer in a virtual machine. There are a number of ways to run virtual machines on Linux, such as:

- [KVM](https://www.linux-kvm.org/), the native Linux kernel hypervisor, which can be managed with
  - [Multipass](https://multipass.run/), a lightweight, command-line VM launcher, for **terminal-based** control nodes only
  - [Gnome Boxes](https://wiki.gnome.org/Apps/Boxes), a simple desktop GUI VM manager
  - [virt-manager](https://virt-manager.org/), a more advanced desktop GUI VM manager
- [VirtualBox](https://www.virtualbox.org/)
- [VMware Workstation Player](https://www.vmware.com/products/workstation-player/workstation-player-evaluation.html) - free only for non-commercial, personal and home use

Once you have chosen, activated/installed your virtual machine environment, install a Ubuntu 20.04 LTS virtual machine (server version for a terminal-based control node, desktop version for a control node with a graphical interface) as described in the relevant hypervisor documentation.

### Control node setup: Windows

A terminal-based control node or a control node with a graphical desktop can be run on Windows in a virtual machine. There are a number of ways to run virtual machines on Windows, depending on your Windows version, such as:

- [Hyper-V](https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/), available in Windows 10 Enterprise, Pro, or Education versions, which can be managed from the Windows UI or, for **terminal-based** control nodes only, using [Multipass](https://multipass.run/), a lightweight, command-line VM launcher
- [VirtualBox](https://www.virtualbox.org/)

Once you have chosen, activated/installed your virtual machine hypervisor, install a Ubuntu 20.04 LTS virtual machine (server version for a terminal-based control node, desktop version for a control node with a graphical interface) as described in the relevant hypervisor documentation.

{{< highlight "warning" "VMware Workstation Player">}}

On Windows 10, testing has shown that the free, personal, non-commercial use version of [VMware Workstation Player](https://www.vmware.com/products/workstation-player/workstation-player-evaluation.html) **does not work** with rollyourown.xyz due to networking issues for containers within a virtual machine preventing the image build process from succeeding. With the VMWare Player Pro version, these problems *may* be solved by setting promiscuous mode on virtual network bridge, but we have been unable to test this. If you can verify this and provide step-by-step instructions how to solve these issues, please contribute [LINK TO CONTRIBUTION PAGE].

{{< /highlight >}}

### Control node setup: macOS

{{< highlight "warning" "macOS setup is untested">}}

We have currently been unable to test any of the macOS-based virtual machine options for compatibility with a rollyourown.xyz control node and scripts.Please consider contributing [LINK TO RELEVANT PAGE HERE] if you can help us with this.

{{< /highlight >}}

A terminal-based control node or a control node with a graphical desktop can be run on an Apple computer in a virtual machine. There are a number of ways to run virtual machines on macOS, such as:

- [Multipass](https://multipass.run/), a lightweight, command-line VM launcher using the macOS native hypervisor, for **terminal-based** control nodes only
- [VirtualBox](https://www.virtualbox.org/)
- [VMware Fusion](https://www.vmware.com/products/fusion.html) - free only for non-commercial, personal and home use

### Control node setup on a dedicated machine

{{< highlight "danger" "Processor architecture">}}

Currently, only the x86 or amd64 architectures are supported (for control machine and host server). This means, for example, that a Raspberry Pi cannot be used as a control node. Even if all control node software is installed, container images built on an ARM architecture will not run on an x86/amd64 host server.

{{< /highlight >}}

Depending on the available hardware (e.g. with or without a monitor), a terminal-based control node or a control node with a graphical desktop can be run on a dedicated computer running Ubuntu 20.04 LTS. This could, for example, be an old Laptop or desktop computer, an [Intel NUC](https://www.intel.com/content/www/us/en/products/boards-kits/nuc.html) or other mini PC or barebones computer. Prerequisite is that the computer has [Ubuntu 20.04 server](https://ubuntu.com/download/server) (for a terminal-based control node) or [Ubuntu 20.04 desktop](https://ubuntu.com/download/desktop) (for a control node with graphical desktop) installed.

## Automated control node configuration

Once a [control node is up and running with Ubuntu 20.04 LTS](#control-node-setup), the control node needs to be configured and software installed to run your rollyourown.xyz project automation scripts. This software installation and configuration is itself automated.

{{< highlight "warning" "The non-root user">}}

During setup of Ubuntu 20.04 LTS, you will either have been asked to specifiy a username and password for a non-root user, or Ubuntu is already pre-setup with the non-root user `ubuntu`, typically with password `ubuntu`. This non-root user account should be used for executing the rollyourown.xyz scripts and the user-name and password are needed to configure the scripts, being entered in the "Local user configuration" section of the `configuration.yml` file (Step 4 below).

{{< /highlight >}}

1. Log in to the control node as the non-root user, upgrade the system and then reboot to apply any system changes:

    ```console
    sudo apt update && sudo apt upgrade -y
    sudo reboot -n
    ```

2. Log back in to the control node as the non-root user and install `ansible`, `git` and `nano`:

    ```console
    sudo apt install software-properties-common
    sudo apt-add-repository --yes --update ppa:ansible/ansible
    sudo apt install ansible git nano -y
    ```

3. Log in to the control node as the non-root user, create a working directory, enter the directory and clone the **control node repository** to your control node:

    ```console
    mkdir ~/ryo-projects
    cd ~/ryo-projects
    git clone https://github.com/rollyourown-xyz/ryo-control-node.git
    ```

4. Copy the file `~/ryo-projects/ryo-control-node/configuration/configuration_TEMPLATE.yml` to a new file `~/ryo-projects/ryo-control-node/configuration/configuration.yml`

    ```console
    cp ryo-control-node/configuration/configuration_TEMPLATE.yml ryo-control-node/configuration/configuration.yml
    ```

5. Edit the file `~/ryo-projects/ryo-control-node/configuration/configuration.yml` and add the non-root username and password. If you aren't familiar with a different linux editor, use nano to edit the file with:

    ```console
    nano ryo-control-node/configuration/configuration.yml
    ```

6. Run the control node setup automation script `local-setup.sh` from the `ryo-control-node` directory to prepare the control node and its secure connection to the host server:

    ```console
    cd ~/ryo-projects/ryo-control-node/
    ./local-setup.sh
    ```

7. After running the local-setup script, log out and back in again one time so that the assignment of the user to the `lxd` group is activated (adding the user to the LXD group has already been done as part of local-setup). This is a prerequisite for running the project automation scrips.

After setting up the control node, you are ready to clone the project repository and run the automation scrips to set up the host server, build images and deploy the project.

## Control node deletion

{{< highlight "danger" "Warning!">}}

After a project is deployed, the control node for the project is used to keep the project's applications up to date. Therefore, the control node may be shut down but **should not be deleted** until the project is no longer needed. It is recommended to back up the control node VM (see the relevant online documentation for the hypervisor technology you are using for the control node) at least after deployment or after updates to the deployed project.

{{< /highlight >}}

## Control node using WSL or container technology on Linux

{{< highlight "warning">}}

If you consider running a control node on [Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/about) or as an [LXD container](https://linuxcontainers.org/lxd/) on Linux, please be aware that **this is currently unsupported**, due to limitations of the two technologies:

- In WSL, missing systemd functionality prevents the wireguard interface from starting automatically and prevents snapd from working which in turn prevents the installation of LXD via snap
- With LXD containers, container nesting prevents the control node from working correctly for some projects. One of the roles of a control node is to build container images, which is done on the control node using LXD containers. The rollyourown.xyz image building playbooks do not always work reliably with nested containers

It is our goal to eventually support a control node running as a WSL app on Windows or as an LXD container on Linux, to provide a simple and fast setup of a control node. We will revisit this if and when the technologies have been updated to resolve these problems.

{{< /highlight >}}
