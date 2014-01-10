# Description:
#   Capture tokyo-ame.jwa.or.jp as an image. This script is based on webshot.coffee.
#
# Dependencies:
#
# Configuration:
#   HUBOT_WEBTHUMB_USER
#   HUBOT_WEBTHUMB_API_KEY
#
# Commands:
#   hubot ame me - Captures tokyo-ame.jwa.or.jp as an image.
#
# Author:
#   3100
crypto = require 'crypto'
moment = require 'moment'

module.exports = (robot) ->
  robot.respond /ame( me)?/i, (msg) ->
    url = "http://tokyo-ame.jwa.or.jp/"
    getResult(msg, url)

getResult = (msg, url) ->
  if process.env.HUBOT_WEBTHUMB_USER and process.env.HUBOT_WEBTHUMB_API_KEY
    result = 'http://webthumb.bluga.net/easythumb.php?user=' + process.env.HUBOT_WEBTHUMB_USER + '&url=' + encodeURIComponent(url) + '&size=large&hash=' + webthumbhash(process.env.HUBOT_WEBTHUMB_API_KEY, url) + '&cache=14#.jpeg'
    msg.send result

webthumbhash = (apikey, url) =>
  now = moment()
  str = now.format('YYYYMMDD') + url + apikey
  console.log str
  crypto.createHash('md5').update(str).digest('hex')

webthumbhashold = (apikey, url) =>
  now = new Date
  now = new Date(now.getTime() - (now.getTimezoneOffset() * 1000))
  month = (now.getUTCMonth() < 9 ? '0' : '') + (now.getUTCMonth()+1)
  day = (now.getUTCDate() < 10 ? '0' : '') + now.getUTCDate()
  str = now.getUTCFullYear().toString() + month + day + url + apikey
  console.log str
  crypto.createHash('md5').update(str).digest('hex')
