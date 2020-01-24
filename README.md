# README

This is a Rails app 5.0.2 using Ruby 2.3.5

### Dependencies
* Ruby 2.3.5
* Ruby on Rails 5.0.2
* Bundler 1.17.3
* Ruby Version Manager (RVM)
* PostgreSQL
* Heroku CLI

#Configuration

### Database creation
Default settings for development in `database.yml`:
```
default: &default
    adapter: postgresql
    encoding: unicode
    timeout: 5000
    pool: 2

development:
    <<: *default
    database: certifiedpeng_dev
    username: ***
    password: ***

test:
    <<: *default
```

Then run `rake db:create`

### Migrations 
Active Record tracks which migrations have already been run so 
all you have to do is update your source and run `rake db:migrate`. 

Active Record will work out which migrations should be run. 
It will also update your `db/schema.rb` file to match the structure of your database.


### Gemset
RVM is a command-line tool which allows you to easily install, manage, 
and work with multiple ruby environments from interpreters to sets of gems.

Gemsets must be created before being used. To create a new gemset for Ruby, do this:

`rvm use 2.3.5@cert --create`

And then `bundle install` for install the gems specified in your Gemfile.

#### Bundler
If this is the first time you run `bundle install` (and a *Gemfile.lock* does not exist), 
Bundler will fetch all remote sources, resolve dependencies and install all needed gems.

If a *Gemfile.lock* does exist, and you have not updated your *Gemfile*, Bundler will 
fetch all remote sources, but use the dependencies specified in the *Gemfile.lock* instead 
of resolving dependencies.

If a *Gemfile.lock* does exist, and you have updated your *Gemfile*, Bundler will use 
the dependencies in the *Gemfile.lock* for all gems that you did not update, but will 
re-resolve the dependencies of gems that you did update.

### Stripe
The payments are done with Stripe as Payment Gateway.

Overall, when a customer want to sign up for the service, first they have to be created in Stripe where after the credit card
is transformed into a token. This token is then used to create a subscription.

The configuration file for Stripe is here: `config/initializers/stripe.rb`

# Up and running

### Development

1. Pull repository from Github
1. Run `rvm use 2.3.5@cert`
1. Run `bundle install`
1. Create the database: `rails db:create`
1. Migrate the database: `rails db:migrate`
1. Seed the database: `rails db:seed`
1. Start the server: `rails server`


### Production
Deployed to Heroku

1. Install Heroku CLI `brew tap heroku/brew && brew install heroku`
1. Login to Heroku `heroku login`
1. Go to the project folder and run `heroku git:remote -a certifiedpeng`
1. Push branch `git push heroku <branch_name>:master`


# Testing Stripe

Get test payment cards at: https://stripe.com/docs/testing#cards

A successful card is: 4242424242424242

A declined card is: 4000000000000002

Just put in any date larger than today and random CVC e.g. 09/19 123.

