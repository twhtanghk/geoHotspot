env = require './env.coffee'
require 'PageableAR'
		
angular.module 'starter.model', ['PageableAR']
	
	.factory 'model', (pageableAR, $filter) ->

		class User extends pageableAR.Model
			$idAttribute: 'username'
			
			$urlRoot: "api/user/"
			
			_me = null
			
			@me: ->
				_me ?= new User username: 'me'

		class Tag extends pageableAR.Model
			$idAttribute: 'id'
			
			$urlRoot: "api/tag/"
		
		class Hotspot extends pageableAR.Model
			$idAttribute: 'id'
			
			$urlRoot: "api/hotspot/"	
		
		class HotspotList extends pageableAR.PageableCollection
			model: Hotspot
		
			$urlRoot: "api/hotspot/"
			
		class geoHotspot extends pageableAR.Model
			$idAttribute: '_id'
			
			$urlRoot: "api/geohotspot/"	
		
		class MapList extends pageableAR.PageableCollection
			model: geoHotspot
			
			$urlRoot: "api/geohotspot/search"

		User:		User
		Tag:	Tag
		Hotspot:	Hotspot
		HotspotList:	HotspotList
		MapList:	MapList
		geoHotspot:	geoHotspot
