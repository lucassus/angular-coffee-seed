CustomCasper = require("./test/casperjs/helpers/custom_casper").CustomCasper
casper = new CustomCasper()

casper.start "http://localhost:9001", ->
  @clickLabel "Todos", "a"

  # Define custom assertion
  @test.assertTodoCount = (n) =>
    @test.assertEquals @currentPage().getTodosCount(), n, "Page displays #{n} todos"

casper.then ->
  @test.assertEquals @currentPage().pageTitleText(), "Todo List"

casper.then ->
  @test.assertEquals @currentPage().remainingText(), "2 of 3 remaining"
  @test.assertTodoCount 3

casper.then ->
  @currentPage().form.fillWith name: "New Todo"
  @currentPage().form.clickAddButton()

casper.then ->
  @test.assertEquals @currentPage().remainingText(), "3 of 4 remaining"
  @test.assertTodoCount 4

casper.then ->
  @currentPage().form.fillWith name: "Another Todo"
  @currentPage().form.checkDone()
  @currentPage().form.clickAddButton()

casper.then ->
  @test.assertEquals @currentPage().remainingText(), "3 of 5 remaining"
  @test.assertTodoCount 5

casper.then ->
  @currentPage().clickArchive()
  @test.assertEquals @currentPage().remainingText(), "3 of 3 remaining"
  @test.assertTodoCount 3

casper.then ->
  @currentPage().clickNthTodo(1)
  @test.assertEquals @currentPage().remainingText(), "2 of 3 remaining"
  @test.assertTodoCount 3

casper.then ->
  @currentPage().clickNthTodo(3)
  @test.assertEquals @currentPage().remainingText(), "3 of 3 remaining"
  @test.assertTodoCount 3

casper.run ->
  @test.renderResults(true)
