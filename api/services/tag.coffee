Promise = require 'promise'
actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'

module.exports = 
	delete: (tagids) ->
		Promise.all (_.map tagids, (tagid) ->
			sails.models.tag.findOne(id:tagid)
				.populateAll()
				.then (tag) ->
					#if tag.geohotspots.length==0
					if tag.hotspots.length==0
			      		sails.models.tag.destroy(id: tag.id)
			      			.then Promise.resolve
				.catch Promise.reject)
