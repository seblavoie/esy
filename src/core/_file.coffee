class EsyFile

  constructor: () ->
    return @

  delete: (filepath) ->
    file = File filepath
    file.remove()

  append: (filepath, content) ->
    file = File filepath
    file.open "a"
    file.write content
    file.close()
    return file

  buildExtendScript: (filepath, destination) ->
    content = @read filepath
    read    = (str, p1) => @read "#{@path filepath}/#{p1}"
    content = content.replace /#include \"(.*)\";/g, read
    @create "#{destination}x", content

  create: (filepath, content = "") ->
    file = File filepath
    file.open "w"
    file.write content
    file.close()
    return file

  exists: (filepath) ->
    file = File filepath
    if file.created
      return file
    else
      return false

  read: (filepath) ->
    file = File filepath
    file.open "r"
    content = file.read()
    file.close()
    return content

  filename: (filepath) ->
    filename = filepath.substr filepath.lastIndexOf('/') + 1
    return filename

  path: (filepath) ->
    filename = filepath.substr 0, filepath.lastIndexOf('/')
    return filename