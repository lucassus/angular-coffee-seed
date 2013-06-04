* AngularJS
* RequireJS
* Jasmine
* karma
* grunt

## Bootstrap

install nodejs from the sources

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

Task `grunt watch` has to be executed since it's recompiling all coffeescripts.

## Roadmap

* figure out how to debug jasmine tests
* run jasmine specs in the browser
* setup e2e via karma
* run e2e tests in the browser
* grunt-coffeelint
* build production release
* compile angular html templates
