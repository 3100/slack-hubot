# Description:
#   Quote from Shuzo Matsuoka
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot shuzo - Quote
#
# Author:
#   3100

module.exports = (robot) ->
  robot.respond /shuzo/i, (msg) ->
    shuzoMe msg, '修造 名言', (url) ->
      msg.send url

shuzoMe = (msg, query, animated, faces, cb) ->
  cb = animated if typeof animated == 'function'
  cb = faces if typeof faces == 'function'
  q = v: '1.0', rsz: '8', q: query, safe: 'active'
  q.imgtype = 'animated' if typeof animated is 'boolean' and animated is true
  q.imgtype = 'face' if typeof faces is 'boolean' and faces is true
  msg.http('http://ajax.googleapis.com/ajax/services/search/images')
    .query(q)
    .get() (err, res, body) ->
      images = JSON.parse(body)
      images = images.responseData?.results
      if images?.length > 0
        image  = msg.random images
        cb "#{image.unescapedUrl}#.png"
