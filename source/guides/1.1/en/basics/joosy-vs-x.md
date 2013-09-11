---
layout: guide
title: "Joosy vs X"
version: 1.1
language: en
---

### How is Joosy different from X

Joosy was created to be the foundation of the large browser applications. Since large applications are always tightly bound to the server implementation, Joosy is not trying to achieve abstraction and independency. It uses Rails as the Application Server and lives among Views terms.

Talking about an MVC paradigm, Joosy is a View part while Controllers and Models are still in Rails. The great description of Joosy paradigm can be met at [Getting Started](/guides/1.1/en/basics/getting-started.html) guide. Please read it before passing on to direct comparison parts so you are sure to understand it correctly.

The another thing we inherit from Rails is a passion to have a nice set of ready conventions to solve common problems you meet from day to day. Real-life orientation is a great Joosy feature. Most of conventions are shamelessly copied from Rails to ease adaptation and cooperation.

### Highlights comparison

&#x20;<table class="comparison">
  <tr>
    <th style="width: 1%"></th>
    <th class="title"><a href="http://documentcloud.github.com/backbone/">Backbone</a></th>
    <th class="title"><a href="http://emberjs.com/">Ember.js</a></th>
    <th class="title">Joosy</th>
  </tr>
  <tr>
    <th>Backend-independent</th>
    <td class="y">✔</td>
    <td class="y">✔</td>
    <td class="n">✖</td>
  </tr>
    <tr>
    <th>JS-compatible</th>
    <td class="y">✔</td>
    <td class="y">✔</td>
    <td class="m">~</td>
  </tr>
    <tr>
    <th>Routing</th>
    <td class="y">✔</td>
    <td class="y">✔</td>
    <td class="y">✔</td>
  </tr>  
  <tr>
    <th>ActiveSupport analog</th>
    <td class="m">~</td>
    <td class="m">~</td>
    <td class="y">✔</td>
  </tr>
  <tr>
    <th>Preloaders</th>
    <td class="n">✖</td>
    <td class="n">✖</td>
    <td class="y">✔</td>
  </tr>
  <tr>
    <th>Different template engines</th>
    <td class="y">✔</td>
    <td class="n">✖</td>
    <td class="y">✔</td>
  </tr>
  <tr>
    <th>HAML support</th>
    <td class="n">✖</td>
    <td class="n">✖</td>
    <td class="y">✔</td>
  </tr>
  <tr>
    <th>Dynamic rendering</th>
    <td class="n">✖</td>
    <td class="y">✔</td>
    <td class="y">✔</td>
  </tr>
  <tr>
    <th>Helpers</th>
    <td class="n">✖</td>
    <td class="n">✖</td>
    <td class="y">✔</td>
  </tr>
  <tr>
    <th>Identity map</th>
    <td class="n">✖</td>
    <td class="n">✖</td>
    <td class="y">✔</td>
  </tr>
  <tr>
    <th>Forms</th>
    <td class="n">✖</td>
    <td class="m">~</td>
    <td class="y">✔</td>
  </tr>
  <tr>
    <th>Code generators</th>
    <td class="n">✖</td>
    <td class="m">~</td>
    <td class="y">✔</td>
  </tr>
  <tr>
    <th>Size</th>
    <td>
      Raw: <b>5.6 Kb</b>
      <br />
      Bundled: <b>42 Kb</b>
    </td>
    <td>
      Raw: <b>42 Kb</b>
      <br />
      Bundled: <b>80 Kb</b>
    </td>
    <td>
      Raw: <b>12 Kb</b>
      <br />
      Bundled: <b>87 Kb</b>
    </td>
  </tr>
</table><br /><br />

Bundled size is the size of the framework and related assets and
libraries:

* **Backbone**: jQuery, Underscore
* **Ember.js**: jQuery
* **Joosy**: jQuery, Sugar.js
