module.exports = (protractor) ->
  ptor = protractor.getInstance()

  Object.create Object::,

    greeting: get: ->
      ptor.findElement protractor.By.binding("You have {{index.products.length}} products")

    productNames: get: ->
      ptor.findElements protractor.By.repeater("product in index.products").column("product.name")

    nthProduct: value: (index) ->
      locator = protractor.By.repeater("product in index.products").row(index)

      byBinding = (binding) =>
        ptor.findElement locator.column(binding)

      Object.create Object::,

        # row values
        id:          get: -> byBinding("product.id")
        name:        get: -> byBinding("product.name")
        description: get: -> byBinding("product.description")

        # action buttons
        actionButton: get: ->
          ptor.findElement(locator).findElement protractor.By.xpath("//button[contains(text(), 'Action')]")

        showButton: get: ->
          @actionButton.click()
          ptor.findElement(locator).findElement protractor.By.xpath("//a[contains(text(), 'Show')]")

        editButton: get: ->
          @actionButton.click()
          ptor.findElement(locator).findElement protractor.By.xpath("//a[contains(text(), 'Edit')]")

        deleteButton: get: ->
          @actionButton.click()
          ptor.findElement(locator).findElement protractor.By.xpath("//a[contains(text(), 'Delete')]")

    createButton: get: ->
      ptor.findElement protractor.By.xpath("//a[contains(text(), 'Create new product')]")
