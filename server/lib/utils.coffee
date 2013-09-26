module.exports =

  # Pauses for the given time in milliseconds
  sleep: (millis = 1000) ->
    time = new Date().getTime() + millis
    while new Date().getTime() <= time
      "do nothing"

  # Pauses for 0.5s / 1s or 1.5s
  randomSleep: (times = [500, 1000, 1500]) ->
    time = @randomItemFrom times
    @sleep time

  # Returns a random element from the given collection
  randomItemFrom: (collection) ->
    indx = Math.floor(Math.random() * collection.length)
    collection[indx]
