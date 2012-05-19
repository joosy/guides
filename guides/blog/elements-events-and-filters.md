---
layout: guide
title: "Elements, events and filters"
---

TODO: Write this guide.

<h1 style="color: red">EVERYTHING BELOW IS OUTDATED</h1>

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

As well as in server-side controllers, you often need to perform some actions on different stages of client page's life. It can be moments just before beginning of page/layout/widget loading, when they start rendering, when user goes off from page etc. Joosy simplifies your efforts with a set of methods.

### beforeLoad, afterLoad and afterUnload

These three filters are the most common. They represent actions that can be done right just before page starts to load; when page has just ended all loading actions and rendering; when user navigates to another page respectively.

"beforeLoad" filter is the best place for authentication checks and other actions, that can influence whether page can be loaded or can not:

    @beforeLoad ->
      unless confirm 'Are you admin?'
        @navigate '/auth_page'

"afterLoad" filter can be applied to the wide range of tasks that should be performed asynchronously right after the page (layout or widget) is fully loaded and rendered.

    @afterLoad ->
      @setInterval 60000, =>
        @bannerImage.attr 'src', "/banners/buySomeCialis_#{[0..10].sample()}.png"

This @setInterval form is a Joosy's syntax sugar: it's arguments position is more convenient for CoffeeScript, and it is internally automatically cleared with "afterUnload" filter. Another purposes of "afterUnload" can be: removing JS plugins from page, clearing events and timeouts set by non-Joosy tools etc.

    @afterUnload 'unbindKeyboard'
      
    unbindKeyboard: ->
      $('body').unbind 'keydown.keyNavigation'

### beforePaint, paint, erase, fetch and fetchSynchronized

These filters differ from previous three with in one key property: they can accept asynchronous methods to delay some loading stage while showing graphic effects, fetching AJAX data etc. Let's see how it works on the example of "fetch". "fetch" filter is called right after "beforeLoad" and is usually used for asynchronous data fetching from external resources (such as your server AJAX). Let's see example:

    @fetch (done) ->
      $.ajax '/some_data.json',
        success: (data) =>
          @data.lollipops = data.candies
          done()

As you can see, "fetch" filter accepts function with one argument - callback, that should be called as soon as your asynchronous actions are over. Other filters in this group have similar behavior, but they are performed in other page loading stages.

At the same time when starts "fetch" filter, previous page (if current page was navigated from some) calls "erase" filter. You can use this filter for example to appoint some graphics effects for previous page disappearance:

    @erase (previousContainer, page, done) ->
      previousContainer.fadeOut 400, =>
        done()

When old page "erase" filter is done, there comes current page's "beforePaint" filter. It is useful when you want to start some visual effects for new page rendering independently from page's data. When both "fetch" and "beforePaint" filters are done, data is in page and page is ready to be rendered, here comes the turn of "paint" filter. It is commonly used to beautify content appearing on the page:

    @beforePaint (done) ->
      @layout.showPreloader()
      @container.fadeTo 0.2, 300, =>
        done()


    @paint (done) ->
      @layout.hidePreloader()
      @container.fadeTo 80, 0, =>
        done().fadeTo 400, 1

This example shows how you can make pretty fading effects when user navigates through pages. Also, using both "beforePaint" and "paint" filters benefits with advanced interactivity of site: users will not notice any AJAX loading (if it is faster than 300ms) because .fadeTo(0.2, 300) is performed at the same time with fetching.

The last one "fetchSynchronized" filter is a "fetch" filter on steroids. It is most useful in cases when you need to load many AJAX sources for one page. You have only one 'done' callback, and if you want to call it when all of your AJAX requests are complete, you could use special @wait and @trigger mechanism. But "fetchSynchronized" filter can do it for you:

    @fetchSynchronized (context) ->
      context.do (done) ->
        $.get '/rumbas', (data) =>
          @data.rumbas = data
          done()
    
      context.do (done) ->
        $.get '/kutuzkas', (data) =>
          @data.kutuzkas = data
          done()

And page loading will continue only when both requests will complete.

Here is a flow chart of all filters:

![Filters Flow Chart](/img/filters_flow.png "Filters Flow Chart")

At last you should remember some facts about filters:

1. beforeLoad, afterLoad and afterUnload accept both function and string - name of method.
Other filters accept only functions with first parameter - callback function to proceed loading.
paint, erase and beforePaint accept second parameter - container (HTML element) that will own future content
This three filters accept third parameter - new page - when called for layout.

2. beforeLoad, afterLoad and afterUnload can be chained, i.e. if you call this filters five times on page for some functions, all five functions will be performed. Other filters will perform only one last function.

3. All filters are inherited from ancestor to its children classes.

Now you know how to add user interface behavior to your site pages with Joosy. In the [next chapter](resources.html) you will learn how Joosy simplifies working with server AJAX requests and models mapping.