# Helpers.
KEY = "items"

# Load data from localstorage
@load = (missing)->
  try
    console.log "Loading."
    return JSON.parse localStorage.getItem KEY
  catch error
    console.log "Load failed. Falling back to default."
    console.error error
    return missing

# Save data in localStorage
@save = (data)->
  console.log "Saving."
  console.log data
  localStorage.setItem KEY, JSON.stringify data
