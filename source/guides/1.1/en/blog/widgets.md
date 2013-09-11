---
layout: guide
title: "Widgets"
version: 1.1
language: en
---

{% assign gist_id = 2828061 %}

According to the previous chapter goals we are going to move inline editor functionality to the Widget and include it into index page. Generate Widget:

{% assign gist_file = 'Generate.sh' %}
{% include gist.html %}

## Creating widget

Just like pages and layouts, widgets can have elements, events, filters and templates. The key difference is the first container you meet that can be created by you. That's why it has constructor. Our current goal is to move all the functionality we created for the Show page to the widget as-is.

{% assign gist_file = 'Widget.coffee' %}
{% include gist.html %}

Remember to remove all this stuff from the Show page! It's not needed anymore!

The next step is to move all the required HAML into widget's template. And don't forget the dynamic partial that should be moved to `templates/widgets` directory either.

{% assign gist_file = 'Templates.haml' %}
{% include gist.html %}

## Including widget

Widget is quite a common entity. Widget you create can wrap around existing DOM, use own templates, interact with page/layout or be completely encapsulated. To fulfill such needs Joosy introduces two methods to require widget.

The first one goes the direct inclusion from within a template. This is a very comfortable way of inclusion if your widget has its own template and is encapsulated. Our new widget fits perfectly.

{% assign gist_file = 'Widget Template.haml' %}
{% include gist.html %}

Look at the line one. The first argument is a container tag for the widget to be put at. Choose something that will not break your layout. And the second parameter is a widget you are going to bind to container tag. It can be a lambda (like in example) or just a widget class. In the latter case it will be created without arguments to constructor.

And actually this is it. Nothing more is required to do. If only expand our widget usage to the Posts.Index page. So was the plan, wasn't it?

{% assign gist_file = 'Widget Index Template.haml' %}
{% include gist.html %}

<div class="warning">
  <p>
    More info about widgets inclusion and manipulation is not required to complete our blog. Skip to the <a href="/guides/blog/helpers.html">next chapter</a> if you want to get back to that later.
  </p>
</div>

<hr class="additional" />

## Alternative widget registration

If your widgets are about to control the existing DOM structures (please ensure you don't break encapsulation) or you are going to interact between widget and it's container, you have an option to directly bind the widget from a page. This looks similar to the elements and events bindings. You just define the `widgets` hash:

{% assign gist_file = 'Widgets Hash.coffee' %}
{% include gist.html %}

To maintain direct bridge between the container and the widget you can assign creating instance of widet instance variable. That's exactly what we do at the third example. But **beware**! If the selector matches several DOM elements, each of them will be passed to a separate widget. And therefore with this lambda `@testWidget` will always contain the last loaded widget.

## Manual registration and destruction

You can either register and unregister widgets manually. Page and Layout define two methods to help you with this. They are: `@registerWidget(container, widget)` and `@unregisterWidget(widget)`. 

The first one takes the reference to the DOM node (container) and the widget. The widget can be pased in the same manner, as a Class or as a lambda. `registerWidget` will return you the widget instance. It will be unloaded in process of page/layout destruction.

In cases when you want to control the lifetime of this widget manually, use `unregisterWidget` that accepts the instance of widget to shutdown. Note that still widgets never survive destruction of page/layout they are contained by.

Next Chapter - [helpers](/guides/1.1/en/blog/helpers.html).
