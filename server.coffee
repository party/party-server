fs = require('fs')

express = require('express')

app = express()

app.use express.static(__dirname)

io = require('socket.io').listen app.listen 80

state = null

io
  .of('/provider')
  .on 'connection', (socket) ->
    socket.on 'bpm', (data) ->
      state = data
      io.of('/consumer').emit 'bpm', state

    socket.on 'bump', (data) ->
      io.of('/consumer').emit 'bump', data

io
  .of('/consumer')
  .on 'connection', (socket) ->
    if state?
      socket.emit 'bpm', state

    socket.on 'hue.change', (data) ->
      console.log 'hue', data

console.log "Listening on 80"
