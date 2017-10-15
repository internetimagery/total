# Main functionality

items = load [] # Store items calculated

# Add new entry
addItem = (value)->
  items.push value
  refresh()

# Remove specific entry
removeItem = (index)->
  items.splice(index, 1)
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
    makeItem entries, "$#{val.toFixed 2}"
  document.getElementById "calc"
  .text "$#{total.toFixed 2}"

# Make li item to display stuff
makeItem = (parent, value)->
    elm = document.createElement "li"
    elm.appendChild document.createTextNode value
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
