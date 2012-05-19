---
layout: guide
title: "Joosy Basics"
---

## Creating basic Rails blog app

Assuming you already have Ruby & Rails installed, let's proceed to creating a new rails project.

    rails new blog

Now, let's generate scaffolds for Post and Comment, and add sample data
to the database.

    rails g scaffold Post title:string body:text
    rails g scaffold Comment post:references body:text

Fire up your text editor of choice and declare `has_many` for Post.

    class Post < ActiveRecord::Base
      has_many :comments
    end

Don't forget to run migrations after that

    rake db:migrate

Let's fill our database with sample data. Put the following into
`db/seeds.rb`

{% highlight ruby %}
posts = Post.create([{ title: 'Welcome there', body: 'Hey, welcome to the joosy blog example' }, { title: 'Test post', body: 'Nothing there. Really' }])
Comment.create(body: 'Great article!', post: posts.first)
{% endhighlight %}

After running `rake db:seed` we are ready to go.

## Adding Joosy

To activate Joosy you only need to extend your Gemfile with:

    gem 'joosy'

After `bundle install` is done you can generate basic Joosy application skeleton.

    rails g joosy:application blog
    rails g joosy:preloader blog

First command will create the application itself. The second one will generate required bootstrap to properly run it from Rails. It will by default create a controller by application name. It's safe to transfer it to any other controller you want but don't forget to update routes.

Now you can start rails with `rails s` and visit you newly created app [localhost:3000/blog](http://localhost:3000/blog). This is what you are supposed to see:

![](http://cl.ly/221l423a0U33362x2V2g/Screen%20Shot%202012-02-11%20at%2011.28.49%20AM.png)

According to Rails Assets Pipeline your application is now situated in `app/assets/javascripts` folder. At top level we have:

    blog_preloader.js.coffee
    blog/

First one is needed to boot the application while `blog` directory contains application sources in it. We'll discuss bootstrap and preloaders later in this guide so for now you should consider `app/assets/javascripts/blog` as a baseline.

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

Joosy application structure is pretty straightforward and with structure you get your first page and layout. You either get your first templates… and they are in HAML. If you never used HAML before you should [go try now](http://haml-lang.com/). Joosy bundles and uses excellent [CoffeScript-enabled HAML notation](https://github.com/9elements/haml-coffee). Within advanced topics we'll describe it how to change the template engine to anything like ECO or Jade. But you are encouraged to use HAML for now since all this guide is built on top of that.

You should try to investigate `layouts/` and `pages/` content on your own since that are the things we will go through in [next chapter](layouts-pages-and-routing.html).
