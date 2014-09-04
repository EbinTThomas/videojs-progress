(function() {
  "use strict";
  var $, Progress, evoClass, vjsProgress;

  $ = jQuery;

  evoClass = function(className, hasDot) {
    return "" + (hasDot ? "." : "") + "vjs-" + className;
  };

  Progress = (function() {
    function Progress(player) {
      this.player = player;
    }

    Progress.prototype.createTimepoints = function(data) {
      var container, createTimepoint, delimiter, duration, player, timepoints, video;
      if (!$.isArray(data)) {
        return false;
      }
      player = this.player;
      video = $(player.el());
      duration = player.duration();
      delimiter = "-vjs-timepoint-";
      timepoints = [];
      container = $("<div />", {
        "class": evoClass("progress-timepoints")
      });
      createTimepoint = function(sec, text) {
        var pt;
        pt = $("<div />", {
          "id": "" + (video.attr("id")) + delimiter + (timepoints.length + 1),
          "class": evoClass("progress-timepoint")
        });
        timepoints.push({
          sec: sec,
          text: text
        });
        return pt.css("left", "" + ((sec / duration) * 100) + "%");
      };
      $.each(data, function(idx, pt) {
        var _ref;
        if ((0 <= (_ref = Number(pt.time)) && _ref <= duration)) {
          return container.append(createTimepoint(pt.time, pt.text));
        }
      });
      player.controlBar.progressControl.el().appendChild(container.get(0));
      $(evoClass("progress-timepoint", true)).on("click", function() {
        player.currentTime(timepoints[this.id.split(delimiter)[1] - 1].sec);
        return false;
      });
      return true;
    };

    Progress.prototype.createTooltip = function() {
      var duration, player, progress;
      player = this.player;
      progress = player.controlBar.progressControl;
      duration = player.duration();
      $(progress.el()).on("mousemove", function(event) {
        var bar, currentPos, offsetLeft, seekBar;
        bar = $(progress.el());
        offsetLeft = bar.offset().left;
        currentPos = event.clientX;
        console.log((currentPos - offsetLeft) / bar.width() * duration);
        seekBar = progress.seekBar;
      });
    };

    return Progress;

  })();

  vjsProgress = function(options) {
    var progress;
    progress = new Progress(this);
    this.on("loadedmetadata", function() {
      progress.createTimepoints(options.timepoints);
      return progress.createTooltip();
    });
  };

  videojs.plugin("progress", vjsProgress);

}).call(this);
