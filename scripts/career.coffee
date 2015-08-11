# Description:
# Know how long you work here
#
# Dependencies:
# bluebird
# moment
#
# Commands:
# hubot career start <Y/M/D> - Set your start date
# hubot career start - Show your start date
# hubot career - Show your count

moment = require('moment')
BRAIN_KEY = 'career-dict'

about = [
  "だいたい",
  "おおよそ",
  "たぶん",
  "もしかしたら",
  "きっと",
  "間違いなく",
  "知らないけど",
  "約"
]

comment = [
  "そろそろ転職？",
  "まだまだだな",
  "長いね",
  "昔は良かった",
  "もうベテランですかね",
  "光陰矢の如し",
  "少年老いやすく学成り難し",
  "最近たるんでませんか？",
  "期待してます！"
]

format = 'YYYY/M/D'
usage = "先に`career start YYYY/M/D`で入社日を登録してください。"

module.exports = (robot) ->
  robot.respond /career start (\S+)$/i, (msg) ->
    dateLocalStr = moment(msg.match[1], format).toLocaleString()
    if dateLocalStr == 'Invalid date'
      msg.send '入社年月日を正しく認識できませんでした。入力形式はYYYY/M/Dです。'
      return false
    dict = loadDict(robot) ? {}
    dict[msg.username] = dateLocalStr
    robot.brain.set(BRAIN_KEY, JSON.stringify(dict))
    msg.send "#{moment(new Date(dateLocalStr)).format(format)}で登録されました。"

  robot.respond /career start$/i, (msg) ->
    dateLocalStr = loadDateLocalStr(robot, msg.username)
    if dataLocalStr?
      msg.send moment(new Date(dateLocalStr)).format('YYYY年M月D日入社とのことです。')
    else
      msg.send usage

  robot.respond /career$/i, (msg) ->
    dateLocalStr = loadDateLocalStr(robot, msg.username)
    if dataLocalStr?
      span_m = moment().diff(moment(new Date(dateLocalStr)), 'month')
      result = "#{pick(about)}#{Math.floor(span_m/12)}年#{span_m%12}ヶ月です。#{pick(comment)}"
      msg.send result
    else
      msg.send usage

  loadDict = (robot) ->
    JSON.parse(robot.brain.get(BRAIN_KEY))

  loadDateLocalStr = (robot, user) ->
    dict = loadDict(robot)
    return null unless dict?
    dict[user]

  pick = (arr) ->
    arr[Math.floor(Math.random() * arr.length)]
