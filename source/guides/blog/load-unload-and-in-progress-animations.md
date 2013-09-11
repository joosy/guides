---
layout: guide
title: "Load, unload and 'in-progress' animations"
---

{% assign gist_id = 2835542 %}

The final thing we will add to our blog will be page switching animation. At the beginning of this guide we learned how to use before/after page load hooks. Joosy defines much more control points that will allow you wedge betwen unload and rendering controling the way your page (dis)appears. And one more tiny feature: automatic scrolling.

## Page bootstrap proccess

<img src="http://f.cl.ly/items/1Z2L0l3V171H1n2U1o2S/filters_flow.png" style="float: left; margin-right: 40px">

With the help of `beforePaint`, `paint` and `erase` hooks you can define animation that will be used to show and hide page. On the left you can see the order of page bootstrap stages. As you can see `beforeLoad` and `fetch` of new pages happens in parallel with `erase` and `beforePaint`. That means that you can hide your data fetch proccess behind animation.

Let's imagine the full cycle. While your current page is fading out we do run `@fetch`. When fading is done we check if `@fetch` was complete. If not, we show preloader to indicate loading in progress. If it did, we just fade in the new page. As the result, most of your pages will transparently load data at the effect time which will look like it doesn't load anything at all.

But talk is cheap! Show me the code!

{% assign gist_file = 'Effects.coffee' %}
{% include gist.html %}

Layout preloader was commented since we don't really have preloader available. If you want you can try to do that on your own.

This code will control your pages but the first load will still happen harshly. This happens because first load renders the layout and therefore uses the same hooks of your `ApplicationLayout` (or any other that is associated to the current page). To fix that you can reproduce the same hooks at the layout itself.

For the complex cases you will probably want to use different animations for different layouts and pages. There are some useful tips. First of all all the rendering hooks accept several params. They are the container element as the first parameter (and that's all for the Page) and the current page loading (only for Layout). One more thing you can use is the check what was the previous page. Previous page is always accessible from the current page through `@previous` instance variable.

With help of that you can mix different animations and make your application shiny and nice.

## Scrolling

Classic web pages always scroll to the top as soon as the next page loads. With Joosy you always stay within one page in terms of browser. So it will not scroll anywhere. To workaround this Joosy has a syntax sugar for comfortable scroll point definition.

{% assign gist_file = 'Scroll.coffee' %}
{% include gist.html %}

With that your page will be smoothly scrolled to the first element that fits current selector. You can specify custom margin in pixels and the speed. If you set 0 it will be scrolled without animation. Default speed is 500.

## That's all folks!

Our blog is ready. It shows basic pages, loads data and even uses some nice animations. Now that you have basic understanding of Joosy it's a good time to go read some [advanced guides](/). We still have a lot of secrets to share with you!