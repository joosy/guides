---
layout: guide
title: "Layouts, pages and routing"
---

### Creating a page

Now let's create a simple Joosy page and see what's going on.

    rails g joosy:page blog/welcome/hi

It will create `blog/pages/welcome/hi.js.coffee` with the page class, and an empty template at `blog/templates/pages/welcome/hi.jst.hamlc`. Put some simple HAML into the template, like

    %h1 Hi there
    %p P.S.: Joosy rocks!

In most Joosy applications HAML is used to do markup. However you're free to use any other templating engine. 

The page class looks as follows

    Joosy.namespace 'Welcome', ->
        
        class @HiPage extends ApplicationPage
        @layout ApplicationLayout
        @view   'hi'

it describes what layout and view to use. However, it can contain `afterLoad`/`beforeLoad` (like rails' `after_filter` and `before_filter`), as well as elements and events hashes.

In order to be able to navigate to this page, we need to add a route for it. Open `routes.js` and add

    '/hi'           : Welcome.HiPage

after the index (`/`) route. Now we can fire up the browser and navigate to [localhost:3000/blog/#!/hi](http://localhost:3000/blog/#!/hi)

![](http://f.cl.ly/items/0q1H0O402E040n2T0718/Screen%20Shot%202012-02-11%20at%2011.49.14%20AM.png)

As you can see, we pass params to our Joosy app after the she-bang (`!#`). It's common behavior for most modern web apps, like Twitter, iCloud, etc.
