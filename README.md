# Artist Directory

This is a simple artist directory app that allows users to see a list of artists and their image gallery. Users can give reviews to artists and derectly contact them through the app. Users can also search for artists by name, location, and category. Admins can add, edit, and delete artists and their images. Admins can also add, edit, and delete category and locations. Autentication is done through Devise gem.

## Requirements

The setups steps expect following tools installed on the system.

* **Rails 7.0.7.2**
* **Ruby 3.2.2**

### Check you ruby version if not same 3.2.2 then install this version using rvm

## Install system dependencies

```bash
bundle install
```

## Initialize the database

```bash
rails db:create db:migrate db:seed
```

## Start the Rails server

You can start the rails server using the command given below.

```bash
rails s
```

And now you can visit the site with the URL http://localhost:3000

## How to run the test suite

Rspect is used for testing. You can run the tests using the command given below.

```bash
bundle exec rspec
```

## Admin login

### Email: admin@user.com
### Password: Admin@123

## Extra gems used

* devise
* rspec-rails
* factory_bot_rails
* faker
* letter_opener
* ransack
* rubocop
* rubocop-rails
* rubocop-performance
