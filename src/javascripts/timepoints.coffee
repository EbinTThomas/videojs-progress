# 初始化时间点
initTimepoints = ( player, pointsData ) ->
  return false if not $.isArray pointsData

  video = $(player.el())

  TIMEPOINT_ID_DELIMITER = "-vjs-timepoint-"
  timepoints = []

  # 创建时间点
  createTimepoint = ( sec, text ) ->
    pt = $("<div />", {
        "id": "#{video.attr("id")}#{TIMEPOINT_ID_DELIMITER}#{timepoints.length + 1}"
        "class": evoClass "progress-point"
      })

    timepoints.push {sec, text}

    return pt.css "left", "#{(sec/player.duration())*100}%"

  player.on "loadedmetadata", ->
    duration = player.duration()
    container = $("<div />", {
        "class": evoClass "progress-points"
      })

    $.each pointsData, ( idx, pt ) ->
      container.append(createTimepoint(pt.time, pt.text)) if 0 <= Number(pt.time) <= duration

    player.controlBar.progressControl.el().appendChild container.get(0)

    # 将播放进度调整到指定时间点
    $(evoClass("progress-point", true)).on "click", ->
      player.currentTime timepoints[@id.split(TIMEPOINT_ID_DELIMITER)[1] - 1].sec

      return false

  return true
