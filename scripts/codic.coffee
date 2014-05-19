# Description:
#   Searching by a keyword in codic.jp
#
# Dependencies:
#   cheerio
#
# Configuration:
#   None
#
# Commands:
#   hubot codic <keywords> - Show result
#
# Author:
#   3100

url = 'http://codic.jp'
cheerio = require 'cheerio'
max = 4

module.exports = (robot) ->
  getResult = (msg, keyword) ->
    encoded = encodeURIComponent keyword
    msg
      .http("#{url}/search?q=#{encoded}&via=is")
      .get() (err, res, body) ->
        $ = cheerio.load body
        # input is english
        selector = $('div.entries article div.post')
        result = []
        selector.slice(0, max).each (index, element) ->
          name = $(this).children('a').text()
          note = $(this).children('p.description').text()
          type = $(this).children('span').text()
          #result.push "[#{name}](#{href})"
          result.push "#{name}:[#{type}] #{note}"
        if result.length == 0
          selector = $('div.entries ol li.translation')
          selector.slice(0, max).each (index, element) ->
            type = $(this).children('.word-class').attr('title')
            name = $(this).children('.translated').text()
            result.push "#{name}:[#{type}]"
        if result.length == 0
          msg.send 'no result'
        else
          msg.send result.join('\n')

  robot.respond /codic (\S+)$/i, (msg) ->
    keyword = msg.match[1]
    getResult msg, keyword
