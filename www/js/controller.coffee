_ = require 'lodash'
env = require './env.coffee'

angular

  .module 'starter.controller', ['starter.model']

  .controller 'MenuCtrl', ($scope) ->
    return

  .controller 'MapCtrl', ($scope, pos, resource) ->
    collection = new resource.HotspotList()

    get = ->
      count = collection.models.length
      collection
        .$fetch()
        .then ->
           if count != collection.models.length
             get()

    get()

    _.extend $scope,
      collection: collection
      map:
        center: _.pick pos, 'latitude', 'longitude'
        zoom: env.map.zoom
        window:
          options:
            pixelOffset:
              height: -25
              width: 0
          show: false
          close: ->
            @show = false
        markersEvents:
          click: (marker, eventName, model) ->
            $scope.map.window.model = model
            $scope.map.window.show = true

  .controller 'HotspotCtrl', ($scope, model, $location) ->
    return

  .controller 'HotspotListCtrl', ($scope, collection, $location, model) ->
    return

  .controller 'SearchCtrl', ($scope) ->
    return

  .controller 'GeoCtrl', ($scope, collection, geoModel, coords, model, uiGmapGoogleMapApi, uiGmapIsReady) ->
     return

  .filter 'HotspotFilter', ->
    (hotspots, search) ->
      return
