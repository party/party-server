socket = io.connect('http://naked.party.sh/consumer')

interval = undefined
changeInterval = (newBpm) ->
	if interval
		clearInterval(interval)
	interval = setInterval( ->
		$("body").trigger("beatFireBeat")
	60000 / newBpm)

start = ->
	socket.on('bpm', changeInterval)

start()
