#!/usr/bin/coffee

Sails = require 'sails'
stream = require 'stream'
Promise = require 'bluebird'
_ = require 'lodash'
lib = require './lib.coffee'
csv = require 'csv-parser'
errCount=0

class HotspotCreate extends stream.Transform

	_transform: (data, encoding, cb) ->
		tagsReady data.tags.split(",")
			.then (tags) ->
				data.tags = tags
				data.location =
					coordinates: [parseFloat(data.longitude), parseFloat(data.latitude)]
					type: 'Point'
				
				if isNaN(parseInt data.info)
					data.info =
						title: 'Ministry'
						value: data.info
				else
					data.info =
						title: 'No. of Parking Space'
						value: data.info	
				
				sails.models.hotspot.create(data)
			.catch (err) ->
				errCount++
				sails.log.error "#{errCount}. #{err}"
			.finally cb

tagsReady = (tags) ->
	Promise.all  _.map tags, (name) ->
		sails.models.tag.findOrCreate name:name

lib.sailsReady
	.then (sails) ->
		new Promise (resolve, reject) ->
			process.stdin
				.pipe csv()
				.pipe new HotspotCreate(writableObjectMode: true)
				.on 'finish', ->
					sails.log.info 'create data finish!'
					resolve()
				.pipe process.stdout
	.finally ->
		Sails.lower()
		process.exit()