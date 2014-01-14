(function() {
  var bpm, changeInterval, interval, paused, socket, unpause;
  socket = io.connect('http://party.naked.sh:80/consumer');
  interval = void 0;
  bpm = void 0;
  paused = false;
  changeInterval = function(newBpm) {
    console.log("new bpm detected", newBpm);
    if (newBpm != null) {
      bpm = newBpm;
    } else {
      newBpm = bpm;
    }
    if (interval) {
      clearInterval(interval);
    }
    return interval = setInterval(function() {
      if (paused) {
        return;
      }
      return $("body").trigger("beatFireBeat");
    }, 60000 / newBpm);
  };
  socket.on('bpm', changeInterval);
  unpause = void 0;
  socket.on("bump", function() {
    console.log("bump");
    $("body").trigger("beatFireBump");
    if (paused && unpause) {
      clearTimeout(unpause);
    }
    paused = true;
    return unpause = setTimeout(function() {
      return paused = false;
    }, 4 * 1000);
  });
}).call(this);
