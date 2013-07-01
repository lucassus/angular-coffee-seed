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
  #
  # `@defineElement "complete", "input[type=checkbox]"`
  # If a checkbox is given it will additionally generate the following methods:
  #   @checkComplete()
  #   @unCheckComplete()
  defineElement: (id, selector) ->
    prefix = id
    suffix = id.charAt(0).toUpperCase() + id.slice(1)

    # Retrieve text contents
    fetchText = => @casper.fetchText(selector).trim()
    @["#{prefix}Text"] = fetchText

    # Perform click
    clickElement = => @casper.click(selector)
    @["click#{suffix}"] = clickElement

    # Retrieve the given attribute
    getAttribute = (attribute) => @casper.getElementAttribute(selector, attribute)
    @["#{prefix}Attribute"] = getAttribute

    info = @casper.getElementInfo(selector)

    # Generate methods for the form inputs
    if info.nodeName is "input"
      # Generate methods for the checkbox
      if getAttribute("type") is "checkbox"
        checked = => @casper.evaluate -> $("#{selector}:checked").length > 0

        checkElement = => if not checked() then clickElement()
        @["check#{suffix}"] = checkElement

        unCheckElement = => if checked() then clickElement()
        @["unCheck#{suffix}"] = unCheckElement

