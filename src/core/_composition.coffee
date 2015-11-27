class EsyComposition

# ----------------------------------------
# hasLayers
# ----------------------------------------
  hasLayers: (composition) ->
    return composition.numLayers > 0


# ----------------------------------------
# find
# ----------------------------------------
  find: (composition, layerName) ->
    if composition
      if @hasLayers composition
        for i in [1..composition.numLayers]
          if composition.layers[i].name is layerName
            return composition.layers[i]
    else
      alert "Cannot find composition #{composition}"