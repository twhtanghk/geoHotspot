module.exports = 
	policies:
		HotspotController:	
			'*':		false
			find:		true
			findOne:	true
			create:		['isAuth','setOwner']
			update:		['isAuth','isOwner']
			destroy:	['isAuth','isOwner']
			add:		['isAuth']
			remove:		['isAuth']
			populate:	true
			search:		true	
		UserController:
			'*':		false
			find:		['isAuth']
		TagController:
			'*':		false
			find:		['tag/isName']
			findOne:	true
			create:		['isAuth','setOwner']
			update:		['isAuth','isOwner']
			destroy:	['isAuth','isOwner']
			add:		['isAuth']
			remove:		['isAuth']
			populate:	true			