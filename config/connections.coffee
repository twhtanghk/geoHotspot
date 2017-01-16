module.exports =
  connections:
    mongo:
      adapter: 'sails-mongo'
      driver: 'mongodb'
      url: process.env.DB || 'mongodb://@hotspot_mongo:27017/hotspot'
