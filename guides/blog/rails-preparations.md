---
layout: guide
title: "Rails preparations"
---

{% assign gist_id = 2759363 %}

Before you start, please ensure your system has Rails version >= 3.1. Versions prior to that are not supported due to lack of assets pipeline support.

### Dependencies and scaffolds

Generate new Rails project:

{% assign gist_file = 'Create project.sh' %}
{% include gist.html %}

Besides basic functionality Rails has to offer we'll need to include `joosy` gem and the Twitter bootstrap assets to make our blog look better. This is the gemfile we are supposed to work with:

{% assign gist_file = 'Gemfile.rb' %}
{% include gist.html %}

Now make bundler handle the dependencies:

{% assign gist_file = 'Bundle.sh' %}
{% include gist.html %}

Using Rails scaffold let's prepare some entities we will need inside our blog:

{% assign gist_file = 'Scaffold.sh' %}
{% include gist.html %}

We'll have to modify our models a bit to define an association. Another thing to do is to prepare some seeds.

{% assign gist_file = 'Models.rb' %}
{% include gist.html %}

{% assign gist_file = 'Seeds.rb' %}
{% include gist.html %}

Run `rake db:seed` to make your seeds real and that's pretty much it. Joosy is totally compatible with Rails basic scaffolds generators. You'll have an option to improve your code with better JSON builders and some logic but we'll concentrate on Joosy part for now.

### Joosy application generation

Each Rails application can have several Joosy applications inside it. You can, for example, have seperate applications for your front part and the admin one.

Let's start from generating the front part:

{% assign gist_file = 'Generate Joosy Application.sh' %}
{% include gist.html %}

First command will create the application itself. The second one will generate required bootstrap to properly run it from Rails. It will by default create a controller by application name. It's safe to transfer it to any other controller you want but don't forget to update routes.

According to Rails Assets Pipeline your application is now situated in `app/assets/javascripts` folder. At top level we have:

    blog_preloader.js.coffee
    blog/

First one is required to boot the application while `blog` directory contains application sources in it. We'll discuss bootstrap and preloaders in latter parts of blog creation so for now you should consider `app/assets/javascripts/blog` as a baseline.

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

Together with your first application structure you get sample page and layout. You either get your first templates and they are in HAML. If you never used HAML before you should [go try now](http://haml-lang.com/). Joosy bundles and uses excellent [CoffeScript-enabled HAML notation](https://github.com/9elements/haml-coffee). Within advanced topics we'll cover it how to change the template engine to anything like ECO or Jade. But you are encouraged to use HAML for now since all this guide is built on top of that. And it's just awesome, seriously.

To ensure everything is functioning properly run the ready bundle with `rails s` and go to [localhost:3000/blog](http://localhost:3000/blog). This is what you are supposed to see:

![](http://cl.ly/221l423a0U33362x2V2g/Screen%20Shot%202012-02-11%20at%2011.28.49%20AM.png)

Congratulations! It works! It's time to go further to [Resources](/guides/blog/resources.html).
