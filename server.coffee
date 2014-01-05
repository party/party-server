fs = require('fs')

express = require('express')

app = express()

app.use express.static(__dirname)

io = require('socket.io').listen app.listen 80


io
  .of('/provider')
  .on 'connection', (socket) ->
    socket.on 'beat', (data) ->
      io.of('/consumer').emit 'beat', data

io
  .of('/consumer')
  .on 'connection', (socket) ->
    socket.on 'hue.change', (data) ->
      console.log 'hue', data

    socket.on 'time', (data) ->
      console.log 'RT TIME', (new Date - data.time)

console.log "Listening on 80"
