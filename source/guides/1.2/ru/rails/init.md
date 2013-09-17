---
layout: guide
title: "Подготовка проекта"
version: 1.2
language: ru
---



<div class="info">
  <p>
    Пожалуйста, убедитесь, что спользуете версию Rails >= 4.0.0
  </p>
</div>

## Зависимости и настройки


Создайте новый Rails проект:

{% highlight bash linenos%}
  rails new joosy-blog
{% endhighlight%}


Отключите Turbolinks из базового набора Rails и добавьте Joosy вместе с Twitter Bootstrap, благодаря которому приложение будет выглядит красивее.

 Для этого удалите строку <code>gem 'turbolinks'</code> из <code>Gemfile</code> и подключите  необходимые гемы

##### Gemfile
{% highlight ruby linenos %}
  source 'https://rubygems.org'
 
  gem 'rails', '4.0.0'
  gem 'sqlite3'
  gem 'sass-rails', '~> 4.0.0'
  gem 'uglifier', '>= 1.3.0'
  gem 'coffee-rails', '~> 4.0.0'
  gem 'jquery-rails'
  gem 'jbuilder', '~> 1.2'
   
  group :doc do
    gem 'sdoc', require: false
  end
   
  gem "joosy", "~> 1.2.0.beta.2"      #<- добавьте это
  gem 'bootstrap-sass'                #<- и это
  gem 'font-awesome-sass-rails'       #<- и это
{% endhighlight %}

В <code>app/views/layouts/application.html.erb</code> удалите две пары ключ/значение <code>"data-turbolinks-track" => true</code>

##### application.html.erb
{% highlight erb linenos %}
  <!DOCTYPE html>
  <html>
  <head>
    <title>JoosyBlog</title>
    <%= stylesheet_link_tag    "application", media: "all"%>
    <%= javascript_include_tag "application" %>
    <%= csrf_meta_tags %>
  </head>
  <body>
   
  <%= yield %>
   
  </body>
  </html>
{% endhighlight %}

Из <code>app/assets/javascripts/application.js</code> удалите строку <code>//= require turbolinks</code>

##### application.js
{% highlight javascript linenos %}
  // Комментарии упущены
  //= require jquery
  //= require jquery_ujs
  //= require_tree .
{% endhighlight %}

Теперь задействуем Bootstrap. Переименуйте <code>app/assets/stylesheets/application.css</code> в <code>app/assets/stylesheets/application.css.scss</code> и добавьте следующие объявления
{% highlight scss linenos %}
  @import 'bootstrap';
  @import 'font-awesome';
   
  body {
      padding-top: 60px;
  }
{% endhighlight %}

Наконец настало время позаботиться о зависимостях и перейти к программированнию! 

{% highlight bash linenos %}
  bundle install
{% endhighlight %}

## Генераторы

Используя генераторы Rails давайте создадим несколько сущностей для нашего проекта: 

{% highlight bash linenos %}
  rails g scaffold Post title:string body:text comments_count:integer
  rails g scaffold Comment post:references body:text
{% endhighlight %}


Теперь мы дополним ассоциации и добавим образцу каждой модели, что бы было с чем работать

##### app/models/post.rb
{% highlight ruby linenos%}
  class Post < ActiveRecord::Base
    has_many :comments
  end
{% endhighlight %}

##### app/models/comment.rb
{% highlight ruby linenos%}
  class Comment < ActiveRecord::Base
    belongs_to :post, :counter_cache => true
  end
{% endhighlight %}

##### db/seeds.rb
{% highlight ruby linenos %}
  posts = Post.create([
    { title: 'Welcome there', body: 'Hey, welcome to the joosy blog example' },
    { title: 'Test post',     body: 'Nothing there. Really' }
  ])
  Comment.create(body: 'Great article!', post: posts.first)
{% endhighlight %}

Напоследок осталось добавить идентификатор в список сериализируемых через JSON полей

##### app/views/posts/index.json.jbuilder
{% highlight ruby linenos %}
  json.array!(@posts) do |post|
    json.extract! post, :id, :title, :body, :comments_count
    json.url post_url(post, format: :json)
  end
{% endhighlight %}

##### app/views/comments/index.json.jbuilder
{% highlight ruby linenos %}
  json.array!(@comments) do |comment|
    json.extract! comment, :id, :post_id, :body
    json.url comment_url(comment, format: :json)
  end
{% endhighlight %}

Запустите <code>rake db:migrate</code> и <code>rake db:seed</code> для настройки БД и фундамент заложен. Joosy полностью совместима с Rails scaffold генераторами поэтому оставив в стороне всевозможные улучшения в генерации JSON и логике мы сконцентрируемся на сочной стороне нашего приложения - Joosy ;)
