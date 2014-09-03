(function() {
  "use strict";
  var $, evoClass, vjsProgressEvo;

  evoClass = function(className) {
    return "vjs-" + className + "--evo";
  };

  $ = jQuery;

  vjsProgressEvo = function(options) {
    var control, createPoint, player, pts, video;
    pts = options.points;
    player = this;
    video = $(this.el());
    control = function() {
      return player.controlBar.progressControl;
    };
    createPoint = function(sec, text) {
      var bar, pt;
      pt = $("<div />", {
        "class": evoClass("progress-point"),
        "data-sec": sec,
        "data-text": text
      });
      bar = control().el().appendChild(pt.get(0));
      return pt.css({
        left: "" + ((sec / player.duration()) * 100) + "%",
        marginLeft: "-" + (pt.width() / 2) + "px"
      });
    };
    if ($.isArray(pts)) {
      this.on("loadedmetadata", function() {
        var duration;
        duration = this.duration();
        return $.each(pts, function(idx, pt) {
          var _ref;
          if ((0 <= (_ref = Number(pt.time)) && _ref <= duration)) {
            return createPoint(pt.time, pt.text);
          }
        });
      });
    }
  };

  videojs.plugin("progressEvo", vjsProgressEvo);

}).call(this);
