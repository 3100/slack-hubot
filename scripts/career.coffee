# Description:
# Know how long you work here
#
# Dependencies:
# bluebird
# moment
#
# Commands:
# hubot career start <date> - Set your start date
# hubot career - Show your count

moment = require('moment')
BRAIN_KEY = 'career-dict'

about = [
  "だいたい",
  "おおよそ",
  "たぶん",
  "もしかしたら",
  "きっと",
  "間違いなく"
]

comment = [
  "そろそろ転職？",
  "まだまだだな",
  "長いね",
  "昔は良かった",
  "もうベテランですかね",
  "光陰矢の如し",
  "少年老いやすく学成り難し"
]

module.exports = (robot) ->
  robot.respond /career start (\S+)$/i, (msg) ->
    user = msg.username
    dateLocalStr = moment(msg.match[1]).toLocaleString()
    dict = JSON.parse(robot.brain.get(BRAIN_KEY)) ? {}
    dict[user] = dateLocalStr
    robot.brain.set(BRAIN_KEY, JSON.stringify(dict))
    msg.send

  robot.respond /career$/i, (msg) ->
    user = msg.username
    dateLocalStr = JSON.parse(robot.brain.get(BRAIN_KEY))[user]
    span_m = moment().diff(moment(dateLocalStr), 'month')
    result = "#{pick(about)}#{Math.floor(span_m/12)}年#{span_m%12}ヶ月です。#{pick(comment)}"
    msg.send result

  pick = (arr) ->
    arr[Math.floor(Math.random() * arr.length)]
