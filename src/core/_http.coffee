class EsyHttp

# ----------------------------------------
# open
# ----------------------------------------
  open: (url) ->
    unless $.os.indexOf("Windows") is -1
      url = url.replace(/&/g, "^&")
      command = "cmd /c 'explorer #{url}'"
    else
      command = "open '#{url}'"
    system.callSystem command


# ----------------------------------------
# get
# ----------------------------------------
  get: (url) ->
    port = "80"
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


# delay = (time, fn, args...) ->
#   # setTimeout fn, time, args...
#   app.scheduleTask('function(){alert "okay"}()', time, false)



# guid = () ->
#   s4 = () ->
#     Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1)

#   return s4() + s4() + s4() + s4()  + s4()  + s4() + s4() + s4();

# _temp = new Object()

# setTimeout = (func, time) ->
#   guid = guid();
#   _temp["interval_#{guid}"] = func;
#   app.scheduleTask("_temp['interval_#{guid}']();", time, false);
