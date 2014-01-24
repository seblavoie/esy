class Esy

  constructor: () ->
    
    @file = new Esy.file
    @ui   = new Esy.ui
    @http = new Esy.http

  listProperties: (obj) ->
    $.write obj.numProperties
    for property in [1..obj.numProperties]
      @write property

  write: (text) ->
    $.write "\n#{text}"

  dump: (obj) ->
    $.write """

    DUMPING
    -------
    """

    for propertyName, propertyValue of obj
      $.write "#{propertyName}: #{propertyValue?.toString()} \n"    


class Esy.file

  remove: (filepath) ->
    file = File filepath
    file.remove()

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
    

class Esy.ui



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

String::capitalize = ->
  @replace /(?:^|\s)\S/g, (a) ->
    a.toUpperCase()

esy = new Esy()
