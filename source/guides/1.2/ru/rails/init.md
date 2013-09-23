---
layout: guide
title: "Подготовка проекта"
version: 1.2
language: ru
---



{% sidenote info%}
  Пожалуйста, убедитесь, что спользуете версию Rails >= 4.0.0
{% endsidenote %}

<h2>Зависимости и настройки</h2> 


Нам понадобиться один свежий Rails проект - создайте его коммандой

{% highlight bash linenos%}
  rails new joosy-blog
{% endhighlight%}

Joosy использует отдельный layout так, что удалять Turbolinks не обязательно, а вот добавить Bootstrap не помешает. Он значительно облегчит оформление внешнего вида нашего проекта.
Отредактируйте <code>Gemfile</code> и подключите  необходимые гемы:

<h5>Gemfile</h5>
{% highlight ruby linenos %}
  source 'https://rubygems.org'
 
  gem 'rails', '4.0.0'
  gem 'sqlite3'
  gem 'sass-rails', '~> 4.0.0'
  gem 'uglifier', '>= 1.3.0'
  gem 'coffee-rails', '~> 4.0.0'
  gem 'jquery-rails'
  gem 'turbolinks'
  gem 'jbuilder', '~> 1.2'
   
  group :doc do
    gem 'sdoc', require: false
  end
   
  gem "joosy", "~> 1.2.0.beta.2"      #<- добавьте это
  gem 'bootstrap-sass'                #<- и это
  gem 'font-awesome-sass-rails'       #<- и это
{% endhighlight %}

Справившись с этой задачей можно смело его задействовать:  переименуйте <code>app/assets/stylesheets/application.css</code> в <code>app/assets/stylesheets/application.css.scss</code> и добавьте следующие строки:
{% highlight scss linenos %}
  @import 'bootstrap';
  @import 'font-awesome';
   
  body {
      padding-top: 60px;
  }
{% endhighlight %}

Теперь настало время позаботиться о зависимостях и перейти к программированнию! Выполните

{% highlight bash linenos %}
  bundle install
{% endhighlight %}

<h2>Генераторы</h2>

Для нашего блога потребуется несколько моделей - Сообщения и Комментарии, даваайте же создадим их незамедлительно!

{% highlight bash linenos %}
  rails g scaffold Post title:string body:text comments_count:integer
  rails g scaffold Comment post:references body:text
{% endhighlight %}


Установим необходимые связи и добавим капельку исходный данных, что бы было с чем работать.

<h5>app/models/post.rb</h5>
{% highlight ruby linenos%}
  class Post < ActiveRecord::Base
    has_many :comments
  end
{% endhighlight %}

<h5>app/models/comment.rb</h5>
{% highlight ruby linenos%}
  class Comment < ActiveRecord::Base
    belongs_to :post, :counter_cache => true
  end
{% endhighlight %}

<h5>db/seeds.rb</h5>
{% highlight ruby linenos %}
  posts = Post.create([
    { title: 'Welcome there', body: 'Hey, welcome to the joosy blog example' },
    { title: 'Test post',     body: 'Nothing there. Really' }
  ])
  Comment.create(body: 'Great article!', post: posts.first)
{% endhighlight %}

Так же Rails 4 по-умолчанию не сереилизирует id через JSON, поэтому их нужно включить принудительно 

<h5> app/views/posts/index.json.jbuilder</h5>
{% highlight ruby linenos %}
  json.array!(@posts) do |post|
    json.extract! post, :id, :title, :body, :comments_count
    json.url post_url(post, format: :json)
  end
{% endhighlight %}

<h5>app/views/comments/index.json.jbuilder</h5>
{% highlight ruby linenos %}
  json.array!(@comments) do |comment|
    json.extract! comment, :id, :post_id, :body
    json.url comment_url(comment, format: :json)
  end
{% endhighlight %}

Запустите <code>rake db:migrate</code> и <code>rake db:seed</code> для настройки БД и фундамент можно считать заложенным. Нам очень повезло, что Joosy полностью совместима с семантикой Rails, поэтому оставив в стороне все возможные потенциальные  улучшения мы незамедлительно переходим к сочной стороне нашего приложения - Joosy ;) 

<h2> Создание Joosy приложения</h2>

Каждый Rails  проект может содержать внутри себя несколько Joosy приложений. Например, совершенно независимые пользовательскую часть и для административную панель!

Давайте начнем с пользовательской части. 

{% highlight bash linenos %}
  rails g joosy:application blog
{% endhighlight %}

