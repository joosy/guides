---
layout: guide
title: "Getting Started with Joosy"
---

## Assumptions

The guide is designed for people who want to empower their apps with a web UI that rocks. It relies on you having basic understanding of Rails, REST, ActiveRecord, and common Rails patterns.

Because of Asset Pipeline, it's required to have at least Rails 3.1 installed.

## What is Joosy

Joosy is a full-featured javascript MVC framework, which mostly follows Rails philosophy, particularly in preferring conventions over configuration. It helps you to avoid boilerplate and makes it easy to maintain and extend the app.

Joosy allows you to create web apps which work completely in the browser. So that, it helps you to relocate all your Rails Views to the client side. It also helps you with managing the growing quantity of JS code. On another hand, it makes your backend to have exactly one function --  to be a simple REST provider. That leads to easier development support and improves the scalability greatly.

You'd consider Joosy as a client-side Rails. It doesn't compete with jQuery. It is built on the top of jQuery, and utilizes CoffeeScript. It has its own ActiveSupport. Also, by default Joosy includes Sugar.js to make your JS code sweet.

Finally, Joosy boosts your development drastically.

### The Joosy MVC Interpretation

As a developer with some Rails background, you'd be familiar with the concept of MVC. It's a pattern to keep code DRY, isolate business logic from the UI. However the concept of Model-View-Controller just doesn't work for browser applications. While building Joosy, we've came up with out interoperation of MVC which works with web apps just fine.

#### Resources

A resource represents the structured piece of data. In Joosy, resources are mostly used to fetch data from the REST backend of your application. 

#### Pages

Pages are the heart of the entire application. They are used to fetch data, trig visual effects, and pass the data to the templates. Providing an analogy with Rails, Pages are something like Rails controller actions.

#### Templates

Templates represent the UI of your application. They're the View layer. Often, templates are written in HAML with some snippets of CoffeeScript.

### REST

REST stands for Representational State Transfer. It's an important concept, especially for modern web applications.

Basically, Joosy can work with the REST resources by default with no additional configuration needed, however if you choose to not use REST for some reason, you can use any other way of exchanging the information with server.

## What is Joosy good for

Joosy is intended to ease building of modern medium and large-sized web applications, minimize code base while providing more features, and also to require almost no effort from your behalf to learn it, because it's really like "Rails on browser".

## Creating a new Joosy project

Assuming you already have Ruby & Rails installed, let's proceed to creating a new rails project.

    rails new blog

Then let's add `gem 'joosy', :git => 'git://github.com/roundlake/joosy.git'` to the Gemfile and `bundle`.

Now you can generate basic Joosy application skeleton.

    rails g joosy:application blog

In order to have the application booted, we need to also generate the preloader.

    rails g joosy:preloader blog

So you can `rails s` and see Joosy placeholder at [localhost:3000/blog](http://localhost:3000/blog)

![](http://f.cl.ly/items/3r1T27472y0K0u440Z3B/Screen%20Shot%202012-02-11%20at%2011.28.49%20AM.png)

Let's see where our Joosy application sources are placed. In `app/assets/javascripts` we have the `blog_preloader.js.coffee`, which is needed to boot the application, and the `blog` directory with the application sources in it.

Joosy application structure is quite similar to Rails' one. We'll assume you to do most of your work in there.

    .
    ├── helpers
    │   └── application.js.coffee
    ├── layouts
    │   └── application.js.coffee
    ├── pages
    │   ├── application.js.coffee
    │   └── welcome
    │       └── index.js.coffee
    ├── resources
    ├── routes.js.coffee
    ├── templates
    │   ├── layouts
    │   │   └── application.jst.hamlc
    │   ├── pages
    │   │   └── welcome
    │   │       └── index.jst.hamlc
    │   └── widgets
    └── widgets

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

### Basic Joosy interaction with backend
