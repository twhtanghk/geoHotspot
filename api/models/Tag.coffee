module.exports =

  tableName: 'tag'

  schema: true
  
  attributes:
  
    name:
      type: 'string'
      required:	true
      
    createdBy:
      type: 'string'
            
    hotspots:
      collection: 'hotspot'
      via: 'tags' 
