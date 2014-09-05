"use strict"

$ = jQuery

evoClass = ( className, hasDot ) ->
  return "#{if hasDot then "." else ""}vjs-#{className}"

class Progress
  constructor: ( player ) ->
    @player = player
    @timepoint =
      initialized: false
      delimiter: "-vjs-timepoint-"
      data: []

  timepoints: ( data ) ->
    info = @timepoint

    return false if info.initialized or not $.isArray(data)

    inst = @
    player = @player
    video = $(player.el())
    duration = player.duration()

    delimiter = info.delimiter
    timepoints = info.data

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
      container.append(createTimepoint(Math.round(pt.time), pt.text)) if 0 <= Number(pt.time) <= duration

    player.controlBar.progressControl.el().appendChild container.get(0)

    # 将播放进度调整到指定时间点
    $(evoClass("progress-timepoint", true)).on "click", ->
      player.currentTime inst.timepointData(@id).sec

      return false

    info.initialized = true

    return true

  timepointData: ( id ) ->
    return @timepoint.data[id.split(@timepoint.delimiter)[1] - 1]

  tooltip: ->
    player = @player
    progress = player.controlBar.progressControl
    duration = player.duration()

    tip = $("<div />", {
        "class": evoClass "progress-tooltip"
        "text": "0:00"
      })

    # 给数字补上前导零
    zerofill = ( num ) ->

      num = "0#{num}" if num < 10

      return num

    # 格式化时间
    formatTime = ( time ) ->
      time = Math.round time
      base = 60

      if time < base
        time = "00:#{zerofill time}"
      else
        time = "#{zerofill time//base}:#{zerofill time%base}"

      return time

    progress.el().appendChild tip.get(0)

    $(progress.el()).on
      "mousemove": ( event ) =>
        bar = $(progress.el())

        offsetLeft = event.clientX - bar.offset().left
        target = event.target
        tipText = formatTime offsetLeft/bar.width()*duration

        if $(target).is evoClass("progress-timepoint", true)
          tipText += "<span>#{@timepointData(target.id).text}</span>"

        tip.html tipText
        tip.show()
        tip.css "left", offsetLeft - tip.outerWidth()/2

      "mouseleave": ->
        tip.hide()

    return

vjsProgress = ( options ) ->
  progress = new Progress @

  @on "loadedmetadata", ->
    progress.timepoints options?.timepoints
    progress.tooltip()

  return

videojs.plugin "progress", vjsProgress
