vjsProgress = ( options ) ->
  initTimepoints this, options.timepoints

  return

videojs.plugin "progress", vjsProgress
