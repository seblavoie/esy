class Esy.ui

  constructor: () ->
    @sizes = {}
    @window = null
    @currentPanel = null
    @panels = []
    @rows = []
    @buttons = []
    @textbox = []
    @xOffset = 0
    @yOffset = 0

  set: (width = 300, paddingLeft = 10, paddingTop = 10) ->
    @sizes.paddingLeft      = paddingLeft
    @sizes.paddingTop       = paddingTop
    @sizes.width            = width
    @sizes.heightIncrement  = 0

    if esy.container instanceof Panel then @window = esy.container
    else @window = new Window "window {orientation: 'column'}"
    return this

  show: () ->
    if esy.container not instanceof Panel then @window.show()
    return this

  addRow: (data) ->
    height = 0
    width  = 0

    for elements in data

      for elementType, element of elements
        values = @returnGoodUIValues element.height ?= 30, element.width ?= 100

        if height is 0 then height += element.height

        switch elementType
          when "button"
            @addButton element.label, values

    @currentPanel.height += height

    return this



  addPanel: (label) ->
    values = @returnGoodUIValues 60, @sizes.width
    @panels[label] = @currentPanel = @window.add 'panel', values, label
    return this

  getPanel: (label) ->
    return @panels[label]

  addButton: (label, values) ->
    @buttons[label] = @window.add 'button', values, label
    return this

  getButton: (label) ->
    return @buttons[label]

  addTextbox: (label, showLabel = false, height = 30, offsets = [10, 10, -10, 0]) ->
    @textbox[label] = @window.add 'editText', @returnGoodUIValues(height, false, offsets), ""
    return this

  getTextbox: (label) ->
    return @textbox[label]

  returnGoodUIValues: (height, width, adaptSizes = [0,0,0,0]) ->
    sizes = []
    i = 0
    for key, value of @sizes
      sizes[key] = value + adaptSizes[i]
      i++

    # xOffset = 0

    values = [
      sizes.paddingLeft,
      sizes.paddingTop + @sizes.heightIncrement,
      sizes.width / (100 / width),
      sizes.paddingTop + @sizes.heightIncrement + height
    ]

    # @sizes.heightIncrement += sizes.paddingTop
    # @sizes.heightIncrement += height if increment is true

    return values