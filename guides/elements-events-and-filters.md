---
layout: guide
title: "Elements, events and filters"
---

## Elements

At the lower level `elements` is a hash, whose keys are internal variable names and values are jQuery selectors for them. If you had following in some of your pages

    elements { foo: '.bar'}

Then after page is loaded, you get @foo variable in that page, that provides access to the element with class `bar`.

Let's add the comments count next to post titles which appears when we hover the title.

Navigate to your index post template (`templates/pages/post/index.jst.hamlc`) and replace its content with

    - @posts.each (post) =>
      %h1
    = post['title']
      %small.comments_count= "- " + post['comments'].length + " comments"
      %p= post['body']

If we navigate to [localhost:3000/blog/#!/posts](http://localhost:3000/blog/#!/posts) we'd see

![](http://f.cl.ly/items/2Z1m3R3D0u0v1A423K3B/Screen%20Shot%202012-02-19%20at%207.55.23%20PM.png)

## Events

## Filters
