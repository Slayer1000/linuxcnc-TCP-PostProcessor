/**
  Copyright (C) 2012-2018 by Autodesk, Inc.
  All rights reserved.

  LinuxCNC (EMC2) post processor configuration.

  $Revision: 42049 24365c4692af9ba58117d1ab4b45705fca82c227 $
  $Date: 2019-02-23 11:44:37 $
  
  FORKID {52A5C3D6-1533-413E-B493-7B93D9E48B30}
*/

description = "LinuxCNC - Spangled 20190223 + XYZAC Axis inverse time feed + SK7112022 TCP Anpassungen zur ab und Anwahl";
vendor = "LinuxCNC";
vendorUrl = "http://www.linuxcnc.org";
legal = "Copyright (C) 2012-2018 by Autodesk, Inc.";
certificationLevel = 2;
minimumRevision = 40783;

longDescription = "Milling post for LinuxCNC by Spangled+ A-axis using inverse time feed.";

extension = "ngc";
setCodePage("ascii");

capabilities = CAPABILITY_MILLING;
tolerance = spatial(0.002, MM);

minimumChordLength = spatial(0.01, MM);
minimumCircularRadius = spatial(0.01, MM);
maximumCircularRadius = spatial(1000, MM);
minimumCircularSweep = toRad(0.01);
maximumCircularSweep = toRad(180);
allowHelicalMoves = true;
allowedCircularPlanes = undefined; // allow any circular motion


// user-defined properties
properties = {
  writeMachine: true, // write machine
  writeTools: true, // writes the tools
  preloadTool: true, // preloads next tool on tool change if any
  showSequenceNumbers: false, // show sequence numbers
  sequenceNumberStart: 10, // first sequence number
  sequenceNumberIncrement: 5, // increment for sequence numbers
  optionalStop: true, // optional stop
  separateWordsWithSpace: true, // specifies that the words should be separated with a white space
  useRadius: false, // specifies that arcs should be output using the radius (R word) instead of the I, J, and K words
  useParametricFeed: false, // specifies that feed should be output using Q values
  showNotes: false, // specifies that operation notes should be output
  useG28: false, // turn on to use G28 instead of G53 for machine retracts
  useG64: true, // turn on to enable G64 path blending - Spangled 20190223
  useG64Tolerance: 0.01, // Blending tolerance for G64 P - Spangled 20190223
  useRewindCAxis:false, // use C Axis rewind
  useRewindCAxisEncoder:false, // rewind C axis encoder
  useRewindCAxisSafeRetractDistance: 300.0,  
};

// user-defined property definitions
propertyDefinitions = {
  writeMachine: {title:"Write machine", description:"Output the machine settings in the header of the code.", group:0, type:"boolean"},
  writeTools: {title:"Write tool list", description:"Output a tool list in the header of the code.", group:0, type:"boolean"},
  preloadTool: {title:"Preload tool", description:"Preloads the next tool at a tool change (if any).", type:"boolean"},
  showSequenceNumbers: {title:"Use sequence numbers", description:"Use sequence numbers for each block of outputted code.", group:1, type:"boolean"},
  sequenceNumberStart: {title:"Start sequence number", description:"The number at which to start the sequence numbers.", group:1, type:"integer"},
  sequenceNumberIncrement: {title:"Sequence number increment", description:"The amount by which the sequence number is incremented by in each block.", group:1, type:"integer"},
  optionalStop: {title:"Optional stop", description:"Outputs optional stop code during when necessary in the code.", type:"boolean"},
  separateWordsWithSpace: {title:"Separate words with space", description:"Adds spaces between words if 'yes' is selected.", type:"boolean"},
  useRadius: {title:"Radius arcs", description:"If yes is selected, arcs are outputted using radius values rather than IJK.", type:"boolean"},
  useParametricFeed:  {title:"Parametric feed", description:"Specifies the feed value that should be output using a Q value.", type:"boolean"},
  showNotes: {title:"Show notes", description:"Writes operation notes as comments in the outputted code.", type:"boolean"},
  useG28: {title:"G28 Safe retracts", description:"Disable to avoid G28 output for safe machine retracts. When disabled, you must manually ensure safe retracts.", type:"boolean"},
  useG64: {title:"G64 Path blending", description:"Enable motion blending - be sure to specify P tolerance to maintain accuracy.", type:"boolean"}, //Spangled 20190223  
  useG64Tolerance: {title:"G64 Blending tolerance P", description:"Tolerance value P for G64 motion blending.", type:"number"}, // Spangled 20190223
  useRewindCAxis: {title:"C Axis Rewind", description:"Use C axis rewind for impossible angles.", type:"boolean"}, // 
  useRewindCAxisEncoder: {title:"C Axis Rewind Encoder", description:"Use C axis rewind Encoder", type:"boolean"}, // 
  useRewindCAxisSafeRetractDistance: {title:"C Axis Rewind Safe retract distance", description:"Specifies the distance to add to retract distance when rewinding rotary axes.", type:"spatial"},
   useTCP: {
    title      : "Use TCP mode",
    description: "Enable if the control supports TCPC mode.  This property is ignored if a Machine Configuration is used.",
    group      : "multiAxis",
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  forceHomeOnIndexing: {
    title      : "Save Position for TCP G53",
    description: "Sicheres Position zum für TCP Drehung",
    group      : "multiAxis",
    type       : "boolean",
    value      : true,
    scope      : "post"
  },
    forceHomeOnIndexingvaluex: {
    title      : "Save Position for TCP G53 X value",
    description: "Sicheres Position zum für TCP Drehung in X",
    group      : "multiAxis",
    type       : "spatial",
    value      : 0,
    scope      : "post"
  },
      forceHomeOnIndexingvaluey: {
    title      : "Save Position for TCP G53 Y value",
    description: "Sicheres Position zum für TCP Drehung in Y",
    group      : "multiAxis",
    type       : "spatial",
    value      : 0,
    scope      : "post"
  },
      forceHomeOnIndexingvaluez: {
    title      : "Save Position for TCP G53 Z value",
    description: "Sicheres Position zum für TCP Drehung in Z",
    group      : "multiAxis",
    type       : "spatial",
    value      : -150,
    scope      : "post"
  },
  useTCPDebug: {
    title      : "Debug Mode for TCP",
    description: "Enable Comments.",
    group      : "multiAxis",
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
    useTCPSpeed: {
    title      : "Speed B Axis in TCP Mode",
    description: "Degree per minute.",
    group      : "multiAxis",
    type       : "spatial",
    value      : 250,
    scope      : "post"
  },
    headOffset : {
    title      : "Head Offset B Axis",
    description: "in mm.",
    group      : "multiAxis",
    type       : "spatial",
    value      : 102.5,
    scope      : "post"
  },
};

var permittedCommentChars = " ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,=_-";

// samples:
// throughTool: {on: 88, off: 89}
// throughTool: {on: [8, 88], off: [9, 89]}
var coolants = {
  flood: {on: 8},
  mist: {on: 7},
  throughTool: {},
  air: {},
  airThroughTool: {},
  suction: {},
  floodMist: {},
  floodThroughTool: {},
  off: 9
};

var gFormat = createFormat({prefix:"G", decimals:1});
var mFormat = createFormat({prefix:"M", decimals:1});
var hFormat = createFormat({prefix:"H", decimals:1});
var dFormat = createFormat({prefix:"D", decimals:1});

var xyzFormat = createFormat({decimals:(unit == MM ? 3 : 4), forceDecimal:true});
var rFormat = xyzFormat; // radius
var abcFormat = createFormat({decimals:3, forceDecimal:true, scale:DEG});
var feedFormat = createFormat({decimals:(unit == MM ? 4 : 5), forceDecimal:true});
var pitchFormat = createFormat({decimals:(unit == MM ? 3 : 4), forceDecimal:true});
var toolFormat = createFormat({decimals:0});
var rpmFormat = createFormat({decimals:0});
var secFormat = createFormat({decimals:3, forceDecimal:true}); // seconds - range 0.001-99999.999
var taperFormat = createFormat({decimals:1, scale:DEG});

var xOutput = createVariable({prefix:"X"}, xyzFormat);
var yOutput = createVariable({prefix:"Y"}, xyzFormat);
var zOutput = createVariable({onchange:function () {retracted = false;}, prefix:"Z"}, xyzFormat);
var aOutput = createVariable({prefix:"A"}, abcFormat);
var bOutput = createVariable({prefix:"B"}, abcFormat);
var cOutput = createVariable({prefix:"C"}, abcFormat);
var feedOutput = createVariable({prefix:"F"}, feedFormat);
var inverseTimeOutput = createVariable({prefix:"F", force:true}, feedFormat);
var sOutput = createVariable({prefix:"S", force:true}, rpmFormat);
var dOutput = createVariable({}, dFormat);

// circular output
var iOutput = createReferenceVariable({prefix:"I", force:true}, xyzFormat);
var jOutput = createReferenceVariable({prefix:"J", force:true}, xyzFormat);
var kOutput = createReferenceVariable({prefix:"K", force:true}, xyzFormat);

var gMotionModal = createModal({}, gFormat); // modal group 1 // G0-G3, ...
var gPlaneModal = createModal({onchange:function () {gMotionModal.reset();}}, gFormat); // modal group 2 // G17-19
var gAbsIncModal = createModal({}, gFormat); // modal group 3 // G90-91
var gFeedModeModal = createModal({onchange:function() {gMotionModal.reset();}}, gFormat); // modal group 5 // G93-94
var gUnitModal = createModal({}, gFormat); // modal group 6 // G20-21
var gCycleModal = createModal({}, gFormat); // modal group 9 // G81, ...
var gRetractModal = createModal({}, gFormat); // modal group 10 // G98-99
var gPathControlModal = createModal({}, gFormat); //modal group 13 // G64  //Spangled 20190223

var mTCPModal = createModal({}, mFormat); // M428, M429

// fixed settings
var firstFeedParameter = 100;
var useInverseTimeFeed = true; // enable to use inverse-time feed for multi axis
var maxInverseTime = 45000;

var WARNING_WORK_OFFSET = 0;

// collected state
var sequenceNumber;
var currentWorkOffset;
var forceSpindleSpeed = false;
var activeMovements; // do not use by default
var currentFeedId;
var retracted = false; // specifies that the tool has been retracted to the safe plane
var previousABC = new Vector(0, 0, 0);


/**
  Writes the specified block.
*/
function writeBlock() {
  var text = formatWords(arguments);
  if (!text) {
    return;
  }
  if (properties.showSequenceNumbers) {
    writeWords2("N" + sequenceNumber, arguments);
    sequenceNumber += properties.sequenceNumberIncrement;
    if (sequenceNumber > 99999) {
      sequenceNumber = properties.sequenceNumberStart;
    }
  } else {
    writeWords(arguments);
  }
}

/**
  Writes the specified optional block.
*/
function writeOptionalBlock() {
  if (properties.showSequenceNumbers) {
    var words = formatWords(arguments);
    if (words) {
      writeWords("/", "N" + sequenceNumber, words);
      sequenceNumber += properties.sequenceNumberIncrement;
      if (sequenceNumber > 99999) {
        sequenceNumber = properties.sequenceNumberStart;
      }
    }
  } else {
    writeWords2("/", arguments);
  }
}

function formatComment(text) {
  return "(" + filterText(String(text).toUpperCase(), permittedCommentChars) + ")";
}

/**
  Output a comment.
*/
function writeComment(text) {
  writeln(formatComment(text));
}

function onOpen() {
  if (properties.useRadius) {
    maximumCircularSweep = toRad(90); // avoid potential center calculation errors for CNC
  }


//SK15112022

// internal variables, do not change
var receivedMachineConfiguration;
var operationSupportsTCP;
var multiAxisFeedrate;
// var tcpIsSupported = properties.useTCP;



//SK15112022

  if (true) { // note: setup your machine here
    var useTCP = getProperty("useTCP"); //SK15112022
    // var aAxis = createAxis({coordinate:0, table:true, axis:[-1, 0, 0], offset:[0, 0, 0], cyclic:false, range:[-15,100], preference:0});
    var bAxis = createAxis({coordinate:1, table:false, axis:[0, 1, 0], range:[-90, 90], preference:1, cyclic:false, reset:getProperty("useUnwind") ? 2 : 0, tcp:useTCP});
    // var cAxis = createAxis({coordinate:2, table:true, axis:[0, 0, -1], offset:[0, 0, 0], cyclic:false, range:[-0,360], preference:0});
    machineConfiguration = new MachineConfiguration(bAxis);

    setMachineConfiguration(machineConfiguration);
  if (properties.useTCP) {
        if (properties.useTCPDebug) {
          writeln("( TCP mode enabled optimizeMachineAngles2(0);)");
        }
          optimizeMachineAngles2(0); // TCP mode enabled (eg. M128, TRAORI, G43.4, G243)
    }else 
    {
        if (properties.useTCPDebug) {
      writeln("( TCP mode disable optimizeMachineAngles2(1);)");
        }
      optimizeMachineAngles2(1); 
    }
   // optimizeMachineAngles2(0); // TCP mode enabled (eg. M128, TRAORI, G43.4, G243)
    // optimizeMachineAngles2(1); // TCP mode disable  (eg. M128, TRAORI, G43.4, G243)


    
  }

  if (!machineConfiguration.isMachineCoordinate(0)) {
    aOutput.disable();
  }
  if (!machineConfiguration.isMachineCoordinate(1)) {
    bOutput.disable();
  }
  if (!machineConfiguration.isMachineCoordinate(2)) {
    cOutput.disable();
  }
  
  if (!properties.separateWordsWithSpace) {
    setWordSeparator("");
  }

  sequenceNumber = properties.sequenceNumberStart;
  writeln("%");

  if (programName) {
    writeComment(programName);
  }
  if (programComment) {
    writeComment(programComment);
  }

  //writeln(properties.useTCP);
  if (properties.useTCP) {
    writeln("( TCP is ON selected at Post Processor options)");
    }else {
    writeln("( TCP is OFF selected at Post Processor options)");
    }

  // dump machine configuration
  var vendor = machineConfiguration.getVendor();
  var model = machineConfiguration.getModel();
  var description = machineConfiguration.getDescription();

  if (properties.writeMachine && (vendor || model || description)) {
    writeComment(localize("Machine"));
    if (vendor) {
      writeComment("  " + localize("vendor") + ": " + vendor);
    }
    if (model) {
      writeComment("  " + localize("model") + ": " + model);
    }
    if (description) {
      writeComment("  " + localize("description") + ": "  + description);
    }
  }

  // dump tool information
  if (properties.writeTools) {
    var zRanges = {};
    if (is3D()) {
      var numberOfSections = getNumberOfSections();
      for (var i = 0; i < numberOfSections; ++i) {
        var section = getSection(i);
        var zRange = section.getGlobalZRange();
        var tool = section.getTool();
        if (zRanges[tool.number]) {
          zRanges[tool.number].expandToRange(zRange);
        } else {
          zRanges[tool.number] = zRange;
        }
      }
    }

    var tools = getToolTable();
    if (tools.getNumberOfTools() > 0) {
      for (var i = 0; i < tools.getNumberOfTools(); ++i) {
        var tool = tools.getTool(i);
        var comment = "T" + toolFormat.format(tool.number) + "  " +
          "D=" + xyzFormat.format(tool.diameter) + " " +
          localize("CR") + "=" + xyzFormat.format(tool.cornerRadius);
        if ((tool.taperAngle > 0) && (tool.taperAngle < Math.PI)) {
          comment += " " + localize("TAPER") + "=" + taperFormat.format(tool.taperAngle) + localize("deg");
        }
        if (zRanges[tool.number]) {
          comment += " - " + localize("ZMIN") + "=" + xyzFormat.format(zRanges[tool.number].getMinimum());
        }
        comment += " - " + getToolTypeName(tool.type);
        writeComment(comment);
      }
    }
  }
  
  if (false) {
    // check for duplicate tool number
    for (var i = 0; i < getNumberOfSections(); ++i) {
      var sectioni = getSection(i);
      var tooli = sectioni.getTool();
      for (var j = i + 1; j < getNumberOfSections(); ++j) {
        var sectionj = getSection(j);
        var toolj = sectionj.getTool();
        if (tooli.number == toolj.number) {
          if (xyzFormat.areDifferent(tooli.diameter, toolj.diameter) ||
              xyzFormat.areDifferent(tooli.cornerRadius, toolj.cornerRadius) ||
              abcFormat.areDifferent(tooli.taperAngle, toolj.taperAngle) ||
              (tooli.numberOfFlutes != toolj.numberOfFlutes)) {
            error(
              subst(
                localize("Using the same tool number for different cutter geometry for operation '%1' and '%2'."),
                sectioni.hasParameter("operation-comment") ? sectioni.getParameter("operation-comment") : ("#" + (i + 1)),
                sectionj.hasParameter("operation-comment") ? sectionj.getParameter("operation-comment") : ("#" + (j + 1))
              )
            );
            return;
          }
        }
      }
    }
  }

  if ((getNumberOfSections() > 0) && (getSection(0).workOffset == 0)) {
    for (var i = 0; i < getNumberOfSections(); ++i) {
      if (getSection(i).workOffset > 0) {
        error(localize("Using multiple work offsets is not possible if the initial work offset is 0."));
        return;
      }
    }
  }

  // absolute coordinates, inverse time feed, and incremental arc center mode
  //writeBlock(gAbsIncModal.format(90), gFeedModeModal.format(93), gPlaneModal.format(17), gFormat.format(91.1)); //SK habe ich in G94 geänder G93 muss ich erst ggf. einbauen wenn benötigt
  writeBlock(gAbsIncModal.format(90), gFeedModeModal.format(94), gPlaneModal.format(17), gFormat.format(91.1));
  if (properties.useG64) {															//Spangled 20190223
	writeBlock((gPathControlModal.format(64)) + " P" + properties.useG64Tolerance); //Spangled 20190223
  }																					//Spangled 20190223
  switch (unit) {
  case IN:
    writeBlock(gUnitModal.format(20));
    break;
  case MM:
    writeBlock(gUnitModal.format(21));
    break;
  }
}

function onComment(message) {
  writeComment(message);
}

/** Force output of X, Y, and Z. */
function forceXYZ() {
  xOutput.reset();
  yOutput.reset();
  zOutput.reset();
}

/** Force output of A, B, and C. */
function forceABC() {
  aOutput.reset();
  bOutput.reset();
  cOutput.reset();
}

function forceFeed() {
  currentFeedId = undefined;
  feedOutput.reset();
}

/** Force output of X, Y, Z, A, B, C, and F on next output. */
function forceAny() {
  forceXYZ();
  forceABC();
  forceFeed();
}

//SK15112022 Start

var lengthCompensationActive = false;
function disableLengthCompensation(force) {
  if (lengthCompensationActive || force) {
    writeBlock(gFormat.format(49));
    lengthCompensationActive = false;
  }
}

function setTCPMode(mode) {
  if (properties.useTCPDebug){
writeln("( Zeile 438 TCP ON/OFF => " + properties.useTCP + ")"); //SK15112022
writeln("( Zeile 439 Mode ON/OFF => " + mode + ")");
if (!mode) {
  writeln("( TCP Block wird Uebersprungen da mode = > "  + mode + ")");
}
  }
operationSupportsTCP = properties.useTCP; //SK15112022
  if (operationSupportsTCP) {
    if (mode) {
      validate(lengthCompensationActive, "Length compensation must be active when enabling TCP.");
      if (properties.useTCPDebug){
      writeln("( Zeile 449 TCP => " + operationSupportsTCP  + " // Mode => " + mode + ")" );
      writeln("jetz kommt 428")
      }
      writeBlock(mTCPModal.format(428));
    } else {
      if (properties.useTCPDebug){
      writeln("( Zeile 455 TCP => " + operationSupportsTCP  + " // Mode => " + mode + ")" );
      writeln("(jetz kommt keine 429 ausser ganz am Ende! Wie das geht keine Ahnung verstehe da die Syntax von writeBlock(mTCPModal.format(429)); nicht. Das ist die naechste Zeile. Wie zu sehen kommt im Progtamm keine 429, am Ende aber schon obwohl es in der Schleife die gleiche Stelle ist. In Zeile 952 setzt er die G43 und H die bewirkt das er diesen Bereich richtig anwendet! )" )
      // hier weiß ich nicht warum die 429 nicht geht die 428 würde funktionieren
      //NC code passt aber so
      }
      writeBlock(mTCPModal.format(429));
    }
  }
}
//SK15112022 End
function FeedContext(id, description, feed) {
  this.id = id;
  this.description = description;
  this.feed = feed;
}

function getFeed(f) {
  if (useInverseTimeFeed) {
		forceFeed();
  }
  if (activeMovements) {
    var feedContext = activeMovements[movement];
    if (feedContext != undefined) {
      if (!feedFormat.areDifferent(feedContext.feed, f)) {
        if (feedContext.id == currentFeedId) {
          return ""; // nothing has changed
        }
        forceFeed();
        currentFeedId = feedContext.id;
        return "F#" + (firstFeedParameter + feedContext.id);
      }
    }
    currentFeedId = undefined; // force Q feed next time
  }
  return feedOutput.format(f); // use feed value
}

function initializeActiveFeeds() {
  activeMovements = new Array();
  var movements = currentSection.getMovements();
  
  var id = 0;
  var activeFeeds = new Array();
  if (hasParameter("operation:tool_feedCutting")) {
    if (movements & ((1 << MOVEMENT_CUTTING) | (1 << MOVEMENT_LINK_TRANSITION) | (1 << MOVEMENT_EXTENDED))) {
      var feedContext = new FeedContext(id, localize("Cutting"), getParameter("operation:tool_feedCutting"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_CUTTING] = feedContext;
      activeMovements[MOVEMENT_LINK_TRANSITION] = feedContext;
      activeMovements[MOVEMENT_EXTENDED] = feedContext;
    }
    ++id;
    if (movements & (1 << MOVEMENT_PREDRILL)) {
      feedContext = new FeedContext(id, localize("Predrilling"), getParameter("operation:tool_feedCutting"));
      activeMovements[MOVEMENT_PREDRILL] = feedContext;
      activeFeeds.push(feedContext);
    }
    ++id;
  }
  
  if (hasParameter("operation:finishFeedrate")) {
    if (movements & (1 << MOVEMENT_FINISH_CUTTING)) {
      var feedContext = new FeedContext(id, localize("Finish"), getParameter("operation:finishFeedrate"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_FINISH_CUTTING] = feedContext;
    }
    ++id;
  } else if (hasParameter("operation:tool_feedCutting")) {
    if (movements & (1 << MOVEMENT_FINISH_CUTTING)) {
      var feedContext = new FeedContext(id, localize("Finish"), getParameter("operation:tool_feedCutting"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_FINISH_CUTTING] = feedContext;
    }
    ++id;
  }
  
  if (hasParameter("operation:tool_feedEntry")) {
    if (movements & (1 << MOVEMENT_LEAD_IN)) {
      var feedContext = new FeedContext(id, localize("Entry"), getParameter("operation:tool_feedEntry"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LEAD_IN] = feedContext;
    }
    ++id;
  }

  if (hasParameter("operation:tool_feedExit")) {
    if (movements & (1 << MOVEMENT_LEAD_OUT)) {
      var feedContext = new FeedContext(id, localize("Exit"), getParameter("operation:tool_feedExit"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LEAD_OUT] = feedContext;
    }
    ++id;
  }

  if (hasParameter("operation:noEngagementFeedrate")) {
    if (movements & (1 << MOVEMENT_LINK_DIRECT)) {
      var feedContext = new FeedContext(id, localize("Direct"), getParameter("operation:noEngagementFeedrate"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LINK_DIRECT] = feedContext;
    }
    ++id;
  } else if (hasParameter("operation:tool_feedCutting") &&
             hasParameter("operation:tool_feedEntry") &&
             hasParameter("operation:tool_feedExit")) {
    if (movements & (1 << MOVEMENT_LINK_DIRECT)) {
      var feedContext = new FeedContext(id, localize("Direct"), Math.max(getParameter("operation:tool_feedCutting"), getParameter("operation:tool_feedEntry"), getParameter("operation:tool_feedExit")));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LINK_DIRECT] = feedContext;
    }
    ++id;
  }
  
  if (hasParameter("operation:reducedFeedrate")) {
    if (movements & (1 << MOVEMENT_REDUCED)) {
      var feedContext = new FeedContext(id, localize("Reduced"), getParameter("operation:reducedFeedrate"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_REDUCED] = feedContext;
    }
    ++id;
  }

  if (hasParameter("operation:tool_feedRamp")) {
    if (movements & ((1 << MOVEMENT_RAMP) | (1 << MOVEMENT_RAMP_HELIX) | (1 << MOVEMENT_RAMP_PROFILE) | (1 << MOVEMENT_RAMP_ZIG_ZAG))) {
      var feedContext = new FeedContext(id, localize("Ramping"), getParameter("operation:tool_feedRamp"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_RAMP] = feedContext;
      activeMovements[MOVEMENT_RAMP_HELIX] = feedContext;
      activeMovements[MOVEMENT_RAMP_PROFILE] = feedContext;
      activeMovements[MOVEMENT_RAMP_ZIG_ZAG] = feedContext;
    }
    ++id;
  }
  if (hasParameter("operation:tool_feedPlunge")) {
    if (movements & (1 << MOVEMENT_PLUNGE)) {
      var feedContext = new FeedContext(id, localize("Plunge"), getParameter("operation:tool_feedPlunge"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_PLUNGE] = feedContext;
    }
    ++id;
  }
  if (true) { // high feed
    if (movements & (1 << MOVEMENT_HIGH_FEED)) {
      var feedContext = new FeedContext(id, localize("High Feed"), this.highFeedrate);
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_HIGH_FEED] = feedContext;
    }
    ++id;
  }
  
  for (var i = 0; i < activeFeeds.length; ++i) {
    var feedContext = activeFeeds[i];
    writeBlock("#" + (firstFeedParameter + feedContext.id) + "=" + feedFormat.format(feedContext.feed), formatComment(feedContext.description));
  }
}

var currentWorkPlaneABC = undefined;

function forceWorkPlane() {
  currentWorkPlaneABC = undefined;
}

function setWorkPlane(abc) {
   if (properties.useTCPDebug){
   writeln("( Eingang setWorkPlane Zeile 618 )");
      writeln("( Vector abc => " + abc + " )");
   }
  if (!machineConfiguration.isMultiAxisConfiguration()) {
       if (properties.useTCPDebug){
      writeln("( setWorkPlane !machineConfiguration.isMultiAxisConfiguration() Zeile 618 )");
       } 
    return; // ignore
  }

  if (!((currentWorkPlaneABC == undefined) ||
        abcFormat.areDifferent(abc.x, currentWorkPlaneABC.x) ||
        abcFormat.areDifferent(abc.y, currentWorkPlaneABC.y) ||
        abcFormat.areDifferent(abc.z, currentWorkPlaneABC.z))) {
             if (properties.useTCPDebug){
              writeln("( setWorkPlane !((currentWorkPlaneABC == undefined)  Zeile 618 )");
              }
    return; // no change
  }

    if (getProperty("useParkPositionOperation") && (getCurrentSectionId() >= 0)) { // only if we are between operations
                 if (properties.useTCPDebug){
                writeln("( setWorkPlane getProperty(useParkPositionOperation) && (getCurrentSectionId()  Zeile 636)");
                }
    var aDelta = Math.abs(abc.x - (currentWorkPlaneABC ? currentWorkPlaneABC.x : 0));
                 if (properties.useTCPDebug){
                  writeln("( setWorkPlane Zeile 644 var aDelta => "+ aDelta + "  )");
                  }

    if (aDelta > toRad(getProperty("maximumAAxisChange"))) {
                if (properties.useTCPDebug){
                writeln("( setWorkPlane aDelta > toRad  Zeile 642)");
                }
      setTCPMode(false);
      writeRetract(X, Y);
    }
  }

  onCommand(COMMAND_UNLOCK_MULTI_AXIS);

  if (!retracted) {
    writeRetract(Z);
  }
  
                   if (properties.useTCPDebug){
                  writeln("( setWorkPlane Zeile 663 )");
                  }
  gMotionModal.reset();
  writeBlock(
    // gMotionModal.format(0),
    gMotionModal.format(1),
    conditional(machineConfiguration.isMachineCoordinate(0), "A" + abcFormat.format(abc.x)),
    conditional(machineConfiguration.isMachineCoordinate(1), "B" + abcFormat.format(abc.y)),
    conditional(machineConfiguration.isMachineCoordinate(2), "C" + abcFormat.format(abc.z)), "F"+ properties.useTCPSpeed
  );

/**
  if (abc.x == 0) {
    writeBlock(mFormat.format(429));
  } else {
    writeBlock(mFormat.format(428));
  }
*/

  onCommand(COMMAND_LOCK_MULTI_AXIS);

  currentWorkPlaneABC = abc;
}

var closestABC = false; // choose closest machine angles
var currentMachineABC;

function getWorkPlaneMachineABC(workPlane) {
  var W = workPlane; // map to global frame
 // tcpIsSupported = true;
 // var tcp = tcpIsSupported; //SK15112022
 // var tcpIsSupported = properties.useTCP;


  var abc = machineConfiguration.getABC(W);
  if (closestABC) {
    if (currentMachineABC) {
      abc = machineConfiguration.remapToABC(abc, currentMachineABC);
    } else {
      abc = machineConfiguration.getPreferredABC(abc);
    }
  } else {
    abc = machineConfiguration.getPreferredABC(abc);
  }
  
  try {
    abc = machineConfiguration.remapABC(abc);
    currentMachineABC = abc;
  } catch (e) {
    error(
      localize("Machine angles not supported") + ":"
      + conditional(machineConfiguration.isMachineCoordinate(0), " A" + abcFormat.format(abc.x))
      + conditional(machineConfiguration.isMachineCoordinate(1), " B" + abcFormat.format(abc.y))
      + conditional(machineConfiguration.isMachineCoordinate(2), " C" + abcFormat.format(abc.z))
    );
  }
  
  var direction = machineConfiguration.getDirection(abc);
  if (!isSameDirection(direction, W.forward)) {
    error(localize("Orientation not supported."));
  }
  
  if (!machineConfiguration.isABCSupported(abc)) {
    error(
      localize("Work plane is not supported") + ":"
      + conditional(machineConfiguration.isMachineCoordinate(0), " A" + abcFormat.format(abc.x))
      + conditional(machineConfiguration.isMachineCoordinate(1), " B" + abcFormat.format(abc.y))
      + conditional(machineConfiguration.isMachineCoordinate(2), " C" + abcFormat.format(abc.z))
    );
  }

  // var tcp = false;
  if (properties.useTCP) {
    setRotation(W); // TCP mode
  } else {
    var O = machineConfiguration.getOrientation(abc);
    var R = machineConfiguration.getRemainingOrientation(abc, W);
    setRotation(R);
  }
  
  return abc;
}

function isProbeOperation() {
  return hasParameter("operation-strategy") && (getParameter("operation-strategy") == "probe");
}

function onSection() {
   // writeBlock(mFormat.format(429));
   var useTCP = properties.useTCP; //locale variable
   if (properties.useTCPDebug){
   writeln("( Zeile 730 lokale useTCP => "+ useTCP + ")");
   }
   if (useTCP) {
    if (properties.useTCPDebug){
       //validate(lengthCompensationActive, "Length compensation must be active when enabling TCP.");
       writeln("( Zeile 735 TCP = ON )");
       //writeln("( TCP = ON )");
    }
       writeBlock(mTCPModal.format(429));
     } else {
      if (properties.useTCPDebug){
      writeln("( Zeile 741 TCP = OFF )");
       // writeln("( TCP = OFF )");
      }
       writeBlock(mTCPModal.format(428));
     }

  var insertToolCall = isFirstSection() ||
    currentSection.getForceToolChange && currentSection.getForceToolChange() ||
    (tool.number != getPreviousSection().getTool().number);
  
  retracted = false;
  var newWorkOffset = isFirstSection() ||
    (getPreviousSection().workOffset != currentSection.workOffset); // work offset changes
  var newWorkPlane = isFirstSection() ||
    !isSameDirection(getPreviousSection().getGlobalFinalToolAxis(), currentSection.getGlobalInitialToolAxis()) ||
    (currentSection.isOptimizedForMachine() && getPreviousSection().isOptimizedForMachine() &&
      Vector.diff(getPreviousSection().getFinalToolAxisABC(), currentSection.getInitialToolAxisABC()).length > 1e-4) ||
    (!machineConfiguration.isMultiAxisConfiguration() && currentSection.isMultiAxis()) ||
    (!getPreviousSection().isMultiAxis() && currentSection.isMultiAxis() ||
      getPreviousSection().isMultiAxis() && !currentSection.isMultiAxis()); // force newWorkPlane between indexing and simultaneous operations
  if (insertToolCall || newWorkOffset || newWorkPlane) {
    
    // stop spindle before retract during tool change
    if (insertToolCall && !isFirstSection()) {
      onCommand(COMMAND_STOP_SPINDLE);
    }
    
    // retract to safe plane
    setTCPMode(false); //SK15112022
    writeRetract(Z);
  }

  if (hasParameter("operation-comment")) {
    var comment = getParameter("operation-comment");
    if (comment) {
      writeComment(comment);
    }
  }
  
  if (properties.showNotes && hasParameter("notes")) {
    var notes = getParameter("notes");
    if (notes) {
      var lines = String(notes).split("\n");
      var r1 = new RegExp("^[\\s]+", "g");
      var r2 = new RegExp("[\\s]+$", "g");
      for (line in lines) {
        var comment = lines[line].replace(r1, "").replace(r2, "");
        if (comment) {
          writeComment(comment);
        }
      }
    }
  }
  
  if (insertToolCall) {
    forceWorkPlane();
    
    setCoolant(COOLANT_OFF);
  
    if (!isFirstSection() && properties.optionalStop) {
      onCommand(COMMAND_OPTIONAL_STOP);
    }

    if (tool.number > 99) {
      warning(localize("Tool number exceeds maximum value."));
    }
//SK15112022 Start
    setTCPMode(false);
    disableLengthCompensation(false);
    onCommand(COMMAND_STOP_SPINDLE);
//SK15112022 End

    if (tool.comment) {
	  writeComment("DEBUG, Change to " + (tool.comment) + " then click Resume");  //Spangled 20190223
      //writeComment(tool.comment);												  //Spangled 20190223
    }
    writeBlock("T" + toolFormat.format(tool.number), mFormat.format(6));
    var showToolZMin = false;
    if (showToolZMin) {
      if (is3D()) {
        var numberOfSections = getNumberOfSections();
        var zRange = currentSection.getGlobalZRange();
        var number = tool.number;
        for (var i = currentSection.getId() + 1; i < numberOfSections; ++i) {
          var section = getSection(i);
          if (section.getTool().number != number) {
            break;
          }
          zRange.expandToRange(section.getGlobalZRange());
        }
        writeComment(localize("ZMIN") + "=" + zRange.getMinimum());
      }
    }

    if (properties.preloadTool) {
      var nextTool = getNextTool(tool.number);
      if (nextTool) {
        writeBlock("T" + toolFormat.format(nextTool.number));
      } else {
        // preload first tool
        var section = getSection(0);
        var firstToolNumber = section.getTool().number;
        if (tool.number != firstToolNumber) {
          writeBlock("T" + toolFormat.format(firstToolNumber));
        }
      }
    }
  }
  
  if (insertToolCall ||
      forceSpindleSpeed ||
      isFirstSection() ||
      (rpmFormat.areDifferent(spindleSpeed, sOutput.getCurrent())) ||
      (tool.clockwise != getPreviousSection().getTool().clockwise)) {
    forceSpindleSpeed = false;
    
    if (spindleSpeed < 1) {
      error(localize("Spindle speed out of range."));
      return;
    }
    if (spindleSpeed > 99999) {
      warning(localize("Spindle speed exceeds maximum value."));
    }
    writeBlock(
      sOutput.format(spindleSpeed), mFormat.format(tool.clockwise ? 3 : 4)
    );
  }

  // wcs
  if (insertToolCall) { // force work offset when changing tool
    currentWorkOffset = undefined;
  }
  var workOffset = currentSection.workOffset;
  if (workOffset == 0) {
    warningOnce(localize("Work offset has not been specified. Using G54 as WCS."), WARNING_WORK_OFFSET);
    workOffset = 1;
  }
  if (workOffset > 0) {
    if (workOffset > 6) {
      var p = workOffset - 6; // 1->...
      if (p > 3) {
        error(localize("Work offset out of range."));
        return;
      } else {
        if (workOffset != currentWorkOffset) {
          writeBlock(gFormat.format(59.1), "P" + p); // G59.1P
          currentWorkOffset = workOffset;
        }
      }
    } else {
      if (workOffset != currentWorkOffset) {
        writeBlock(gFormat.format(53 + workOffset)); // G54->G59
        currentWorkOffset = workOffset;
      }
    }
  }

  //SK15112022 Start
  if (newWorkPlane || (insertToolCall && !retracted)) { // go to home position for safety
    if (properties.useTCPDebug){
      writeln("Zeile 901 Schleife TCP Homing - !retract => " + retracted);
    }
    if (!retracted) {
      retracted = true;
      if (properties.useTCPDebug){
        writeln("Zeile 903 Schleife TCP Homing - in !retract Schleife");
      }
      if (properties.useG28) {
        writeBlock(gFormat.format(28), gAbsIncModal.format(91), "Z" + xyzFormat.format(0));
      } else {
        gMotionModal.reset();
        writeBlock(gAbsIncModal.format(90), gFormat.format(53), gMotionModal.format(0), "Z" + xyzFormat.format(machineConfiguration.getRetractPlane()));
      }
      writeBlock(gAbsIncModal.format(90));
      zOutput.reset();
    }
    if (properties.useTCPDebug){
      writeln("Zeile 918 Schleife TCP Homing nach !retract Schleife");
    }
    if (properties.forceHomeOnIndexing) { // e.g. when machining very big parts
      writeBlock(
        gAbsIncModal.format(90), gFormat.format(53), gMotionModal.format(0),
        "X" + xyzFormat.format(machineConfiguration.hasHomePositionX() ? machineConfiguration.getHomePositionX() : properties.forceHomeOnIndexingvaluex),
        "Y" + xyzFormat.format(machineConfiguration.hasHomePositionY() ? machineConfiguration.getHomePositionY() : properties.forceHomeOnIndexingvaluey),
        "Z" + xyzFormat.format(machineConfiguration.hasHomePositionZ() ? machineConfiguration.getHomePositionZ() : properties.forceHomeOnIndexingvaluez)
      ); // Safe tool position
    }
  }
  //SK15112022 End
  forceXYZ();

  if (machineConfiguration.isMultiAxisConfiguration()) { // use 5-axis indexing for multi-axis mode
    // set working plane after datum shift

    var abc = new Vector(0, 0, 0);
    if (currentSection.isMultiAxis()) {
//      forceWorkPlane();
      cancelTransformation();
    } else {
      abc = getWorkPlaneMachineABC(currentSection.workPlane);
    }
    setWorkPlane(abc);
  } else { // pure 3D
    var remaining = currentSection.workPlane;
    if (!isSameDirection(remaining.forward, new Vector(0, 0, 1))) {
      error(localize("Tool orientation is not supported."));
      return;
    }
    setRotation(remaining);
  }

  // set coolant after we have positioned at Z
  setCoolant(tool.coolant);

  forceAny();
  gMotionModal.reset();

  var initialPosition = getFramePosition(currentSection.getInitialPosition());
  if (!retracted && !insertToolCall) {
    if (getCurrentPosition().z < initialPosition.z) {
      writeBlock(gMotionModal.format(0), zOutput.format(initialPosition.z));
    }
  }

  if (insertToolCall || retracted || (!isFirstSection() && getPreviousSection().isMultiAxis())) {
    var lengthOffset = tool.lengthOffset;
    if (lengthOffset > 99) {
      error(localize("Length offset out of range."));
      return;
    }

  // SK15112022 Start

 // operationSupportsTCP = true;
  //if (!currentSection.isMultiAxis() && (useMultiAxisFeatures || isSameDirection(machineConfiguration.getSpindleAxis(), currentSection.workPlane.forward))) {
 //   operationSupportsTCP = false;
 // }
 
  // set coolant after we have positioned at Z
  setCoolant(tool.coolant);
 
  forceAny();
  gMotionModal.reset();
 
  var lengthOffset = tool.lengthOffset;
  if (lengthOffset > 99) {
    error(localize("Length offset out of range."));
    return;
  }
 
  // tool length compensation needs to be enabled prior to enabling TCP
  if (!lengthCompensationActive) {
        if (properties.useTCPDebug){
      writeln("Zeile 1045 Schleife G43");
    }
    writeBlock(gFormat.format(43), hFormat.format(lengthOffset));
    lengthCompensationActive = true;
  }
  // SK15112022 End
 

    gMotionModal.reset();
    writeBlock(gPlaneModal.format(17));
    
    if (!machineConfiguration.isHeadConfiguration()) {
      writeBlock(
        gAbsIncModal.format(90),
        //Zeile 818 Z hinzugefügt
        gMotionModal.format(0), xOutput.format(initialPosition.x), yOutput.format(initialPosition.y) , zOutput.format(initialPosition.z)
      );
      // writeBlock(gMotionModal.format(0), gFormat.format(43), zOutput.format(initialPosition.z), hFormat.format(lengthOffset));
    } else {
      writeBlock(
        gAbsIncModal.format(90),
        gMotionModal.format(0),
        // gFormat.format(43), xOutput.format(initialPosition.x),
        yOutput.format(initialPosition.y),
        //zOutput.format(initialPosition.z), hFormat.format(lengthOffset)
                zOutput.format(initialPosition.z)
      );
    }

    gMotionModal.reset();
  } else {
    writeBlock(
      gAbsIncModal.format(90),
      gMotionModal.format(0),
      xOutput.format(initialPosition.x),
      yOutput.format(initialPosition.y)
    );
  }
  //SK15112022 Start
    if (operationSupportsTCP) {
      if (properties.useTCPDebug){
        writeln("Zeile 1021 Schleife setTCPMode(true) da operationSupportsTCP => "+ operationSupportsTCP);
      }
    setTCPMode(true);
  }
  //SK15112022 End


  if (properties.useParametricFeed &&
      hasParameter("operation-strategy") &&
      (getParameter("operation-strategy") != "drill") && // legacy
      !useInverseTimeFeed &&
      !(currentSection.hasAnyCycle && currentSection.hasAnyCycle())) {
    if (!insertToolCall &&
        activeMovements &&
        (getCurrentSectionId() > 0) &&
        ((getPreviousSection().getPatternId() == currentSection.getPatternId()) && (currentSection.getPatternId() != 0))) {
      // use the current feeds
    } else {
      initializeActiveFeeds();
    }
  } else {
    activeMovements = undefined;
  }
}

function onDwell(seconds) {
  if (seconds > 99999.999) {
    warning(localize("Dwelling time is out of range."));
  }
  writeBlock(gFeedModeModal.format(94), gFormat.format(4), "P" + secFormat.format(seconds));
}

function onSpindleSpeed(spindleSpeed) {
  writeBlock(sOutput.format(spindleSpeed));
}

function onCycle() {
  writeBlock(gPlaneModal.format(17));
}

function getCommonCycle(x, y, z, r) {
  forceXYZ(); // force xyz on first drill hole of any cycle
  return [xOutput.format(x), yOutput.format(y),
    zOutput.format(z),
    "R" + xyzFormat.format(r)];
}

function onCyclePoint(x, y, z) {
  switch (cycleType) {
  case "tapping":
  case "left-tapping":
  case "right-tapping":
    cycleExpanded = false;
    repositionToCycleClearance(cycle, x, y, z);
    writeBlock(
      gAbsIncModal.format(90), gMotionModal.format(0),
      conditional(gPlaneModal.getCurrent() == 17, zOutput.format(cycle.retract)),
      conditional(gPlaneModal.getCurrent() == 18, yOutput.format(cycle.retract)),
      conditional(gPlaneModal.getCurrent() == 19, xOutput.format(cycle.retract))
    );
    writeBlock(
      gAbsIncModal.format(90), gFormat.format(33.1),
      conditional(gPlaneModal.getCurrent() == 17, zOutput.format(z)),
      conditional(gPlaneModal.getCurrent() == 18, yOutput.format(y)),
      conditional(gPlaneModal.getCurrent() == 19, xOutput.format(x)),
      "K" + pitchFormat.format(tool.threadPitch)
    );
    gMotionModal.reset();
    writeBlock(
      gAbsIncModal.format(90), gMotionModal.format(0),
      conditional(gPlaneModal.getCurrent() == 17, zOutput.format(cycle.clearance)),
      conditional(gPlaneModal.getCurrent() == 18, yOutput.format(cycle.clearance)),
      conditional(gPlaneModal.getCurrent() == 19, xOutput.format(cycle.clearance))
    );
    return;
  /*
  case "tapping-with-chip-breaking":
  case "left-tapping-with-chip-breaking":
  case "right-tapping-with-chip-breaking":
  */
  }

  if (isFirstCyclePoint()) {
    cycleExpanded = true;
    repositionToCycleClearance(cycle, x, y, z);
    
    // return to initial Z which is clearance plane and set absolute mode

    var F = cycle.feedrate;
    var P = !cycle.dwell ? 0 : clamp(0.001, cycle.dwell, 99999999); // in seconds

    switch (cycleType) {
    case "drilling":
      writeBlock(
				gFeedModeModal.format(94), gMotionModal.format(1),
        //gRetractModal.format(98), gAbsIncModal.format(90), gCycleModal.format(81),
        //getCommonCycle(x, y, z, cycle.retract),
        xOutput.format(x), yOutput.format(y),zOutput.format(z),
        feedOutput.format(F)
      );
      break;
    case "counter-boring":
      if (P > 0) {
        writeBlock(
					gFeedModeModal.format(94), 
          gRetractModal.format(98), gAbsIncModal.format(90), gCycleModal.format(82),
          getCommonCycle(x, y, z, cycle.retract),
          "P" + secFormat.format(P),
          feedOutput.format(F)
        );
      } else {
        writeBlock(
					gFeedModeModal.format(94), 
          gRetractModal.format(98), gAbsIncModal.format(90), gCycleModal.format(81),
          getCommonCycle(x, y, z, cycle.retract),
          feedOutput.format(F)
        );
      }
      break;
    case "chip-breaking":
      expandCyclePoint(x, y, z);
      break;
    case "deep-drilling":
      if (P > 0) {
        expandCyclePoint(x, y, z);
      } else {
        writeBlock(
					gFeedModeModal.format(94), 
          gRetractModal.format(98), gAbsIncModal.format(90), gCycleModal.format(83),
          getCommonCycle(x, y, z, cycle.retract),
          "Q" + xyzFormat.format(cycle.incrementalDepth),
          // conditional(P > 0, "P" + secFormat.format(P)),
          feedOutput.format(F)
        );
      }
      break;
    case "fine-boring":
      expandCyclePoint(x, y, z);
      break;
    /* // not supported
    case "back-boring":
      var dx = (gPlaneModal.getCurrent() == 19) ? cycle.backBoreDistance : 0;
      var dy = (gPlaneModal.getCurrent() == 18) ? cycle.backBoreDistance : 0;
      var dz = (gPlaneModal.getCurrent() == 17) ? cycle.backBoreDistance : 0;
      writeBlock(
        gRetractModal.format(98), gAbsIncModal.format(90), gCycleModal.format(87),
        getCommonCycle(x - dx, y - dy, z - dz, cycle.bottom),
        "Q" + xyzFormat.format(cycle.shift),
        "P" + secFormat.format(P), // not optional
        feedOutput.format(F)
      );
      break;
    */
    case "reaming":
      if (P > 0) {
        writeBlock(
					gFeedModeModal.format(94), 
          gRetractModal.format(98), gAbsIncModal.format(90), gCycleModal.format(89),
          getCommonCycle(x, y, z, cycle.retract),
          "P" + secFormat.format(P),
          feedOutput.format(F)
        );
      } else {
        writeBlock(
					gFeedModeModal.format(94), 
          gRetractModal.format(98), gAbsIncModal.format(90), gCycleModal.format(85),
          getCommonCycle(x, y, z, cycle.retract),
          feedOutput.format(F)
        );
      }
      break;
    case "stop-boring":
      writeBlock(
				gFeedModeModal.format(94), 
        gRetractModal.format(98), gAbsIncModal.format(90), gCycleModal.format(86),
        getCommonCycle(x, y, z, cycle.retract),
        conditional(P > 0, "P" + secFormat.format(P)),
        feedOutput.format(F)
      );
      break;
    case "manual-boring":
      writeBlock(
				gFeedModeModal.format(94), 
        gRetractModal.format(98), gAbsIncModal.format(90), gCycleModal.format(88),
        getCommonCycle(x, y, z, cycle.retract),
        "P" + secFormat.format(P), // not optional
        feedOutput.format(F)
      );
      break;
    case "boring":
      if (P > 0) {
        writeBlock(
					gFeedModeModal.format(94), 
          gRetractModal.format(98), gAbsIncModal.format(90), gCycleModal.format(89),
          getCommonCycle(x, y, z, cycle.retract),
          "P" + secFormat.format(P), // not optional
          feedOutput.format(F)
        );
      } else {
        writeBlock(
					gFeedModeModal.format(94), 
          gRetractModal.format(98), gAbsIncModal.format(90), gCycleModal.format(85),
          getCommonCycle(x, y, z, cycle.retract),
          feedOutput.format(F)
        );
      }
      break;
    default:
      expandCyclePoint(x, y, z);
    }
  } else {
    if (cycleExpanded) {
      expandCyclePoint(x, y, z);
    } else {
      var _x = xOutput.format(x);
      var _y = yOutput.format(y);
      var _z = zOutput.format(z);
      if (!_x && !_y && !_z) {
        switch (gPlaneModal.getCurrent()) {
        case 17: // XY
          xOutput.reset(); // at least one axis is required
          _x = xOutput.format(x);
          break;
        case 18: // ZX
          zOutput.reset(); // at least one axis is required
          _z = zOutput.format(z);
          break;
        case 19: // YZ
          yOutput.reset(); // at least one axis is required
          _y = yOutput.format(y);
          break;
        }
      }
      writeBlock(_x, _y, _z);
    }
  }
}

function onCycleEnd() {
  if (!cycleExpanded) {
    writeBlock(gCycleModal.format(80));
    gMotionModal.reset();
  }
}

var pendingRadiusCompensation = -1;

function onRadiusCompensation() {
  pendingRadiusCompensation = radiusCompensation;
}

function onRapid(_x, _y, _z) {
    if (properties.useTCPDebug){
  writeln("( onRapid Zeile 1283 )");
    }
  var x = xOutput.format(_x);
  var y = yOutput.format(_y);
  var z = zOutput.format(_z);
  if (x || y || z) {
    if (pendingRadiusCompensation >= 0) {
      error(localize("Radius compensation mode cannot be changed at rapid traversal."));
      return;
    }
    writeBlock(gMotionModal.format(0), x, y, z);
    forceFeed();
  }
}

function onLinear(_x, _y, _z, feed) {
  var x = xOutput.format(_x);
  var y = yOutput.format(_y);
  var z = zOutput.format(_z);
  var f = feedOutput.format(feed);
  if (x || y || z) {
    if (pendingRadiusCompensation >= 0) {
      pendingRadiusCompensation = -1;
      var d = tool.diameterOffset;
      if (d > 99) {
        warning(localize("The diameter offset exceeds the maximum value."));
      }
      writeBlock(gPlaneModal.format(17));
      switch (radiusCompensation) {
      case RADIUS_COMPENSATION_LEFT:
        dOutput.reset();
        writeBlock(gFeedModeModal.format(94), gMotionModal.format(1), gFormat.format(41), x, y, z, dOutput.format(d), f);
        break;
      case RADIUS_COMPENSATION_RIGHT:
        dOutput.reset();
        writeBlock(gFeedModeModal.format(94), gMotionModal.format(1), gFormat.format(42), x, y, z, dOutput.format(d), f);
        break;
      default:
        writeBlock(gFeedModeModal.format(94), gMotionModal.format(1), gFormat.format(40), x, y, z, f);
      }
    } else {
      writeBlock(gFeedModeModal.format(94), gMotionModal.format(1), x, y, z, f);
    }
  } else if (f) {
    if (getNextRecord().isMotion()) { // try not to output feed without motion
      forceFeed(); // force feed on next line
    } else {
      writeBlock(gFeedModeModal.format(94), gMotionModal.format(1), f);
    }
  }
}


// Start of multi-axis feedrate logic
/***** Be sure to add 'useInverseTime' to post properties if necessary. *****/
/***** 'inverseTimeOutput' must be defined. *****/
/***** 'headOffset' should be defined when a head rotary axis is defined. *****/
var headOffset = properties.headOffset;
/***** The feedrate mode must be included in motion block output (linear, circular, etc. *****/
var dpmBPW = 0.1; // ratio of rotary accuracy to linear accuracy for DPM calculations
var inverseTimeUnits = 1.0; // 1.0 = minutes, 60.0 = seconds
var maxInverseTime = 999999; // maximum value to output for Inverse Time feeds

/** Calculate the multi-axis feedrate number. */
function getMultiaxisFeed(_x, _y, _z, _a, _b, _c, feed) {
    if (properties.useTCPDebug){
      writeln(" ( getMultiaxisFeed Zeile 1348 )");
    }
  var f = {frn:0, fmode:0};
  if (feed <= 0) {
    error(localize("Feedrate is less than or equal to 0."));
    return f;
  }

  var length = getMoveLength(_x, _y, _z, _a, _b, _c);

  if (true) { // inverse time
    f.frn = inverseTimeOutput.format(getInverseTime(length, feed));
    f.fmode = 93;
    feedOutput.reset();
  } else { // degrees per minute
    f.frn = feedOutput.format(getFeedDPM(length, feed));
    f.fmode = 94;
  }
  return f;
}

/** Calculate the DPM feedrate number. */
function getFeedDPM(_moveLength, _feed) {
  // moveLength[0] = Tool tip, [1] = XYZ, [2] = ABC

  if (false) { // TCP mode is supported, output feed as FPM
    return feed;
  } else { // DPM feedrate calculation
    var moveTime = ((_moveLength[0] < 1.e-6) ? 0.001 : _moveLength[0]) / _feed;
    var length = Math.sqrt(Math.pow(_moveLength[1], 2.0) + Math.pow((toDeg(_moveLength[2]) * dpmBPW), 2.0));
    return length / moveTime;
  }
}

/** Calculate the Inverse time feedrate number. */
function getInverseTime(_length, _feed) {
  var inverseTime;
  if (_length < 1.e-6) { // tool doesn't move
    if (typeof maxInverseTime === "number") {
      inverseTime = maxInverseTime;
    } else {
      inverseTime = 999999;
    }
  } else {
    inverseTime = _feed / _length / inverseTimeUnits;
    if (typeof maxInverseTime === "number") {
      if (inverseTime > maxInverseTime) {
        inverseTime = maxInverseTime;
      }
    }
  }
  return inverseTime;
}

/** Calculate the distance of the tool position to the center of a rotary axis. */
function getRotaryRadius(center, direction, toolPosition) {
  var normal = direction.getNormalized();
  var d1 = toolPosition.x - center.x;
  var d2 = toolPosition.y - center.y;
  var d3 = toolPosition.z - center.z;
  var radius = Math.sqrt(
    Math.pow((d1 * normal.y) - (d2 * normal.x), 2.0) +
    Math.pow((d2 * normal.z) - (d3 * normal.y), 2.0) +
    Math.pow((d3 * normal.x) - (d1 * normal.z), 2.0)
   );
  return radius;
}

/** Calculate the linear distance based on the rotation of a rotary axis. */
function getRadialDistance(axis, startTool, endTool, startABC, endABC) {
  // rotary axis does not exist
  if (!axis.isEnabled()) {
    return 0.0;
  }

  // calculate the rotary center based on head/table
  var center;
  if (axis.isHead()) {
    var pivot;
    writeln("Headoffset => "+ headOffset + "mm")
    if (typeof headOffset === "number") {
      pivot = headOffset;
    } else {
      pivot = tool.getBodyLength();
    }
    center = Vector.sum(startTool, Vector.product(machineConfiguration.getSpindleAxis(), pivot));
    center = Vector.sum(center, axis.getOffset());
  } else {
    center = axis.getOffset();
  }
/*
 * I don't understand why the center is not in (0,0,0) or (some number, 0, 0)
 
	center.x=0;
	center.y=0;
	center.z=0;
*/	
  // calculate the radius of the tool end point compared to the rotary center
  var endRadius = getRotaryRadius(center, axis.getEffectiveAxis(), endTool);
  var startRadius = getRotaryRadius(center, axis.getEffectiveAxis(), startTool);

  // calculate length of radial move
  var deltaAng = Math.abs(endABC.getCoordinate(axis.getCoordinate()) - startABC.getCoordinate(axis.getCoordinate()));
  while (deltaAng > Math.PI) {
    deltaAng = 2 * Math.PI - deltaAng;
  }
  var radialLength = (endRadius + startRadius)/2.0 * deltaAng; // How to deal with radial movement? Take average
  return radialLength;
}

/** Calculate tooltip, XYZ, and rotary move lengths. */
function getMoveLength(_x, _y, _z, _a, _b, _c) {
  // get starting and ending positions
  var moveLength;
  var startTool;
  var endTool;
  var startXYZ;
  var endXYZ;
  var startABC = getCurrentDirection();
  var endABC = new Vector(_a, _b, _c);
  
  if (currentSection.getOptimizedTCPMode() == 0) {
    startTool = getCurrentPosition();
    endTool = new Vector(_x, _y, _z);
    startXYZ = machineConfiguration.getOrientation(startABC).getTransposed().multiply(startTool);
    endXYZ = machineConfiguration.getOrientation(endABC).getTransposed().multiply(endTool);
  } else {
    startXYZ = getCurrentPosition();
    endXYZ = new Vector(_x, _y, _z);
    startTool = machineConfiguration.getOrientation(startABC).multiply(startXYZ);
    endTool = machineConfiguration.getOrientation(endABC).multiply(endXYZ);
  }
    
  // calculate the radial portion of the move
  var radialVector = new Vector(
    // Order is a mystery. U affects Y and Z. This works for A-axis now. Not general though.
		getRadialDistance(machineConfiguration.getAxisV(), startTool, endTool, startABC, endABC),
    -getRadialDistance(machineConfiguration.getAxisU(), startTool, endTool, startABC, endABC),
		getRadialDistance(machineConfiguration.getAxisW(), startTool, endTool, startABC, endABC));
  
  // calculate the lengths of move
  // tool tip distance is the move distance based on a combination of linear and rotary axes movement
    var linearVector = new Vector(_x, _y, _z);
    linearVector = Vector.diff(endXYZ, startXYZ);
    var moveVector = new Vector(_x, _y, _z);
    moveVector = Vector.sum(linearVector, radialVector);
   
    moveLength = moveVector.length;

    return moveLength;
}
// End of multi-axis feedrate logic


function onRapid5D(_x, _y, _z, _a, _b, _c) {
    if (properties.useTCPDebug){
    writeln("( onRapid5D Zeile 1500 )");
    }
  if (!currentSection.isOptimizedForMachine()) {
    error(localize("This post configuration has not been customized for 5-axis simultaneous toolpath."));
    return;
  }
  if (pendingRadiusCompensation >= 0) {
    error(localize("Radius compensation mode cannot be changed at rapid traversal."));
    return;
  }
  var x = xOutput.format(_x);
  var y = yOutput.format(_y);
  var z = zOutput.format(_z);
  var a = aOutput.format(_a);
  var b = bOutput.format(_b);
  var c = cOutput.format(_c);

  writeBlock(gMotionModal.format(0), x, y, z, a, b, c);
  forceFeed();
}

function onLinear5D(_x, _y, _z, _a, _b, _c, feed) {
    if (properties.useTCPDebug){
    writeln("( onLinear5D Zeile 1526 )");
    }
  if (!currentSection.isOptimizedForMachine()) {
    error(localize("This post configuration has not been customized for 5-axis simultaneous toolpath."));
    return;
  }
  if (pendingRadiusCompensation >= 0) {
    error(localize("Radius compensation cannot be activated/deactivated for 5-axis move."));
    return;
  }
  var x = xOutput.format(_x);
  var y = yOutput.format(_y);
  var z = zOutput.format(_z);
  var a = aOutput.format(_a);
  var b = bOutput.format(_b);
  var c = cOutput.format(_c);
  
  // get feedrate number
  var f = {frn:0, fmode:0};
  if (a || b || c) {
    f = getMultiaxisFeed(_x, _y, _z, _a, _b, _c, feed);
  } else {
    f.frn = feedOutput.format(feed);
    f.fmode = 94;
  }

  if (x || y || z || a || b || c) {
    writeBlock("",gFeedModeModal.format(f.fmode), gMotionModal.format(1), x, y, z, a, b, c, f.frn);
  } else if (f.frn) {
    if (getNextRecord().isMotion()) { // try not to output feed without motion
      forceFeed(); // force feed on next line
    } else {
      writeBlock(gFeedModeModal.format(f.fmode), gMotionModal.format(1), f.frn);
    }
  }
}



// Start of onRewindMachine logic
/***** Be sure to add 'useRewindCAxisSafeRetractDistance' to post properties. *****/
var performRewinds = false; // enables the onRewindMachine logic
var safeRetractFeed = (unit == IN) ? 20 : 500;
var safePlungeFeed = (unit == IN) ? 10 : 250;
var stockAllowance = (unit == IN) ? 0.1 : 5;

/** Allow user to override the onRewind logic. */
function onRewindMachineEntry(_a, _b, _c) {
    if (properties.useTCPDebug){
    writeln("( onRewindMachineEntry Zeile 1575 )");
    }
  // reset the rotary encoder if supported to avoid large rewind
  if (properties.useRewindCAxisEncoder) {
    var c = _c;
    if ((abcFormat.getResultingValue(c) == 0) && !abcFormat.areDifferent(getCurrentDirection().y, _b)) {
      writeBlock(gAbsIncModal.format(91), gFormat.format(28), "C" + abcFormat.format(0));
      writeBlock(gAbsIncModal.format(90));
      return true;
    }
  }
  return false;
}

/** Retract to safe position before indexing rotaries. */
// das muss ich noch analysieren
function moveToSafeRetractPosition(isRetracted) {
  //SK15112022 Start
  // cancel TCP so that tool doesn't follow rotaries
  if (properties.useTCPDebug){
    writeln("Zeile 1570 Schleife setTCPMode(false) in Funktion moveToSafeRetractPosition");
  }
  setTCPMode(false);
  //SK15112022 End
  writeRetract(Z);
  if (properties.forceHomeOnIndexing) {
    writeRetract(X, Y);
  }
}

/** Return from safe position after indexing rotaries. */
function returnFromSafeRetractPosition(position) {
    if (operationSupportsTCP) {
    var G = ((highFeedMapping != HIGH_FEED_NO_MAPPING) || !getProperty("useG0")) ? 1 : 0;
    var F = ((highFeedMapping != HIGH_FEED_NO_MAPPING) || !getProperty("useG0")) ? getFeed(highFeedrate) : "";
    prePositionXYZ(getCurrentPosition(), !retracted, G, F);
    setTCPMode(true);
    gMotionModal.reset();
    forceXYZ();
    forceABC();
  } else {
  forceXYZ();
  xOutput.reset();
  yOutput.reset();
  zOutput.disable();
  onRapid(position.x, position.y, position.z);
  zOutput.enable();
  onRapid(position.x, position.y, position.z);
  }

}

/** Determine if a point is on the correct side of a box side. */
function isPointInBoxSide(point, side) {
  var inBox = false;
  switch (side.side) {
  case "-X":
    if (point.x >= side.distance) {
      inBox = true;
    }
    break;
  case "-Y":
    if (point.y >= side.distance) {
      inBox = true;
    }
    break;
  case "-Z":
    if (point.z >= side.distance) {
      inBox = true;
    }
    break;
  case "X":
    if (point.x <= side.distance) {
      inBox = true;
    }
    break;
  case "Y":
    if (point.y <= side.distance) {
      inBox = true;
    }
    break;
  case "Z":
    if (point.z <= side.distance) {
      inBox = true;
    }
    break;
  }
  return inBox;
}

/** Intersect a point-vector with a plane. */
function intersectPlane(point, direction, plane) {
  var normal = new Vector(plane.x, plane.y, plane.z);
  var cosa = Vector.dot(normal, direction);
  if (Math.abs(cosa) <= 1.0e-6) {
    return undefined;
  }
  var distance = (Vector.dot(normal, point) - plane.distance) / cosa;
  var intersection = Vector.diff(point, Vector.product(direction, distance));
  
  if (!isSameDirection(Vector.diff(intersection, point).getNormalized(), direction)) {
    return undefined;
  }
  return intersection;
}

/** Intersect the point-vector with the stock box. */
function intersectStock(point, direction) {
  var stock = getWorkpiece();
  var sides = new Array(
    {x:1, y:0, z:0, distance:stock.lower.x, side:"-X"},
    {x:0, y:1, z:0, distance:stock.lower.y, side:"-Y"},
    {x:0, y:0, z:1, distance:stock.lower.z, side:"-Z"},
    {x:1, y:0, z:0, distance:stock.upper.x, side:"X"},
    {x:0, y:1, z:0, distance:stock.upper.y, side:"Y"},
    {x:0, y:0, z:1, distance:stock.upper.z, side:"Z"}
  );
  var intersection = undefined;
  var currentDistance = 999999.0;
  var localExpansion = -stockAllowance;
  for (var i = 0; i < sides.length; ++i) {
    if (i == 3) {
      localExpansion = -localExpansion;
    }
    if (isPointInBoxSide(point, sides[i])) { // only consider points within stock box
      var location = intersectPlane(point, direction, sides[i]);
      if (location != undefined) {
        if ((Vector.diff(point, location).length < currentDistance) || currentDistance == 0) {
          intersection = location;
          currentDistance = Vector.diff(point, location).length;
        }
      }
    }
  }
  return intersection;
}

/** Calculates the retract point using the stock box and safe retract distance. */
function getRetractPosition(currentPosition, currentDirection) {
  var retractPos = intersectStock(currentPosition, currentDirection);
  if (retractPos == undefined) {
    if (tool.getFluteLength() != 0) {
      retractPos = Vector.sum(currentPosition, Vector.product(currentDirection, tool.getFluteLength()));
    }
  }
  if ((retractPos != undefined) && properties.useRewindCAxisSafeRetractDistance) {
    retractPos = Vector.sum(retractPos, Vector.product(currentDirection, properties.useRewindCAxisSafeRetractDistance));
  }
  return retractPos;
}

/** Determines if the angle passed to onRewindMachine is a valid starting position. */
function isRewindAngleValid(_a, _b, _c) {
  // make sure the angles are different from the last output angles
  if (!abcFormat.areDifferent(getCurrentDirection().x, _a) &&
      !abcFormat.areDifferent(getCurrentDirection().y, _b) &&
      !abcFormat.areDifferent(getCurrentDirection().z, _c)) {
    error(
      localize("REWIND: Rewind angles are the same as the previous angles: ") +
      abcFormat.format(_a) + ", " + abcFormat.format(_b) + ", " + abcFormat.format(_c)
    );
    return false;
  }
  
  // make sure angles are within the limits of the machine
  var abc = new Array(_a, _b, _c);
  var ix = machineConfiguration.getAxisU().getCoordinate();
  var failed = false;
  if ((ix != -1) && !machineConfiguration.getAxisU().isSupported(abc[ix])) {
    failed = true;
  }
  ix = machineConfiguration.getAxisV().getCoordinate();
  if ((ix != -1) && !machineConfiguration.getAxisV().isSupported(abc[ix])) {
    failed = true;
  }
  ix = machineConfiguration.getAxisW().getCoordinate();
  if ((ix != -1) && !machineConfiguration.getAxisW().isSupported(abc[ix])) {
    failed = true;
  }
  if (failed) {
    error(
      localize("REWIND: Rewind angles are outside the limits of the machine: ") +
      abcFormat.format(_a) + ", " + abcFormat.format(_b) + ", " + abcFormat.format(_c)
    );
    return false;
  }
  
  return true;
}

function onRewindMachine(_a, _b, _c) {
  performRewinds = properties.useRewindCAxis; // enables the onRewindMachine logic
  if (!performRewinds) {
    error(localize("REWIND: Rewind of machine is required for simultaneous multi-axis toolpath and has been disabled."));
    return;
  }
  
  // Allow user to override rewind logic
  if (onRewindMachineEntry(_a, _b, _c)) {
    return;
  }
  
  // Determine if input angles are valid or will cause a crash
  if (!isRewindAngleValid(_a, _b, _c)) {
    error(
      localize("REWIND: Rewind angles are invalid:") +
      abcFormat.format(_a) + ", " + abcFormat.format(_b) + ", " + abcFormat.format(_c)
    );
    return;
  }
  
  // Work with the tool end point
  if (currentSection.getOptimizedTCPMode() == 0) {
    currentTool = getCurrentPosition();
  } else {
    currentTool = machineConfiguration.getOrientation(getCurrentDirection()).multiply(getCurrentPosition());
  }
  var currentABC = getCurrentDirection();
  var currentDirection = machineConfiguration.getDirection(currentABC);
  
  // Calculate the retract position
  var retractPosition = getRetractPosition(currentTool, currentDirection);

  // Output warning that axes take longest route
  if (retractPosition == undefined) {
    error(localize("REWIND: Cannot calculate retract position."));
    return;
  } else {
    var text = localize("REWIND: Tool is retracting due to rotary axes limits.");
    warning(text);
    writeComment(text);
  }

  // Move to retract position
  var position;
  if (currentSection.getOptimizedTCPMode() == 0) {
    position = retractPosition;
  } else {
    position = machineConfiguration.getOrientation(getCurrentDirection()).getTransposed().multiply(retractPosition);
  }
  onLinear(position.x, position.y, position.z, safeRetractFeed);
  
  //Position to safe machine position for rewinding axes
  moveToSafeRetractPosition(false);

  // Rotate axes to new position above reentry position
  xOutput.disable();
  yOutput.disable();
  zOutput.disable();
  onRapid5D(position.x, position.y, position.z, _a, _b, _c);
  xOutput.enable();
  yOutput.enable();
  zOutput.enable();

  // Move back to position above part
  if (currentSection.getOptimizedTCPMode() != 0) {
    position = machineConfiguration.getOrientation(new Vector(_a, _b, _c)).getTransposed().multiply(retractPosition);
  }
  returnFromSafeRetractPosition(position);

  // Plunge tool back to original position
  if (currentSection.getOptimizedTCPMode() != 0) {
    currentTool = machineConfiguration.getOrientation(new Vector(_a, _b, _c)).getTransposed().multiply(currentTool);
  }
  onLinear(currentTool.x, currentTool.y, currentTool.z, safePlungeFeed);
}
// End of onRewindMachine logic

function onCircular(clockwise, cx, cy, cz, x, y, z, feed) {
  if (pendingRadiusCompensation >= 0) {
    error(localize("Radius compensation cannot be activated/deactivated for a circular move."));
    return;
  }

  var start = getCurrentPosition();

  if (isFullCircle()) {
    if (properties.useRadius || isHelical()) { // radius mode does not support full arcs
      linearize(tolerance);
      return;
    }
    switch (getCircularPlane()) {
    case PLANE_XY:
      writeBlock(gAbsIncModal.format(90), gPlaneModal.format(17), gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2 : 3), iOutput.format(cx - start.x, 0), jOutput.format(cy - start.y, 0), getFeed(feed));
      break;
    case PLANE_ZX:
      writeBlock(gAbsIncModal.format(90), gPlaneModal.format(18), gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2 : 3), iOutput.format(cx - start.x, 0), kOutput.format(cz - start.z, 0), getFeed(feed));
      break;
    case PLANE_YZ:
      writeBlock(gAbsIncModal.format(90), gPlaneModal.format(19), gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2 : 3), jOutput.format(cy - start.y, 0), kOutput.format(cz - start.z, 0), getFeed(feed));
      break;
    default:
      linearize(tolerance);
    }
  } else if (!properties.useRadius) {
    switch (getCircularPlane()) {
    case PLANE_XY:
      writeBlock(gAbsIncModal.format(90), gPlaneModal.format(17), gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), iOutput.format(cx - start.x, 0), jOutput.format(cy - start.y, 0), getFeed(feed));
      break;
    case PLANE_ZX:
      writeBlock(gAbsIncModal.format(90), gPlaneModal.format(18), gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), iOutput.format(cx - start.x, 0), kOutput.format(cz - start.z, 0), getFeed(feed));
      break;
    case PLANE_YZ:
      writeBlock(gAbsIncModal.format(90), gPlaneModal.format(19), gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), jOutput.format(cy - start.y, 0), kOutput.format(cz - start.z, 0), getFeed(feed));
      break;
    default:
      linearize(tolerance);
    }
  } else { // use radius mode
    var r = getCircularRadius();
    if (toDeg(getCircularSweep()) > (180 + 1e-9)) {
      r = -r; // allow up to <360 deg arcs
    }
    switch (getCircularPlane()) {
    case PLANE_XY:
      writeBlock(gPlaneModal.format(17), gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), "R" + rFormat.format(r), getFeed(feed));
      break;
    case PLANE_ZX:
      writeBlock(gPlaneModal.format(18), gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), "R" + rFormat.format(r), getFeed(feed));
      break;
    case PLANE_YZ:
      writeBlock(gPlaneModal.format(19), gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), "R" + rFormat.format(r), getFeed(feed));
      break;
    default:
      linearize(tolerance);
    }
  }
}

var currentCoolantMode = undefined;
var coolantOff = undefined;

function setCoolant(coolant) {
  var coolantCodes = getCoolantCodes(coolant);
  if (Array.isArray(coolantCodes)) {
    for (var c in coolantCodes) {
      writeBlock(coolantCodes[c]);
    }
    return undefined;
  }
  return coolantCodes;
}

function getCoolantCodes(coolant) {
  if (!coolants) {
    error(localize("Coolants have not been defined."));
  }
  if (!coolantOff) { // use the default coolant off command when an 'off' value is not specified for the previous coolant mode
    coolantOff = coolants.off;
  }

  if (isProbeOperation()) { // avoid coolant output for probing
    coolant = COOLANT_OFF;
  }

  if (coolant == currentCoolantMode) {
    return undefined; // coolant is already active
  }

  var multipleCoolantBlocks = new Array(); // create a formatted array to be passed into the outputted line
  if ((coolant != COOLANT_OFF) && (currentCoolantMode != COOLANT_OFF)) {
    multipleCoolantBlocks.push(mFormat.format(coolantOff));
  }

  var m;
  if (coolant == COOLANT_OFF) {
    m = coolantOff;
    coolantOff = coolants.off;
  }

  switch (coolant) {
  case COOLANT_FLOOD:
    if (!coolants.flood) {
      break;
    }
    m = coolants.flood.on;
    coolantOff = coolants.flood.off;
    break;
  case COOLANT_THROUGH_TOOL:
    if (!coolants.throughTool) {
      break;
    }
    m = coolants.throughTool.on;
    coolantOff = coolants.throughTool.off;
    break;
  case COOLANT_AIR:
    if (!coolants.air) {
      break;
    }
    m = coolants.air.on;
    coolantOff = coolants.air.off;
    break;
  case COOLANT_AIR_THROUGH_TOOL:
    if (!coolants.airThroughTool) {
      break;
    }
    m = coolants.airThroughTool.on;
    coolantOff = coolants.airThroughTool.off;
    break;
  case COOLANT_FLOOD_MIST:
    if (!coolants.floodMist) {
      break;
    }
    m = coolants.floodMist.on;
    coolantOff = coolants.floodMist.off;
    break;
  case COOLANT_MIST:
    if (!coolants.mist) {
      break;
    }
    m = coolants.mist.on;
    coolantOff = coolants.mist.off;
    break;
  case COOLANT_SUCTION:
    if (!coolants.suction) {
      break;
    }
    m = coolants.suction.on;
    coolantOff = coolants.suction.off;
    break;
  case COOLANT_FLOOD_THROUGH_TOOL:
    if (!coolants.floodThroughTool) {
      break;
    }
    m = coolants.floodThroughTool.on;
    coolantOff = coolants.floodThroughTool.off;
    break;
  }
  
  if (!m) {
    onUnsupportedCoolant(coolant);
    m = 9;
  }

  if (m) {
    if (Array.isArray(m)) {
      for (var i in m) {
        multipleCoolantBlocks.push(mFormat.format(m[i]));
      }
    } else {
      multipleCoolantBlocks.push(mFormat.format(m));
    }
    currentCoolantMode = coolant;
    return multipleCoolantBlocks; // return the single formatted coolant value
  }
  return undefined;
}

var mapCommand = {
  COMMAND_STOP:0,
  COMMAND_OPTIONAL_STOP:1,
  COMMAND_END:2,
  COMMAND_SPINDLE_CLOCKWISE:3,
  COMMAND_SPINDLE_COUNTERCLOCKWISE:4,
  COMMAND_STOP_SPINDLE:5,
  COMMAND_ORIENTATE_SPINDLE:19,
  COMMAND_LOAD_TOOL: 6
};

function onCommand(command) {
  switch (command) {
  case COMMAND_STOP:
    writeBlock(mFormat.format(0));
    forceSpindleSpeed = true;
    return;
  case COMMAND_START_SPINDLE:
    onCommand(tool.clockwise ? COMMAND_SPINDLE_CLOCKWISE : COMMAND_SPINDLE_COUNTERCLOCKWISE);
    return;
  case COMMAND_LOCK_MULTI_AXIS:
    return;
  case COMMAND_UNLOCK_MULTI_AXIS:
    return;
  case COMMAND_BREAK_CONTROL:
    return;
  case COMMAND_TOOL_MEASURE:
    return;
  }
  
  var stringId = getCommandStringId(command);
  var mcode = mapCommand[stringId];
  if (mcode != undefined) {
    writeBlock(mFormat.format(mcode));
  } else {
    onUnsupportedCommand(command);
  }
}

function onSectionEnd() {
  if (currentSection.isMultiAxis()) {
    setTCPMode(false);
    writeBlock(gMotionModal.format(49));
  }
  writeBlock(gPlaneModal.format(17));

  if (((getCurrentSectionId() + 1) >= getNumberOfSections()) ||
      (tool.number != getNextSection().getTool().number)) {
    onCommand(COMMAND_BREAK_CONTROL);
  }

  forceAny();
}

/** Output block to do safe retract and/or move to home position. */
function writeRetract() {
                if (properties.useTCPDebug){
                writeln(" ( writeRetract Anfang )");
                }
  if (arguments.length == 0) {
    error(localize("No axis specified for writeRetract()."));
    return;
  }
  var words = []; // store all retracted axes in an array
  for (var i = 0; i < arguments.length; ++i) {
    let instances = 0; // checks for duplicate retract calls
    for (var j = 0; j < arguments.length; ++j) {
      if (arguments[i] == arguments[j]) {
        ++instances;
      }
    }
    if (instances > 1) { // error if there are multiple retract calls for the same axis
      error(localize("Cannot retract the same axis twice in one line"));
      return;
    }
    switch (arguments[i]) {
    case X:
      if (machineConfiguration.hasHomePositionX() || machineConfiguration.hasHomePositionY()) {
        words.push("X" + xyzFormat.format(machineConfiguration.hasHomePositionX() ?machineConfiguration.getHomePositionX() : 0));
                        if (properties.useTCPDebug){
                writeln(" ( writeRetract case x)");
                }
      }
      break;
    case Y:
      if (machineConfiguration.hasHomePositionX() || machineConfiguration.hasHomePositionY()) {
        words.push("Y" + xyzFormat.format(machineConfiguration.hasHomePositionY() ? machineConfiguration.getHomePositionY() : 0));
                                if (properties.useTCPDebug){
                writeln(" ( writeRetract case y)");
                }
      }
      break;
    case Z:
                            if (properties.useTCPDebug){
                writeln(" ( writeRetract case z)");
                }
      words.push("Z" + xyzFormat.format(machineConfiguration.getRetractPlane()));
      retracted = true; // specifies that the tool has been retracted to the safe plane
      break;
    default:
      error(localize("Bad axis specified for writeRetract()."));
      return;
    }
  }
  if (words.length > 0) {
    if (properties.useG28) {
      gAbsIncModal.reset();
                              if (properties.useTCPDebug){
                writeln(" ( writeRetract use28 Start )");
                }
      writeBlock(gFormat.format(28), gAbsIncModal.format(91), words); // retract
      writeBlock(gAbsIncModal.format(90));
                                    if (properties.useTCPDebug){
                writeln(" ( writeRetract use28 End)");
                }
      
    } else {
                              if (properties.useTCPDebug){
                writeln(" ( writeRetract else von use28 Start)");
                }
      writeBlock(gAbsIncModal.format(90), gFormat.format(53), gMotionModal.format(0), words); // retract
                                    if (properties.useTCPDebug){
                writeln(" ( writeRetract else von use28 End)");
                }
    }
  }
  zOutput.reset();
}

function onClose() {
                  if (properties.useTCPDebug){
                writeln(" ( onClose Anfang )");
                }
  setCoolant(COOLANT_OFF);

  setTCPMode(false);

  writeRetract(Z);

  setWorkPlane(new Vector(0, 0, 0)); // reset working plane

  writeRetract(X, Y);

  onImpliedCommand(COMMAND_END);
  onImpliedCommand(COMMAND_STOP_SPINDLE);
  writeBlock(mFormat.format(30)); // stop program, spindle stop, coolant off
  writeln("%");
}