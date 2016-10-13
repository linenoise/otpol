One Thousand Points of Light
============================

This is the main One Thousand Points of Light ("Otpol") API and web application. It is a public-facing Ruby on Rails app. 


Development
-----------

To setup a development environment on OSX:

    ### Clone the repository
    
    git clone git@github.com:linenoise/otpol
    cd otpol
    
    ### Install Nokogiri, Imagemagick, and gems

    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install imagemagick
    brew tap homebrew/dupes
    brew install libxml2 libxslt
    brew install libiconv
    gem install nokogiri  -v '1.6.1' -- --with-iconv-dir=/usr/local/Cellar/libiconv/1.14/
    bundle install
    
    ### Migrate a database and run the test suite

    rake db:migrate
    rake test
    
    ### Run the dev server
    
    rails server

Now open it in your browser: http://localhost:3000/


API Documentation
-----------------

To generate API documentation under doc/api, run

    bundle exec rake doc:rails


Administration
--------------

The administration area is located at /admin. 

The default email is `admin@example.com` and the default password is `password`.


Command Line Interface
----------------------

    rails console


Code Standards
--------------

... TODO write

Testing
-------

Running your RSpec tests:

	bin/rspec

Running your Cucumber tests:

	bin/cucumber



Deploying
---------

To use the below commands, you will need to have the [Heroku Toolbelt](https://toolbelt.heroku.com/) installed and be familiar with the [Heroku Command Line Interface](https://devcenter.heroku.com/categories/command-line). And if you haven't done so yet, you'll need to push some SSH keys to them with the `heroku login` command once the above tools are installed.


Staging
=======

The staging environment at [http://staging.onethousandpointsoflight.com](https://staging.onethousandpointsoflight.com/) is used to test changes before they're merged into production. It is configured with *sandboxed* payment provider credentials (that is, transactions won't actually go through, but it will act like they always clear) and with *production* email provider credentials (that is, it **wil** actually send email when you ask it to).

To deploy to staging, make sure your code gets into the staging branch on origin:

    ### Push master to staging on origin
    git checkout staging
    git merge master
    git push origin staging

On the near-zero chance Github is down, you can push straight to Heroku as well. First, make sure your checkout of this repositor has the following remote configured in its `.git/config` file:

    [remote "heroku-staging"]
      url = https://git.heroku.com/otpol-staging.git
      fetch = +refs/heads/*:refs/remotes/heroku/*

Next, you'd want to push a branch straight to the heroku-staging remote master:

    git push heroku-staging master

And if you need to migrate the database on staging:

    heroku run rake db:migrate --app otpol-staging


Production
==========

The prodcution deployment procedure is largely the same as the one for staging. The production environment at [https://onethousandpointsoflight.com/](https://onethousandpointsoflight.com) is the main customer-facing application. Nothing gets merged into production without being verified in staging first. It is configured with production credentials across the board--emails will send and credit card payment will actually process.

To deploy to production, make sure your code gets into the production branch on origin, through staging:

    ### Push staging to production on origin
    git checkout production
    git merge staging
    git push origin production

On the near-zero chance Github is down, you can push straight to Heroku as well. First, make sure your checkout of this repositor has the following remote configured in its `.git/config` file:

    [remote "heroku-production"]
      url = https://git.heroku.com/otpol-production.git
      fetch = +refs/heads/*:refs/remotes/heroku/*

Next, you'd want to push a branch straight to the heroku-staging remote master:

    git push heroku-production master

And if you need to migrate the database on production:

    heroku run rake db:migrate --app otpol-production

Scaling
-------

If you need to manually scale the production cluster on Heroku to more dynos:

    heroku ps:scale web=1 --app otpol-production

Note: please don't do this on staging. We only need one dyno there unless we're testing things specific to load-balancing (such as TLS processing).


Scheduling
----------

This is done through the Heroku scheduler:

    heroku addons:open scheduler --app otpol-production

or:

    open https://scheduler.heroku.com/dashboard

To view the logs from the scheduler:

    heroku logs --ps scheduler.1 --app otpol-production

There is no scheduler configured for the staging server.


Debugging
---------

On development, you should see stack traces in the app itself on any errors you're able to recreate. On staging or production, you'll need to use one of the following commands to see error messages:

    heroku logs --app otpol-production
    heroku logs --app otpol-staging

To get console:

    heroku run console --app otpol-production
    heroku run console --app otpol-staging

To connect to the database:

    heroku pg:psql --app otpol-production HEROKU_POSTGRESQL_MAUVE
    heroku pg:psql --app otpol-staging HEROKU_POSTGRESQL_CRIMSON

To clone production or staging databases to development:

    heroku pg:pull HEROKU_POSTGRESQL_MAUVE otpol_development --app otpol-production
    heroku pg:pull HEROKU_POSTGRESQL_CRIMSON otpol_development --app otpol-staging
