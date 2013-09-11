---
layout: guide
title: "Getting started"
version: 1.1
language: en
---

{% assign gist_id = 2731308 %}

### What is Joosy?

Here is the typical transport flow for a Rails web application:

![Typical](http://f.cl.ly/items/322w1b1j2y2X0C212O1U/typical.png)

Joosy moves HTML rendering, event handling and everything that is connected to the views right to your browser. During preloading, Joosy gets all the templates from the server and uses the Rails backend as a REST data provider. And your application looks like this:

![Joosy](http://f.cl.ly/items/0k3f1W2p1H0B1j0r231Z/joosy.png)

With Joosy your views are transformed into robust client-side logic. You get application state, defined structure, lots of conventions for typical day-to-day problems and even DOM rendering control points.

### ZOMG! Another MVC Framework...

Joosy is not an MVC framework. It addresses the same problems as Backbone or Ember.js, but it's not based on the popular MVC paradigm. Nor it is an MVVM. Joosy is an active view for your server-side framework (mainly [Rails](http://rubyonrails.org/)). It was created to complement and cooperate with the backend. Not to be an abstraction. Therefore, you'll probably like it if you:

* Are a Rails developer
* Use CoffeeScript heavily
* Like HAML (though this one's not really required)

The first point is required to experience Joosy the right way. It was greatly inspired by the approach Rails promotes. Unlike most alternatives, we don't shy away from real-world challenges. Nor do we expect the community to decide on it's own. We try to be opinionated, and provide some kind of convention for each situation. Just like in Rails, Joosy allows you to concentrate on what you do, not how you do it.

[CoffeeScript](http://rubyonrails.org/) and Joosy are like peas and carrots. In theory you can use Joosy with plain JS, but you won't be happy. We use the Coffee meta possibilities heavily. Joosy is class-based and relies on CoffeeScript's static methods and prototype magic. By loosening the requirement to stay JS-compatible we were able to create as clear an interface as possible.

We've added some sweet spice to the Rails+Coffee combo. Applause! [Sugar.js](http://sugarjs.com/) is an incredible library that extends JS in ways you are used to with ActiveSupport. All the comfortable features are here: `[].first`, `'foo'.camelize`, `'fluffy'.pluralize` and many, many more. The sweetness of Sugar really makes Coffee feel just like Ruby!

And last but not least, viva la [HAML](http://haml.info/)! Joosy uses template abstraction so in theory you can use anything you are used to. But if you tried HAML and fell in love with it like we did, Joosy ships with an amazing HAML-Coffee template engine.

### Not an MVC? But...

The idea is simple. REST is not SQL. An application server is not an RDBMS. You can't have real logic inside your models. Therefore you don't have models. Inside your browser you don't need to be linked to a REST structure since your only goal is the interaction with user. That's why you don't need controllers. Joosy operates with View terms. It has pages, layouts and widgets. Each of them works with templates, resources (doh... models) and forms. That's pretty much it, the typical separation for the View part.

![Scheme](http://cl.ly/1M470v24220L2e080h1L/scheme.png)

In Rails, you pass your data to your templates through a controller, and then get it back from forms or AJAX-queries. That's exactly how Joosy works. 

The central entity in Joosy is a `Page`. Each time the URL changes, a new page gets loaded. Joosy loads the layout for the first page, or if the requested page requires it, another layout. After the container is prepared, you request your `Resources` and render the templates using it. Remember, your templates are HAML with inline CoffeeScript support. They even have mature helpers support.

The page rendering flow looks like this:

![Initialization](http://f.cl.ly/items/1K2W1w2N1g1h2O2v3r0V/initialization.png)

Note that most of this stuff is happening asynchronously!

Here's a sample Page and Template at a glance:

{% assign gist_file = 'Page Sample.coffee' %}
{% include gist.html %}

{% assign gist_file = 'Template Sample.haml' %}
{% include gist.html %}

To send data back, Joosy has a `Form`. It wraps your basic HTML form and turns it into an AJAXified thing. It works without page reload and interacts with your code using events. (It even has an event for "upload progress!") `Forms` are magically linked to `Resources`, so you don't need to write your code twice. And what's more, you even have a `formFor` helper, just like in Rails!

### Okay, it's like Rails. Anything else?

Unlike a Rails server application, a Joosy application has state. For example, if you only use one `Layout` for all of your pages, it will never get reloaded, even though the data it holds does. To simplify DOM updates, Joosy has a `dynamic rendering` feature. It allows you to bind your resource to a template to automatically update the DOM whenever the resource changes. No manual event handling and rerendering. You just call `@renderDynamic` for a partial and it always stays up-to-date.

{% assign gist_file = 'Partial Sample.haml' %}
{% include gist.html %}

Besides that, Joosy also offers a built-in [Identity Map](http://en.wikipedia.org/wiki/Identity_map_pattern) implementation. Now, you don't have to care about your `Resource` instances. Even if you reload your `Resource` from a new Page, your dynamic rendering will work from your Layout. Or any other place.

To ensure you won't have problems with really large applications, Joosy comes with a set of preloaders implementing a variety of preloading strategies.

### Feature Summary

Just to make sure you get it right, here's the full list of functionality highlights we have to offer:

* Easy and familiar application structure. You work with pages, layouts and forms.
* Built-in ActiveSupport analog
* Built-in HAML-Coffee templates
* Helpers
* Identity Map for your data
* Easy and straightforward dynamic binding of data to a DOM
* Built-in preloaders
* Automatic Resources generation based on Rails REST routes
* Out-of-the-box code generators
* ActiveResource-like REST interface

### So what is Joosy good for

Joosy is intended to simplify building modern, medium to large-sized, browser-based applications using Rails as a backend. It aims to minimize code base while providing more of the most important features, while giving you ready conventions for typical tasks.

Joosy is to Backbone as Rails is to Sinatra. While the Rails engine is much more powerful, Sinatra still has a lot of valid use cases. If all you need is to enable some RICHness on one of your pages, Joosy can handle that, but Backbone will do the trick with fewer dependencies. On the other hand, if you need to move a complete web resource to the browser, Joosy will do the task at its best.
Still unsure whether or not Joosy is a better fit for your needs than Backbone or Ember? Check out [the feature comparison table](/guides/1.1/en/basics/joosy-vs-x.html).

So what are you waiting for? [Go check out the guides to get started!](/guides/1.1/en/)
