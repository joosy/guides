---
layout: guide
title: "Dynamic rendering"
version: 1.1
language: en
---

{% assign gist_id = 2827878 %}

During this chapter we'll implement inline post title editing. It will be available at `post/show` page. As you click on the title it gets replaced with the inline form. After that the submit title shows up again, but with the new value.

## Templates and partials scopes

While working on forms we already faced partials of templates. Just like in Rails, partials are just other templates that get included. While `@render` seems a really easy-to-use thing (and it really is), it has its ace in the hole. Common approach for the most of template engines is to accept a Hash as the context of rendering. With Joosy you can either pass in the Resource and the Collection. Remember that any other types besides Object, Resource, Collection will raise an exception.

{% assign gist_file = 'Template Scopes.coffee' %}
{% include gist.html %}

Note that `@data` variable you use at a page is internally used exactly as a rendering context. So it shares the same rules, you can fill it with Resource or Collection, not only a Hash (like we did everywhere before).

## Dynamic partials

Joosy has the ability to keep partial up-to-date. It's being achieved by using <a href="http://api.joosy.ws/mixins/Joosy/Modules/Events.html">Events</a>. As soon as any of partial scope variables triggers `changed` event, Joosy will rerender exactly this part of page with the same instances. You can use this manually but two typical use cases are Resource and Collection that do trigger `changed` event on each modification.

Open up your `posts/show` template and move the title header into partial.

{% assign gist_file = 'Partial.haml' %}
{% include gist.html %}

Now let the magic begin! Open up your console being at `/blog/#!/posts/1` page. And call something like `Joosy.Application.page.data.post('title', 'test')`. See? It reloads the partial and the new title appears on the page as soon as you modify resource.

## Inline title editor

We need to modify `post/show` once more to add the hidden form.

{% assign gist_file = 'Form.haml' %}
{% include gist.html %}

Everything else should be quite familiar if you did read the previous guides. These are the additions to the Posts.ShowPage:

{% assign gist_file = 'Editor.coffee' %}
{% include gist.html %}

Note the Line 14. As soon as server responds successfully, we modify the resource and it immediately gets updated at DOM.

And now that our inline editor is ready why not copy that to index page? To keep code clean and avoid duplication <a href="/guides/1.1/en/blog/widgets.html">the next chapter</a> will describe the clear way to achieve this using Widgets.
