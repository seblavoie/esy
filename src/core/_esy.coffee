class Esy

  initialize: () ->

    @ui    = new Esy.ui
    @http  = new Esy.http
    @file  = new EsyFile
    @color = new Esy.color

    @selfBuild()

  selfBuild: () ->
    destination = ((new File($.fileName)).parent.parent).path
    file = @file.exists "#{destination}/esy.js"
    file = esy.file.buildExtendScript "~/Dropbox/_Personnal/code/scripts/toggler/components/esy/lib/esy.js", "#{destination}/esy.js"

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

