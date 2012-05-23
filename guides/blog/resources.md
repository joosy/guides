---
layout: guide
title: "Resources"
---

{% assign gist_id = 2775191 %}

### Generation

One of the most important parts of your application is the data you get from your server to work with. While most of other frameworks call this a `Model` at Joosy we call it `Resource`. Your application logic will always remain at server. This is something we can't change. And since Joosy allows you to create helpers, extending your Resource is truly a rare case. So it's much more a definition of your server data container than a Model.

Having a ready set of Rails REST routes Joosy predefines resources for you inside `blog_railties.js.coffee.erb` class. We'll discuss pregeneration options later and now let's move on the magic! At the previous chapter we've generated two scaffolds for `Post` and `Comment` models. In a default setup it means that you already have two classes ready to use. Open your browser console and check if `Post` is accessible.

![Post](http://f.cl.ly/items/3R3420150W0x3A0k1m2q/post.png)

If you try the same for the `Comment` resource you'll see quite another result:

![Comment](http://f.cl.ly/items/1L2j3r1V1H333v430F1v/comment.png)

The reason of this is that Joosy resources predefiner is not destructive. And since W3C defines top-level Comment object it was not rewriten. To carry this out we'll have to generate required resource manually (this is either something you should do if you turn automatic generation off).

{% assign gist_file = 'Generate.sh' %}
{% include gist.html %}

![Comment](http://f.cl.ly/items/3n0Y3R1Q1M130z3J0F0Q/real_comment.png)

Way better now. We have both resources defined. One of those is manually generated and is located at `blog/resources/comment.js.coffee`.

### Entries

Here's the short list of the commands that load and modify the resource:

{% assign gist_file = 'Basic entry actions.coffee' %}
{% include gist.html %}

Did you notice the `save` method was not mentioned? Joosy uses Forms to notify server about modifications. We'll discuss creation and modification in later chapters and now let's focus on the additionals options we can find and create entities with. And the way we can monitor Resource changes.

Here are extended `find` options that can be extremely useful for your REST implementation:

{% assign gist_file = 'Entry find.coffee' %}
{% include gist.html %}

You can combine any of these three options inside your `find` call to retrieve from the URL like `/posts/1/posts/2/foo?foo=bar`.

The other thing you can do with Resource is to subscribe to it's modification event. Each time you modify any field or it gets reloaded it will let you know:

{% assign gist_file = 'Entity monitor.coffee' %}
{% include gist.html %}

You can get a Resource not only by a retrieving if from the server but either by creating it:

{% assign gist_file = 'Entry creation.coffee' %}
{% include gist.html %}

As it was mentioned, Joosy uses identity map. So every object sharing the same ID will either share the same instance. No matter if it was created using `build` or retrieved several times. This gets really useful with events. No matter where and how you got your Resource. If someone is subscribed to modification of instance with id X it will get its notification.

### Collections

Among your pages you'll often want to work with a number of entities instead of just one. Joosy introduces collections as a resources sets.

{% assign gist_file = 'Collections basics.coffee' %}
{% include gist.html %}

Just like single entries collections allow events subscriptions (same name, 'changed') and accept same additional options to `find` method.

### Relations

REST is not SQL. That's why REST consumer does not really needs the relations. Your typical task is to _reduce_ number of HTTP queries that's why it's a common practice to load top instance that has children inlines. However inlined children are still separate resources that's why Joosy supports some kind of `has_many` mapping.

{% assign gist_file = 'Mappings.coffee' %}
{% include gist.html %}

This is pretty enough to complete our Blog implementation goal. So if you want, you can skip to [next chapter](/guides/blog/layouts-pages-and-routing) and study additional resources capabilities later.

<hr class="additional" />

### Raw HTTP calls

Resources also allow you to do direct HTTP calls. Both the class and the object of Resource have same number of methods: get, post, put, delete. The difference is the actual request URL they will use:

{% assign gist_file = 'Raw queries.coffee' %}
{% include gist.html %}

You can see that each of them accepts path modifiers just like `find` does.

### Accurate Resource setup

Sometimes you might want to use Joosy for existing REST providers which are not able to fullfill our conventions. Each manually-generated Resource contains several points of controll. Here are the most of them:

{% assign gist_file = 'Resource setup.coffee' %}
{% include gist.html %}