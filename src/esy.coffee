class Esy

  constructor: () ->

    @file  = new Esy.file
    @ui    = new Esy.ui
    @http  = new Esy.http
    @color = new Esy.color

  listProperties: (obj) ->
    @log "Esy.listProperties:"
    for property in [1..obj.numProperties]
      @log obj[property]

  log: (str) ->
    try $.write "#{str?.toString()}\n"

  dump: (obj) ->
    if obj
      @log "Esy.dump:"
      for propertyName, propertyValue of obj
        @log "#{propertyName}: #{propertyValue?.toString()} \n"


class Esy.file

  root: (File($.fileName).parent).path

  delete: (filepath) ->
    file = File filepath
    file.remove()

  append: (filepath, content) ->
    file = File filepath
    file.open "a"
    file.write content
    file.close()
    return file

  create: (filepath, content = "") ->
    file = new File filepath
    file.open "w"
    file.write content
    file.close()
    return file

  read: (filepath) ->
    file = File filepath
    file.open "r"
    content = file.read()
    file.close()
    return content

  filename: (filepath) ->
    filename = filepath.substr filepath.lastIndexOf('/') + 1
    return filename

class Esy.ui
  # Todo

class Esy.color

  hexToRgb: (hex) ->
    hex = parseInt(hex,16);
    r = hex >> 16;
    g = (hex & 0x00ff00) >> 8;
    b = hex & 0xff;

    return [r,g,b];

  hexToHsl: (hex) ->
    hex = parseInt(hex,16);
    r = hex >> 16;
    g = (hex & 0x00ff00) >> 8;
    b = hex & 0xff;

    return [r/255,g/255,b/255];

class Esy.http

  open: (url) ->
    unless $.os.indexOf("Windows") is -1
      url = url.replace(/&/g, "^&")
      command = "cmd /c 'explorer #{url}'"
    else
      command = "open '#{url}'"
    system.callSystem command

  get: (url) ->
    httpPrefix = url.match /http:\/\//
    domain = (if not httpPrefix? then url.split("/")[0] + ":" + port else url.split("/")[2] + ":" + port)
    call = "GET " + ((if not httpPrefix? then "http://" + url else url)) + " HTTP/1.0\r\nHost:" + ((if not httpPrefix? then url.split("/")[0] else url.split("/")[2])) + "\r\nConnection: close\r\n\r\n"
    reply = new String()
    conn = new Socket()
    typeMatch = url.match(/(\.)(\w{3,4}\b)/g)
    if conn.open(domain, "binary")
      conn.write call
      reply = conn.read(9999999999)
      conn.close()
    else
      reply = ""

    return reply.substr(reply.indexOf("\r\n\r\n") + 4)

esy = new Esy()
