# Description:
#   Generate a QR code.
#
# Dependencies:
#
# Configuration:
#
# Commands:
#   hubot qrcode <str> - Generate a QR code.
#
# Author:
#   3100
module.exports = (robot) ->
  robot.respond /qrcode (\S+)/i, (msg) ->
    msg.send generate(msg.match[1])

  generate = (str) ->
    encoded = encodeURIComponent str
    "http://chart.apis.google.com/chart?chs=150x150&cht=qr&chl=#{encoded}"
