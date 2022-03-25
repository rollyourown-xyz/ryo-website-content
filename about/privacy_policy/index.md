---
title: "Privacy Policy"
weight: 11
tags: []
draft: false
---
<!--
SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
SPDX-License-Identifier: CC-BY-SA-4.0
-->

Our policy is to collect as little personal data as necessary in providing this website and the services we offer to contributors to our project.

This page provides information on the processing of personal data while visiting this and our related websites. In addition, this page provides information on the processing of personal data of members of our organisation while using our Git repository server or Matrix communication/collaboration service.

<!--more-->

Protection of your data as a website visitor or member of our project is taken very seriously. Any personal data collected is handled confidentially and in accordance with European data protection regulations. We do not share personal data with third parties without your permission.

## Data Controller

Data controller for our website and services is Wilfred Nicoll. The Data Controller can be contacted as follows:

Contact form: [https://forms.rollyourown.xyz/data-protection](https://forms.rollyourown.xyz/data-protection/)

Wilfred Nicoll\
Hosigaustr. 10\
81375 Munich / München\
Germany / Deutschland

## Your rights

You have the right under European regulation to:

- Be informed and request a copy of any personal data we store about you and the purpose of any processing of that data
- Have any of your personal data corrected if incorrect
- Have your personal data deleted
- Withdraw any permission to process your personal information in future or object to the processing of your personal information

To request information about any personal data stored or to contact us regarding any of these rights, please use our [contact form](https://forms.rollyourown.xyz/data-protection/) or contact us in writing at the above address.

## Public Website

The main part of our website is generated from content stored in our repositories and mirrored [to Codeberg](https://codeberg.org/rollyourown-xyz/ryo-website-hugo-content) and [GitHub](https://github.com/rollyourown-xyz/ryo-website-hugo-content). This content is converted into static HTML files by the [Hugo](https://gohugo.io/) static site generator. As a static website, there is no database to store information of any kind.

Contact forms are non-static pages that we serve from a [Grav CMS](https://getgrav.org/). Grav is a flat-file CMS which also uses no database, with all content and settings stored in files.

Public IP addresses and user agent strings from connecting computers used by visitors to access our website may be stored in server logs for a limited period of time and used to generate statistics.

### Site generation settings

As described in the [Hugo documentation on the General Data Protection Regulation (GDPR)](https://gohugo.io/about/hugo-and-gdpr/), we have disabled all external services with the following settings in the Hugo configuration file:

```toml
[privacy]
  [privacy.disqus]
    disable = true
  [privacy.googleAnalytics]
    disable = true
  [privacy.instagram]
    disable = true
  [privacy.twitter]
    disable = true
  [privacy.vimeo]
    disable = true
  [privacy.youtube]
    disable = true
```

In addition, there is no integration of these, or any other external services, in the site's custom theme templates.

### Contact forms

When you use one of our contact forms to contact us, we ask you to enter your name and email address along with your message so that we can respond. This information is processed for the sole purpose of responding to your message and is deleted once no further communication is needed with you.

### Cookies

No cookies are used on the public website at [https://rollyourown.xyz](https://rollyourown.xyz), which is why there is no cookie consent popup or banner.

Our contact form server at [https://forms.rollyourown.xyz](https://forms.rollyourown.xyz) sets a session cookie. Since this session cookie is technically necessary for the correct functioning of the contact forms and is not used for any other purpose, there is no cookie consent popup or banner.

### Bootstrap framework

We use the [Bootstrap framework](https://getbootstrap.com/) for the responsive theme on our website and forms server. We serve the bootstrap.min.css style sheet and bootstrap.bundle.min.js javascript resources directly from our web server and not linked via an external source or CDN.

### Feather icons

We use [Feather icons](https://feathericons.com/) on our website and forms server. The feather.min.js javascript resources are served directly from our web server and not linked via an external source or CDN.

## Services for organisation members

Members of our organisation are provided with an account on our Git repository server. This account is used to access our repository server as well as provide credentials for accessing our non-public development website and our collaboration tools.

### Repository server

#### Account data

As the minimal personal information required to maintain an account on our Git repository server, accounts are created with a username, password and email address and these are stored for as long as the account is available. The user may modify these values.

In addition, a user can freely add, change and delete the following personal information in their user profile via the user interface:

- The language for the user interface
- A full name
- Additional email addresses
- A short text as Biography
- A link to an external website
- A location
- A small graphic file as Avatar
- Cryptographic key files

The user has full control over this information and may modify or delete it from the production system at any time. The user may also delete their entire account, leading to a deletion of all personal information from the production system.

The information may, however, continue to be stored in off-line backup files for a limited time (maximum 30 days) until these are destroyed.

#### Repository server cookies

Our repository server sets technically necessary cookies needed for the functioning of the service. In addition, the user can optionally select "Remember me" to reduce the number of times a login is needed. This sets an additional cookie.

#### User provided content

With an account on our Git repository server, you may create your own repositories within your own account. As a user, you have access to and are fully responsible for the data you choose to store in your repositories. If you choose to delete your account, your personal repositories will also be deleted from the production systems.

The information may, however, continue to be stored in off-line backup files for a limited time (maximum 30 days) until these are destroyed.

If you contribute to other repositories, then any information you provide (Issues, code or content contributions, comments you make to issues or pull requests) is public and stored in these repositories. These become an integral part of the repository history and are **not** deleted if your account is deleted. This is inherent to the way Git repositories work.

### Development website

Our development website at [https://dev.rollyourown.xyz](https://dev.rollyourown.xyz), containing draft content not yet published to the public website, is only accessible by members of our organisation with an account on our Git repository server. Access to the site is authorised via [OAuth2](https://oauth.net/2/). After successful authorisation, a technically necessary cookie is set which enables the user to access further pages on the development website without re-authorisation.

### Collaboration tools

With an account on our repository server, a user may also optionally use our collaboration and communication systems.

#### Matrix homeserver

Our communication and collaboration platform is a [Matrix](https://matrix.org/) homeserver. The personal data stored and processed by this system is described in detail in the [Matrix.org Homeserver Privacy Notice](https://matrix.org/legal/privacy-notice). The following provides a summary.

On first log in, an account is created on the system with the same username as the account on our repository server. No additional password is stored on this system, as login is always via the account on our repository server.

In addition, a user can freely add, change and delete the following personal information in their user profile via a [client](#matrix-client) User Interface:

- The language for the user interface
- A "Display Name" - i.e. a nickname shown to other users in chats
- An email address for notifications from the system
- A telephone number

A user can request a deactivation of their account, which will lead to a removal of personal information on the production system. The information may, however, continue to be stored in off-line backup files for a limited time (maximum 30 days) until these are destroyed.

Once an account has been created, the user may use the system to communicate with other Matrix users, either on the same server or on other Matrix servers federated with it. Communication types are 1-1 or group chats as well as voice and video calls.

As a federated communication system, messages and content sent by a user are shared with the recipients. These recipients may be other users of the same system or users of other Matrix systems federated with it. As is the case with other communications systems such as email or SMS, messages or content that have been received by other users are **not** necessarily deleted from those recipient users' accounts when the sending user's account is deleted.

Furthermore, while data storage and processing on the rollyourown.xyz collaboration and communication systems are covered by this policy, our organisation cannot take responsibility for data storage and processing on other federated systems. The Matrix protocol is a federated communications protocol and anyone, anywhere in the world may run a Matrix homeserver. If a user of our system communicates with users of other systems, then our user's data will be processed by systems outside our responsibility. This is an inherent property of a federated communication system.

#### Matrix client

In order to use and interact with our Matrix collaboration and communication systems, a user needs to use **client** software. As an open protocol, there are many clients that can be used with our servers, for example those listed on [https://matrix.org/clients/](https://matrix.org/clients/). Our organisation is not responsible for the data stored and processed by any client software. Matrix clients typically store the user's data locally on the device on which the client is running (e.g. the laptop from which the user accesses the web-based client or the smartphone on which the user installs a client app). This is also the case for the [Element](https://element.io/) web-based Matrix client that we host at [https://element.rollyourown.xyz/](https://element.rollyourown.xyz/).

## Hosting

Our production services are hosted on virtual private servers rented from an external provider and located in Germany. The personal data described above is stored and processed on these servers. Our provider maintains log files for the management of their server infrastructure for a [maximum of 14 days](https://www.netcup-wiki.de/wiki/Wie_lange_werden_Logdateien_gespeichert) _(note: linked website is in German)_. Basic anonymized statistics are gathered on CPU, hard disk and network usage and made available to us.

Our hosting provider is:

netcup GmbH\
Daimlerstraße 25\
D-76185 Karlsruhe

Our hosting provider's own data protection policy is here: [https://www.netcup.de/kontakt/datenschutzerklaerung.php](https://www.netcup.de/kontakt/datenschutzerklaerung.php) _(note: linked website is in German)_.

A standard contract with netcup GmbH is in place for the processing of data (Auftragsverarbeitung) in the context of server hosting.

## Monitoring and improving our services

We do not use any external services (e.g. Google Analytics) for monitoring visitors' use of our website. As an open source project, feedback can be given (e.g. on design, usability etc.) voluntarily via our repositories and collaboration resources. We would highly appreciate any feedback or contributions you may have. See our [Collaboration pages](/collaborate) for more details.

In future, we may implement our own, more detailed, monitoring of our infrastructure (e.g. to monitor server status and performance, network status etc.). We will update this page with information about privacy and data-protections aspects if and when we do this.

## Additional topics

We may, in future, implement ways for users to sponsor or donate to the project - e.g. to help fund the running costs of rollyourown.xyz services.  If and when we do this, then we will update this page with information about privacy and data-protections aspects.
