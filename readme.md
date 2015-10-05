# Server API Template

This is our simple template for giving people an easy way to create RESTful JSON APIs
to power their applications.

## Outline

 - [Setup Docker Environment](#setup-docker-environment)
 - [Installation](#installation)
 - [Building APIs](#building-apis)
 - [Quick Reference](#quick-reference)
 - [Deploying to Heroku](#deploying)

## Libraries

This project is using several libraries and frameworks:

 - [Grape](http://rdoc.info/github/intridea/grape) - API endpoints

## Setup Docker Environment

### Preparation

install docker
Dockerfile explanation 

### Pull Docker Environment

checkout project

### Dockerfile

## Installation

### Dependencies

Explanation Ruby, Grape and gem inside gemfile

### Running Docker Container

Once you are setup, be sure to start your Docker Container:

```bash
$ docker
```

### Accessing Docker Container

This starts your API application at <http://localhost:3000> so you
can try it locally. Try going to <http://localhost:3000/api/v1/sessions>.

## Building APIs

### Define User Stories

Always start by defining user stories of what the user can do in your app. For example,
with in our example we create API for to do application, so we assume you can:
 - Register an account
 - Post to do
 - See my to do
 - delete to do
 - etc

### Define Schema

Next, define a schema based on resources.

 - Identify resources in your application (i.e user and to do)
 - Identify attributes of each resource (i.e a to do item has a content, timestamp)
 - Identify the "associations" for each resource (i.e a to do has a user_id)

For example, you will have a `user` resource and a `todos` resource
and a todo "belongs to" a user. A user has an email and a password and a todo
has a body and a timestamp.

### Create Models

Models are the way that a Ruby application stores data for your application resources.
On a high level:

  - explain how to : generate model 
  - Fill out the "db/migrate/xxxxx" file for each model
  - Fill out associations for each model (i.e `belongs_to :user`)
  - Fill out any validations for each model (i.e `validates :body, :presence => true`)

For example, imagine we want to create a "todo" resource that has a status and is created by a user. First,
we would generate the todo resource:

```bash
$ rake
```

Now we can run the migrations with `rake db:migrate` and then check out our
model file at `app/models/todo.rb`. Models are blank by default and often don't need any
additional code. The fields (todo and user_id) will work automatically.

We can now create, update or destroy todo from within our APIs:

```ruby
# create
snippet code
# update
snippet code
# find
snippet code
# delete
snippet code
```

Once we have our models, we can build the related API endpoints so our client mobile applications
can modify the resources.

### Build Grape Resources

In Grape, APIs are defined in terms of "resources" which are different nouns within your application.
An 'endpoint' is a URL that creates, updates, returns or deletes resource data. For example, creating a new
todo, returning a list of todos, deleting a todo, et al. On a high level, APIs are defined through:

  - Editing `app/api/endpoints` for various resource endpoint files
  - Add resource declarations into grape endpoint files
  - Write the endpoint code for each resource API

An API endpoint lives inside of `app/api/endpoints/someresource.rb` where "someresource" is
the noun being affected by the API. For instance, the API endpoint for registering
a new user lives in `app/api/endpoints/users.rb` and is described by the following:

```ruby
resource :users do
  desc "Register a new user"
  params do
    requires :email, type: String, desc: "email for user"
    requires :password, type: String, desc: "password for user"
  end
  post do
    @user = User.new(params.slice(:email, :password))
    if @user.save
      status 201
      @user.as_json
    else # user didn't save
      error!({ :error => "user could not be registered", :details => @user.errors }, 400)
    end
  end
end
```

Notice that there are three main parts: description (`desc`) for describing the purpose, params for specifying
required parameters for the API request and then the API code which starts with an HTTP request method such
as `get`, `post`, `put`, or `delete`.

Be sure to check out the [quick reference](#quick-reference) for better notes on how to
select a request method and/or response status codes.

API endpoints are defined in terms of other resources (todos, tweets, appointments, statuses, etc)
based on the APIs and models in your application.

For example, a todo endpoint for creating (POST) a new todo would live in `app/api/endpoints/todo.rb` and
look like this:

```ruby
resource :todos do
  desc "Create a new todo"
  params do
    requires :item, type: String, desc: "item for todo"
    requires :user_id, type: String, desc: "user for todo"
  end
  post do
    @todo = Todo.new(params.slice(:todo, :user_id))
    if @todo.save
      status 201
      @todo.as_json
    else # user didn't save
      error!({ :error => "todo could not be created", :details => @todo.errors }, 400)
    end
  end
end
```

and a method for getting (GET) all todos for a user might look like:

```ruby
resource :todos do
  desc "Gets a user's todos"
  params do
    requires :user_id, type: String, desc: "user for todo"
  end
  get do
    @todos = Todo.where(:user_id => params[:user_id])
    @todos.as_json
  end
end
```

You simply need to identify the resources for you application, what
actions can be taken on them (create, read, update or delete) and then
implement the endpoints accordingly.

## Other Tasks

Here's a list of a few other todos:

  - In "config/initializers/configure_api.rb" configure the username / password for your authenticated APIs
  - In "app/api/api_router.rb" uncomment lines to create basic authenticated endpoints.
  - In "config/environments/production.rb" fill in the real domain for your application
  - may be we can take a look on airbrake

## Quick Reference

### Key files

Key files to edit:

  - "app/api/endpoints/*" - Adding endpoints and APIs
  - "db/migrate" - Defining the model attributes in the database
  - "app/models" - Defining any additional model information
  - "test/api"   - Defining tests for your APIs (if needed)

### Key URLs

  - "/api/sessions" - Simple endpoint that returns text
  - "/users/sign_in" - Login (or register) a user
  - etc

### Request Methods

As a rule of thumb, the request method to pick is as follows:

|Method|Description|Example|
| ------ | ------ | ----- |
|get|For returning resources from read-only endpoint|Get user todos|
|post|For creating new resources|Create new todo|
|put|For updating an existing resource|Editing a user's password|
|delete|For deleting a resource|Trashing a todo|


### Response Status Codes

Another thing to notice is API response `status` codes, as a rule of thumb:

|Status|Description|Example|
| ------ | ------ | ----- |
|200|Success|Retrieved list of user todos|
|201|Created|Create new todo|
|400|Bad request|Invalid email for registration|
|401|Unauthorized|No permission or not logged in|
|500|Error|Exception happened on server|

## Deploying

The easiest way to deploy your APIs is to use [Heroku](http://heroku.com).

### Register for an account

First, register yourself a (free) Heroku account at <https://api.heroku.com/signup>. This is
your developer account that can contain any number of free applications.

We will use heroku to deploy ourr docker image, 
here are further reads : 

https://devcenter.heroku.com/articles/docker
install heroku toolbelt >> https://toolbelt.heroku.com

### Create app

Run the following command in the terminal to create your app:

```bash
$ gem install heroku
$ heroku login
$ heroku create myappname
$ heroku plugins:install heroku-docker
```

**Note:** Be sure to replace `myappname` with your own application name above.

Be sure to enter your username and password as defined when you created your Heroku account earlier.


### Setup heroku docker env

we can get the setting automatically using this command : 

```bash
$ heroku docker:init
```

but here we will set this manually

### Deploy App

Next it is time to deploy your application:

```bash
$ heroku docker:release
```

You may need to type 'yes' when it asks if you want to continue. At this point you should see
Heroku deploying your application to the internet:

```
Warning: Permanently added the RSA host key for IP address '50.19.85.156' to the list of known hosts.
Counting objects: 206, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (184/184), done.
Writing objects: 100% (206/206), 53.24 KiB, done.
Total 206 (delta 70), reused 0 (delta 0)

-----> Ruby app detected
-----> Installing dependencies using Bundler version 1.3.2
...
```

Wait while this command sets up your application on their servers. Once this is finished, it is time to setup our application on their servers:

### Verify App

Now you can open the url to your app with:

```bash
$ heroku open
```

and now you can visit `/api/...` in your browser to confirm this app is running if you see:

```
"api bla bla bla result"
```

### Wrapping Up ###

At this point you have a deployed API application. If you make changes to your app, simply run:

```bash
$ git add .
$ git commit -am "describe my changes here"
$ docker push ...
```

and the updated code will be pushed to Heroku accordingly.