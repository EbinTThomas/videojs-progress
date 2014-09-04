initTooltip = ( player ) ->
  player.on "loadedmetadata", ->
    progress = player.controlBar.progressControl
    duration = player.duration()

    $(progress.el()).on "mousemove", ( event ) ->
      bar = $(progress.el())
      offsetLeft = bar.offset().left
      currentPos = event.clientX
      console.log (currentPos - offsetLeft)/bar.width() * duration
      seekBar = progress.seekBar
      return
