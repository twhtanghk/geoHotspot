module.exports = 
	routes:	
		# list hotspot by google map
		'GET /api/hotspot/map':
			controller:		'HotspotController'
			action:			'findByMap'