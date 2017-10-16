(function() {
  var KEY, addItem, clearAll, items, load, makeItem, refresh, removeItem, save;

  KEY = "items";

  load = function(missing) {
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

  save = function(data) {
    console.log("Saving.");
    console.log(data);
    return localStorage.setItem(KEY, JSON.stringify(data));
  };

  addItem = function(value) {
    console.log("Adding: " + value);
    items.push({
      time: Date.now(),
      value: value
    });
    return refresh();
  };

  removeItem = function(i) {
    items.splice(i, 1);
    return refresh();
  };

  clearAll = function() {
    console.log("Clearing items");
    items.length = 0;
    return refresh();
  };

  refresh = function() {
    var entries, i, item, total, _i;
    console.log("ITEMS");
    console.log(items);
    save(items);
    entries = document.getElementById("entries");
    entries.innerHTML = "";
    total = 0;
    for (i = _i = items.length - 1; _i >= 0; i = _i += -1) {
      item = items[i];
      total += item.value;
      makeItem(entries, item, i);
    }
    return document.getElementById("calc").innerHTML = "$" + (total.toFixed(2));
  };

  makeItem = function(parent, item, index) {
    var a, amount, elm, time;
    elm = document.createElement("li");
    amount = document.createElement("span");
    time = document.createElement("span");
    a = document.createElement("a");
    amount.innerHTML = "$" + (item.value.toFixed(2));
    time.innerHTML = timeago().format(item.time);
    a.innerHTML = "Delete";
    a.href = "#";
    a.className = "u-pull-right";
    time.className = "u-pull-left";
    a.onclick = function(e) {
      e.preventDefault();
      return removeItem(index);
    };
    elm.appendChild(amount);
    elm.appendChild(time);
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

  items = load([]);

  document.addEventListener("DOMContentLoaded", refresh);

}).call(this);
