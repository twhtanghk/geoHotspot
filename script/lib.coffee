Sails = require 'sails'
Promise = require 'promise'

module.exports = 
	sailsReady: new Promise (resolve, reject) ->
		config =
			environment:	'development'
			port:	2000
			hooks:
				grunt:			false
				views:			false
				csrf:			false
				http:			false
				pubsub:			false
				sockets:		false
									
		Sails.lift config, (err, sails) ->
			if err
				return reject err
			resolve sails
