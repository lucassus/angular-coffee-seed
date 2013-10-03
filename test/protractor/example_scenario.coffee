util = require("util")

describe "angularjs homepage", ->
  ptor = null

  beforeEach ->
    ptor = protractor.getInstance()
    ptor.get "http://www.angularjs.org"

  it "should greet using binding", ->
    ptor.findElement(protractor.By.input("yourName")).sendKeys "Julie"
    greeting = ptor.findElement(protractor.By.binding("{{yourName}}!"))
    expect(greeting.getText()).toEqual "Hello Julie!"

  it "should list todos", ->
    todo = ptor.findElement(protractor.By.repeater("todo in todos").row(2))
    expect(todo.getText()).toEqual "build an angular app"
