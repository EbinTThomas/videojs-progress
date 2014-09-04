vjsProgressEvo = ( options ) ->
  pts = options.points
  player = this
  video = $(@el())

  control = ->
    return player.controlBar.progressControl

  createPoint = ( container, sec, text ) ->
    pt = $("<div />", {
        "class": evoClass "progress-point"
        "data-sec": sec,
        "data-text": text
      })

    container.append pt

    pt.css
      left: "#{(sec/player.duration())*100}%"
      marginLeft: "-#{pt.width()/2}px"

  if $.isArray pts
    @on "loadedmetadata", ->
      duration = @duration()
      container = $("<div />", {
          "class": evoClass "progress-points"
        })

      control().el().appendChild container.get(0)

      $.each pts, ( idx, pt ) ->
        if 0 <= Number(pt.time) <= duration
          createPoint container, pt.time, pt.text

  return

videojs.plugin "progressEvo", vjsProgressEvo
