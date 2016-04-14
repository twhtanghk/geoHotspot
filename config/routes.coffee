module.exports = 
	routes:	
		# list hotspot by google map
		'GET /api/hotspot/map':
			controller:		'HotspotController'
			action:			'findByMap'
			
		# search hotspot by geospatial query
		'GET /api/geohotspot/search':
			controller:		'GeoHotspotController'
			action:			'search'