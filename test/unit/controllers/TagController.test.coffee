request = require 'supertest'
assert = require 'assert'

describe 'TagController', ->
	
	id = ''
	describe 'GET /api/tag', ->
		it 'list records', (done) ->
			request(sails.hooks.http.app)
				.get('/api/tag')
				.end (err, res) ->
					#console.log 'err:' + JSON.stringify(err)
					#console.log 'res:' + JSON.stringify(res)
					assert.equal err, null
					assert.equal res.status, '200'
					if res.status == 200
						console.log 'response:'+res.text
					done()
					return
			return
		return	

	describe 'POST /api/tag', ->
		it 'create record', (done) ->
			request(sails.hooks.http.app)
				.post('/api/tag')
				.send(name:'tag testing',createdBy:'test')
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

	describe 'PUT /api/tag', ->
		it 'update record', (done) ->
			request(sails.hooks.http.app)
				.put('/api/tag/' + id)
				.send(name:'tag testing amend',createdBy:'test')
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

	describe 'DELETE /api/tag', ->
		it 'delete record', (done) ->
			request(sails.hooks.http.app)
				.delete('/api/tag/' + id)
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
				     		