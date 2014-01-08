# Description:
#   Searching by a keyword in docs.ruby-lang.org
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot rurima <keywords> - Show basic result
#   hubot rurima <keywords> in <version> - Show basic result

lang = 'ja'
defaultVersion = '2.1.0'
url = 'http://docs.ruby-lang.org'
max = 5

cheerio = require 'cheerio'

module.exports = (robot) ->
  getResult = (msg, keywords, version) ->
    queries = ''
    for keyword in keywords
      queries += "/query:#{keyword}"
    msg
      .http("#{url}/#{lang}/search#{queries}/version:#{version}/")
      .get() (err, res, body) ->
        $ = cheerio.load body
        selector = $('dl.entries dt.entry-name h3 span.signature a')
        result = []
        selector.slice(0, max).each (index, element) ->
          href = url + $(this).attr('href')
          name = $(this).text()
          result.push "[#{name}](#{href})"
        if result.length == 0
          msg.send "not found"
        else
          msg.send result.join('\n')

  robot.respond /rurima((?: \S+)+?)(?: in (\d\.\d\.\d))?$/i, (msg) ->
    keywords = msg.match[1].split(' ')
    keywords.shift() # remove an empty item
    if msg.match[2]?
      getResult msg, keywords, msg.match[2]
    else
      getResult msg, keywords, defaultVersion
