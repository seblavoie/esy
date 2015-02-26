class Esy

# ----------------------------------------
# initialize
# ----------------------------------------
  initialize: () ->

    @ui    = new EsyUi
    @http  = new EsyHttp
    @file  = new EsyFile
    @color = new EsyColor

    if esy.debug
      @selfBuild (new File($.fileName)).parent.parent.path
    else
      @updater = new EsyUpdater
        repo: "seblavoie/esy"
        file: "esy.jsx"
        version: "v0.0.2"
        destination: "#{Folder.appPackage.path}/Scripts/startup"
      @updater.checkForUpdate()


# ----------------------------------------
# selfBuild
# ----------------------------------------
  selfBuild: (path) ->
    esy.file.buildExtendScript "#{path}/lib/esy.js", ["#{path}/esy.jsx"]

# ----------------------------------------
# listProperties
# ----------------------------------------
  listProperties: (obj) ->
    @log "Esy.listProperties:"
    for property in [1..obj.numProperties]
      @log property

# ----------------------------------------
# log
# ----------------------------------------
  log: (str) ->
    try $.write "#{str?.toString()}\n"

# ----------------------------------------
# dump
# ----------------------------------------
  dump: (obj, name = null, line = true) ->
    if obj
      name ?= "[#{typeof obj}]"
      @log "\n------------------------" if line
      @log "Dump of #{name}:\n"
      for propertyName, propertyValue of obj
        @log "  #{propertyName}: #{propertyValue?.toString()} \n"
      @log "------------------------" if line

# ----------------------------------------
# extend
# ----------------------------------------
  extend: (sourceObject, defaultObject) ->
    for propertyName, propertyValue of defaultObject
      if not sourceObject[propertyName]
        sourceObject[propertyName] = propertyValue
    return sourceObject


log = (log) -> esy.log log
dump = (obj, line = true) -> esy.dump obj