class PageObject

  # Locates the first element containing `label` text
  byLabel: (label, tag = "a") ->
    protractor.By.xpath(".//#{tag}[contains(text(), '#{label}')]")

  # Waits until all animations stop
  waitForAnimations: ->
    browser.wait ->
      animatedElements = browser.findElements protractor.By.css(".ng-animate")
      animatedElements.then (animated) -> animated.length is 0

  # Define element on the page
  @has: (name, getter) ->
    Object.defineProperty @::, name, get: getter

module.exports = PageObject
