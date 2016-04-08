Promise = require 'promise'
actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'
http = require 'needle'
querystring = require 'querystring'

module.exports =

	geoforward: (data) ->
		if _.isUndefined data.latitude
			@forward data.address
				.then (geo) ->
					data.latitude = geo.lat
					data.longitude = geo.lon
					return data
		else
			return Promise.resolve data
	
	reverse: (data) ->
		url = sails.config.geo.url
		param =
			format:		'json'
			lat:		data.latitude
			lon:		data.longitude
			#email:		'openstreetmap@gmail.com'
		new Promise (resolve, reject) ->
				sails.services.rest().get "", "#{url}?#{querystring.stringify(param)}"
					.then (res) ->
						if res.body.error
							sails.log.error "reverse lookup #{JSON.stringify(data)} failed"
							resolve data
							#reject new Error("reverse lookup #{JSON.stringify(data)} failed")
						else
							data.address = res.body.display_name
							resolve data
					.catch reject
	# input: 
	#	data:	
	#		address:	string
	# output:
	#	promise to find latitude & longitude, if latitude & longitude not define	
	forward: (address) ->
			url = sails.config.geo.addressUrl
			param =
				format:		'json'
				q:			address
				#email:		'openstreetmap@gmail.com'
			new Promise (resolve, reject) ->
				sails.services.rest().get "", "#{url}?#{querystring.stringify(param)}"
					.then (res) ->
						if res.body.length
							resolve _.pick res.body[0], 'lat', 'lon'
						else
							reject new Error "forward lookup #{address} failed"
					.catch reject