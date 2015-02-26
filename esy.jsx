// Generated by CoffeeScript 1.7.1#target "aftereffects-13.0";// Generated by CoffeeScript 1.7.1var Esy, dump, log;Esy = (function() {  function Esy() {}  Esy.prototype.initialize = function() {    this.ui = new EsyUi;    this.http = new EsyHttp;    this.file = new EsyFile;    this.color = new EsyColor;    if (esy.debug) {      return this.selfBuild((new File($.fileName)).parent.parent.path);    } else {      this.updater = new EsyUpdater({        repo: "seblavoie/esy",        file: "esy.jsx",        version: "v0.0.2",        destination: "" + Folder.appPackage.path + "/Scripts/startup"      });      return this.updater.checkForUpdate();    }  };  Esy.prototype.selfBuild = function(path) {    return esy.file.buildExtendScript("" + path + "/lib/esy.js", ["" + path + "/esy.jsx"]);  };  Esy.prototype.listProperties = function(obj) {    var property, _i, _ref, _results;    this.log("Esy.listProperties:");    _results = [];    for (property = _i = 1, _ref = obj.numProperties; 1 <= _ref ? _i <= _ref : _i >= _ref; property = 1 <= _ref ? ++_i : --_i) {      _results.push(this.log(property));    }    return _results;  };  Esy.prototype.log = function(str) {    try {      return $.write("" + (str != null ? str.toString() : void 0) + "\n");    } catch (_error) {}  };  Esy.prototype.dump = function(obj, line) {    var propertyName, propertyValue;    if (line == null) {      line = true;    }    if (obj) {      this.log("Esy.dump:");      if (line) {        this.log("--------------- \n");      }      for (propertyName in obj) {        propertyValue = obj[propertyName];        this.log("" + propertyName + ": " + (propertyValue != null ? propertyValue.toString() : void 0) + " \n");      }      if (line) {        return this.log("\n --------------- \n");      }    }  };  Esy.prototype.extend = function(sourceObject, defaultObject) {    var propertyName, propertyValue;    for (propertyName in defaultObject) {      propertyValue = defaultObject[propertyName];      if (!sourceObject[propertyName]) {        sourceObject[propertyName] = propertyValue;      }    }    return sourceObject;  };  return Esy;})();log = function(log) {  return esy.log(log);};dump = function(obj, line) {  if (line == null) {    line = true;  }  return esy.dump(obj);};// Generated by CoffeeScript 1.7.1var EsyUpdater;EsyUpdater = (function() {  function EsyUpdater(opts) {    this.repo = opts.repo, this.file = opts.file, this.destination = opts.destination;    this.localVersion = opts.version;    this.username = encodeURIComponent(system.userName);    this.data;    this.remoteVersion;  }  EsyUpdater.prototype.initialize = function() {};  EsyUpdater.prototype.getLatestVersion = function() {    var data, url;    url = encodeURIComponent("https://api.github.com/repos/" + this.repo + "/releases");    data = eval(esy.http.get("http://hyle.io/proxy?url=" + url + "&username=" + this.username));    this.data = data[0];    this.remoteVersion = this.data.tag_name;    return this.remoteVersion;  };  EsyUpdater.prototype.checkIfLatest = function() {    if (this.remoteVersion == null) {      this.remoteVersion = this.getLatestVersion();    }    return this.remoteVersion === this.localVersion;  };  EsyUpdater.prototype.checkForUpdate = function() {    if (!this.checkIfLatest()) {      if (confirm("An update is available for " + this.repo + " (" + this.remoteVersion + "). Do you want to download the update?")) {        return this.update();      }    } else {      return true;    }  };  EsyUpdater.prototype.update = function() {    var content, url;    url = encodeURIComponent("https://raw.githubusercontent.com/" + this.repo + "/master/" + this.file);    content = esy.http.get("http://hyle.io/proxy?url=" + url + "&username=" + this.username);    esy.file.create("" + this.destination + "/esy_" + this.remoteVersion + ".jsx", content);    log("delete " + this.destination + "/esy_" + this.localVersion + ".jsx");    return esy.file["delete"]("" + this.destination + "/esy_" + this.localVersion + ".jsx");  };  return EsyUpdater;})();// Generated by CoffeeScript 1.7.1var EsyColor;EsyColor = (function() {  function EsyColor() {}  EsyColor.prototype.hexToRgb = function(hex) {    var b, g, r;    hex = parseInt(hex, 16);    r = hex >> 16;    g = (hex & 0x00ff00) >> 8;    b = hex & 0xff;    return [r, g, b];  };  EsyColor.prototype.hexToHsl = function(hex) {    var b, g, r;    hex = parseInt(hex, 16);    r = hex >> 16;    g = (hex & 0x00ff00) >> 8;    b = hex & 0xff;    return [r / 255, g / 255, b / 255];  };  return EsyColor;})();// Generated by CoffeeScript 1.7.1var EsyFile;EsyFile = (function() {  function EsyFile() {}  EsyFile.prototype["delete"] = function(filepath) {    var file;    if (File(filepath)) {      file = File(filepath);    }    return file.remove();  };  EsyFile.prototype.append = function(filepath, content) {    var file;    file = File(filepath);    file.open("a");    file.write(content);    file.close();    return file;  };  EsyFile.prototype.buildExtendScript = function(filepath, destinations) {    var content, destination, read, _i, _len, _results;    content = this.read(filepath);    content = content.replace("esy.debug = true", "esy.debug = false");    read = (function(_this) {      return function(str, p1) {        return _this.read("" + (_this.path(filepath)) + "/" + p1);      };    })(this);    content = content.replace(/#include \"(.*)\";/g, read);    if (typeof destinations === "string") {      destinations = [destinations];    }    _results = [];    for (_i = 0, _len = destinations.length; _i < _len; _i++) {      destination = destinations[_i];      _results.push(this.create("" + (destination.toString()), content));    }    return _results;  };  EsyFile.prototype.create = function(filepath, content, overwrite) {    var file;    if (content == null) {      content = "";    }    if (overwrite == null) {      overwrite = true;    }    if (overwrite) {      this["delete"](filepath);    }    file = File(filepath);    file.open("w");    file.write(content);    file.close();    return file;  };  EsyFile.prototype.exists = function(filepath) {    var file;    file = File(filepath);    if (file.created) {      return file;    } else {      return false;    }  };  EsyFile.prototype.read = function(filepath) {    var content, file;    file = File(filepath);    file.open("r");    content = file.read();    file.close();    return content;  };  EsyFile.prototype.folderName = function(filepath) {    var folderName;    folderName = this.filename(filepath);    return folderName;  };  EsyFile.prototype.fileName = function(filepath) {    var filename;    filename = filepath.substr(filepath.lastIndexOf('/') + 1);    return filename;  };  EsyFile.prototype.path = function(filepath) {    var filename;    filename = filepath.substr(0, filepath.lastIndexOf('/'));    return filename;  };  return EsyFile;})();// Generated by CoffeeScript 1.7.1var EsyHttp;EsyHttp = (function() {  function EsyHttp() {}  EsyHttp.prototype.open = function(url) {    var command;    if ($.os.indexOf("Windows") !== -1) {      url = url.replace(/&/g, "^&");      command = "cmd /c 'explorer " + url + "'";    } else {      command = "open '" + url + "'";    }    return system.callSystem(command);  };  EsyHttp.prototype.get = function(url) {    var call, conn, domain, httpPrefix, port, reply, typeMatch;    port = "80";    httpPrefix = url.match(/http:\/\//);    domain = (httpPrefix == null ? url.split("/")[0] + ":" + port : url.split("/")[2] + ":" + port);    call = "GET " + (httpPrefix == null ? "http://" + url : url) + " HTTP/1.0\r\nHost:" + (httpPrefix == null ? url.split("/")[0] : url.split("/")[2]) + "\r\nConnection: close\r\n\r\n";    reply = new String();    conn = new Socket();    typeMatch = url.match(/(\.)(\w{3,4}\b)/g);    if (conn.open(domain, "binary")) {      conn.write(call);      reply = conn.read(9999999999);      conn.close();    } else {      reply = "";    }    return reply.substr(reply.indexOf("\r\n\r\n") + 4);  };  return EsyHttp;})();// Generated by CoffeeScript 1.7.1var EsyUi;EsyUi = (function() {  function EsyUi() {}  return EsyUi;})();var esy;esy = {};esy = new Esy();esy.container = this;esy.debug = false;esy.initialize();esy.dump([0, 1]);