 # GeoHotspotController
 #
 # @description :: Server-side logic for managing Geohotspots
 # @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
Promise = require 'promise'
actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'

module.exports =
	search: (req, res) ->
		Model = actionUtil.parseModel req
		cond = actionUtil.parseCriteria req
		limit = actionUtil.parseLimit(req)
		skip = actionUtil.parseSkip(req)
		sort = actionUtil.parseSort(req)

		sails.models.geohotspot.native (err, collection) ->
  			if err or _.isUndefined(cond.longitude) or _.isUndefined(cond.latitude)
  				res.serverError err
  			
  			condition =
  				location:
  					$geoWithin:
  						$centerSphere:	[ [ parseFloat(cond.longitude),parseFloat(cond.latitude) ], cond.distance / 3963.2 ]
			
  			collection.find(condition)
  				.toArray (err, results) ->
	  				if err
	  					res.serverError err
	  				
	  				val =
	  					count:		results.length
	  					results:	results
	  				res.ok val
				
	  				
	  				