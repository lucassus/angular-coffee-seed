# Custom AngularJS seed project

[![Build status](https://secure.travis-ci.org/lucassus/angular-seed.png)](http://travis-ci.org/lucassus/angular-seed)
[![Dependency Status](https://gemnasium.com/lucassus/angular-seed.png)](https://gemnasium.com/lucassus/angular-seed)
[![Stories in Ready](https://badge.waffle.io/lucassus/angular-seed.png?label=ready)](https://waffle.io/lucassus/angular-seed)

This is a custom AngularJS seed project based on grunt the JavaScript task runner.

* AngularJS 1.2.0
* CoffeeScript and Less support
* Bower for front-end packages management
* Full support for unit and end2end tests
* Unit tests with Mocha, Chai and SinonJS
* Generates test code coverage the unit tests
* Support for protractor integration tests
* Support for Karma Test Runner (formerly Testacular)
* Continuous Integration ready ready via `grunt test:ci` task
* Grunt task runner along with several useful plugins
* Production release minification and angular template caching
* ..and a lot more

Demo: http://lucassus-angular-seed.herokuapp.com

## Directory structure

* `./app` - contains CoffeeScript sources, styles, images, fonts and other assets
  * `./app/scripts` - CoffeeScript sources
  * `./app/styles` - stylesheets
  * `./app/views` - html templates used by AngularJS
* `./test` - contains tests for the application
  * `./tests/integration` - protractor integration specs
  * `./test/e2e` - AngularJS end2end scenarios
  * `./tests/unit` - unit tests for AngularJS components

Third-party libraries

* `./bower_components` - components dowloaded by `bower install` command
* `./custom_components` - you could put custom components here
* `./node_modules` - command dowloaded by `npm install` command

Generated stuff

* `./dev` - compiled development release
* `./dist` - created by `grunt build` command, contains the minified production release of the app

## Bootstrap

Install nodejs v0.10.12 from the sources:

```
sudo apt-get install build-essential openssl libssl-dev pkg-config

wget http://nodejs.org/dist/v0.10.12/node-v0.10.12.tar.gz
tar -xzf node-v0.10.12.tar.gz

cd node-v0.10.7
./configure
make
sudo make install
```

## Install grunt, nodemon and bower globally

```
sudo npm install -g grunt-cli
sudo npm install -g nodemon
sudo npm install -g bower
```

### Run the app

```
npm install
bower install
script/start-server
```

Navigate to `http://localhost:9000`

## Running tests

By default all tests are executed in PhantomJS browser

* `grunt test:unit` or `grunt test` - run unit tests
* `grunt test:unit:watch` or
* `grunt test:watch` - run unit tests in watch mode
* `grunt test --coverage-reporter=html` - generate html code coverage report

Run test against specific browsers

`grunt test:unit --browsers=Chrome,Firefox,Opera,PhantomJS`

## Running integration tests

* `script/test-unit` - run unit tests
* `script/test-integration` - run integration specs

### How to develop specs

* install standalone Selenium `./node_modules/protractor/bin/webdriver-manager update`
* start the app in the `test` evn `./script/start-test-server`
* run it with `./node_modules/protractor/bin/protractor test/protractor-conf.coffee`

### WebDriver and PhantomJS

* run PhantomJS with WebDriver support `phantomjs --webdriver=4444`
* setup protractor `browserName: "phantomjs"`
* run specs

## Running tests for the server side application

`mocha --compilers coffee:coffee-script --watch --reporter spec server/test`

### How to debug failing specs

Put `debugger` in the failing spec:

```coffee
describe "Failing spec", ->

  it "should run smoothly", ->
    debugger # this is like setting a breakpoint
    failMiserably()
```

Run karma in Chrome browser:

`grunt test:unit:watch --browsers=Chrome`

* Go to the newly opened Chrome Browser
* Open Chrome's DevTools and refresh the page
* Now in the source tab you should see the execution stopped at the debugger

Run karma directly without CoffeeScript compilation:

`karma start test/karma-conf.coffee --single-run`

or with auto watch option:

`karma start test/karma-conf.coffee`

or

`karma test:unit:watch`

### Running tests headlessly

Start Xvfb and export DISPLAY variable:

```
./script/xvfb start
export DISPLAY=:99
```

Perform single run:

`grunt test --browsers=Firefox,Chrome,Opera,PhantomJS`

or

`grunt test:watch --browsers=Chrome`

## Build process

`script/build` will build the minified production release.

`(cd dist/ ; python -m SimpleHTTPServer 8000)` will serve a static assets from `./dist` directory.

Navigate to `http://localhost:8000` to see the production release.

# Heroku deployment

```
git co heroku-production
git merge master
grunt build
git push heroku heroku-production:master -f
```
