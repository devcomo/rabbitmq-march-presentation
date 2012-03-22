amqp = require 'amqp'

conn = amqp.createConnection()

conn.on 'ready', ->
  ex = conn.exchange 'numbers', {type: 'topic', durable: true}
  setInterval publishNumbers(ex, [200000..1]), 500

publishNumbers = (ex, numbers) ->
  ->
    n = numbers.shift()
    if n % 2 is 0
      routingKey = 'number.even'
    else
      routingKey = 'number.odd'
    
    console.log "publishing #{n} with routing key #{routingKey}"
    ex.publish routingKey, {number:n}, {contentType:'application/json'}


