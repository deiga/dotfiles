// Monitors
var monLaptop = "1680x1050";
var monTbolt = "2560x1440";

var hyper = "ctrl;shift;alt;cmd"

// Operations
var lapChat = S.op("corner", {
  "screen" : monLaptop,
  "direction" : "top-left",
  "width" : "screenSizeX/9",
  "height" : "screenSizeY"
});
var lapMain = lapChat.dup({ "direction" : "top-right", "width" : "8*screenSizeX/9" });
var tboltFull = S.op("move", {
  "screen" : monTbolt,
  "x" : "screenOriginX",
  "y" : "screenOriginY",
  "width" : "screenSizeX",
  "height" : "screenSizeY"
});
var tboltTop = tboltFull.dup({ "height" : "screenSizeY/2" });
var tboltTopLeft = tboltTop.dup({ "width" : "screenSizeX/2" });
var tboltTopRight = tboltTopLeft.dup({ "x" : "screenOriginX+screenSizeX/2" });
var tboltBottom = tboltTop.dup({ "y" : "screenOriginY+screenSizeY/2" });
var tboltBottomLeft = tboltBottom.dup({ "width" : "screenSizeX/3" });
var tboltBottomMid = tboltBottomLeft.dup({ "x" : "screenOriginX+screenSizeX/3" });
var tboltBottomRight = tboltBottomLeft.dup({ "x" : "screenOriginX+2*screenSizeX/3" });
var tboltLeft = tboltTopLeft.dup({ "height" : "screenSizeY" });
var tboltRight = tboltTopRight.dup({ "height" : "screenSizeY" });

// common layout hashes
var lapMainHash = {
  "operations" : [lapMain],
  "ignore-fail" : true,
  "repeat" : true
};
var tboltTopHash  = {
  "operations" : [tboltTop],
  "repeat" : true
};
var iTermHash = {
  "operations" : [tboltBottomLeft, tboltBottomMid, tboltBottomRight, lapMain],
  "sort-title" : true,
  "repeat-last" : true
};
var genBrowserHash = function(regex) {
  return {
    "operations" : [function(windowObject) {
      var title = windowObject.title();
      if (title !== undefined && title.match(regex)) {
        windowObject.doOperation(hpRight);
      } else {
        windowObject.doOperation(lapMain);
      }
    }],
    "ignore-fail" : true,
    "repeat" : true
  };
}

// 2 monitor layout
var twoMonitorLayout = S.lay("twoMonitor", {
  "iTerm" : iTermHash,
  "Google Chrome" : lapMainHash,
  "SourceTree" : lapMainHash,
  "Spotify" : lapMainHash
});

// 1 monitor layout
var oneMonitorLayout = S.lay("oneMonitor", {
  "iTerm" : lapMainHash,
  "Google Chrome" : lapMainHash,
  "SourceTree" : lapMainHash,
  "Spotify" : lapMainHash
});

S.def([monTbolt, monLaptop], twoMonitorLayout);
S.def([monLaptop], oneMonitorLayout);

// Layout operations
var twoMonitor = S.op("layout", { "name" : twoMonitorLayout });
var oneMonitor = S.op("layout", { "name" : oneMonitorLayout });
var universalLayout = function() {
  // Should probably make sure the resolutions match but w/e
  if (S.screenCount() === 3) {
    threeMonitor.run();
  } else if (S.screenCount() === 2) {
    twoMonitor.run();
  } else if (S.screenCount() === 1) {
    oneMonitor.run();
  }
};

// Batch bind everything. Less typing.
S.bnda({

  // Layout Bindings
  "padEnter:ctrl" : universalLayout,
  "space:ctrl" : universalLayout,

  // Relaunch
  "r:ctrl;shift;alt;cmd" : S.op("relaunch")
});

// Log that we're done configuring
S.log("[SLATE] -------------- Finished Loading Config --------------");
