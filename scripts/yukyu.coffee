# Description:
# Get My Yukyu (our company only)
#
# Commands:
# hubot yukyu - Show your paid vacation aka yukyu

Promise = require('bluebird')

module.exports = (robot) ->
  robot.respond /yukyu/i, (msg) ->
    id = ids[msg.message.user.name]
    if !id
      msg.send "ユーザを識別できませんでしたm(__)m"
      return
    p.then(detect(id)).then((val) ->
      msg.reply "残り:#{val.remain}, フレックス:#{val.flexremain}, 振替:#{val.furikae}, 使用:#{val.used}"
    , (message) ->
      msg.send message
    )

  p = new Promise (resolve, reject) ->
    request = robot.http(url).header('Authorization', "Basic #{authdata}").get()
    request (err, res, body) ->
      if err
        reject err
        return
      resolve JSON.parse(body)

authdata = new Buffer("#{process.env.YUKYU_USER}:#{process.env.YUKYU_PASSWORD}").toString('base64')
url = process.env.YUKYU_JSON_URL

# 関数を戻すことに留意
detect = (id) ->
  (json) ->
    for val, i in json.json
      if val.syainid == id.toString()
        return val
    throw "IDが正しいことを確認してください。ID: #{id}"

# とりあえずSlack参加ユーザ
# idは社員番号とは関係がない
ids = {}
ids['181']      = 34
ids['3100']     = 36
ids['nue']      = 38
ids['tksk']     = 39
ids['moriya']   = 40
ids['soto']     = 41
ids['yano']     = 46
ids['wada']     = 47
ids['miyazaki'] = 48
ids['dg']       = 49
ids['hiddenki'] = 51
ids['dnaga392'] = 52
