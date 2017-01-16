module.exports =
  
  tablename: 'hotspot'
  
  schema: true
  
  attributes:
  
    name:
      type: 'string'
      required: true
      
    location:
      type: 'json'
    
    createdBy:
      model: 'user'
      required: true
    
    tags:
      collection: 'tag'
      via: 'hotspots'
    
    info:
      type: 'json'
