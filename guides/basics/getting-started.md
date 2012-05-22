---
layout: guide
title: "Getting started"
---

{% assign gist_id = 2731308 %}

### What is Joosy?

Here is the typical transport flow for the Rails web application:

![Typical](http://f.cl.ly/items/322w1b1j2y2X0C212O1U/typical.png)

Joosy moves the HTML rendering, events handling and everything that is connected to the views right into your browser. During preloading, Joosy gets all the templates from the server and uses Rails backend as a REST data provider. And your application looks like this:

![Joosy](http://f.cl.ly/items/0k3f1W2p1H0B1j0r231Z/joosy.png)

With Joosy your views are truly ready for a massive client-side logic. You get application state, defined structure, lot of conventions for typical day-to-day problems and even DOM rendering control points.

### ZOMG! Another MVC Framework...

Joosy is not an MVC framework. It addresses the same problems as Backbone or Ember.js but it's not based clearly on a popular MVC paradigm. Nor it is an MVVM. Joosy is an active view for your server-side framework (mainly the [Rails](http://rubyonrails.org/)). It was created to complement and cooperate with backend. Not to be an abstraction. Therefore you'll probably like it if you are:

* Rails developer
* Use CoffeeScript heavily
* Like HAML (not really required)

The first point is required to feel Joosy the right way. It was greatly inspired by the approach Rails promotes. Unlike most of alternatives we don't stay away from a real-life troubles. Nor we expect the community to decide on it's own. We try to give some kind of convention for each of them. Just like in Rails you should concetrate on what you do. Not how you do it.

[CoffeeScript](http://rubyonrails.org/) is an alma-mater of Joosy. In theory you can use Joosy with a plain JS but you won't be happy. We use the Coffee meta posibilities heavily. Joosy is class-based and relays on CoffeeScript static methods prototype magic. Without having requirement to stay JS-compatible we created an interface that is as clear as possible.

We've added some spice to the Rails+Coffee combo. Applause, the [Sugar.js](http://sugarjs.com/). This incredible library extends the JS the way you are used to with an ActiveSupport. All the comfortable features are here: `[].first`, `'foo'.camelize`, `'fluffy'.pluralize` and many-many more. This sause really make the Coffee feel just like Ruby.

And last but no the least: viva la [HAML](http://haml.info/)! Joosy uses templaters abstraction so in theory you can use anything you are used to. But if you ever tried HAML and fell in love like we did, Joosy is shipped with amazing HAML-Coffee template engine.

### Not am MVC? But...

The idea is simple. REST in not an SQL. Application Server is not an RDBMS. You can't have real logic inside your models. Therefore you don't have models. Inside your browser you don't need to be linked to REST structure since your only goal is an interaction with user. That's why you don't need controllers. Joosy operates with View terms. It has pages, layouts and widgets. Each of them works with templates, resources (doh... models) and forms. That's pretty much it, the typical separation for the View part.

![Scheme](http://cl.ly/1M470v24220L2e080h1L/scheme.png)

Inside Rails you pass your data to your templates through controller and then get it back from forms or AJAX-queries. That's exactly how Joosy works. 
The central entity is a `Page`. Each time URL changes new page gets loaded. Joosy loads the layout for the first page or if the requested page requires another layout. After the container is prepared, you request your Resources and render the templates using it. Remeber, your templates are HAML with inline Coffee support. They even have mature helpers support.

Finally it looks like this:

![Initialization](http://f.cl.ly/items/1K2W1w2N1g1h2O2v3r0V/initialization.png)

Note that most of this stuff is happening asynchronously!

And here's the Page and a Template at a glance:

{% assign gist_file = 'Page Sample.coffee' %}
{% include gist.html %}

{% assign gist_file = 'Template Sample.haml' %}
{% include gist.html %}

To send data back Joosy has a `Form`. It wraps your basic HTML form and turns it into AJAXified thing. It works without page reload and interacts with your code using events. It even has an event for the "upload progress". `Forms` are magically linked to `Resources` so you don't write your code twice. Wait, even more! You have the `formFor` helper. Just like in Rails.

### Okay, it's like Rails. Anything else?

Unlike Rails server application it has a state. For example if you use the only `Layout` for every page it will never get reloaded. Unlike the data it holds. To ease the DOM updates Joosy has `dynamic rendering` feature. It allows you to bind your resource to a template to automatically update DOM whenever resource changes. No manual events handling and rerendering. You just call `@renderDynamic` for a partial and it always stays actual.

{% assign gist_file = 'Partial Sample.haml' %}
{% include gist.html %}

Besides that Joosy offers built-in Identity Map implementation. You don't have to care about `Resources` instances. Even if you reload your `Resource` from a new Page your dynamic rendering will work from your Layout. Or any other place.

And to ensure you won't have problems with really large applications, Joosy comes with a set of preloaders implementing set of strategies.

### Total highlights

Just to make sure you get it right here's the full list of functionality highlights we have to offer:

* Easy and familiar Application structure. You work with pages, layouts and forms.
* Built-in ActiveSupport analog
* Built-in HAML-Coffee templates
* Helpers
* Identity Map for your data
* Easy and straightforward dynamic binding of data to a DOM
* Built-in preloaders
* Automatic Resources generation based on Rails REST routes
* Out-of-box code generators
* ActiveResource-like REST interface

### So what is Joosy good for

Joosy is intended to ease building of modern medium and large-sized browser-based applications using Rails as a backend. To minimize code base while providing more features and what's most important, giving you ready conventions for typical tasks.

Compare Joosy to Backbone like Rails to Sinatra. While Rails engine is much more powerful, Sinatra still has a lot of cases to be used at. If all you need is to enable some RICHness on one of your pages, Joosy can handle that. But Backbone will do the trick with lesser dependencies. If you need to move complete web-resource to browser Joosy will do the task at its Best.

So what are you waiting for? [Go look for some guides!](/)