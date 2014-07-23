class EsyUi

  constructor: () ->
    @sizes        = {}
    @window       = null
    @currentPanel = null
    @panels       = []
    @rows         = []
    @buttons      = []
    @textbox      = []

  set: () ->
    window = new EsyUiWindow

    return window

  show: () ->
    # if esy.container not instanceof Panel then @window.show()
    return this

class EsyUiWindow

  constructor: () ->
    @sizes =
      paddingLeft      : 10
      paddingTop       : 10
      width            : 300
      heightIncrement  : 0
    @element = null
    @render()
    return this

  render: () ->
    if esy.container instanceof Panel then @element = esy.container else @element = new Window "window {orientation: 'row'}"

  addPanel: (data) ->
    new EsyUiPanel @, data

class EsyUiPanel

  constructor: (window, data) ->
    @window  = window
    @element = null
    @data    = data
    @yOffset = 0
    @render()
    return this

  render: () ->
    values = [
      @window.sizes.paddingLeft,
      @window.sizes.heightIncrement,
      @window.sizes.width,
      60
    ]

    @element = @window.element.add 'panel', values, @data.label
    return @

  addRow: (data) ->
    new EsyUIWindowRow @, data


class EsyUIWindowRow

  constructor: (panel, data) ->
    @panel = panel
    @data = data
    @render()
    return @panel

  render: () ->
    currentPanel = @panel.element
    height       = 30
    width        = 100
    paddingLeft  = 10
    paddingTop   = 10
    xOffset      = currentPanel.margins[0]
    yOffset      = currentPanel.margins[1] + @panel.yOffset

    esy.log "yOffset = #{yOffset}"

    for elements in @data
      esy.log "currentPanel.margins[0] = #{currentPanel.margins[0]}"
      for elementType, element of elements
        element.height ?= height
        element.width ?= width
        values = [
          paddingLeft + xOffset,
          paddingTop + yOffset,
          currentPanel.size[0] * element.width / 100 + xOffset - currentPanel.margins[0],
          paddingTop + element.height + yOffset
        ]


        xOffset = currentPanel.size[0] * (element.width / 100) + xOffset
        @panel.yOffset += paddingTop + currentPanel.margins[1] + element.height

        switch elementType
          when "button"
            @addButton element.label, values

    currentPanel.size[1] += element.height

    return this

  addButton: (label, values) ->
    @panel.window.element.add 'button', values, label
    return this

  getButton: (label) ->
    return @buttons[label]

  addTextbox: (label, values) ->
    return @window.add 'editText', values, label
