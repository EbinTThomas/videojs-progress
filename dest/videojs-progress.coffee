"use strict"

$ = jQuery

evoClass = ( className, hasDot ) ->
  return "#{if hasDot then "." else ""}vjs-#{className}"

class Progress
  constructor: ( player ) ->
    @player = player

  createTimepoints: ( data ) ->
    return false if not $.isArray data

    player = @player
    video = $(player.el())
    duration = player.duration()

    delimiter = "-vjs-timepoint-"
    timepoints = []

    container = $("<div />", {
        "class": evoClass "progress-timepoints"
      })

    # 创建时间点
    createTimepoint = ( sec, text ) ->
      pt = $("<div />", {
          "id": "#{video.attr("id")}#{delimiter}#{timepoints.length + 1}"
          "class": evoClass "progress-timepoint"
        })

      timepoints.push {sec, text}

      return pt.css "left", "#{(sec/duration)*100}%"

    # 添加时间点
    $.each data, ( idx, pt ) ->
      container.append(createTimepoint(pt.time, pt.text)) if 0 <= Number(pt.time) <= duration

    player.controlBar.progressControl.el().appendChild container.get(0)

    # 将播放进度调整到指定时间点
    $(evoClass("progress-timepoint", true)).on "click", ->
      player.currentTime timepoints[@id.split(delimiter)[1] - 1].sec

      return false

    return true

  createTooltip: ->
    player = @player
    progress = player.controlBar.progressControl
    duration = player.duration()

    $(progress.el()).on "mousemove", ( event ) ->
      bar = $(progress.el())
      offsetLeft = bar.offset().left
      currentPos = event.clientX
      console.log (currentPos - offsetLeft)/bar.width() * duration
      seekBar = progress.seekBar
      return

    return

vjsProgress = ( options ) ->
  progress = new Progress @

  @on "loadedmetadata", ->
    progress.createTimepoints options.timepoints
    progress.createTooltip()

  return

videojs.plugin "progress", vjsProgress
