# Custom AngularJS seed project

This is a custom AngularJS seed project based on grunt the JavaScript task runner.

* AngularJS 1.0.7
* CoffeeScript and Less support
* Bower for front-end package menagement
* Full support for unit and e2e tests
* Generates code coverage for JavaScripr unit tests
* Support for CasperJS integration tests
* Support for Karma Test Runner (formerly Testacular)
* Continous Integration ready ready via `grunt test:ci` task
* Grunt task runner along with several useful plugins
* Production release minification and angular template caching
* ..and a lot more

[![Build status](https://secure.travis-ci.org/lucassus/angular-seed.png)](http://travis-ci.org/lucassus/angular-seed)
[![Dependency Status](https://gemnasium.com/lucassus/angular-seed.png)](https://gemnasium.com/lucassus/angular-seed)

Demo: http://lucassus-angular-seed.herokuapp.com

## Directory structure

* ./app - contains CoffeeScript sources, styles, images, fonts and other assets
  * ./app/scripts - CoffeeScript sources
  * ./app/styles - stylesheets
  * ./app/views - html views used by AngularJS
* ./test - contains tests for the application
  * ./tests/casperjs - CasperJS integration specs
  * ./tests/unit - unit tests for AngularJS components

Third-party libraries

* ./bower_components - components dowloaded by `bower install` command
* ./custom_components - you could put custom components here
* ./node_modules - command dowloaded by `npm install` command

Generated stuff

* ./dev - compiled development release
* ./dist - created by `grunt build` command, contains the production minified release of the app

## Bootstrap

Install nodejs v0.10.7 from the sources:

```
sudo apt-get install build-essential openssl libssl-dev pkg-config

wget http://nodejs.org/dist/v0.10.7/node-v0.10.7.tar.gz
tar -xzf node-v0.10.7.tar.gz

cd node-v0.10.7
./configure
make
sudo make install
```

Newer versions of nodejs cause problems with karma and PhantomJS
see: https://github.com/karma-runner/karma/issues/558

## Install tools

```
npm install -g grunt-cli
npm install -g bower
```

### Run the app

```
npm install
bower install
grunt server
```

Navigate to http://localhost:9000

## Install PhantomJS ad CasperJS for the integration testing

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

## Running test

By default all tests are executes in PhantomJS browser

`grunt test`

Run test against specific browsers

`grunt test --browsers=Chrome,Firefox,Opera,PhantomJS`

Run karma with `autoWatch` option:

```
# inside the first terminal
grunt server --force

# inside the second terminal
grunt test:watch --browsers=Chrome,Opera
```

or

```
# inside the first terminal
grunt build:dev watch --force

# inside the second terminal
grunt test:watch --browsers=Firefox,PhantomJS
```

Task `grunt watch` has to be executed since it's recompiling all CoffeeScripts.

### How to debug failing specs

Put `debugger` in the failing spec:

```coffee
describe "Failing spec", ->

  it "should run smoothly", ->
    debugger # this is like setting a breakpoint
    failMiserably()
```

Run karma in Chrome browser:

`grunt test:watch --browsers=Chrome`

* Go to the newly opened Chrome Browser
* Open Chrome's DevTools and refresh the page
* Now in the source tab you should see the execution stopped at the debugger

### Running e2e tests

`grunt test:e2e`
`grunt test:casperjs`

### Running tests headlessly

Start Xvfb and export DISPLAY variable:

```
./script/xvfb start
export DISPLAY=:99
```

Perform single run:

grunt test --browsers=Firefox,Chrome,Opera,PhantomJS

or

`grunt test:watch --browsers=Chrome`

### Running jasmine specs inside the browser

`grunt server`

navigate to: http://localhost:9000/jasmine.html

## Build process

```
grunt build
(cd dist/ ; python -m SimpleHTTPServer 8000)
```

And then navigate to `http://localhost:8000` to see the production release.

# Heroku deployment

```
git co heroku-production
git merge master
grunt heroku:production
git push heroku heroku-production:master -f
```
