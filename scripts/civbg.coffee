# Description:
#   some utils for civbg
#
# Dependencies:
#
# Configuration:
#   None
#
# Commands:
#   hubot civbg? <keyword> - Show the definition of <keyword>
#   hubot civbg! <keyword> <value> - Add a new definition
#
# Author:
#   3100

module.exports = (robot) ->
  PREFIX = 'civbg_'

  getValue = (key) ->
    return robot.brain.get(PREFIX + key) or {}

  setValue = (key, value) ->
    return robot.brain.set PREFIX+key, value

  robot.respond /civbg\? (\S+)$/i, (msg) ->
    msg.send getValue(msg.match[1])

  robot.respond /civbg! (\S+) (.+)$/i, (msg) ->
    setValue(msg.match[1], msg.match[2])
    msg.send "#{msg.match[1]} = #{msg.match[2]. OK."
