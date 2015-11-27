`#include "../lib/core/_esy.js"`
`#include "../lib/core/_updater.js"`
`#include "../lib/core/_color.js"`
`#include "../lib/core/_file.js"`
`#include "../lib/core/_http.js"`
`#include "../lib/core/_ui.js"`
`#include "../lib/core/_project.js"`
`#include "../lib/core/_composition.js"`


esy = {}

esy           = new Esy()
esy.container = @
esy.debug     = true
esy.initialize()
