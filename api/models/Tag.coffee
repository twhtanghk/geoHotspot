module.exports =

  tableName: 'tag'

  schema: true

  attributes:

    name:
      type: 'string'
      required: true

    hotspot:
      collection: 'hotspot'
      via: 'tag'
