# Main functionality

items = load [] # Store items calculated

# Add new entry
addItem = (value)->
  items.push value
  refresh()

# Remove specific entry
@removeItem = (value)->
  i = items.indexOf value
  if i != -1
    items.splice i, 1
    refresh()

# Clear every entry
clearAll = ()->
  items = []
  refresh()

# Refresh the listings
refresh = ()->
  # Update storage
  save items
  # Clear out previous entries
  entries = document.getElementById "entries"
  entries.innerHTML = "" # Clear all children
  total = 0
  for val in items by -1
    total += val
    makeItem entries, val
  document.getElementById "calc"
  .innerHTML = "$#{total.toFixed 2}"

# Make li item to display stuff
makeItem = (parent, value)->
    elm = document.createElement "li"
    p = document.createElement "span"
    a = document.createElement "a"

    p.innerHTML = "$#{value.toFixed 2}"
    a.innerHTML = "Delete"
    a.href = "#"
    a.className = "u-pull-right"
    a.onclick = (e)->
      e.preventDefault()
      removeItem value

    elm.appendChild p
    elm.appendChild a
    parent.appendChild elm

# Take input and add item
document.getElementById "form"
.addEventListener "submit", (e)->
  e.preventDefault()
  entry = document.getElementById "entry"
  re = /[-\d\.]+/
  if re.exec entry.value
    addItem Number entry.value
    entry.value = ""

# Make clear button work.
document.getElementById "clear"
.addEventListener "click", (e)->
  e.preventDefault()
  clearAll()

# Wait till page load before starting
document.addEventListener "DOMContentLoaded", refresh
