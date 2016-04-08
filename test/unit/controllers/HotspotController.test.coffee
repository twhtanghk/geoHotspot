request = require 'supertest'
assert = require 'assert'

describe 'HotspotController', ->
	
	id = ''
	describe 'GET /api/hotspot', ->
		it 'list records', (done) ->
			request(sails.hooks.http.app)
				.get('/api/hotspot')
				.end (err, res) ->
					assert.equal err, null
					assert.equal res.status, '200'
					if res.status == 200
						console.log 'response:'+res.text
					done()
					return
			return
		return	

	describe 'POST /api/hotspot', ->
		it 'create record', (done) ->
			request(sails.hooks.http.app)
				.post('/api/hotspot')
				.send(name:'testing', latitude:'25.043965',longitude:'121.519581',createdBy:'test')
				.set('Authorization',"Bearer #{sails.token}")
				.end (err, res) ->
					assert.equal err, null
					assert.equal res.status, '201'
					if res.status == 201
						console.log 'response:'+res.text
						id = JSON.parse(res.text).id
						console.log 'id='+id
					done()
					return
			return
		return 

	describe 'PUT /api/hotspot', ->
		it 'update record', (done) ->
			request(sails.hooks.http.app)
				.put('/api/hotspot/' + id)
				.send(name:'testing amend', latitude:'25.043965',longitude:'121.519581',createdBy:'test')
				.set('Authorization',"Bearer #{sails.token}")
				.end (err, res) ->
					assert.equal err, null
					assert.equal res.status, '200'
					if res.status == 200
						console.log 'response:'+res.text
					done()
					return
			return
		return

	describe 'DELETE /api/hotspot', ->
		it 'delete record', (done) ->
			request(sails.hooks.http.app)
				.delete('/api/hotspot/' + id)
				.set('Authorization',"Bearer #{sails.token}")
				.end (err, res) ->
					assert.equal err, null
					assert.equal res.status, '200'
					if res.status == 200
						console.log 'response:'+res.text
					done()
					return
			return
		return		
				     		