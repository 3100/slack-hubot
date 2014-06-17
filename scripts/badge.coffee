# Description:
#    get a badge.
#
# Dependencies:
#
# Configuration:
#
# Commands:
#   hubot badge( me) str1 str2( color) - get a badge image from shields.io. (default: red)
#
# Author:
#   3100
module.exports = (robot) ->
  robot.respond /badge( me)? (\S+) (\S+) (\S+)$/i, (msg) ->
    str1 = msg.match[2]
    str2 = msg.match[3]
    color = msg.match[4]
    url = "http://img.shields.io/badge/#{str1}-#{str2}-#{color}.png"
    msg.send url

  robot.respond /badge( me)? (\S+) (\S+)$/i, (msg) ->
    str1 = msg.match[2]
    str2 = msg.match[3]
    color = 'red'
    url = "http://img.shields.io/badge/#{str1}-#{str2}-#{color}.png"
    msg.send url
