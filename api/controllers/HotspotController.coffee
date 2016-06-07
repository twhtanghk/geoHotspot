 # HotspotController
 #
 # @description :: Server-side logic for managing hotspots
 # @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
Promise = require 'promise'
actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'

module.exports =
	find: (req, res) ->
		Model = actionUtil.parseModel req
		cond = actionUtil.parseCriteria req
		
		count = Model.count()
			.where( cond )
			.toPromise()
		query = Model.find()
			.where( cond )
			.populateAll()
			.limit( actionUtil.parseLimit(req) )
			.skip( actionUtil.parseSkip(req) )
			.sort( actionUtil.parseSort(req) )
			.toPromise()

		Promise.all([count, query])
			.then (data) ->
				Promise.all ( _.map data[1], (record) ->
					sails.services.geo.reverse(record))
					.then (result) ->
						val =
							count:		data[0]
							results:	result
						res.ok(val)
			.catch res.serverError
	
	create: (req, res) ->
		Model = actionUtil.parseModel(req)
		data = actionUtil.parseValues(req)
		
		sails.services.geo.geoforward data
			.then (data) ->
				if data.location
					_.extend data.location,
						type: 'Point'
				Model.create(data)
					.then (newInstance) ->
						Promise.all (_.map req.body.newTag, (tag) ->
							sails.models.tag.findOrCreate name:tag.name, {name:tag.name, createdBy:req.user.username}
								.then (tagInstance) ->
									tagInstance.hotspots.add newInstance
									tagInstance.save()
							)
								.then res.created(newInstance)
					.catch (err) ->
						sails.log.error err
						res.serverError	
	
	findone: (req, res) ->
		Model = actionUtil.parseModel(req)
		pk = actionUtil.requirePk(req)
		query = Model.findOne(pk)
		query = actionUtil.populateEach(query, req)
		query.exec (err, matchingRecord) ->
			if err
				return res.serverError(err)
			if !matchingRecord
				return res.notFound('No record found with the specified `id`.')
			sails.services.geo.reverse(matchingRecord)
				.then res.ok
				.catch (err) ->
					sails.log.error err
					res.serverError
	
	update: (req, res) ->
		Model = actionUtil.parseModel(req)
		pk = actionUtil.requirePk(req)
		values = actionUtil.parseValues(req) 	    
		
		sails.services.geo.geoforward values
			.then (values) ->
				Model.update(pk, values)
					.then (updatedRecord) ->
						if req.body.delTag.length !=0
							sails.services.tag.delete(req.body.delTag)
						Promise.all (_.map req.body.newTag, (tag) ->
							sails.models.tag.findOrCreate name:tag.name, {name:tag.name, createdBy:req.user.username}
									.then (tagInstance) ->
										tagInstance.hotspots.add updatedRecord
										tagInstance.save()
									)
								.then res.ok(updatedRecord)
			.catch res.serverError
	
	search: (req, res) ->
		Model = actionUtil.parseModel req
		cond = actionUtil.parseCriteria req
		limit = actionUtil.parseLimit(req)
		skip = actionUtil.parseSkip(req)
		sort = actionUtil.parseSort(req)
	
		getRecords = () ->
			return new Promise (fulfill, reject) ->
				sails.models.hotspot.native (err, collection) ->
		  			if err or _.isUndefined(cond.longitude) or _.isUndefined(cond.latitude)
		  				reject err
		  				
		  			condition =
		  				location:
		  					$geoWithin:
		  						$centerSphere:	[ [ parseFloat(cond.longitude),parseFloat(cond.latitude) ], cond.distance / 6378.1 ]
					
		  			collection.find(condition)
		  				.toArray (err, results) ->
		  					if err
			  					reject err
			  				fulfill results
		  				
		getRecords()
			.then (data) ->
				arryIds = _.map data, (item) -> item._id
				new Promise (fulfill, reject) ->
					Model.find()
						.where({id: arryIds})
						.populateAll()
						.then (records) ->
							#sails.log.debug "records.length: #{records.length}"
							fulfill res.ok records
						.catch reject
	  	 	.catch res.serverError
				  				
	findAddress: (req, res) ->
		cond = actionUtil.parseCriteria req
		cond.location =
				coordinates: [cond.longitude, cond.latitude]
			
		sails.services.geo.reverse cond
			.then (data) ->
				address = data.address
				res.ok(address)
			.catch res.serverError			
	  				
	  				