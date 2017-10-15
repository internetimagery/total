(function() {
  var addItem, clearAll, items, makeItem, refresh;

  items = load([]);

  addItem = function(value) {
    items.push(value);
    return refresh();
  };

  this.removeItem = function(value) {
    var i;
    i = items.indexOf(value);
    if (i !== -1) {
      items.splice(i, 1);
      return refresh();
    }
  };

  clearAll = function() {
    items = [];
    return refresh();
  };

  refresh = function() {
    var entries, total, val, _i;
    save(items);
    entries = document.getElementById("entries");
    entries.innerHTML = "";
    total = 0;
    for (_i = items.length - 1; _i >= 0; _i += -1) {
      val = items[_i];
      total += val;
      makeItem(entries, val);
    }
    return document.getElementById("calc").innerHTML = "$" + (total.toFixed(2));
  };

  makeItem = function(parent, value) {
    var a, elm, p;
    elm = document.createElement("li");
    p = document.createElement("span");
    a = document.createElement("a");
    p.innerHTML = "$" + (value.toFixed(2));
    a.innerHTML = "Delete";
    a.href = "#";
    a.className = "u-pull-right";
    a.onclick = function(e) {
      e.preventDefault();
      return removeItem(value);
    };
    elm.appendChild(p);
    elm.appendChild(a);
    return parent.appendChild(elm);
  };

  document.getElementById("form").addEventListener("submit", function(e) {
    var entry, re;
    e.preventDefault();
    entry = document.getElementById("entry");
    re = /[-\d\.]+/;
    if (re.exec(entry.value)) {
      addItem(Number(entry.value));
      return entry.value = "";
    }
  });

  document.getElementById("clear").addEventListener("click", function(e) {
    e.preventDefault();
    return clearAll();
  });

  document.addEventListener("DOMContentLoaded", refresh);

}).call(this);
