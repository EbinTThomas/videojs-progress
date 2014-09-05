vjsProgress = ( options ) ->
  progress = new Progress @

  @on "loadedmetadata", ->
    progress.timepoints options?.timepoints
    progress.tooltip()

  return

videojs.plugin "progress", vjsProgress
