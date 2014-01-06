socket = io.connect('http://party.naked.sh:80/consumer')

interval = undefined
bpm = undefined
paused = false
changeInterval = (newBpm) ->
	console.log "new bpm detected", newBpm

	if newBpm?
		bpm = newBpm
	else
		newBpm = bpm

	if interval
		clearInterval(interval)

	interval = setInterval( ->
		return if paused
		$("body").trigger("beatFireBeat")
	60000 / newBpm)

socket.on('bpm', changeInterval)
socket.on("bump", ->
	$("body").trigger("beatFireBump")
	paused = true
	setTimeout( ->
		paused = false
	, 20000)
)
