scenario = require("./test/casperjs/helpers/scenario").create()

# Page Objects
TaskList = require("./test/casperjs/helpers/page_objects/task_list").TaskList

scenario "Task List page", ->
  page = new TaskList(this)
  form = page.getForm()

  @feature "Navigate to the Task List page", ->
    @clickLabel "Tasks", "a"
    @test.assertTitle "Angular Seed"

    # Define custom assertion
    @test.assertTasksCount = (number) =>
      @test.assertEquals page.getTasksCount(), number,
        "Page displays #{number} tasks"

  @feature "Show the valid page title", ->
    @test.assertEquals page.pageTitleText(), "Tasks List"

  @feature "Show all tasks", ->
    @test.assertEquals page.remainingText(), "2 of 3 remaining"
    @test.assertTasksCount 3

    firstTask = page.findTaskByName("First task")
    @test.assertEquals "First task", firstTask.getName()
    @test.assertFalsy firstTask.isCompleted()

    completedTask = page.findTaskByName("Completed task")
    @test.assertEquals "Completed task", completedTask.getName()
    @test.assertTruthy completedTask.isCompleted()

  @feature "Create a new task", ->
    form.fillWith name: "New task"

    formValues = form.getValues()
    @test.assertEqual "New task", formValues.name
    @test.assertFalse formValues.done

    form.clickAddButton()

    @test.assertEquals page.remainingText(), "3 of 4 remaining"
    @test.assertTasksCount 4

    newTask = page.findTaskByName("New task")
    @test.assertFalsy newTask.isCompleted()

  @feature "Create a new completed task", ->
    form.fillWith name: "Another task"
    form.checkDone()

    formValues = form.getValues()
    @test.assertEqual "Another task", formValues.name
    @test.assertTruthy formValues.done

    form.clickAddButton()

    @test.assertEquals page.remainingText(), "3 of 5 remaining"
    @test.assertTasksCount 5

    newTask = page.findTaskByName("Another task")
    @test.assertTruthy newTask.isCompleted()

  @feature "Complete a taks", ->
    task = page.findTaskByName("First task")
    @test.assertFalsy task.isCompleted()
    task.complete()

    @test.assertEquals page.remainingText(), "2 of 5 remaining"
    @test.assertTasksCount 5

  @feature "Incomplete other task", ->
    task = page.findTaskByName("Completed task")
    @test.assertTruthy task.isCompleted()
    task.incomplete()

    @test.assertEquals page.remainingText(), "3 of 5 remaining"
    @test.assertTasksCount 5

  @feature "Archive all completed tasks", ->
    page.clickArchiveButton()
    @test.assertEquals page.remainingText(), "3 of 3 remaining"
    # @test.assertTasksCount 3 TODO something is wrong with ng-animations
