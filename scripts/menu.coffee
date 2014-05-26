# Description:
#   Get a Menu from hanasaki co.
#
# Dependencies:
#   moment
# Configuration:
#
# Commands:
#   hubot menu ajisai
#   hubot menu kikyo
#   hubot menu healthy
#   hubot menu onigiri
#
# Author:
#   Takasuka
moment = require 'moment'

module.exports = (robot) ->
  robot.respond /menu ajisai/i, (msg) ->
    msg.send getUrl('ajisai')

  robot.respond /menu kikyo/i, (msg) ->
    msg.send getUrl('kikyou')

  robot.respond /menu healthy/i, (msg) ->
    msg.send getUrl('herusi')

  robot.respond /menu onigiri/i, (msg) ->
    msg.send getUrl('onigiri')

  getUrl = (keyword) ->
    now = moment()
    year = now.format 'YYYY'
    hyear = parseInt(year, 10) - 1988
    month = now.format 'M'
    url = "http://hanasaki.ico.bz/upfile/H#{hyear}-#{month}#{keyword}.pdf"
