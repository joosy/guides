---
layout: guide
title: "Ресурсы: Подготовка Backend"
version: 1.2
language: ru
---

## Ресурсы: Подготовка Backend

Ресурсами в Joosy называется отображение Backend-моделей. Перед тем как начать работать с ними со стороны Joosy, нам надо подготовиться со стороны сервера. По-умолчанию связка Joosy и Rails использует REST в качестве транспорта. Поэтому нам понадобится несколько моделей, контроллеров CRUD и представлений, которые будут отдавать JSON вместо стандартного HTML.

### Модели

В блоге мы будем использовать Сообщения и Комментарии, давайте же создадим их незамедлительно!

{% highlight bash linenos %}
  rails g scaffold Post title:string body:text comments_count:integer
  rails g scaffold Comment post:references body:text
{% endhighlight %}

Установим необходимые связи и добавим капельку исходных данных, что бы было с чем работать.

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

### Контроллеры

Контроллеры, которые генерирует Rails-scaffold нас полностью устраивают. Они являются прямым отображением конвенций Rails, а именно на них и заточен Joosy.

### View

В то время как рендеринг всего HTML Joosy переносит в браузер, серверу все еще нужны View для того чтобы правильно отдавать нам модели. Для этого мы будем использовать jbuilder. По-умолчанию jbuilder не сериализирует id, поэтому их нужно включить принудительно:

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

Запустите `rake db:migrate` и `rake db:seed` для настройки БД и фундамент можно считать заложенным.

* **[Оглавление](/guides/1.2/ru/)**
* &#8592; [Установка и использование генераторов](/guides/1.2/ru/rails/init.html)
* &#8594; [Ресурсы: Основные возможности](/guides/1.2/ru/rails/resources/main.html)