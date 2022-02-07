---
title: "Privacy and Data Protection"
weight: 10
tags: []
draft: true
---

Summary.

<!--more-->

TODO: Add more descriptive content to explain what this is about and what is relevant.

## Data Protection

TODO: Include link to data protection contact form

## Notes on GDPR.

### Link to Hugo page on GDPR

Source: [https://gohugo.io/about/hugo-and-gdpr/](https://gohugo.io/about/hugo-and-gdpr/).

Notes:

* Static site generator
* Privacy Config settings in config.toml - defaults settings _off_
* No cookies used on the website
* TODO: something about cookies used on Gitea, Synapse, Jitsi, ...

### External services disabled

The following settings are made in the [Hugo](https://gohugo.io/) configuration file to disable all external services in Hugo's internal templates:

```
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

### Notes on Bootstrap and JQuery

We use the [Bootstrap framework](https://getbootstrap.com/) and [jQuery library](https://jquery.com/) for the reponsive theme on our website. We include the bootstrap.min.css, bootstrap.bundle.min.js and jQuery javascript library resources directly from this website and not linked via an external source or CDN.

TODO: Anything else needed?

### Notes on Feather icons

We use [Feather icons](https://feathericons.com/) on our website. We include the feather.min.js resources directly from the website and not linked via an external source or CDN.

TODO: Anything else needed?

### Notes on cookies

VERIFY THIS: No cookies are used on this website. We therefore have no cookie consent popup or banner.

TODO: Add something about cookies on Gitea and other RYO services.

### Notes on webserver logs

VERIFY THIS: This website is created using [Hugo](https://gohugo.io/), which is a static HTML site generator. Hugo processes the content stored in our content repository [**Link here**](#), applying the theme stored in our theme repository [**Link here**](#). The result of the Hugo build process is a set of static HTML pages, which are then (automatically) synchronised to our webservers. There is no server-side code used on the website and no database, so that the only information stored about visitors to the website is in the webserver logs.

TODO: About webserver logs and data retention (check nginx settings)

### Services for monitoring and improving rollyourown.xyz

We do not use any internal or external services (e.g. Google Analytics, **other examples here**...) for monitoring visitors' use of the website. As an open source project, feedback can be given (e.g. on design, usability etc.) voluntarily via our repositories and collaboration resources. We would highly appreciate any feedback or contributions you may have. See our [Collaboration pages](/collaborate) for more details.

In future, we may implement monitoring of our infrastructure (server status and performance, network status etc.). We will update this page with information about privacy and data-protections aspects if and when we do this.

### Additional topics

We may, in future, implement ways (e.g. affiliate links, donate buttons) for users to sponsor the project or generate income - e.g. to help fund the running costs of rollyourown.xyz services. We will update this page with information about privacy and data-protections aspects if and when we do this.
