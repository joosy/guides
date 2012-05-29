---
layout: guide
title: "Elements, events and filters"
---

{% assign gist_id = 2819730 %}

<div class="info">
  <p>
    During this chapter we will add the most stupid and useless feature of our blog. The clocks that will appear when mouse hits the header pane. While you probably will never do something like this in a real life this is a very full example for our case.
  </p>
</div>

For the start let's add a tiny mock to our layout HAML to inspect the future look of the clocks we are working on (Lines 4-7).

{% assign gist_file = 'Mock layout.haml' %}
{% include gist.html %}

## Elements, Events

Inside your page, layout or widget you can define two lists. The list of DOM elements to wrap into jQuery and put into instance variables. And list of events to bind to. The first thing we are about to do is to make our mock hide/appear when the mouse reaches `.navbar`. And since it's a part of a layout, we are going to work within it. Don't forget to explicitly set `style="display:none"` right after you check your mock is in place to make your clocks hidden by default.

{% assign gist_file = 'Events.coffee' %}
{% include gist.html %}

At its keys the `elements` hash contains the names of instance variables to assign. And the values are actual jQuery DOM selectors. As you can see in this example it not only defines instance variables but either allows you to avoid duplications while defining events. 

At events hash you write `event_name selector` as a key and pass in lambdas to call at this event. At the selector position you are allowed to use `$element` notation or simply put the full selector as-is: `click .foo .bar`. The lambdas you define accept two arguments: the first is the actual element event was triggered on. And the second is the full jQuery event object. In our cases we don't need any of them so they are omited.

Here is the alternative notation that can help your keep your code readable for the complex cases:

{% assign gist_file = 'Events (complex).coffee' %}
{% include gist.html %}

## Filters

Now is the time to make our clocks alive. Joosy defines set of `before` and `after` hooks that are similar to Rails controller filters. To make clocks work we need to put actual time on when the pages load and register javascript `interval` to update it every second. Put this code into your `ApplicationLayout`:

{% assign gist_file = 'Filters.coffee' %}
{% include gist.html %}

The important thing to note is a `@setInterval` call. Joosy gives you two wrappers for common `setInteval` and `setTimeout` functions. There are two important differences between them and native calls. The first is the arguments order. In Joosy the first argument is the actual timeout/interval delay. Arguments were moved to ease callbacks description for Coffee. And the second difference is the garbage collection. Your interval/timeout will be automatically cleared whenever the container (layout/page/widget) is not active anymore. So you just define the interval and Joosy cares out all the rest.

Together with `afterLoad` Joosy gives you the `beforeLoad` hook. Within beforeLoad you don't have your elements/events assigned nor you have data fetch. But you can controll the page loading flow. As soon as your `beforeLoad` returned false the page load will be aborted. So you can, for example, redirect user to another page.

{% assign gist_file = 'Flow control.coffee' %}
{% include gist.html %}

Both `afterLoad` and `beforeLoad` can be chained. They will be called in exact order you define those among your container. Moreover, if you use classes inheritance, Joosy will call parents hooks. The order is still under controll. Joosy will start from the upper parent and step down towards children.

The next chapter will describe one of the most exciting features, the [Dynamic Rendering](/guides/blog/dynamic-rendering.html).