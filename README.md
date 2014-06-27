# SimpleBlog

Is a blogging engine that you can plug into your rails app. It's not a mountable engine (so it's not namespaced), it's designed to be pluggable into your app and not mounted as a sepparate one.

## Getting started

It's worth mentioning that the default views provide a basic structure and style which you should override. You can also use the default views and just add some styling of your own (by overriding the default styling).

SimpleBlog works with Rails 4.0 onwards. You can add it to your Gemfile with:

```ruby
gem 'simple_blog', :git => 'git@github.com:mixandgo/simple_blog.git'
```

#### Post installation

Install migrations

```shell
#For simple blog migrations
rake simple_blog_engine:install:migrations

#For simple blog tags migrations
rake acts_as_taggable_on_engine:install:migrations
```

Install assets

```shell
rails generate simple_blog:install
```

##Usage

```ruby
#in layouts/application.html.erb
<%= yield(:seo_meta) %>
```

# License

### This code is free to use under the terms of the MIT license.

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
