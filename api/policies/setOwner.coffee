module.exports = (req, res, next) ->
	req.options.values = req.options.values || {}
	if _.isUndefined(req.body.createdBy)
		req.options.values.createdBy = req.user.username
			
	next()	