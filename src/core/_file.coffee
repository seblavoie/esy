class EsyFile

  delete: (filepath) ->
    file = File filepath if File filepath
    file.remove()

  append: (filepath, content) ->
    file = File filepath
    file.open "a"
    file.write content
    file.close()
    return file

  buildExtendScript: (filepath, destinations) ->
    content = @read filepath
    content = content.replace "esy.debug = true", "esy.debug = false"

    read    = (str, p1) => @read "#{@path filepath}/#{p1}"

    content = content.replace /#include \"(.*)\";/g, read

    if typeof destinations is "string" then destinations = [destinations]
    for destination in destinations
      @create "#{destination.toString()}", content

  create: (filepath, content = "", overwrite = true) ->
    @delete filepath if overwrite
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

  folderName: (filepath) ->
    folderName = @filename filepath
    return folderName

  fileName: (filepath) ->
    filename = filepath.substr filepath.lastIndexOf('/') + 1
    return filename

  path: (filepath) ->
    filename = filepath.substr 0, filepath.lastIndexOf('/')
    return filename