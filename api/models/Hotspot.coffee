module.exports =

  tablename: 'poi'

  schema: true

  attributes:

    name:
      type: 'string'
      required: true

    extra:
      type: 'json'

    lat:
      type: 'float'
      required: true

    lng:
      type: 'float'
      required: true

    createdBy:
      model: 'user'
      required: true

    tag:
      collection: 'tag'
      via: 'hotspot'
