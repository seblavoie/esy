// Generated by CoffeeScript 1.10.0
var EsyComposition;

EsyComposition = (function() {
  function EsyComposition() {}

  EsyComposition.prototype.hasLayers = function(composition) {
    return composition.numLayers > 0;
  };

  EsyComposition.prototype.find = function(composition, layerName) {
    var i, j, layers, ref;
    layers = [];
    if (composition) {
      if (this.hasLayers(composition)) {
        for (i = j = 1, ref = composition.numLayers; 1 <= ref ? j <= ref : j >= ref; i = 1 <= ref ? ++j : --j) {
          if (composition.layers[i].name === layerName) {
            layers.push(composition.layers[i]);
          }
        }
      }
    }
    return layers;
  };

  EsyComposition.prototype.first = function(composition, layerName) {
    var layers;
    layers = this.find(composition, layerName);
    return layers[0];
  };

  return EsyComposition;

})();
