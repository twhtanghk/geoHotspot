module.exports =
  oauth2:
    tokenUrl: process.env.TOKENURL
    verifyURL: process.env.VERIFYURL
    scope: process.env.OAUTH2_SCOPE?.split(' ') || [
        'User'
      ]
