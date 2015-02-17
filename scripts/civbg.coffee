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
#   hubot civbg?? - Show all definitions
#   hubot civbg! <keyword> <value> - Add a new definition (can't update)
#   hubot civbg!! <keyword> <value> - Force to update or simply add a definition
#
# Author:
#   3100

module.exports = (robot) ->
  PREFIX = 'civbg_'
  KEYS = 'civbgkeys'

  getKeys = () ->
    robot.brain.get(KEYS) or {}

  updateKeys = (key) ->
    keys = getKeys()
    keys = keys + ",#{key}"
    robot.brain.set KEYS, keys

  getValue = (key) ->
    return robot.brain.get(PREFIX + key) or {}

  setValue = (key, value) ->
    robot.brain.set PREFIX+key, value
    updateKeys(key)

  robot.respond /civbg\? (\S+)$/i, (msg) ->
    val <- getValue(msg.match[1])
    if (val.length?)
      msg.send val
    else
      msg.send "sorry, but I don't know #{msg.match[1]}"

  robot.respond /civbg\?\?/i, (msg) ->
    keys = getKeys()#.replace(",", "\n")
    msg.send keys

  robot.respond /civbg! (\S+) (.+)$/i, (msg) ->
    val <- getValue(msg.match[1])
    if (val.length?)
      msg.send "#{msg.match[1]} is already defined"
    else
      setValue(msg.match[1], msg.match[2])
      msg.send "#{msg.match[1]} = #{msg.match[2]}. OK."

  robot.respond /civbg!! (\S+) (.+)$/i, (msg) ->
    setValue(msg.match[1], msg.match[2])
    msg.send "#{msg.match[1]} = #{msg.match[2]}. OK."
