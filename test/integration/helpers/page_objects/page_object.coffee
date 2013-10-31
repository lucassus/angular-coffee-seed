class PageObject

  # an alias for a collection of element locators
  by: protractor.By

  # Locates the first element containing `label` text
  byLabel: (label, tag = "a") ->
    @by.xpath ".//#{tag}[contains(text(), '#{label}')]"

  # Waits until all animations stop
  waitForAnimations: ->
    browser.wait =>
      animated = browser.findElements @by.css(".ng-animate")
      animated.then (animated) -> animated.length is 0

  # Define element on the page
  @has: (name, getter) ->
    Object.defineProperty @::, name, get: getter

module.exports = PageObject
