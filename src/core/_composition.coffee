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
    layers = []
    if composition
      if @hasLayers composition
        for i in [1..composition.numLayers]
          if composition.layers[i].name is layerName
            layers.push composition.layers[i]

    return layers

# ----------------------------------------
# first
# ----------------------------------------
  first: (composition, layerName) ->
    layers = @find composition, layerName
    return layers[0]