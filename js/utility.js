(function() {
  var KEY;

  KEY = "items";

  this.load = function(missing) {
    var error;
    try {
      console.log("Loading.");
      return JSON.parse(localStorage.getItem(KEY));
    } catch (_error) {
      error = _error;
      console.log("Load failed. Falling back to default.");
      console.error(error);
      return missing;
    }
  };

  this.save = function(data) {
    console.log("Saving.");
    console.log(data);
    return localStorage.setItem(KEY, JSON.stringify(data));
  };

}).call(this);
