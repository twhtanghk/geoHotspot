env = require './env.coffee'
require 'PageableAR'

angular.module 'starter.model', ['PageableAR']

  .factory 'resource', (pageableAR, $filter, $http) ->

    class User extends pageableAR.Model
      $urlRoot: "api/user/"

      _me = null

      @me: ->
        _me ?= new User username: 'me'

    class Hotspot extends pageableAR.Model
      $idAttribute: 'id'

      $urlRoot: "api/hotspot/"

      $parse: (data, opts) ->
        tag = data.tag[0]?.name
        ret = super(data, opts)
        ret['latitude'] = ret['lat']
        ret['longitude'] = ret['lng']
        ret['options'] = {title: "#{ret['name']}", icon: "img/#{tag}.png"}
        return ret

      info: ->
        ret = _.pick @, 'name'
        ret = _.extend ret, @extra
        JSON.stringify ret

    class HotspotList extends pageableAR.PageableCollection
      model: Hotspot

      $urlRoot: "api/hotspot/"

    class Tag extends pageableAR.Model
      $urlRoot: "api/tag/"

    class TagList extends pageableAR.PageableCollection
      model: Tag

      $urlRoot = "api/tag/"

    User: User
    Hotspot: Hotspot
    HotspotList: HotspotList
    Tag: Tag
    TagList: TagList
