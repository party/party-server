socket = io.connect('http://party.naked.sh:80/consumer')
console.log "BEATFIRE"

interval = undefined
changeInterval = (newBpm) ->
	console.log "new bpm detected", newBpm
	if interval
		clearInterval(interval)
	interval = setInterval( ->
		$("body").trigger("beatFireBeat")
	60000 / newBpm)

socket.on('bpm', changeInterval)
