---
layout: guide
title: "Forms"
---

{% assign gist_id = 2822781 %}

Joosy includes a very powerful tool to make forms handling really comfortable. `Joosy.Form` wraps your html form and makes it totally AJAXified. No matter if it contains text data or files. So you wrap it and whenever it gets submited you get one of your hooks called (they can be `success`, `error`, `progress`) with the response data passed in.

Besides "AJAXification" it either helps you handle fields management (in conjuction with resources) and invalidation. Both of these will be greatly covered among this chapter.

## Preparations

To implement creation and modification of posts we'll have to add two more pages: `posts/edit` and `posts/new`.

{% assign gist_file = 'Generate pages.sh' %}
{% include gist.html %}

As before let's add some routes to ginger our new pages up:

{% assign gist_file = 'Routes.coffee' %}
{% include gist.html %}

Ensure your `posts/new` route goes _before_ the `posts/:id` one. Routing does always seek for the first match and id matcher will either consume `posts/new` if defined first.

Both pages will actually use the same form. So it's a good candidate to be a partial. Put the following haml to something like `templates/pages/posts/_form.jst.hamlc`:

{% assign gist_file = 'Form.haml' %}
{% include gist.html %}

Joosy has built-in Rails `form_for` analog and we'll get back to this in later chapters. But for now having just two fields hand-writen in HAML is not that bad, so we pass on.

Including this partial to both pages is pretty easy task. Here's how both of our pages templates are going to look:

{% assign gist_file = 'Include.haml' %}
{% include gist.html %}

## Basic binding

We'll work on both pages in parallel since code is going to be pretty similar. In real life you will probably want to refactor it along. But let's keep some duplication to maintain simplicity. We are just learning after all.

`Joosy.Form` works in conjuction with Resource. So what we need to go forward is to get resources for the both pages. And we'll need to address the form so let's bind actual element.

{% assign gist_file = 'Fetch.coffee' %}
{% include gist.html %}

With this code we'll make `@data.post` to contain the resource for the form at both pages. The next code is absolutely identical for either creation and modification so just clone it.

{% assign gist_file = 'Bind.coffee' %}
{% include gist.html %}

Go and check. Your forms are ready. Everything else will be covered by inner magic. Even the validation. But to make it work we'll have to add proper CSS classes and, khm, actually validate something on the server.

## Invalidation

In our case we don't really need to modify styles since we use the same CSS rule name with Rails. And therefore proper CSS is already specified at `scaffold.css`. But if you want to give it a better look search for `.field_with_errors`.

At the server part we'll have to modify our `Post` model:

{% assign gist_file = 'Models.rb' %}
{% include gist.html %}

And you can go check your forms again. Invalidated fields will get it's class and will appear highlighted by CSS rule.

<div class="warning">
  <p>
    Forms are one of the most important parts of Joosy. You really should finish reading this chapter sooner or later. We won't need more info about forms for the whole blog guide though. But you realy should come back later even if decide to pass on to a <a href="/guides/blog/dynamic-rendering.html">Dynamic rendering</a> chapter.
  </p>
</div>

<hr class="additional" />

## Basics

The main goal of `Joosy.Form` is to turn your forms into AJAX to avoid page reload and improve the control. Resources are secondary. Primaries are:

* Catch submit, replace it with AJAX query silently
* If server responded with 200 parse the JSON response and pass it in to the `success` callback
* If server responded with non-200, parse the JSON response and pass it in to the `error` callback
* If `error` callback was not defined but we got error, try to highlight invalidations
* During form upload call `progress` callback periodically and pass in the upload progress

So the default basic look of `attach` call is:

{% assign gist_file = 'Basic attach.coffee' %}
{% include gist.html %}

This call will not modify (or set) the method (POST, PUT etc) of form. And will only affect its action if it was explicitly passed as an `action` parameter. So if you have no resource for the form you still can "activate" it and unleash the power of success/error/progress callbacks.

While success and progress events are very straightforward, the `error` hook plays an important role of validation. If this was not specified Joosy will fallback to default invalidation proccess (which is described below). And more, even if it was specified and did return `true` explicitly, Joosy will still run it's invalidation proccess. This is supposed to ease your form validation handling dramatically.

For the basic form (no resource) invalidation convention is something really easy. `{field: 'error message'}` – this response will make Joosy seek for `input name=field` and mark it as invalid. It matches Rails conventions perfectly.

## Resources

As soon as your form is "attached" you can fill it with the Resource. Do it with `form.fill(resource)` call. In fact passing the `resource` parameter to attach is a shortcut to `fill`. Resource will modify form's behavior slightly.

At first this will try to fill the form with the actual fields values. Joosy will seek the fields by input names. According to Rails conventions you are supposed to call them `model[field]`. Same rule applies to Joosy. Earlier in this guide we've already seen this convention at our edit form.

At second it will properly modify the action and method of form. If the given resource was new, it gets targeted to POST /models. Otherwise it gets targeted to PUT /models/:id. So you just bind your resource, no matter new or existing and form just works.

The last thing that changes with the resource binding is the invalidation proccess. According to Rails conventions backend will still answer with plain hash `{field: 'error message'}` without reference of model name. Joosy will handle it using the name of the attached resource. So for the invalidation it will seek for `input name="resourceName[field]"`.

<div class="info">
  <p>
    Rails is really weak at JSON-reporting of inlined entities validations. It will still answer with plain hash and will omit the details. To make possible automatic validation of complex forms, Joosy will either understand the complex notation:

    <pre>#   { foo: { bar: { baz: ['error'] } } }    # backend response
#   { "foo[bar][baz]": ['error'] }          # field to seek for</pre>
  </p>
</div>

Forms are very important part of Joosy. This chapter gave you the very basics of its possibilities. You can find partial info among other chapters or guides but anyway, please, check out the <a href="http://api.joosy.ws/classes/Joosy/Form.html">API doc</a>. Inside Joosy there's no other class like this that deserves reading it that much.

Next Chapter - [dynamic rendering](/guides/blog/dynamic-rendering.html).
