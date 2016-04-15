module.exports = 
	routes:				
		# search hotspot by geospatial query
		'GET /api/hotspot/search':
			controller:		'HotspotController'
			action:			'search'