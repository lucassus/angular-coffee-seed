# Custom AngularJS seed project

* AngularJS
* browserify
* Jasmine
* karma
* grunt
* ..and a lot more

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

open http://localhost:9000

## Running test

By default all tests are executes in PhantomJS browser

`grunt test`

Run test against specific browsers

`grunt test --browsers=Chrome,Firefox,Opera,PhantomJS`

Run karma with `autoWatch` option:

```
# inside the first terminal
grunt server

# inside the second terminal
grunt test:watch --browsers=Chrome,Opera
```

or

```
# inside the first terminal
grunt build watch

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

## Roadmap

* check http://gpiot.com/twitter-bower-grunt-get-started-with-assets-management/
* document the build process
* check http://www.doboism.com/blog/2013/05/17/cross-developing-for-node-js-and-browsers-using-browserify/
* add browserify for jasmine specs
* migrate karma.*.conf.js to coffee
* try https://github.com/thlorenz/browserify-shim
* build production release
* minify production release
* extend readme, see https://github.com/tnajdek/angular-requirejs-seed
