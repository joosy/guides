---
layout: guide
title: "Установка и использование генераторов"
version: 1.2
language: ru
---

{% sidenote info%}
  Пожалуйста, убедитесь, что спользуете версию Rails >= 4.0.0
{% endsidenote %}

## Зависимости и настройки
Нам понадобится один свежий Rails проект - создайте его коммандой

{% highlight bash linenos %}
  rails new blog
{% endhighlight %}

Joosy использует отдельный layout так, что удалять Turbolinks не обязательно, а вот добавить [Twitter Bootstrap](http://getbootstrap.com) не помешает. Он значительно облегчит оформление внешнего вида нашего проекта.

Отредактируйте `Gemfile` и подключите  необходимые гемы:

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
   
  gem "joosy-rails", "1.0.0.RC2"      # <- сам Joosy
  gem 'bootstrap-sass'                # <- CSS для Twitter Bootstrap
  gem 'font-awesome-sass-rails'       # <- Иконочный шрифт Font Awesome
{% endhighlight %}

Справившись с этой задачей можно смело его задействовать: переименуйте `app/assets/stylesheets/application.css` в `application.css.scss` и добавьте следующие строки:

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

## Создание Joosy приложения

Каждый Rails  проект может содержать внутри себя несколько Joosy приложений. Например, раздельные пользовательский интерфейс и административную панель.

В нашем случае мы будем использовать одно глобальное приложение:

{% highlight bash linenos %}
  rails g joosy:application
{% endhighlight %}

Таким образом генерируется каркас приложения, который в соответствии с Assets Pipeline располагается в директории `app/assets/javascripts`.

{% quotebox %}
  exist  app/assets/javascripts
  create  app/assets/javascripts/application.coffee
  create  app/assets/javascripts/helpers/application.coffee
  create  app/assets/javascripts/layouts/application.coffee
  create  app/assets/javascripts/pages/application.coffee
  create  app/assets/javascripts/pages/welcome/index.coffee
  create  app/assets/javascripts/routes.coffee
  create  app/assets/javascripts/templates/layouts/application.jst.hamlc
  create  app/assets/javascripts/templates/pages/welcome/index.jst.hamlc
  create  app/assets/javascripts/application.js-old
  remove  app/assets/javascripts/application.js
  create  app/views/layouts/joosy.html.erb
   route  joosy '/'
{% endquotebox %}

Отдельно обратите внимание на две последних строчки приведенного ниже списка. Запуск браузерной части происходит из сгенерированного Layout'а и если вы хотите повлиять на то как Joosy запускается &mdash; вам именно сюда. При этом сам Layout загружается с помощью специального хелпера по указанному маршруту.

Вместе с разметкой приложение содержит стартовую страницу в HAML-формате. В дальнейшем мы рассмотрим как заменить его на другой формат ECO или JADE, но поскольку HAML наш любимый формат мы рекомендуем использовать именно его, так, как он великолепен. Серьезно! ;)

Тем временем наступил черед демо - смело запускайте `rails s` и открывайте [http://localhost:3000](http://localhost:3000), где Вас встретит начальная страница Joosy-приложения:

![Начальная страница Joosy-приложения](http://i.imgur.com/2XMSWbo.png)

## Генераторы

Если вы все-таки хотите изолировать ваше Joosy-приложение от другого JS-кода, попробуйте запустить генератор с указанием имени приложения:

{% highlight bash linenos %}
  rails g joosy:application front
{% endhighlight %}

Такой запуск позволит разместить новое приложение в папке `app/assets/javascripts/front` и заранее подготовить его к работе из поддиректории. Обратите внимание, что недостаточно просто перенести проект из одной папки в другую, необходимо также указать путь в [конфигурационной опции `prefix`](/guides/1.2/ru/other/config.html).

В Joosy есть несколько основных компонентов, – ресурсы, страницы, Layout'ы и виджеты. Для каждой из этих сущностей есть генератор:

{% highlight bash linenos %}
  rails g joosy:page page_name [application]
  rails g joosy:layout layout_name [application]
  rails g joosy:widget widget_name [application]
  rails g joosy:resource resource_name [application]
{% endhighlight %}

Второй необязательный параметр содержит имя приложения, если вы его используете. Например в вышеизложенном случае это был бы `front`. Обратите внимание, что имена компонентов могут содержать путь и Joosy автоматически разместит их в указанной поддиректории, а также укажет вашим классам правильный Namespace.

* **[Оглавление](/guides/1.2/ru/)**
* &#8594; [Ресурсы: Подготовка Backend](/guides/1.2/ru/rails/resources/preparations.html)