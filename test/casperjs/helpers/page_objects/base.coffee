exports.Base = class
  constructor: (@casper) ->
    @defineElement "pageTitle", "h2"

  # Dynamically creates various methods for the given elenent.
  #
  # For instance `@defineElement "addButton", "button.btn.add"`
  # will dynamically generate the following methods:
  #   @clickAddButton()             - performs click on the element
  #   @addButtonText()              - retrieves text contents from the element
  #   @addButtonArribute(attribute) - retrieves the value of an attribute on the element
  defineElement: (id, selector) ->
    prefix = id
    suffix = id.charAt(0).toUpperCase() + id.slice(1)

    @["#{prefix}Text"] = ->
      @casper.fetchText(selector).trim()

    @["click#{suffix}"] = ->
      @casper.click(selector)

    @["#{prefix}Attribute"] = (attribute) ->
      @casper.getElementAttribute(selector, attribute)
