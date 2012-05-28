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

Let's move on to the pages. To structure application better we will not use the default pregenerated page (we'll remove it later) but create a set of new ones! We'll need three pages: the list of posts, single post view and two forms – to create the post and edit it. We'll get to modification while working with forms and now let's generate list and view pages:

{% assign gist_file = 'Generate.sh' %}
{% include gist.html %}

Let's put the a tiny mock haml to both pages' templates to check if everything went well:

{% assign gist_file = 'Pages mocks.haml' %}
{% include gist.html %}

Before we check them in a browser, we have to bind them to the routes. The routes are situated at `routes.js.coffe` file. Here's the required routing description:

{% assign gist_file = 'Routes.coffee' %}
{% include gist.html %}

Open your browser and go to: 

<div style="text-align:center">
  <pre>http://localhost:3000/blog/#!/posts/1</pre>
  <img src="http://f.cl.ly/items/1J1I1S3O3C1J3X3Z2j1G/posts.png" />
  <pre>http://localhost:3000/blog/#!/posts/1</pre>
  <img src="http://f.cl.ly/items/3x0B2i1L3D2V1G0k242B/post.png" />
</div>

The only thing left to do is to get the real data from server and put it into the template. Joosy defines `fetch` hook that should be used to load required data. Page, Layout and Widget will expect `@data` to contain hash of template's local variable. So this is how it's supposed to look:

{% assign gist_file = 'Fetch.coffee' %}
{% include gist.html %}

Now insert the proper variables into your templates:

{% assign gist_file = 'Pages.haml' %}
{% include gist.html %}

That's it, your pages now contain real data from server. 

<div class="info">
  <p>
    We did not replaced the blog post date field. Moreover we don't even have such a field inside our model. That's a good chance to practice a bit: try to add this field to your model and templates to consolidate your knowledges.
  </p>
</div>

At this stage we got our Rails backend, Resources and two pages with actual data from server. And further we go with [elements, evends and filters](/guides/blog/elements-events-and-filters.html).