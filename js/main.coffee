# Main functionality

# Helpers.
KEY = "items"

# Load data from localstorage
load = (missing)->
  try
    console.log "Loading."
    return JSON.parse localStorage.getItem KEY
  catch error
    console.log "Load failed. Falling back to default."
    console.error error
    return missing


# Save data in localStorage
save = (data)->
  console.log "Saving."
  console.log data
  localStorage.setItem KEY, JSON.stringify data

# Add new entry
addItem = (value)->
  console.log "Adding: #{value}"
  items.push {time: Date.now(), value: value}
  refresh()

# Remove specific entry
removeItem = (i)->
  items.splice i, 1
  refresh()

# Clear every entry
clearAll = ()->
  console.log "Clearing items"
  items.length = 0
  refresh()

# Refresh the listings
refresh = ()->
  # Update storage
  console.log "ITEMS"
  console.log items
  save items
  # Clear out previous entries
  entries = document.getElementById "entries"
  entries.innerHTML = "" # Clear all children
  total = 0
  for item, i in items by -1
    total += item.value
    makeItem entries, item, i
  document.getElementById "calc"
  .innerHTML = "$#{total.toFixed 2}"

# Make li item to display stuff
makeItem = (parent, item, index)->
    elm = document.createElement "li"
    amount = document.createElement "span"
    time = document.createElement "span"
    a = document.createElement "a"

    amount.innerHTML = "$#{item.value.toFixed 2}"
    time.innerHTML = timeago().format item.time
    a.innerHTML = "Delete"
    a.href = "#"
    a.className = "u-pull-right"
    time.className = "u-pull-left"
    a.onclick = (e)->
      e.preventDefault()
      removeItem index

    elm.appendChild amount
    elm.appendChild time
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

items = load [] # Store items calculated

# Wait till page load before starting
document.addEventListener "DOMContentLoaded", refresh
