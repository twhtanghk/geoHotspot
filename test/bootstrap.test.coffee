Sails = require 'sails'

sails = null

before (done) ->
	
	Sails.lift {
		environment:	'development'
		hooks:
        	grunt:false
        log:
        	level: "silly"
        	
    }, (error, server) ->

    	sails = server
    	Sails.services.rest().token 'https://mob.myvnc.com/org/oauth2/token/', {id:'HotspotTestAuth', secret:'pass1234'}, {id:'ewnchui', secret:'pass1234'}, [ "https://mob.myvnc.com/org/users"]
    		.then (res) ->
    			sails.token = res.body.access_token
    			done error
    	
after (done) ->
	Sails.lower(done)
	