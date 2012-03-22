amqp = require 'amqp'

conn = amqp.createConnection()

conn.on 'ready', ->
  ex = conn.exchange 'numbers', {type: 'topic', durable: true}
  conn.queue 'odd', {durable: true, autoDelete: false}, (queue) ->
    queue.bind 'numbers', '#.odd'

    queue.subscribe (result) ->
      console.log result
