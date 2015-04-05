class EsyColor

# ----------------------------------------
# hexToRgb
# ----------------------------------------
  hexToRgb: (hex) ->
    hex = parseInt(hex,16);
    r = hex >> 16;
    g = (hex & 0x00ff00) >> 8;
    b = hex & 0xff;

    return [r,g,b];


# ----------------------------------------
# rgbToHex
# ----------------------------------------
  rgbToHex: (rgb) ->
    componentToHex = (c) ->
      hex = c.toString(16);
      if hex.length is 1 then "0" + hex else hex

    return "#" + componentToHex(rgb[0]*255) + componentToHex(rgb[1]*255) + componentToHex(rgb[2]*255);


# ----------------------------------------
# hexToHsl
# ----------------------------------------
  hexToHsl: (hex) ->
    hex = parseInt(hex,16);
    r = hex >> 16;
    g = (hex & 0x00ff00) >> 8;
    b = hex & 0xff;

    return [r/255,g/255,b/255];
