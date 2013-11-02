require("jasmine-only")
utils = require("./helpers/utils")

TasksPage = require("./helpers/page_objects/tasks_page")

describe "Tasks page", ->
  tasksPage = null

  beforeEach ->
    browser.get "/#/tasks"

    tasksPage = new TasksPage()

  it "displays a valid page title", ->
    expect(browser.getCurrentUrl()).toEqual "http://localhost:9001/#/tasks"
    expect(browser.getTitle()).toEqual "Angular Seed"

  describe "tasks list", ->

    it "displays all tasks", ->
      expect(tasksPage.tasksCount()).toEqual 3
      expect(tasksPage.remaining.getText()).toEqual "2 of 3 remaining"

      task = tasksPage.taskAt(0)
      expect(task.isCompleted()).toBeFalsy()

      completedTask = tasksPage.taskAt(2)
      expect(completedTask.isCompleted()).toBeTruthy()

  describe "click on `archive` button", ->
    beforeEach ->
      tasksPage.archiveButton.click()

    it "archives all completed tasks", ->
      expect(tasksPage.tasksCount()).toEqual 2
      expect(tasksPage.remaining.getText()).toEqual "2 of 2 remaining"

  describe "click on task's checkbox", ->
    task = null

    describe "when a task is not completed", ->
      beforeEach ->
        task = tasksPage.taskAt(1)
        task.checkbox.click()

      it "marks the task as completed", ->
        expect(task.isCompleted()).toBeTruthy()
        expect(tasksPage.remaining.getText()).toEqual "1 of 3 remaining"

    describe "when a task is completed", ->
      beforeEach ->
        task = tasksPage.taskAt(2)
        task.checkbox.click()

      it "marks the task as not completed", ->
        expect(task.isCompleted()).toBeFalsy()
        expect(tasksPage.remaining.getText()).toEqual "3 of 3 remaining"

  describe "new task form", ->
    form = null
    beforeEach -> form = tasksPage.form

    describe "fill in the name and click `create` button", ->

      it "creates a new task", ->
        form.setName "New task"
        form.submitButton.click()

        expect(tasksPage.tasksCount()).toEqual 4
        expect(tasksPage.remaining.getText()).toEqual "3 of 4 remaining"

        task = tasksPage.taskAt(2)
        expect(task.isCompleted()).toBeFalsy()
        expect(task.label.getText()).toEqual "New task"
