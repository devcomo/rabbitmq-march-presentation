amqp = require 'amqp'

conn = amqp.createConnection()

conn.on 'ready', ->
  ex = conn.exchange 'numbers', {type: 'topic', durable: true}
  conn.queue 'all', {durable: true, autoDelete: false}, (queue) ->
    queue.bind 'numbers', '#'

    queue.subscribe (result) ->
      console.log result
