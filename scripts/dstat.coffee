# Description:
#   Dstat
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot dstat me/cpu/io - Show basic result
#   hubot dstat me delay count - Show result with specified parameters
#   hubot dstat cpu delay count - Show result with specified parameters (--top-cpu)
#   hubot dstat io delay count - Show result with specified parameters (--top-io-adv --top-bio-adv)

util = require 'util'
spawn = require('child_process').spawn
delay_min = 1
delay_max = 60
count_min = 1
count_max = 10
shaped = true

module.exports = (robot) ->
  run_dstat = (msg, options) ->
    result = ''
    dstat = spawn('dstat', options)
    dstat.stdout.setEncoding('utf8')
    dstat.stdout.on 'data', (data) ->
      result += data.toString()
    dstat.on 'exit', (code) ->
      msg.send shape_for_markdown(result)

  shape_for_markdown = (str) ->
    # str has some unwanted characters on its head. I don't know why.
    result = str.slice str.indexOf('t'), str.length-1
    if !shaped
      return result
    array = result.split('\n')
    tmp = array[0].replace(/-+/ig, '').replace(/\s+/ig, '|')
    result += tmp + '\n'
    result += tmp.replace(/[\w\/]/ig, '-') + '\n'
    for i in [1..array.length-1]
      result += "#{array[i]}\n"
    result = result.replace(/\|/ig, ' | ')
    result

  get_options = (flag, delay, count) ->
    switch flag
      when 'cpu'
        ['-am', '--top-cpu', "#{delay}", "#{count}"]
      when 'io'
        ['-am', '--top-io-adv', '--top-bio-adv', "#{delay}", "#{count}"]
      else
        ['-am', "#{delay}", "#{count}"]

  robot.respond /dstat (\S+)$/i, (msg) ->
    run_dstat msg, get_options(msg.match[1], 1, 0)

  robot.respond /dstat (\S+) ([0-9]+) ([0-9]+)$/i, (msg) ->
    flag = msg.match[1]
    delay = msg.match[2]
    count = msg.match[3]
    if delay < delay_min || delay > delay_max
      msg.send "Please set delay between #{delay_min} and #{delay_max}"
      return
    if count < count_min || count > count_max
      msg.send "Please set count between #{count_min} and #{count_max}"
      return
    run_dstat msg, get_options(flag, delay, count - 1)
