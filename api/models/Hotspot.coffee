 # Hotspot.coffee
 #
 # @description :: TODO: You might write a short summary of how this model works and what it represents here.
 # @docs        :: http://sailsjs.org/#!documentation/models

module.exports =
	
	tablename: 'hotspot'
	
	schema: true
	
	attributes:
	
		name:
			type: 'string'
			required: true
			unique: true
			
		location:
			type: 'json'
		
		createdBy:
			type: 'string'
		
		tags:
			collection: 'tag'
			via: 'hotspots'
		
		info:
			type: 'json'
			
	indexes:[
		
		attributes:
			location: '2dsphere'

	]		
    
  