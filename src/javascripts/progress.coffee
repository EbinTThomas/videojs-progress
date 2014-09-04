vjsProgressEvo = ( options ) ->
  player = this
  video = $(@el())

  pts = options.points
  markers = []
  MARKER_ID_DELIMITER = "-vjs-timepoint-"

  # 获取 Video.js 的进度条对象
  control = ->
    return player.controlBar.progressControl

  # 初始化时间点
  initTimepoints = ( pointsData ) ->
    player.on "loadedmetadata", ->
      duration = player.duration()
      container = $("<div />", {
          "class": evoClass "progress-points"
        })

      $.each pointsData, ( idx, pt ) ->
        container.append(createPoint(pt.time, pt.text)) if 0 <= Number(pt.time) <= duration

      control().el().appendChild container.get(0)

      # 将播放进度调整到指定时间点
      $(evoClass("progress-point", true)).on "click", ->
        player.currentTime markers[@id.split(MARKER_ID_DELIMITER)[1] - 1].sec
        return false

  # 创建时间点
  createPoint = ( sec, text ) ->
    pt = $("<div />", {
        "id": "#{video.attr("id")}#{MARKER_ID_DELIMITER}#{markers.length + 1}"
        "class": evoClass "progress-point"
      })

    markers.push { sec, text }

    return pt.css "left", "#{(sec/player.duration())*100}%"

  if $.isArray pts
    initTimepoints pts

  return

videojs.plugin "progressEvo", vjsProgressEvo
