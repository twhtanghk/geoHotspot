# Hotspot

Hotspot is a application to provide the physical location where people may have a interest e.g. wifi, car parking

Server API
---------------------------------------------------------
## hotspot
		
* api

	```
	get /api/hotspot - list hotspot for specified pagination/sorting parameters skip, limit, sort
	post /api/hotspot - create a hotspot item with the specified attributes excluding id
    put /api/hotspot/:id - update hotspot attributes of the specified id
    delete /api/hotspot/:id - delete hotspot item of the specified id
	```
## tag
		
* api

	```
	get /api/tag - list tag for specified pagination/sorting parameters skip, limit, sort
	post /api/tag - create a tag item with the specified attributes excluding id
    put /api/tag/:id - update tag attributes of the specified id
    delete /api/tag/:id - delete tag item of the specified id 
    
	```

Configuration
=============

*   git clone https://github.com/ewnchui/geoHotspot.git
*   cd geoHotspot
*   npm install && bower install
*   update environment variables in config/env/development.coffee for server
```
port: 3000
connections:
	mongo:
		driver:		'mongodb'
		host:		'localhost'
		port:		27017
		user:		'user'
		password:	'password'
		database:	'hotspot'
```

*	update environment variables in www/js/env.coffee for client
```
path: 'hotspot'

# proxy server setting (if required)
agent = require 'https-proxy-agent'

http:
	opts:
		agent:	new agent("http://proxy.server.com:8080")

```

*	node_modules/.bin/gulp
*	sails lift --dev