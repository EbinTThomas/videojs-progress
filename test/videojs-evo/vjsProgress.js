(function() {
  "use strict";
  var $, evoClass, vjsProgressEvo;

  $ = jQuery;

  evoClass = function(className) {
    return "vjs-" + className + "--evo";
  };

  vjsProgressEvo = function(options) {
    var control, createPoint, player, pts, video;
    pts = options.points;
    player = this;
    video = $(this.el());
    control = function() {
      return player.controlBar.progressControl;
    };
    createPoint = function(container, sec, text) {
      var pt;
      pt = $("<div />", {
        "class": evoClass("progress-point"),
        "data-sec": sec,
        "data-text": text
      });
      container.append(pt);
      return pt.css({
        left: "" + ((sec / player.duration()) * 100) + "%",
        marginLeft: "-" + (pt.width() / 2) + "px"
      });
    };
    if ($.isArray(pts)) {
      this.on("loadedmetadata", function() {
        var container, duration;
        duration = this.duration();
        container = $("<div />", {
          "class": evoClass("progress-points")
        });
        control().el().appendChild(container.get(0));
        return $.each(pts, function(idx, pt) {
          var _ref;
          if ((0 <= (_ref = Number(pt.time)) && _ref <= duration)) {
            return createPoint(container, pt.time, pt.text);
          }
        });
      });
    }
  };

  videojs.plugin("progressEvo", vjsProgressEvo);

}).call(this);
