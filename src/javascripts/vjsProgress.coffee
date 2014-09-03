"use strict"

evoClass = ( className ) ->
  return "vjs-#{className}--evo"

$ = jQuery

vjsProgressEvo = ( options ) ->
  pts = options.points
  player = this
  video = $(@el())

  control = ->
    return player.controlBar.progressControl

  createPoint = ( sec, text ) ->
    pt = $("<div />", {
        "class": evoClass "progress-point"
        "data-sec": sec,
        "data-text": text
      })

    bar = control().el().appendChild pt.get(0)

    pt.css
      left: "#{(sec/player.duration())*100}%"
      marginLeft: "-#{pt.width()/2}px"

  if $.isArray pts
    @on "loadedmetadata", ->
      duration = @duration()

      $.each pts, ( idx, pt ) ->
        if 0 <= Number(pt.time) <= duration
          createPoint pt.time, pt.text

  return

videojs.plugin "progressEvo", vjsProgressEvo
