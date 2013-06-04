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

## Roadmap

* karma unit singRun/autoWatch option
* setup e2e via karma
* run jasmine specs in the browser
* run e2e tests in the browser
* build production release
* compile angular html templates
