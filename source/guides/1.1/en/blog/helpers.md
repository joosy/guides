---
layout: guide
title: "Helpers"
version: 1.1
language: en
---

{% assign gist_id = 2829817 %}

At Joosy helpers play exactly the same role as in Rails. They are defined on the application level and will work with any templating engine you use. That certainly includes default HAML one. What differs between Rails and Joosy is the default list of helpers we can afford to introduce for you. Browser-loading reality makes us to try hard to reduce bundle size. So we are very limited on the number of helpers we can include.

## Views

This section defines three useful helpers:

#### Tag

{% assign gist_file = 'Tag.haml' %}
{% include gist.html %}

#### Render Wrapped

{% assign gist_file = 'Wrapped.haml' %}
{% include gist.html %}

Being an indentation-dependent syntax, HAML has a weak part: wrapping. You can easily insert inline part of code as a partial but opposite turns into a hell. This helper was meant to solve the problem. The partial you render will get the same context as the current template. The content given to the helper as the second parameter will be put at `@yield` variable inside wrapping partial.

#### Nl2Br

{% assign gist_file = 'Nl2br.haml' %}
{% include gist.html %}

Simply replaces all the newlines with the `<br />` tag.

## Forms

This set of helpers was meant to ease forms html generation. It was shamelessly cloned from a Rails with a very tiny modifications. Here is the full example of a form:

{% assign gist_file = 'Form.haml' %}
{% include gist.html %}

Only the first argument (name of resource field to draw input for) is required for most of tags. The only exception is a `radioButton` that requires the second parameter (button value).

## Creating own helpers

Joosy application skeleton includes `helpers` directory at its root. `helpers/application.js.coffee` contains basic sample of a helper. Let's define our own helper to make our blog a little more piratish:

{% assign gist_file = 'Helper.coffee' %}
{% include gist.html %}

All the helper defined among `Application` namespace (take a look at line 1) will be accessible at every template. The time has come to prepeate your pirate hook and the parrot:

{% assign gist_file = 'Pirate Title.haml' %}
{% include gist.html %}

And where the hell is rum?

We are not going to piratize anything but blog post titles and they are concectrated in a single widget. In this particular case it's not recomended to polute the global helpers namespace.

## Namespaces and inclusions

Helpers namespaces is a thing that will help you to avoid pollution. Let's move our helper to the new non-global namespace called 'Pirates'.

{% assign gist_file = 'Pirates Helper.coffee' %}
{% include gist.html %}

To include this namespace to our widget use this string inside your widget class:

{% assign gist_file = 'Helpers Inclusion.coffee' %}
{% include gist.html %}

Yarr! Now you are officially an encapsulated pirate!

Most of our blog work is complete. As it was mentioned from the start Joosy has set of preloading strategies bundled. Now is the time to ensure our app loads properly with the [next chapter](/guides/1.1/en/blog/preloaders.html).
