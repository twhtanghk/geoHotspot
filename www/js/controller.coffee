_ = require 'lodash'

angular

  .module 'starter.controller', []

  .controller 'MenuCtrl', ($scope) ->
     return

  .controller 'MapCtrl', ($scope, pos) ->
    _.extend $scope,
      map:
        center: _.pick pos, 'latitude', 'longitude'
   
  .controller 'HotspotCtrl', ($scope, model, $location) ->
     return

  .controller 'HotspotListCtrl', ($scope, collection, $location, model) ->
     return

  .controller 'SearchCtrl', (maps, collection) ->
     return

  .controller 'GeoCtrl', ($scope, collection, geoModel, coords, model, uiGmapGoogleMapApi, uiGmapIsReady) ->
     return

  .filter 'HotspotFilter', ->
    (hotspots, search) ->
      return
