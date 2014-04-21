# Description:
#
# Dependencies:
#
# Configuration:
#
# Commands:
#   hubot yukkuri <message> - out message.
#
# Author:
#   3100

module.exports = (robot) ->
  robot.respond /yukkuri (\S+)/i, (msg) ->
    url = "http://yukkuri.t.proxylocal.com/#{encodeURIComponent(msg.match[1])}"
    getResult(msg, url)

  getResult = (msg, url) ->
    msg.http(url).get() (err, res, body) ->
      if err
        msg.send "something went wrong."
      else
        msg.send "done."
