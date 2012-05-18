---
layout: index
title: "Getting started"
---

### The Joosy MVC Interpretation

You probably are familiar with the concept of MVC. It's a pattern to keep code DRY, isolate business logic from the UI. However the concept of Model-View-Controller just doesn't work for browser applications. There are numerous reasons for that that can't be fit into this introduction. Instead we'll tell you what we propose.

#### Views

In Joosy views are just views. Set of files (in templates/ folder). They do not differ from Rails and give you quite the same abilities (including helpers!). Besides that Joosy has renderDynamic which allows you to bind your variables to HTML representation tightly. You change variable value, Joosy changes HTML.

By default Joosy comes with Coffee-Haml (which looks and works pretty much like Ruby Haml). Combined with Sugar.js it will feel very similar to Ruby and server-side and will provide you the easiest migration.

#### Controllers

Unlike server-side, client-side has a state. At server-side you only have incoming data and you convert it to output data. At client-side you work with events. To handle correct bootstrap and help you organize your code well, we have 3 entities which play the role of controller. Their organizing functions are similar but they behavior dramatically different at bootstrap.

They are:

###### Pages
Pages are the heart of the entire application. They are used to fetch data, bind events, setup widgets, trig visual effects, and pass the data to the templates.

###### Layouts 
Layouts are mainly used to set a part of your page that won't be reloaded often. Pages are wrapped into Layouts. Just like pages Layouts can bind events and setup widgets. Consider layouts as a bit extended version of what you have in Rails.

###### Widgets 
Widgets are needed to keep your code DRY. They help you organize it in reusable modules.

#### Models

There are some facts that should be noted to explain it how we understand browser-side models.

* In most cases you will want to leave your logic on server-side. In a real models. 
* You rarely want to make 5 HTTP requests instead of 1.
* In most cases you will have to give user a Form as a way to change anything.
* You'll get different possible set of fields depending on case you use your model at.

With all that in mind we came up to the fact: you can not reproduce real models in browser nor you should try to. What you need is a comfortable channel between browser and server-side to get structured data, work with that and send it back. That's mainly a transport and interface task while models are MUCH more than that. To solve this task Joosy offers you two things:

###### Resources
Resource is wrapper on top of JSON dump which will help you to get data from server, parse it and structure it. It will trigger 'changed' if you change resource, will map inline hashes in other resources if possible and do all other magic stuff you expect from your model when you read data. Resources either define Collections. In most cases you can say Resources are fully-functional read part of what you get used to as model.

###### Forms
After you got your data as resources and used it to display something, you'll need to change it. While resource defines modification methods like _save_ and _destroy_ most of complex modifications should go through Joosy.Form. It turns your form into AJAX and binds the resource to it. It handles file uploads, it gives you upload progress callback and makes it a dream to handle. Joosy.Form will either understand standard Rails invalidation response and will mark invalidated fields with ".field_with_errors" out of box.


## What is Joosy good for

Joosy is intended to ease building of modern medium and large-sized browser-based applications, minimize code base while providing more features and what's most important, giving you ready conventions for typical tasks.

Compare Joosy to Backbone like Rails to Sinatra. While Rails engine is much more powerful, Sinatra still has a lot of cases to be used at. If all you need is to enable some RICHness on one of your pages, Joosy can handle that. But Backbone will do the trick with lesser dependencies. If you need to move complete web-resource to browser Joosy will do the task at its Best.