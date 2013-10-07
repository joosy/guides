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

{% sidenote info %}
  Построить путь к нестандартному Rails-ресурсу позволит директива <code>@source '/funny_cats/latest_posts.json'</code>
{% endsidenote %}


Чтобы воспользоваться базовыми возможностями Joosy-ресурса, создадим базовый класс странички и ее шаблон, чтобы посмотреть записи блога. В консоли воспользуемся генератором:

    rails g joosy:page posts/index blog


В класс странички `app/assets/javascripts/pages/posts/index.coffee` добавим получение записей блога:

    @fetch (complete) ->
      Post.all (error, data) =>
        @data.posts = data
        complete()

Весь класс страницы должен выглядеть так:

##### app/assets/javascripts/pages/posts/index.coffee
{% highlight ruby linenos %}

    Joosy.namespace 'Posts', ->

      class @IndexPage extends ApplicationPage
        @layout ApplicationLayout
        @view 'index'

        @fetch (complete) ->
          Post.all (error, data) =>
            @data.posts = data
            complete()

{% endhighlight %}

Оживим страничку списком записей блога: `app/assets/javascripts/blog/templates/pages/posts/index.jst.hamlc`

##### app/assets/javascripts/blog/templates/pages/posts/index.jst.hamlc
{% highlight ruby linenos %}

    - @posts.each (post) =>
      %h3
        Title:
        %a{:href => @postPath(id: post.get('id'))}
          = post.get 'title'
      %span
        .some = post.get 'body'
      %span
        Comments count:
        = post.get 'comments_count'

{% endhighlight %}

Добавим роуты в `app/assets/javascripts/blog/routes.coffee`, чтобы добраться до страницы:

##### app/assets/javascripts/blog/routes.coffee
{% highlight ruby linenos %}

    Joosy.Router.draw ->
      @root to: Welcome.IndexPage
      @match '/posts',  to: Posts.IndexPage, as: 'posts'
      @match '/posts/:id', to: Posts.ShowPage, as: 'post'

{% endhighlight %}

И убедимся что все работает, откроем страницу: `localhost:3000/blog/posts`








