# Description:
# Get My Yukyu (our company only)
#
# Commands:
# hubot yukyu - Show your paid vacation aka yukyu

module.exports = (robot) ->
  robot.respond /yukyu/i, (msg) ->
    authdata = new Buffer("#{process.env.YUKYU_USER}:#{process.env.YUKYU_PASSWORD}").toString('base64')
    url = process.env.YUKYU_JSON_URL
    request = robot.http(url).header('Authorization', "Basic #{authdata}").get()
    request (err, res, body) ->
      if err
        msg.send err
        msg.send res
        msg.send body
        return
      json = JSON.parse(body)
      id = ids['3100'] # debug
      if !id
        msg.send "ユーザを識別できませんでしたm(__)m"
        return
      for val, i in json.json
        if val.syainid == id.toString()
          msg.reply "残り:#{val.remain}, フレックス:#{val.flexremain}, 振替:#{val.furikae}, 使用:#{val.used}"
          return


# とりあえずSlack参加ユーザ
# idは社員番号とは関係がない
ids = {}
ids['181']      = 34
ids['3100']     = 36
ids['nue']      = 38
ids['takasuka'] = 39
ids['moriya']   = 40
ids['soto']     = 41
ids['yano']     = 46
ids['wada']     = 47
ids['miyazaki'] = 48
ids['dg']       = 49
ids['hiddenki'] = 51
ids['dnaga392'] = 52
