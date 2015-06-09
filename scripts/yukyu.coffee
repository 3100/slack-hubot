# Description:
# Get My Yukyu (our company only)
#
# Dependencies:
# bluebird
#
# Commands:
# hubot yukyu - Show your paid vacation aka yukyu
# hubot yukyu <user> - Show the user's paid vacation aka yukyu
# hubot yukyuid - Show saved ids (json-like)
# hubot yukyuid <user> <id> - Register user and his/her id

Promise = require('bluebird')
BRAIN_KEY = 'yukyu-dict'

# 関数を戻すことに留意
detect = (id) ->
  (json) ->
    for val, i in json.json
      if val.syainid == id.toString()
        return val
    throw "IDが正しいことを確認してください。ID: #{id}"

module.exports = (robot) ->
  robot.respond /yukyuid (\S+) (\S+)/i, (msg) ->
    user = msg.match[1]
    id   = msg.match[2]
    dict = JSON.parse(robot.brain.get(BRAIN_KEY)) ? {}
    dict[user] = id
    robot.brain.set(BRAIN_KEY, JSON.stringify(dict))
    msg.send dict[user]

  robot.respond /yukyuid$/i, (msg) ->
    msg.send robot.brain.get(BRAIN_KEY)

  robot.respond /yukyu$/i, (msg) ->
    run(msg, msg.message.user.name)

  robot.respond /yukyu (\S+)$/i, (msg) ->
    run(msg, msg.match[1])

  run = (msg, user) ->
    id = JSON.parse(robot.brain.get(BRAIN_KEY))[user]
    if !id
      msg.send "ユーザを識別できませんでしたm(__)m"
      return
    p.then(detect(id)).then((val) ->
      msg.send "#{user} = 残り:#{val.remain}, フレックス:#{val.flexremain}, 振替:#{val.furikae}, 使用:#{val.used}"
    , (message) ->
      msg.send message
    )

  p = new Promise (resolve, reject) ->
    authdata = new Buffer("#{process.env.YUKYU_USER}:#{process.env.YUKYU_PASSWORD}").toString('base64')
    url = process.env.YUKYU_JSON_URL
    request = robot.http(url).header('Authorization', "Basic #{authdata}").get()
    request (err, res, body) ->
      if err
        reject err
        return
      resolve JSON.parse(body)
