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
# hexToHsl
# ----------------------------------------
  hexToHsl: (hex) ->
    hex = parseInt(hex,16);
    r = hex >> 16;
    g = (hex & 0x00ff00) >> 8;
    b = hex & 0xff;

    return [r/255,g/255,b/255];