# TODO write specs for BaseCtrl

class @BaseCtrl

  @register: (app, name) ->
    name ?= @name || @toString().match(/function\s*(.*?)\(/)?[1]
    app.controller name, this

  @inject: (annotations...) ->
    @annotations = annotations
    @$inject = []

    for annotation in annotations
      if typeof annotation is "object"
        annotation = Object.keys(annotation)[0]

      @$inject.push(annotation)

  constructor: (services...) ->

    for annotation, index in @constructor.annotations
      name = if typeof annotation is "object" \
        then annotation[Object.keys(annotation)[0]] \
        else annotation

      this[name] = services[index]

    @initialize?()
