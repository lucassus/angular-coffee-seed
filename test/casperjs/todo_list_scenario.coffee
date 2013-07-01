scenario = require("./test/casperjs/helpers/scenario").create()

scenario "Todo List page", ->

  @feature "Navigate to the Todo List page", ->
    @clickLabel "Todos", "a"
    @test.assertTitle "Angular seed"

    # Define custom assertion
    @test.assertTodoCount = (number) =>
      @test.assertEquals @currentPage().getTodosCount(), number,
        "Page displays #{number} todos"

  @feature "Show the valid page title", ->
    @test.assertEquals @currentPage().pageTitleText(), "Todo List"

  @feature "Show all todos", ->
    @test.assertEquals @currentPage().remainingText(), "2 of 3 remaining"
    @test.assertTodoCount 3

  @feature "Create a new task", ->
    @currentPage().form.fillWith name: "New Todo"
    @currentPage().form.clickAddButton()

    @test.assertEquals @currentPage().remainingText(), "3 of 4 remaining"
    @test.assertTodoCount 4

  @feature "Create a new completed task", ->
    @currentPage().form.fillWith name: "Another Todo"
    @currentPage().form.checkDone()
    @currentPage().form.clickAddButton()

    @test.assertEquals @currentPage().remainingText(), "3 of 5 remaining"
    @test.assertTodoCount 5

  @feature "Has 'Archive' button", ->
    @test.assertEquals "archive", @currentPage().archiveButtonText()

  @feature "Archive all completed tasks", ->
    @currentPage().clickArchiveButton()
    @test.assertEquals @currentPage().remainingText(), "3 of 3 remaining"
    @test.assertTodoCount 3

  @feature "Complete a taks", ->
    @currentPage().clickNthTodo(1)
    @test.assertEquals @currentPage().remainingText(), "2 of 3 remaining"
    @test.assertTodoCount 3

  @feature "Uncomplete other task", ->
    @currentPage().clickNthTodo(3)
    @test.assertEquals @currentPage().remainingText(), "3 of 3 remaining"
    @test.assertTodoCount 3
