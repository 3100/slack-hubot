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

spawn = require('child_process').spawn
delay_min = 1
delay_max = 60
count_min = 1
count_max = 10
shaped = true

module.exports = (robot) ->
  run_dstat = (msg, options) ->
    #result = []
    result = ''
    dstat = spawn('dstat', options)
    dstat.stdout.on 'data', (data) ->
      #result.push data
      result += data
    dstat.on 'exit', (code) ->
      msg.send shape_for_markdown(result)

  #shape_for_markdown = (array) ->
  shape_for_markdown = (str) ->
    result = ''
    if !shaped
      #return array
      return str
    #tmp = array[0].split('\n')
    array = str.split('\n')
    #result += tmp[0]
    result += "#{array[0].replace(/-+/ig, '').replace(/\s+/ig, '|')}\n"
    result += result.replace(/[a-zA-Z0-9\/]/ig, '-')
    #result += tmp[1]
    for i in [1..array.length-1]
      result += "#{array[i]}\n"
    result.replace(/\|/ig, ' | ')

  get_options = (flag, delay, count) ->
    switch flag
      when 'cpu'
        ['-a', '--top-cpu', "#{delay}", "#{count}"]
      when 'io'
        ['-a', '--top-io-adv', '--top-bio-adv', "#{delay}", "#{count}"]
      else
        ['-a', "#{delay}", "#{count}"]

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
