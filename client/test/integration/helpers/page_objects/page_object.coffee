# Base class for all page objects
class PageObject

  # Alias for a collection of element locators
  By: protractor.By

  # Locates the first element containing `label` text
  byLabel: (label, tag = "a") ->
    @By.xpath ".//#{tag}[contains(text(), '#{label}')]"

  # Waits until all animations stop
  waitForAnimations: ->
    browser.wait =>
      animated = browser.findElements @By.css(".ng-animate")
      animated.then (animated) -> animated.length is 0

  # Define element on the page
  @has: (name, getter) ->
    Object.defineProperty @::, name, get: getter

module.exports = PageObject
