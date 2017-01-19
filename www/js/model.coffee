env = require './env.coffee'
require 'PageableAR'

angular.module 'starter.model', ['PageableAR']

  .factory 'resource', (pageableAR, $filter, $http) ->

    class User extends pageableAR.Model
      $idAttribute: 'username'

      $urlRoot: "api/user/"

      _me = null

      @me: ->
        _me ?= new User username: 'me'

    class Hotspot extends pageableAR.Model
      $idAttribute: 'id'

      $urlRoot: "api/hotspot/"

    class HotspotList extends pageableAR.PageableCollection
      model: Hotspot

      $urlRoot: "api/hotspot/"

    User: User
    Hotspot: Hotspot
    HotspotList: HotspotList
