class PageObject

  # Define element on the page
  @has: (name, getter) ->
    Object.defineProperty @::, name, get: getter

module.exports = PageObject
