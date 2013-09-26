# Custom AngularJS seed project

[![Build status](https://secure.travis-ci.org/lucassus/angular-seed.png)](http://travis-ci.org/lucassus/angular-seed)
[![Dependency Status](https://gemnasium.com/lucassus/angular-seed.png)](https://gemnasium.com/lucassus/angular-seed)

This is a custom AngularJS seed project based on grunt the JavaScript task runner.

* AngularJS 1.2.0
* CoffeeScript and Less support
* Bower for front-end packages management
* Full support for unit and end2end tests
* Unit tests with Mocha, Chai and SinonJS
* Generates code coverage for JavaScript unit tests
* Support for AngularJS e2e and CasperJS integration tests
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
  * `./tests/casperjs` - CasperJS integration specs
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
foreman start
```

Navigate to `http://localhost:9000`

## Install PhantomJS and CasperJS for the integration testing

Download and install PhantomJS

```
wget https://phantomjs.googlecode.com/files/phantomjs-1.9.1-linux-x86_64.tar.bz2
tar xvjf phantomjs-1.9.1-linux-x86_64.tar.bz2
cd tar xvjf phantomjs-1.9.1-linux-x86_64
ln -sf `pwd`/bin/phantomjs /usr/local/bin/phantomjs
```

Checkout and install CasperJS

```
git clone git://github.com/n1k0/casperjs.git
cd casperjs
git checkout tags/1.0.2
ln -sf `pwd`/bin/casperjs /usr/local/bin/casperjs
```

## Running tests

By default all tests are executes in PhantomJS browser

`grunt test:unit`

Run test against specific browsers

`grunt test:unit --browsers=Chrome,Firefox,Opera,PhantomJS`

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

`karma start test/karma.conf.coffee --single-run`

or with auto watch option:

`karma start test/karma.conf.coffee`

or

`karma test:unit:watch`

### Running end2end tests

`grunt test:e2e`
`grunt test:casperjs`

### Grunt tasks for running specs

* `grunt test:unit` or `grunt test` - run unit tests
* `grunt test:unit:watch` or
* `grunt test:watch` - run unit tests in watch mode
* `grunt test:coverage` or
* `grunt test:unit:coverage` - run unit tests against compiled development release and generate code coverage report
* `grunt test:unit:coverage --coverage-reporter=html` - generate html code coverage report
* `grunt test:e2e` - build the dev release and run e2e specs
* `grunt test:casperjs` - build the dev release and run casperjs integration specs
* `grunt test:ci` - run all tests on the CI server

* `grunt test --reporters=spec` - run tests with `spec` reporter
* `grunt test --browsers=Chrome,Firefox` - run tests inside Chrome and Firefox

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

`grunt build` will build the minified production release.

`(cd dist/ ; python -m SimpleHTTPServer 8000)` will serve a static assets from `./dist` directory.

Navigate to `http://localhost:8000` to see the production release.

# Heroku deployment

```
git co heroku-production
git merge master
grunt build
git push heroku heroku-production:master -f
```
