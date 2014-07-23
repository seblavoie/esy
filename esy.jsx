// Generated by CoffeeScript 1.7.1#target "aftereffects-12.0";// Generated by CoffeeScript 1.7.1var Esy;Esy = (function() {  function Esy() {}  Esy.prototype.initialize = function() {    this.ui = new EsyUi;    this.http = new EsyHttp;    this.file = new EsyFile;    this.color = new EsyColor;    return this.selfBuild();  };  Esy.prototype.selfBuild = function() {    var destination, file, source;    source = (new File($.fileName)).parent;    destination = source.parent.path;    if (esy.debug) {      return file = esy.file.buildExtendScript("" + source.path + "/esy.js", "" + destination + "/esy.jsx");    } else {    }  };  Esy.prototype.listProperties = function(obj) {    var property, _i, _ref, _results;    this.log("Esy.listProperties:");    _results = [];    for (property = _i = 1, _ref = obj.numProperties; 1 <= _ref ? _i <= _ref : _i >= _ref; property = 1 <= _ref ? ++_i : --_i) {      _results.push(this.log(property));    }    return _results;  };  Esy.prototype.log = function(str) {    try {      return $.write("" + (str != null ? str.toString() : void 0) + "\n");    } catch (_error) {}  };  Esy.prototype.dump = function(obj) {    var propertyName, propertyValue, _results;    if (obj) {      this.log("Esy.dump:");      _results = [];      for (propertyName in obj) {        propertyValue = obj[propertyName];        _results.push(this.log("" + propertyName + ": " + (propertyValue != null ? propertyValue.toString() : void 0) + " \n"));      }      return _results;    }  };  Esy.prototype.extend = function(sourceObject, defaultObject) {    var propertyName, propertyValue;    for (propertyName in defaultObject) {      propertyValue = defaultObject[propertyName];      if (!sourceObject[propertyName]) {        sourceObject[propertyName] = propertyValue;      }    }    return sourceObject;  };  return Esy;})();// Generated by CoffeeScript 1.7.1var EsyColor;EsyColor = (function() {  function EsyColor() {}  EsyColor.prototype.hexToRgb = function(hex) {    var b, g, r;    hex = parseInt(hex, 16);    r = hex >> 16;    g = (hex & 0x00ff00) >> 8;    b = hex & 0xff;    return [r, g, b];  };  EsyColor.prototype.hexToHsl = function(hex) {    var b, g, r;    hex = parseInt(hex, 16);    r = hex >> 16;    g = (hex & 0x00ff00) >> 8;    return b = hex & 0xff;  };  return EsyColor;})();// Generated by CoffeeScript 1.7.1var EsyFile;EsyFile = (function() {  function EsyFile() {}  EsyFile.prototype["delete"] = function(filepath) {    var file;    file = File(filepath);    return file.remove();  };  EsyFile.prototype.append = function(filepath, content) {    var file;    file = File(filepath);    file.open("a");    file.write(content);    file.close();    return file;  };  EsyFile.prototype.buildExtendScript = function(filepath, destinations) {    var content, destination, read, _i, _len, _results;    content = this.read(filepath);    content = content.replace("esy.debug = true", "esy.debug = false");    read = (function(_this) {      return function(str, p1) {        return _this.read("" + (_this.path(filepath)) + "/" + p1);      };    })(this);    content = content.replace(/#include \"(.*)\";/g, read);    if (typeof destinations === "string") {      destinations = [destinations];    }    _results = [];    for (_i = 0, _len = destinations.length; _i < _len; _i++) {      destination = destinations[_i];      _results.push(this.create("" + (destination.toString()), content));    }    return _results;  };  EsyFile.prototype.create = function(filepath, content, overwrite) {    var file;    if (content == null) {      content = "";    }    if (overwrite == null) {      overwrite = true;    }    if (overwrite) {      this["delete"](filepath);    }    file = File(filepath);    file.open("w");    file.write(content);    file.close();    return file;  };  EsyFile.prototype.exists = function(filepath) {    var file;    file = File(filepath);    if (file.created) {      return file;    } else {      return false;    }  };  EsyFile.prototype.read = function(filepath) {    var content, file;    file = File(filepath);    file.open("r");    content = file.read();    file.close();    return content;  };  EsyFile.prototype.folderName = function(filepath) {    var folderName;    folderName = this.filename(filepath);    return folderName;  };  EsyFile.prototype.filename = function(filepath) {    var filename;    filename = filepath.substr(filepath.lastIndexOf('/') + 1);    return filename;  };  EsyFile.prototype.path = function(filepath) {    var filename;    filename = filepath.substr(0, filepath.lastIndexOf('/'));    return filename;  };  return EsyFile;})();// Generated by CoffeeScript 1.7.1var EsyHttp;EsyHttp = (function() {  function EsyHttp() {}  EsyHttp.prototype.open = function(url) {    var command;    if ($.os.indexOf("Windows") !== -1) {      url = url.replace(/&/g, "^&");      command = "cmd /c 'explorer " + url + "'";    } else {      command = "open '" + url + "'";    }    return system.callSystem(command);  };  EsyHttp.prototype.get = function(url) {    var call, conn, domain, httpPrefix, reply, typeMatch;    httpPrefix = url.match(/http:\/\//);    domain = (httpPrefix == null ? url.split("/")[0] + ":" + port : url.split("/")[2] + ":" + port);    call = "GET " + (httpPrefix == null ? "http://" + url : url) + " HTTP/1.0\r\nHost:" + (httpPrefix == null ? url.split("/")[0] : url.split("/")[2]) + "\r\nConnection: close\r\n\r\n";    reply = new String();    conn = new Socket();    typeMatch = url.match(/(\.)(\w{3,4}\b)/g);    if (conn.open(domain, "binary")) {      conn.write(call);      reply = conn.read(9999999999);      conn.close();    } else {      reply = "";    }    return reply.substr(reply.indexOf("\r\n\r\n") + 4);  };  return EsyHttp;})();// Generated by CoffeeScript 1.7.1var EsyUIWindowRow, EsyUi, EsyUiPanel, EsyUiWindow;EsyUi = (function() {  function EsyUi() {    this.sizes = {};    this.window = null;    this.currentPanel = null;    this.panels = [];    this.rows = [];    this.buttons = [];    this.textbox = [];  }  EsyUi.prototype.set = function() {    var window;    window = new EsyUiWindow;    return window;  };  EsyUi.prototype.show = function() {    return this;  };  return EsyUi;})();EsyUiWindow = (function() {  function EsyUiWindow() {    this.sizes = {      paddingLeft: 10,      paddingTop: 10,      width: 300,      heightIncrement: 0    };    this.element = null;    this.render();    return this;  }  EsyUiWindow.prototype.render = function() {    if (esy.container instanceof Panel) {      return this.element = esy.container;    } else {      return this.element = new Window("window {orientation: 'row'}");    }  };  EsyUiWindow.prototype.addPanel = function(data) {    return new EsyUiPanel(this, data);  };  return EsyUiWindow;})();EsyUiPanel = (function() {  function EsyUiPanel(window, data) {    this.window = window;    this.element = null;    this.data = data;    this.yOffset = 0;    this.render();    return this;  }  EsyUiPanel.prototype.render = function() {    var values;    values = [this.window.sizes.paddingLeft, this.window.sizes.heightIncrement, this.window.sizes.width, 60];    this.element = this.window.element.add('panel', values, this.data.label);    return this;  };  EsyUiPanel.prototype.addRow = function(data) {    return new EsyUIWindowRow(this, data);  };  return EsyUiPanel;})();EsyUIWindowRow = (function() {  function EsyUIWindowRow(panel, data) {    this.panel = panel;    this.data = data;    this.render();    return this.panel;  }  EsyUIWindowRow.prototype.render = function() {    var currentPanel, element, elementType, elements, height, paddingLeft, paddingTop, values, width, xOffset, yOffset, _i, _len, _ref;    currentPanel = this.panel.element;    height = 30;    width = 100;    paddingLeft = 10;    paddingTop = 10;    xOffset = currentPanel.margins[0];    yOffset = currentPanel.margins[1] + this.panel.yOffset;    esy.log("yOffset = " + yOffset);    _ref = this.data;    for (_i = 0, _len = _ref.length; _i < _len; _i++) {      elements = _ref[_i];      esy.log("currentPanel.margins[0] = " + currentPanel.margins[0]);      for (elementType in elements) {        element = elements[elementType];        if (element.height == null) {          element.height = height;        }        if (element.width == null) {          element.width = width;        }        values = [paddingLeft + xOffset, paddingTop + yOffset, currentPanel.size[0] * element.width / 100 + xOffset - currentPanel.margins[0], paddingTop + element.height + yOffset];        xOffset = currentPanel.size[0] * (element.width / 100) + xOffset;        this.panel.yOffset += paddingTop + currentPanel.margins[1] + element.height;        switch (elementType) {          case "button":            this.addButton(element.label, values);        }      }    }    currentPanel.size[1] += element.height;    return this;  };  EsyUIWindowRow.prototype.addButton = function(label, values) {    this.panel.window.element.add('button', values, label);    return this;  };  EsyUIWindowRow.prototype.getButton = function(label) {    return this.buttons[label];  };  EsyUIWindowRow.prototype.addTextbox = function(label, values) {    return this.window.add('editText', values, label);  };  return EsyUIWindowRow;})();var esy;esy = new Esy();esy.container = this;esy.debug = false;esy.initialize();