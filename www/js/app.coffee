env = require './env.coffee'
_ = require 'lodash'
window._ = _
require 'angular-google-maps'
require 'angular-simple-logger'
currPos = require('promised-location')
  enableHighAccracy: true
  timeout: 10000
  maximumAge: 60000

angular

  .module 'starter', [
    'ionic'
    'uiGmapgoogle-maps'
    'starter.controller'
    'starter.model'
  ]

  .config (uiGmapGoogleMapApiProvider) ->
    uiGmapGoogleMapApiProvider.configure
      key: env.map.key

  .config ($urlRouterProvider) ->
    $urlRouterProvider.otherwise '/map'

  .run ($rootScope, $ionicPlatform, $location, $http) ->
    $ionicPlatform.ready ->
      if (window.cordova && window.cordova.plugins.Keyboard)
        cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true)
      if (window.StatusBar)
        StatusBar.styleDefault()

  .config ($stateProvider) ->

    $stateProvider.state 'app.hotspot',
      url: "/hotspot"
      cache: false
      views:
        'menuContent':
          templateUrl: "templates/hotspot/list.html"
          controller: 'HotspotListCtrl'
      resolve:
        cliModel: 'model'
        collection: (cliModel) ->
          ret = new cliModel.HotspotList()
          ret.$fetch({params: {sort: 'name ASC'} } )

    $stateProvider.state 'map',
      url: "/map"
      cache: false
      templateUrl: "templates/hotspot/map.html"
      controller: 'MapCtrl'
      resolve:
        pos: ($log) ->
          currPos
            .then (pos) ->
              pos.coords
            .catch (err) ->
              $log.error err
              env.map.pos
        resource: 'resource'
        collection: (resource) ->
          ret = new resource.HotspotList()
          ret.$fetch()

    $stateProvider.state 'app.createHotspot',
      url: "/hotspot/create"
      cache: false
      views:
        'menuContent':
          templateUrl: "templates/hotspot/create.html"
          #controller: "createHotspotCtrl"
          controller: 'HotspotCtrl'
      resolve:
        cliModel: 'model'
        model: (cliModel) ->
          ret = new cliModel.Hotspot()


    $stateProvider.state 'app.editHotspot',
      url: "/hotspot/edit/:id"
      cache: false
      views:
        'menuContent':
          templateUrl: "templates/hotspot/edit.html"
          controller: 'HotspotCtrl'
      resolve:
        id: ($stateParams) ->
          $stateParams.id
        cliModel: 'model'
        model: (cliModel, id) ->
          ret = new cliModel.Hotspot({id: id} )
          ret.$fetch()
            .then () ->
              ret.origTagID = _.map ret.tags, (tag) ->
                tag.id
              return ret
