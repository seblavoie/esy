class Esy

  initialize: () ->

    @ui    = new EsyUi
    @http  = new EsyHttp
    @file  = new EsyFile
    @color = new EsyColor

    @selfBuild (new File($.fileName)).parent.parent.path if esy.debug
    # else
      # Will have to fetch the latest version from github


  selfBuild: (path) ->
    esy.file.buildExtendScript "#{path}/lib/esy.js", ["#{path}/esy.jsx", "#{Folder.appPackage.path}/Scripts/Startup/esy.jsx"]

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

