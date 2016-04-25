module.exports =
	hookTimeout:	400000
	port:			8024
	geo:
		url: 'http://nominatim.openstreetmap.org/reverse'
		addressUrl:	'http://nominatim.openstreetmap.org/search/'	
	promise:
		timeout:	10000 # ms
	oauth2:
		verifyURL:			"https://mob.myvnc.com/org/oauth2/verify/"
		tokenURL:			"https://mob.myvnc.com/org/oauth2/token/"
		scope:				["https://mob.myvnc.com/org/users"]
	models:
		connection: 'mongo'
		migrate:	'alter'
	connections:
		mongo:
			adapter:	'sails-mongo'
			driver:		'mongodb'
			host:		'localhost'
			port:		27017
			user:		''
			password:	''
			database:	'hotspot'
	log:
		level:		'info'