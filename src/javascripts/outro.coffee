vjsProgress = ( options ) ->
  progress = new Progress @

  @on "loadedmetadata", ->
    progress.createTimepoints options.timepoints
    progress.createTooltip()

  return

videojs.plugin "progress", vjsProgress
