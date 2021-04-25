---
title: "{{ replace .Name "-" " " | title }}"
tags: []
draft: false
---

Summary content

<!--more-->

Main content

## Table shortcode

Add bootstrap classes for rendering

{{< table tableclass="table table-bordered table-striped" theadclass="thead-dark" >}}
| Table | Template |
| :------ | :----------- |
| A       | AAAAA |
| B       | BBBBB |
{{< /table >}}

## Highlight shortcode

Add bootstrap colour type as first argument, optional headline as second argument

{{< highlight "primary" "Headline">}}
Some markdown text
{{< /highlight >}}

## Alert shortcode

Add bootstrap colour type as first argument, optional headline as second argument

{{< alert "primary" "Headline">}}
Some markdown text
{{< /alert >}}

## Read more shortcode

Add bootstrap colour type as first argument, optional button text (default is "Read more...") as second argument

{{< more "secondary" "Button text">}}
Some markdown text
{{< /more >}}
