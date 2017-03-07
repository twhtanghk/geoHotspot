Promise = require 'bluebird'

angular

  .module 'starter.event', ['uiGmapgoogle-maps']

  .value 'holdTime', 1000

  .run (uiGmapGoogleMapApi, uiGmapIsReady, holdTime) ->
    Promise
      .all [
        uiGmapGoogleMapApi
        uiGmapIsReady.promise(1)
      ]
      .then (res) ->
        [maps, instances] = res
        mouseUp = false
        maps.event.addListener instances[0].map, 'mousedown', (data) ->
          mouseUp = false
          cb = ->
            if mouseUp == false
              maps.event.trigger instances[0].map, 'tapHold', data.latLng
          setTimeout cb, holdTime
        maps.event.addListener instances[0].map, 'mouseup', ->
          mouseUp = true
        maps.event.addListener instances[0].map, 'dragstart', ->
          mouseUp = true
