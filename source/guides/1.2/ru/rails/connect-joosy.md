---
layout: guide
title: "Создание Joosy-приложения в Rails"
version: 1.2
language: ru
---

## Создание Joosy-приложения в Rails
Воспользуемся генератором:


##### Создание приложения:
{% highlight bash linenos%}
    rails g joosy:application blog
{% endhighlight %}



<div class="info">
  <p>
    Если не указывать генератору имя приложения <code>blog</code>, то приложение будет сгенерировано прямо в папке <code>app/assets/javascripts</code> и доступно по адресу <code>http:/localhost:3000</code>
  </p>
</div>


Joosy-приложение сгенерировано в папке `app/assets/javascripts/blog` и доступно по адресу `http://localhost:3000/blog`


##### config/routes.rb
{% highlight ruby linenos %}
  JoosyBlog::Application.routes.draw do
    joosy '/blog', application: 'blog'

    resources :comments
    resources :posts
  end
{% endhighlight %}


##### Сгенерированные файлы
{% highlight ruby linenos %}
    ~/www/ruby/joosy-blog $ rails g joosy:application blog
      create  app/assets/javascripts/blog
      create  app/assets/javascripts/blog/application.coffee
      create  app/assets/javascripts/blog/helpers/application.coffee
      create  app/assets/javascripts/blog/layouts/application.coffee
      create  app/assets/javascripts/blog/pages/application.coffee
      create  app/assets/javascripts/blog/pages/welcome/index.coffee
      create  app/assets/javascripts/blog/routes.coffee
      create  app/assets/javascripts/blog/templates/layouts/application.jst.hamlc
      create  app/assets/javascripts/blog/templates/pages/welcome/index.jst.hamlc
      create  app/views/layouts/joosy/blog.html.erb
       route  joosy '/blog', application: 'blog'
{% endhighlight %}