_ = require 'lodash'
Promise = require 'bluebird'

module.exports =

  tablename: 'poi'

  schema: true

  attributes:

    name:
      type: 'string'
      required: true

    extra:
      type: 'json'
      defaultsTo: {}

    type:
      type: 'string'
      defaultsTo: 'Point'

    coordinates:
      type: 'json'
      required: true

    createdBy:
      model: 'user'
      required: true

    tag:
      collection: 'tag'
      via: 'hotspot'

  findByBounds: (bounds, where = {}, skip = 0, limit = 10) ->
    @nativeAsync()
      .then (hotspot) =>
        hotspot = Promise.promisifyAll hotspot
        results = new Promise (resolve, reject) ->
          hotspot
            .find _.extend(where, coordinates: $geoWithin: $box: bounds), {id: true}
            .skip skip
            .limit limit
            .toArray (err, results) ->
              if err
                return reject err
              resolve results
       
        Promise
          .all [
            hotspot.countAsync where
            results
              .map (loc) ->
                loc._id
              .then (results) =>
                @findByIdIn results
                  .populateAll()
          ]
          .then (res) ->
            count: res[0]
            results: res[1]
