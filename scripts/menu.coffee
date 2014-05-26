# Description:
#   Get a Menu from hanasaki co.
#
# Dependencies:
#   moment
# Configuration:
#
# Commands:
#   hubot menu a[jisai]
#   hubot menu c[ocoichi]
#   hubot menu f[ukuraya]
#   hubot menu he[althy]
#   hubot menu ho[t[motto]]
#   hubot menu k[ikyo]
#   hubot menu m[atsuya]
#   hubot menu o[nigiri]
#   hubot menu y[occhi]
#
# Author:
#   Takasuka
moment = require 'moment'

module.exports = (robot) ->
  robot.respond /menu y(occhi)?/i, (msg) ->
    msg.send 'http://image1-4.tabelog.k-img.com/restaurant/images/Rvw/18593/320x320_rect_18593010.jpg'
    msg.send 'http://image1-4.tabelog.k-img.com/restaurant/images/Rvw/18593/320x320_rect_18593008.jpg'

  robot.respond /menu m(atsuya)?/i, (msg) ->
    msg.send 'http://www.matsuyafoods.co.jp/menu/index.html'

  robot.respond /menu ho(t(motto)?)?/i, (msg) ->
    msg.send 'http://www.hottomotto.com/menu_list/index/13'

  robot.respond /menu c(ocoichi)?/i, (msg) ->
    msg.send 'http://www.ichibanya.co.jp/menu/index.html'

  robot.respond /menu f(ukuraya)?/i, (msg) ->
    msg.send 'http://tabelog.com/tokyo/A1309/A130905/13056295/dtlmenu/'

  robot.respond /menu a(jisai)?/i, (msg) ->
    msg.send getHanasakiUrl('ajisai')

  robot.respond /menu k(ikyo)?/i, (msg) ->
    msg.send getHanasakiUrl('kikyou')

  robot.respond /menu he(althy)?/i, (msg) ->
    msg.send getHanasakiUrl('herusi')

  robot.respond /menu o(nigiri)?/i, (msg) ->
    msg.send getHanasakiUrl('onigiri')

  getHanasakiUrl = (keyword) ->
    now = moment()
    year = now.format 'YYYY'
    hyear = parseInt(year, 10) - 1988
    month = now.format 'M'
    url = "http://hanasaki.ico.bz/upfile/H#{hyear}-#{month}#{keyword}.pdf"
