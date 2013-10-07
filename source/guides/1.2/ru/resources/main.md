---
layout: guide
title: "Ресурсы Joosy - Основные возможности"
version: 1.2
language: ru
---

## Ресурсы Joosy - Основные возможности

Создадим joosy-класс для модели Post:

##### app/assets/javascripts/resources/post.coffee
{% highlight ruby linenos %}
  class @Post extends Joosy.Resources.REST
    @entity 'post'

{% endhighlight %}

Директива `@entity 'model_name'` обязательна, она позволит построить путь к стандартному REST-ресурсу Rails: `localhost:3000/posts.json`


Построить путь к нестандартному Rails-ресурсу позволит директива `@source '/some_fun_posts.json'`

