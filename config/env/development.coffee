agent = require 'https-proxy-agent'

module.exports =
	hookTimeout:	10000000
	port:			1337
	geo:
		url: 'http://nominatim.openstreetmap.org/reverse'
		addressUrl:	'http://nominatim.openstreetmap.org/search/'	
	http:
		opts:
			agent:	new agent("http://proxy1.scig.gov.hk:8080")				
	promise:
		timeout:	10000000 # ms
	oauth2:
		tokenUrl:			'https://mob.myvnc.com/org/oauth2/token/'
		verifyURL:			'https://mob.myvnc.com/org/oauth2/verify/'
		scope:				[ "https://mob.myvnc.com/org/users"]
		client:
			id:		'HotspotTestAuth'
			secret: 'pass1234'	
	models:
		connection: 'mongo'
		migrate:	'alter'
	connections:
		mongo:
			adapter:	'sails-mongo'
			driver:		'mongodb'
			host:		'localhost'
			port:		27017
			user:		'georw'
			password:	'pass1234'
			database:	'geospatial'
	log:
		level:		'info'			
