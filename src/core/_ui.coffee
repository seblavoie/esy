class EsyUi

  set: () ->
    window = new EsyUiWindow
    return window

  show: () ->
    # if esy.container not instanceof Panel then @window.show()
    return this

class EsyUiWindow

  constructor: () ->
    @element     = null
    @render()
    return this

  render: () ->
    if esy.container instanceof Panel then @element = esy.container else @element = new Window "window {orientation: 'row'}"

  addPanel: (data) ->
    new EsyUiPanel @, data

class EsyUiPanel

  constructor: (window, data) ->
    @window      = window
    @data        = data

    @paddingLeft = 10
    @paddingTop  = 10
    @width       = 300
    @element     = null

    @yOffset     = 0

    @render()
    return this

  render: () ->
    values = [
      @paddingLeft,
      @paddingTop,
      @width,
      60
    ]

    @element = @window.element.add 'panel', values, @data.label
    return @

  addRow: (data) ->
    new EsyUiRow @, data


class EsyUiRow

  constructor: (panel, data) ->
    @panel       = panel
    @data        = data

    @height      = 30
    @width       = 100
    @paddingLeft = 10
    @paddingTop  = @panel.paddingTop + 10
    @xOffset     = @panel.element.margins[0]
    @yOffset     = @panel.element.margins[1] + @panel.yOffset

    @render()


    return @panel

  render: () ->
    for elements in @data
      for elementType, element of elements
        switch elementType
          when "button" then @addButton element
          when "textbox" then @addTextbox element

    @panel.element.size[1] += @height

    return this

  addButton: (element) ->
    new EsyUiButton @, element

  addTextbox: (element) ->
    new EsyUiTextbox @, element

class EsyUiButton

  constructor: (row, data) ->
    @data = data
    @row = row
    @panel = @row.panel
    @render()
    return @

  render: () ->
    @data.height      ?= @row.height
    @data.width       ?= @row.width
    @data.paddingLeft ?= 10
    @data.paddingTop  ?= 0

    values = [
      @data.paddingLeft + @row.xOffset,
      @data.paddingTop + @row.yOffset,
      @panel.element.size[0] * @data.width / 100 + @row.xOffset - @panel.element.margins[0],
      @data.paddingTop + @data.height + @row.yOffset
    ]

    @row.xOffset = @panel.element.size[0] * (@data.width / 100) + @row.xOffset
    @panel.yOffset += @data.paddingTop + @data.height


    @panel.window.element.add 'button', values, @data.label
    return this

class EsyUiTextbox

  constructor: (row, data) ->
    @data = data
    @row = row
    @panel = @row.panel
    @render()
    return @

  render: () ->
    @data.height      ?= @row.height
    @data.width       ?= @row.width
    @data.paddingLeft ?= @row.paddingLeft
    @data.paddingTop  ?= @row.paddingTop

    values = [
      @data.paddingLeft + @row.xOffset,
      @data.paddingTop + @row.yOffset,
      @panel.element.size[0] * @data.width / 100 + @row.xOffset - @panel.element.margins[0],
      @data.paddingTop + @data.height + @row.yOffset
    ]

    @row.xOffset = @panel.element.size[0] * (@data.width / 100) + @row.xOffset
    @panel.yOffset += @data.paddingTop + @panel.element.margins[1] + @data.height


    @panel.window.element.add 'editText', values, @data.label
    return this
