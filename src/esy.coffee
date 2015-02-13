`#target "aftereffects-13.0"`
`#include "../lib/core/_esy.js"`
`#include "../lib/core/_color.js"`
`#include "../lib/core/_file.js"`
`#include "../lib/core/_http.js"`
`#include "../lib/core/_ui.js"`

esy           = new Esy()
esy.container = @
esy.debug     = true
esy.initialize()