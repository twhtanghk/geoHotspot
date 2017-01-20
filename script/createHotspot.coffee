#!/usr/bin/coffee

# usage: node_modules/.bin/coffee script/createHotspot.coffee email
Sails = require 'sails'
lib = require './lib.coffee'
Promise = require 'bluebird'
_ = require 'lodash'

lib.sailsReady
  .then (sails) ->
    Promise.all [
      sails
      sails.models.user.create email: process.argv[2]
      sails.models.tag.create name: 'motorcycle'
    ]
  .then (res) ->
    [sails, user, tag] = res
    data = require '../test/data/motor.json'
    Promise.all data.map (loc) ->
      _.extend loc,
        createdBy: process.argv[2]
        tag: ['motorcycle']
      sails.models.hotspot
        .create loc
        .then sails.log.debug
        .catch sails.log.error
  .catch console.log
  .finally ->
    Sails.lower()
