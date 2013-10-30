class PageObject

  # Locates the first element containing `label` text
  byLabel: (label, tag = "a") ->
    protractor.By.xpath(".//#{tag}[contains(text(), '#{label}')]")

  # Define element on the page
  @has: (name, getter) ->
    Object.defineProperty @::, name, get: getter

module.exports = PageObject
