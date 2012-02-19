---
layout: guide
title: "Layouts, pages and routing"
---

### Pages & Layouts

Let's create a simple Joosy page and see what's going on.

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

it describes what layout and view to use.

### Routing

In order to be able to navigate to this page, we need to add a route for it. Open `routes.js` and add

    '/hi'           : Welcome.HiPage

after the index (`/`) route. Now we can fire up the browser and navigate to [localhost:3000/blog/#!/hi](http://localhost:3000/blog/#!/hi)

![](http://f.cl.ly/items/0q1H0O402E040n2T0718/Screen%20Shot%202012-02-11%20at%2011.49.14%20AM.png)

As you can see, we pass params to our Joosy app after the she-bang (`!#`). It's common behavior for most modern web apps, like Twitter, iCloud, etc.

### Layouts

As you use Rails, you're familiar with the concept behind them. Basically, layouts are used to keep your templates DRY. You can have as many nest levels in your layouts as you want.

Layouts in Joosy are made up of a class and a template

Let's change the main layout a bit, so that, there is a small copyright in the bottom of the page. Add the following to `templates/layouts/application.jst.hamlc` 

    %p &copy; 2012

Hi page now looks like

![](http://f.cl.ly/items/1s0T1y3R263m2w423E18/Screen%20Shot%202012-02-16%20at%208.15.36%20PM.png)

## Let's proceed with out blog app

For first, let's create a new page for post listings.

    rails g joosy:page blog/post/index

Don't forget to add routes for it

    '/posts'        :
      '/'           : Post.IndexPage

Note we now define routes a bit special way. To declare routes for resource in joosy you basically do the following

    '/resources':
      '/': Resource.IndexPage
      '/:id': Resource.ShowPage
    # and so forth

It's like writing `resources :resources` in Rails and specifying each resource method manually.

Now let's allow the app to fetch our posts. Open the Index Post page (`pages/post/index.js.coffee`). To fetch data via the REST API we should declare `@fetch` inside the page class

    @fetch (complete) ->
      $.get '/posts.json', (result) =>
        data = posts: result
        complete()

There we tell Joosy to get the list of posts, and assign it to the `posts` local for the template (via `@data`).

(For those of you wondering about Resources (that's how Models are called in Joosy), we'll cover them in the following chapters. For now let's proceed with manual json fetching.)

To make our templates show posts, we just need to iterate through the `posts` local (`@posts`). Enter the following into `templates/pages/posts/index.jst.hamlc`

    - @posts.each (post) =>
      %h1= post['title']
      %p= post['body']

If you followed everything correctly, now you'd be able to see post listing at [localhost:3000/blog/#!/posts](http://localhost:3000/blog/#!/posts).

![](http://f.cl.ly/items/2i3x1N1K273l3Y1u2R13/Screen%20Shot%202012-02-16%20at%208.15.15%20PM.png)

So we've built a simple Joosy application able to show the post index.
