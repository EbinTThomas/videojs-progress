vjsProgress = ( options ) ->
  initTimepoints @, options.timepoints
  initTooltip @

  return

videojs.plugin "progress", vjsProgress
