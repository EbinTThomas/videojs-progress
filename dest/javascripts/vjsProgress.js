(function() {
  "use strict";
  var $, evoClass, vjsProgressEvo;

  $ = jQuery;

  evoClass = function(className, hasDot) {
    return "" + (hasDot ? "." : "") + "vjs-" + className + "--evo";
  };

  vjsProgressEvo = function(options) {
    var MARKER_ID_DELIMITER, control, createPoint, initTimepoints, markers, player, pts, video;
    player = this;
    video = $(this.el());
    pts = options.points;
    markers = [];
    MARKER_ID_DELIMITER = "-vjs-timepoint-";
    control = function() {
      return player.controlBar.progressControl;
    };
    initTimepoints = function(pointsData) {
      return player.on("loadedmetadata", function() {
        var container, duration;
        duration = player.duration();
        container = $("<div />", {
          "class": evoClass("progress-points")
        });
        $.each(pointsData, function(idx, pt) {
          var _ref;
          if ((0 <= (_ref = Number(pt.time)) && _ref <= duration)) {
            return container.append(createPoint(pt.time, pt.text));
          }
        });
        control().el().appendChild(container.get(0));
        return $(evoClass("progress-point", true)).on("click", function() {
          player.currentTime(markers[this.id.split(MARKER_ID_DELIMITER)[1] - 1].sec);
          return false;
        });
      });
    };
    createPoint = function(sec, text) {
      var pt;
      pt = $("<div />", {
        "id": "" + (video.attr("id")) + MARKER_ID_DELIMITER + (markers.length + 1),
        "class": evoClass("progress-point")
      });
      markers.push({
        sec: sec,
        text: text
      });
      return pt.css("left", "" + ((sec / player.duration()) * 100) + "%");
    };
    if ($.isArray(pts)) {
      initTimepoints(pts);
    }
  };

  videojs.plugin("progressEvo", vjsProgressEvo);

}).call(this);
