 # Hotspot.coffee
 #
 # @description :: TODO: You might write a short summary of how this model works and what it represents here.
 # @docs        :: http://sailsjs.org/#!documentation/models

module.exports =

  tableName: 'hs'
  
  schema: true
  
  attributes:
  
    name:
      type: 'string'
      required:	true
      unique:	true  

    longitude:
      type: 'string'
 
    latitude:
      type: 'string'   
      
    createdBy:
      type: 'string'
      #required: true

   	tags:
      collection: 'tag'
      via:		  'hotspots'	
    
  