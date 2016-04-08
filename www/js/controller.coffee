env = require './env.coffee'
	
MenuCtrl = ($scope) ->
	$scope.env = env
	$scope.navigator = navigator

HotspotCtrl = ($scope, model, $location) ->
	_.extend $scope,
		model: model
		tags: model.tags || []
		edit: (id) ->
			$location.url "/hotspot/edit/#{id}"
		save: ->
			hotspot = $scope.model
			hotspot.newTag = $scope.tags
			if hotspot.id
				hotspot.newTag = _.where hotspot.tags, {id: 0}
				hotspot.tags = _.filter hotspot.tags, (tag) ->
					tag.id != 0				
				hotspot.delTag = _.difference hotspot.origTagID, (_.map hotspot.newTag, (tag) ->	tag.id)										
			hotspot.$save().then =>
				$location.url "/hotspot"			
		

HotspotListCtrl = ($scope, collection, $location, model, uiGmapGoogleMapApi) ->
	_.extend $scope,
		collection: collection
		create: ->
			$location.url "/hotspot/create"			
		read: (id) ->
			$location.url "/hotspot/read/#{id}"						
		edit: (id) ->
			$location.url "/hotspot/edit/#{id}"			
		delete: (obj) ->
			collection.remove obj
			removetags = obj.tags
			_.each removetags, (tag) ->
				tagModel = new model.Tag id: tag.id
				tagModel.$fetch()
					.then ->
						if (tagModel.hotspots).length == 1
							tagModel.$destroy()											
		loadMore: ->
			collection.$fetch({params: {sort: 'name ASC'}})
				.then ->
					$scope.$broadcast('scroll.infiniteScrollComplete')
				.catch alert
			return @

updateCoords = ($scope, coords) ->
	$scope.map.center=coords
	$scope.marker.coords=coords
	$scope.marker.options.labelContent="lat: #{coords.latitude} lon: #{coords.longitude}"
	$scope.$apply 'map'
			
currentPosReady = ($scope)->
	options = 
		timeout: 60000
		enableHighAccuracy: true
		maximumAge : 250

	showLocation = (position) ->
		#coords = position.coords
		updateCoords $scope, position.coords

	errorHandler = (err) ->
		coords = env.map.coords
		coords.latitude = coords.latitude + 1
		updateCoords $scope, coords
		
	if navigator.geolocation
		navigator.geolocation.watchPosition(showLocation, errorHandler, options)
		#watchID = navigator.geolocation.getCurrentPosition(showLocation, errorHandler, options)
		#watchID = navigator.geolocation.watchPosition(showLocation, errorHandler, options)
	else
		coords = env.map.coords
		updateCoords $scope, coords

						
geoCtrl = ($scope, collection, model, $geolocation, uiGmapGoogleMapApi) ->
	convert = (collection) ->
		_.map collection, (item) ->
			id:		item.id
			latitude:	parseFloat(item.latitude)
			longitude:	parseFloat(item.longitude)

	
	currentPosReady($scope)

	_.extend $scope,
		collection: collection
		map:
			zoom:	env.map.zoom
			bounds:	{}
		options:
			scrollwheel:	false
			draggable:		true
		marker:
			id: 0
			options:
				icon:			'img/hotspot/blue_marker.png'
				labelAnchor:	"#{env.map.labelAnchor}"
				labelClass:		"marker-labels"
		markers:	convert(collection.models)
		loadMore: ->
			collection.$fetch({params: {sort: 'name ASC'}})
				.then ->
					$scope.$broadcast('scroll.infiniteScrollComplete')
				.catch alert
			return @

	$scope.$watchCollection 'collection', ->
		$scope.markers = convert($scope.collection.models)

HotspotFilter = ->
	(hotspots, search) ->
		r = new RegExp(search, 'i')

		if search
			return _.filter hotspots, (item) ->
				r.test(item?.name) or r.test(item?.longitude) or r.test(item?.latitude)
		else
			return hotspots				

config = ->
	return
	
angular.module('starter.controller', ['ionic', 'ngCordova', 'http-auth-interceptor', 'starter.model', 'platform']).config [config]	
angular.module('starter.controller').controller 'MenuCtrl', ['$scope', MenuCtrl]
angular.module('starter.controller').controller 'HotspotCtrl', ['$scope', 'model', '$location', '$stateParams', HotspotCtrl]
angular.module('starter.controller').controller 'HotspotListCtrl', ['$scope', 'collection', '$location', 'model', HotspotListCtrl]
angular.module('starter.controller').controller 'geoCtrl', ['$scope', 'collection', 'model', '$geolocation', geoCtrl]
angular.module('starter.controller').filter 'hotspotFilter', HotspotFilter