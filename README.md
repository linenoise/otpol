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


Testing
-------

Running your RSpec tests:

	bin/rspec

Running your Cucumber tests:

	bin/cucumber


Support
-------

Danne Stayskal <danne@stayskal.com>


Contributions
-------------

1. Fork it
2. Branch it
3. Update it
4. Push it
5. Send a pull request
