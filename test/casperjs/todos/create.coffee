casper = require("casper").create()

casper.start "http://localhost:9001", ->
  @clickLabel "Todos", "a"

casper.then ->
  @test.assertSelectorHasText "h2", "Todo List"

casper.then ->
  @test.assertEvalEquals (->
    document.querySelectorAll("ul#todos li").length
  ), 3, "Page displays 3 todos"

casper.then ->
  @fill "form[name='new-todo']", name: "New Todo"
  @clickLabel "Add", "button"

casper.then ->
  @test.assertEvalEquals (->
    document.querySelectorAll("ul#todos li").length
  ), 4, "Page displays 4 todos"

casper.run ->
  @test.renderResults(true)
