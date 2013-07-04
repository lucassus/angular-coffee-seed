scenario = require("./test/casperjs/helpers/scenario").create()

# Page Objects
TodoList = require("./test/casperjs/helpers/page_objects/todo_list").TodoList

scenario "Todo List page", ->
  page = new TodoList(this)
  form = page.getForm()

  @feature "Navigate to the Todo List page", ->
    @clickLabel "Todos", "a"
    @test.assertTitle "Angular seed"

    # Define custom assertion
    @test.assertTodoCount = (number) =>
      @test.assertEquals page.getTodosCount(), number,
        "Page displays #{number} todos"

  @feature "Show the valid page title", ->
    @test.assertEquals page.pageTitleText(), "Todo List"

  @feature "Show all todos", ->
    @test.assertEquals page.remainingText(), "2 of 3 remaining"
    @test.assertTodoCount 3

  @feature "Create a new task", ->
    form.fillWith name: "New Todo"

    formValues = form.getValues()
    @test.assertEqual "New Todo", formValues.name
    @test.assertFalse formValues.done

    form.clickAddButton()

    @test.assertEquals page.remainingText(), "3 of 4 remaining"
    @test.assertTodoCount 4

  @feature "Create a new completed task", ->
    form.fillWith name: "Another Todo"
    form.checkDone()

    formValues = form.getValues()
    @test.assertEqual "Another Todo", formValues.name
    @test.assertTrue formValues.done

    form.clickAddButton()
    @capture "test.png"

    @test.assertEquals page.remainingText(), "3 of 5 remaining"
    @test.assertTodoCount 5

  @feature "Archive all completed tasks", ->
    page.clickArchiveButton()
    @test.assertEquals page.remainingText(), "3 of 3 remaining"
    @test.assertTodoCount 3

  @feature "Complete a taks", ->
    page.clickNthTodo(1)
    @test.assertEquals page.remainingText(), "2 of 3 remaining"
    @test.assertTodoCount 3

  @feature "Uncomplete other task", ->
    page.clickNthTodo(3)
    @test.assertEquals page.remainingText(), "3 of 3 remaining"
    @test.assertTodoCount 3
