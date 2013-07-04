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

    firstTodo = page.findTodoByText("First task")
    @test.assertEquals "First task", firstTodo.getName()
    @test.assertFalsy firstTodo.isCompleted()

    completedTodo = page.findTodoByText("Completed task")
    @test.assertEquals "Completed task", completedTodo.getName()
    @test.assertTruthy completedTodo.isCompleted()

  @feature "Create a new task", ->
    form.fillWith name: "New Todo"

    formValues = form.getValues()
    @test.assertEqual "New Todo", formValues.name
    @test.assertFalse formValues.done

    form.clickAddButton()

    @test.assertEquals page.remainingText(), "3 of 4 remaining"
    @test.assertTodoCount 4

    newTodo = page.findTodoByText("New Todo")
    @test.assertFalsy newTodo.isCompleted()

  @feature "Create a new completed task", ->
    form.fillWith name: "Another Todo"
    form.checkDone()

    formValues = form.getValues()
    @test.assertEqual "Another Todo", formValues.name
    @test.assertTruthy formValues.done

    form.clickAddButton()

    @test.assertEquals page.remainingText(), "3 of 5 remaining"
    @test.assertTodoCount 5

    newTodo = page.findTodoByText("Another Todo")
    @test.assertTruthy newTodo.isCompleted()

  @feature "Complete a taks", ->
    todo = page.findTodoByText("First task")
    @test.assertFalsy todo.isCompleted()
    todo.complete()

    @test.assertEquals page.remainingText(), "2 of 5 remaining"
    @test.assertTodoCount 5

  @feature "Incomplete other task", ->
    todo = page.findTodoByText("Completed task")
    @test.assertTruthy todo.isCompleted()
    todo.incomplete()

    @test.assertEquals page.remainingText(), "3 of 5 remaining"
    @test.assertTodoCount 5

  @feature "Archive all completed tasks", ->
    page.clickArchiveButton()
    @test.assertEquals page.remainingText(), "3 of 3 remaining"
    @test.assertTodoCount 3
