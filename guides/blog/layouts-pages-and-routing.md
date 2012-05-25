---
layout: guide
title: "Layouts, pages and routing"
---

{% assign gist_id = 2785784 %}

In Rails each page is the action template. It gets wrapped into the layout and includes number of partials. As the result you get your HTML generated.

Joosy behaves the same way but unlike elder brother it has to deal with events and user interaction logic so it's not just a renderer. Joosy separates the templates layer and a logic level. Logic level consists of the `Page`, the `Layout` which wraps the page and set of `Widget`s that can be included in both, `Page` and `Layout`. Each element of the logic level uses templates to describe rendering.

![](http://f.cl.ly/items/1S130q3C0n1s2R1I1T0S/pages.png)

<div class="info">
  <p>
    Joosy tries to keep logic elements alive as long as possible. When the new page gets loaded, current layout (object instance, bindings, DOM, included widgets, etc.) will stay untouched unless new pages requires another layout. In this case Page will be linked to an existing instance.
  </p>
</div>

With your first app you got your first page and layout generated. They are situated in

<div class="black_wheel">
  <pre>pages/welcome/index.js.coffee
layouts/application.js.coffee</pre>
</div>

We'll start from the Layout. The only option it sets makes Joosy seek for a template for this layout at `templates/layouts/application.jst.hamlc`. Since we don't really need any logic at our Layout for now let's just modify the HAML. Using twitter bootstrap we can come up with something like this:

{% assign gist_file = 'Layout.haml' %}
{% include gist.html %}

Take a look at the last tricky line. Using `{:id => @yield()}` we mark the `.container` div with the special ID Joosy will use to include page's HTML. Again, with that, we'll get page HTML right inside our `.container` div. And that's pretty much everything we need from the Layout for now.

<div class="info">
  <p>
    This may look like a silly name cause it clearly is not an `yield` in it's real meaning. But wait! Listen! We had a reason to use this name. It helps you to not remember another `longMethodToCall`. It mimics Rails in the closest possible way. 
  </p>
</div>
