---
layout: guide
title: "Preloaders"
---

{% assign gist_id = 2830293 %}

RICH applications that we create with Joosy can weight a lot. While 200KB look not that much for modern internet it still can be a pain for mobile tethering. And it always is better to allow client see load progress. Joosy bundles preloaders that implement several strategies.

## Caching (default one)

This preloader will use localStorage of client browser to manually load and save all the assets. This will guarantee stable cache and proper reloading. Beware though: client browser is supposed to support the localStorage feature. Shims are not doing very well here since for the elder browsers the amount of available storage is often not enough. Remember that 200k is your gziped value while it saves the unarchived JS inside localStorage.

The practice shows, however, that even extremely large application always fit under 1Mb of minified JS. Which is far away from basicly available 5Mb limit.

## Inline

Unlike caching preloader this one will relay on HTTP caching. Each page load will try to load all the assets over and over. It's a browser's choise if it will be loaded from the server or not. This kind of preloader has an unpleasant drawback. It can't tell you about the progress. It only supports `loaded` hook.

## Preloaders API

All the preloaders share the same API (but not all of them use all of available hooks). The bootstrap code that uses the preloader of your blog is situated at `blog_preloader.js.coffee.erb`.

{% assign gist_file = 'Helper.coffee' %}
{% include gist.html %}

Using this line you can controll which strategy will be used. Force option is something you can use to test your preloaders within development environment. By default preloaders will only be activated at production. Set it to true and reload your page.

<div class="info">
  <p>
    Note that within development environment (with `force: true`) caching preloader will never reset its cache. To force this you can call `localStorage.clear()` from your browser console.
  </p>
</div>

The layout for your loading progress counter is situated in `app/views/blog.html.erb`. This is the place to add some CSS for a better look.

But let's get back to the available options of the Preloader.

{% assign gist_file = 'Preloader.coffee' %}
{% include gist.html %}

This is the typical preloader usage. It contains all the available options you can use. Some of preloaders (like Inline) may ignore `progress` callback but common logic is still the same.

Please note that we do not use jQuery at this stage cause it's not yet available. You'll get it when the preloading is done. So it's safe to start using it inside your `bootstrap` callback but not before! Same goes to every other library you depend on.

Take a closer look at what happens at the `start` callback. Before it was called our progress bar stays invisible. If you use the `Caching` strategy this helps to avoid progress bar blinking. Loading assets from localStorage takes some microseconds and for that time it will hang around. `start` callback will only be called if preloader is loading something from the server.

## Bootstrap

And the last thing we have to discuss here does not directly touches the preloaders. It's about a Joosy application boostrap. Let's look through the actual `boostrap` callback

{% assign gist_file = 'Bootstrap.coffee' %}
{% include gist.html %}

Application bootstrap accepts some options that you may find useful. Environment option has no direct use at this moment but the debug option does. As soon as you turn it on Joosy will start spamming your console with a lot of info that happens inside classes you use. Just give it a try. Sometimes it can save you an hour of debugging.

Our blog is ready and prepared to load properly. This already is a finished product but there's still one interesting feature Joosy has to offer. Pass on to the [final chapter](/guides/blog/load-unload-and-in-progress-animations.html) to learn how to controll page switch animation.
