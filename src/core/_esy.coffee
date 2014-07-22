class Esy

  initialize: () ->

    @ui    = new Esy.ui
    @http  = new Esy.http
    @file  = new EsyFile
    @color = new Esy.color

    @selfBuild()

  selfBuild: () ->
    source = (new File($.fileName)).parent
    destination = (source.parent).path
    if esy.debug
      file = esy.file.buildExtendScript "#{source.path}/esy.js", "#{destination}/esy.js"
    else
      # Will have to fetch the latest version from github

  listProperties: (obj) ->
    @log "Esy.listProperties:"
    for property in [1..obj.numProperties]
      @log property

  log: (str) ->
    try $.write "#{str?.toString()}\n"

  dump: (obj) ->
    if obj
      @log "Esy.dump:"
      for propertyName, propertyValue of obj
        @log "#{propertyName}: #{propertyValue?.toString()} \n"

  extend: (sourceObject, defaultObject) ->
    for propertyName, propertyValue of defaultObject
      if not sourceObject[propertyName]
        sourceObject[propertyName] = propertyValue
    return sourceObject

