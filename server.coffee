fs = require('fs')

express = require('express')

app = express()

app.use express.static(__dirname)

io = require('socket.io').listen app.listen 80


io
  .of('/provider')
  .on 'connection', (socket) ->
    socket.on 'beat', ->
      io.of('/consumer').emit 'beat'

io
  .of('/consumer')
  .on 'connection', (socket) ->
    socket.on 'hue.change', (data) ->
      console.log 'hue', data

console.log "Listening on 80"
