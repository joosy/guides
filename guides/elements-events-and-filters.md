---
layout: guide
title: "Elements, events and filters"
---

## Elements & Events

At the lower level `elements` is a hash, whose keys are internal variable names and values are jQuery selectors for them. If you had following in some of your pages

    elements: { foo: '.bar'}

Then after page is loaded, you get @foo variable in that page, that provides access to the element with class `bar`.

Let's add the comments count next to post titles which appears when we hover the title.

Navigate to your index post template (`templates/pages/post/index.jst.hamlc`) and replace its content with

    - @posts.each (post) =>
      %h1= post['title']
        %small.comments_count
          \-
          = post['comments'].length
          comments
      %p= post['body']

If we navigate to [localhost:3000/blog/#!/posts](http://localhost:3000/blog/#!/posts) we'd see

![](http://f.cl.ly/items/2Z1m3R3D0u0v1A423K3B/Screen%20Shot%202012-02-19%20at%207.55.23%20PM.png)

Then open `pages/posts/index.js.coffee` and add `comments_count` element declaration right after `@view`

    elements: 
      commentsCount: '.comments_count'

So we have just defined the `@commentsCount` element. Remember, we want comments counter to be hidden by default? Add following CSS rule to `app/assets/stylesheets/posts.css.scss`

    .comments_count {
      display: none;
    }

![](http://f.cl.ly/items/3a0r2c240c2P0D0P202j/Screen%20Shot%202012-02-19%20at%2010.25.50%20PM.png)

Now it's time to add some animations over here! That's where events come in handy. Basically, `events` is hash of pairs "event descriptions" (which can also contain elements in them)-event handlers.

Syntax for events is really simple

    events: { 'eventname object': (obj) -> $(obj).hide() }

So each key of `events` consists of two main parts: event name (like `click`, `mouseenter`, and so forth) and event object. Joosy has one sweet thing about event objects: you can specify any element you've declared before as event object.

Presume we have

    elements: 
      comments_count: '.comments_count'
      heading: 'h1'

If we wanted to hide title when it's hovered we could declare this very basic event

    events: 
      'mouseenter $heading': (header) ->
        $(header).hide()

That gives us so much flexibility! If we need to change what's
"heading" on your page, we can just change the element, now events will work with an updated element. Cool huh?

Let's get back to our little blog. So we want our comments counters to appear when we hover the post title. As you should probabaly know, javascript event which is responsive for "hover" on an object is called `mouseenter`. So that

    events: 
      'mouseenter $heading': (header) ->
        $(".comments_count", header).fadeIn()

Reload the blog page and hover any title

![](http://f.cl.ly/items/210n173D3H0S1t1Y271M/Screen%20Shot%202012-02-19%20at%2010.43.15%20PM.png)

Pretty smooth. But what if we move the pointer to another title?

![](http://f.cl.ly/items/1y1w210x1w1N3f2W183P/Screen%20Shot%202012-02-19%20at%2010.44.51%20PM.png)

That's not what we expected to see, right? To fix that we simple need to handle the `mouseleave` event to hide comments counter when we're not pointing at the post title anymore.

Change the `events` hash like shown below

    events:
      'mouseenter $heading': (header) ->
        $(".comments_count", header).fadeIn()
      'mouseleave $heading': (header) ->
        $(".comments_count", header).fadeOut()

Only the comments counter of the post we're pointing on the title of
is shown now

![](http://f.cl.ly/items/231X231r0l2i1L3K0t23/Screen%20Shot%202012-02-19%20at%2010.47.21%20PM.png)

Fair enough.

## Filters

TODO: Write this guide.
