# Description:
#   Get a Tokyo weather image from tenki.jp.
#
# Dependencies:
#
# Configuration:
#
# Commands:
#   hubot tenki tokyo - Get a Tokyo weather image
#   hubot tenki saitama - Get a Saitama weather image
#
# Author:
#   3100
moment = require 'moment'

module.exports = (robot) ->
  robot.respond /tenki saitama$/i, (msg) ->
    msg.send getUrl(14)

  robot.respond /tenki( tokyo)?$/i, (msg) ->
    msg.send getUrl(16)

  calcMinutes = (minutesStr) ->
    val = parseInt(minutesStr) - 1
    val = Math.floor(val / 5) * 5
    if val < 10
      return "0#{val}"
    return "#{val}"

  getUrl = (region) ->
    now = moment()
    year = now.format 'YYYY'
    month = now.format 'MM'
    day = now.format 'DD'
    hour = now.format 'HH'
    minutes = calcMinutes(now.format 'm')
    url = "http://az416740.vo.msecnd.net/static-images/rader/#{year}/#{month}/#{day}/#{hour}/#{minutes}/00/pref_#{region}/large.jpg"
