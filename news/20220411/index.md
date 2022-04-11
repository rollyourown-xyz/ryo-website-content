---
title: "rollyourown is published"
date: 2022-04-11
author: "W. Nicoll"
draft: true
tags: []
---
<!--
SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
SPDX-License-Identifier: CC-BY-SA-4.0
-->

After around two years of development, the rollyourown.xyz website and repositories (mirrored [on Codeberg](https://codeberg.org/rollyourown-xyz) and [on GitHub](https://github.com/rollyourown-xyz)) are published. This is the story of how we got here.

<!--more-->

This quite long, rambling post describes how and why the idea for this project came about. The ideas are summarised more concisely, without the backstory, in our [manifesto](/about/manifesto/).

## The backstory

The idea for rollyourown.xyz was born in March 2020, soon after the world began locking down in response to the COVID-19 pandemic. With schools and offices closed and social contact reduced, solutions needed to be found for communicating, sharing and keeping contact with loved ones and colleagues.

I was at home, with time on my hands after a cancelled holiday. As someone with an instinct to do things myself and having some experience using open source software, I decided to set up a [Jitsi](https://jitsi.org/) video conferencing tool and a [Matrix](https://matrix.org/) messaging service for my friends and family.

Reading documentation and various blog posts across the internet, I was able to integrate the various components needed to get these services up and running. It wasn't particularly easy, integrating software components to create working, end-to-end solutions never is, but with my experience working in technology and with other developers sharing their knowledge and experience, I could get the two services running and integrated. My friends and family could start Jitsi video conferences from within chatrooms on my Matrix service.

I saw many people were trying to do the same thing. On forums, in chatrooms, the same hurdles came up over and over again: How to get SSL certificates working on a subdomain? How to pass traffic for multiple services through a reverse proxy? How to set up a webserver to return a JSON payload telling client software where to go when the video conference starts?

I realised that many of the questions and problems raised were related to _integration_ and _configuration_ rather than to the software itself and this reminded me of a question I've been mulling over for years: What is preventing good, high-quality open source software (like Jitsi or Matrix) from proliferating?

For nearly every centralised, proprietary, privacy-invading internet service that surveils and mines users' private data for profit, there is an open source alternative that respects privacy, rejects surveillance and leaves the user in control of their own data and how it is used. The end-user experience is often as good as (and sometimes arguably better than) commercial services. The end-user experience is not the problem. The problem is getting these things set up in the first place.

Myriad, high-quality software applications have been developed by the open source community and made available for everyone to use for free. But whereas downloading and starting a single open source software application may be quite easy, integrating it with other open source applications to create a working end-to-end service is not so easy and requires time, patience and experience to do it properly.

People trip up all the time. There are many blogs describing how developers solve particular problems, with code snippets and their configuration. These are often out of date and always need some understanding to translate to the particular situation. Developers and other system builders in tech forums try to help if they can, but everyone is coming at it from different directions with different levels of understanding. Sometimes, people don’t even know what question to ask, even if they themselves are developers in some other field.

Not everyone has the experience, the bone-headed persistence to make something work, and the understanding to know what needs to be solved to fix the latest problem. Those that do don’t have time to help all the others. Neither do they have the time to repeat the process for friends and family after getting things up and running for themselves. This doesn’t scale. There are open source projects for individual components, but not for the end-to-end solution. For that, you are mostly on your own.

This got me thinking: How can the barrier be lowered to using (which means configuring, integrating and deploying) services based on open source software?

## Some experiences

Companies like Google, Netflix and Facebook have rolled out massive global systems. They've employed thousands of talented developers and system builders to do this. Even with all these resources, there is no way these systems could be run with manual administration. Processes and systems have been developed to roll out and manage large numbers of applications globally, to automate deployments, to scale up and down automatically and to manage upgrades. The key has been to automate everything possible and to keep configuration under version control (so-called "Infrastructure-as-Code"). Some of these processes, scripts, etc. have developed into general-purpose tools. As with much of the software used for internet systems, these tools have been open sourced as well.

### Infrastructure-as-Code and Immutable Infrastructure

With [Infrastructure-as-Code](https://en.wikipedia.org/wiki/Infrastructure_as_code), and using the principle of [Immutable Infrastructure](https://www.hashicorp.com/resources/what-is-mutable-vs-immutable-infrastructure), modern system integration no longer means just fiddling for as long as it takes to get something to work, then leaving it alone unless more fiddling is unavoidable to change or upgrade. That doesn’t scale and isn’t sustainable for massive internet services.

The state of the art for system integration is, more or less, to fiddle for as long as it takes to get something to work **then stop and**:

- Code the configuration of every component and put it into a version-controlled repository (configuration-as-code)

- Use build tools to create each component with exactly the configurations stored in the repository

- Automate the deployment of exactly the working combination of components and configurations, including all underlying infrastructure (networks, firewalls, file storage, etc.) to get a running system -- put this code into a version-controlled repository too (infrastructure-as-code)

- Then, and only then, deploy the service by executing the desired version of the infrastructure code to roll out the components built with the desired version of the configuration code

This entire process can also be coded and automated.

In my experience, there are a number of benefits to this approach.

### Deployment speed

The approach makes deployments fast.

Once infrastructure code has been written, entire systems that would previously take days, weeks or even months to deploy manually can now be deployed in minutes. The first time I saw this, I was astonished.

### Deployment Repeatability

The approach also makes system integration repeatable.

I, like most people, dislike creating documentation. Documentation is often left until the end of a process and there is often a lack of time to do it -- even if each manual tweak or hack done on the way to a working solution can be recalled.

Poor documentation is, unfortunately, a fact of life and the more complex a solution, the more incomplete or incorrect the documentation is likely to be. If something has to be done again, then the same problem-solving process often needs to be repeated to get things up and running. A solution might work in the end, but it may also work differently to the previous version.

If, however, everything is coded, then there is less need for documentation. The code itself is the documentation and exactly the same system comes out at the end when it is executed.

### Reliable system maintenance

The approach also makes systems mode easily manageable.

Previously, to make changes to a running system, careful planning would need to be done. The changes and the processes for performing a change would need to be thought through. Each step of a change would need to be executed manually in some test environment (which would be different to the production environment) to iron out any bugs in the process. When a level of confidence was achieved that changes could be done without wrecking the service, the change processes would be executed in the production environment, often at night or weekends to minimise disruption. Despite careful planning, things often went wrong and things would need to be hacked, under time pressure, to get them working as soon as possible. Even if the upgrade process was documented, these last minute changes were likely not documented properly, so that the exact state of the production environment at any given time would be unknown. This would make the next upgrade more perilous and so it went on.

With immutable infrastructure and everything in code, an upgrade is done by changing the configuration and infrastructure code. A new version of the code is tested by rolling out an exact replica of the production environment (see repeatability above) and running the new version against it. This takes minutes. If problems are found, further changes are made in the code and a new test environment is fired up in minutes to verify those changes.

Once everything is working, a new version of the configuration and infrastructure code is available describing exactly what the upgraded system should look like. This is then executed, again within minutes, to replace the entire production environment with the new version. If something was overlooked, then the previous working system can be restored, exactly as it was, by executing the previous working version of the infrastructure code.

## The idea behind rollyourown

The barriers to using open source software can be lowered by providing configuration and infrastructure code that can be used by anyone to deploy a working, end-to-end solution.

This automation code can itself be developed as an open source project, allowing system builders to share the results of their integration work. Integration-related problem-solving can be done once and the results made available to anyone. The solution can be deployed in minutes and is repeatable over any number of deployments. System integration has become a code development activity and configuration/infrastructure code can now also be developed collaboratively as an open source project.

Initially, I intended to publish my automation code for deploying one or two open source solutions. However, the idea grew into a framework for structuring automation code for any open source solution -- with automated deployment, backups, upgrades and rollbacks.  This framework needed developing, the infrastructure for maintaining what became multiple repositories needed to be built (this is, after all, about rolling your own) and the whole thing needed documenting on this website (which also needed infrastructure to be built). Over a period of around two years, the idea turned into this project and is now ready to be published.

Rollyourown is an open source project for collaborative development of automation code for deploying solutions based on open source software.

Your feedback and collaboration will be very welcome.
