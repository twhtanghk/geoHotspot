 # TagController
 #
 # @description :: Server-side logic for managing hotspots
 # @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
Promise = require 'promise'
actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'


module.exports =
	find: (req, res) ->
		Model = actionUtil.parseModel req
		cond = actionUtil.parseCriteria req

		query = Model.find()
		 	.where( cond )
			.populateAll()
			.limit( actionUtil.parseLimit(req) )
			.skip( actionUtil.parseSkip(req) )
			.sort( actionUtil.parseSort(req) )
			.toPromise()
		
		new Promise (fulfill, reject) ->
			Promise.all([query])
				.then (data) ->
					status = 'fail'
					if _.isArray data
						status = "success"
					val =
						status:	status
						data:	data[0]
					res.ok(val)
				.catch res.serverError			