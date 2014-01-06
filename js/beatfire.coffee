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
unpause = undefined
socket.on("bump", ->
	console.log "bump"
	$("body").trigger("beatFireBump")
	if paused and unpause
		clearTimeout(unpause)
	paused = true
	unpause = setTimeout( ->
		paused = false
	, 20000)
)
