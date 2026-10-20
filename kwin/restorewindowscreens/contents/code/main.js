// Remember each window's geometry while the multi-monitor layout is active. When a
// monitor drops out (KWin evacuates its windows) and the same layout comes back,
// put every window back where it was.

var SETTLE_MS = 3000;   // wait for kscreen to finish re-applying the layout
var REVERT_MS = 2000;   // geometry recorded this close to a screen change is suspect

var saved = {};         // internalId -> { cur: {g, t}, prev: {g, t} }
var savedVsize = null;  // virtual screen size the saved geometries belong to
var savedScreens = 0;
var settling = false;
var evicted = false;

function log(msg) { print("restorewindows: " + msg); }

function copyGeo(g) { return { x: g.x, y: g.y, width: g.width, height: g.height }; }

function sameGeo(a, b) {
    return a.x === b.x && a.y === b.y && a.width === b.width && a.height === b.height;
}

function multiScreen() { return workspace.numScreens >= 2; }

function trackable(c) { return c && c.normalWindow && !c.skipTaskbar; }

function record(c) {
    if (settling || !multiScreen() || !trackable(c)) return;
    var id = c.internalId.toString();
    var entry = saved[id] || {};
    var g = copyGeo(c.frameGeometry);
    if (entry.cur && sameGeo(entry.cur.g, g)) return;
    entry.prev = entry.cur;
    entry.cur = { g: g, t: Date.now() };
    saved[id] = entry;
}

function snapshotAll() {
    var vs = workspace.virtualScreenSize;
    savedVsize = { width: vs.width, height: vs.height };
    savedScreens = workspace.numScreens;
    var clients = workspace.clientList();
    for (var i = 0; i < clients.length; i++) record(clients[i]);
}

function screenFor(g, desktop) {
    var cx = g.x + g.width / 2, cy = g.y + g.height / 2;
    for (var s = 0; s < workspace.numScreens; s++) {
        var a = workspace.clientArea(KWin.ScreenArea, s, desktop > 0 ? desktop : 1);
        if (cx >= a.x && cx < a.x + a.width && cy >= a.y && cy < a.y + a.height) return s;
    }
    return -1;
}

function restoreAll() {
    var clients = workspace.clientList();
    var moved = 0;
    for (var i = 0; i < clients.length; i++) {
        var c = clients[i];
        var entry = saved[c.internalId.toString()];
        if (!trackable(c) || !entry || !entry.cur) continue;
        var g = entry.cur.g;
        if (sameGeo(copyGeo(c.frameGeometry), g)) continue;
        var s = screenFor(g, c.desktop);
        if (s >= 0 && s !== c.screen) workspace.sendClientToScreen(c, s);
        if (!c.fullScreen && !sameGeo(copyGeo(c.frameGeometry), g)) c.frameGeometry = g;
        var now = copyGeo(c.frameGeometry);
        log("  " + c.resourceClass + " -> " + g.x + "," + g.y + " " + g.width + "x" + g.height
            + (sameGeo(now, g) ? "" : " (ended at " + now.x + "," + now.y + " " + now.width + "x" + now.height + ")"));
        moved++;
    }
    log("restored " + moved + " window(s)");
}

var settleTimer = new QTimer();
settleTimer.singleShot = true;
settleTimer.interval = SETTLE_MS;
settleTimer.timeout.connect(function () {
    var vs = workspace.virtualScreenSize;
    log("settled: " + workspace.numScreens + " screen(s), " + vs.width + "x" + vs.height + ", evicted=" + evicted);
    if (!multiScreen()) {
        log("holding saved layout until the monitor returns");
        return; // stay in settling mode: don't record single-screen positions
    }
    if (evicted && savedVsize && vs.width === savedVsize.width && vs.height === savedVsize.height
            && workspace.numScreens === savedScreens) {
        restoreAll();
    }
    evicted = false;
    settling = false;
    snapshotAll();
});

function screensChanged() {
    var vs = workspace.virtualScreenSize;
    log("screens changed: " + workspace.numScreens + " screen(s), " + vs.width + "x" + vs.height);
    if (!settling) {
        // KWin may already have moved windows before this signal arrived; roll those back.
        var now = Date.now();
        for (var id in saved) {
            var e = saved[id];
            if (e.cur && e.prev && now - e.cur.t < REVERT_MS) e.cur = e.prev;
        }
        settling = true;
    }
    // A dropout can be shorter than SETTLE_MS, so note it now rather than when settled.
    if (workspace.numScreens < savedScreens || !savedVsize
            || vs.width !== savedVsize.width || vs.height !== savedVsize.height) {
        evicted = true;
    }
    settleTimer.start();
}

function watch(c) {
    if (!c) return;
    c.frameGeometryChanged.connect(function () { record(c); });
    record(c);
}

workspace.clientAdded.connect(watch);
workspace.clientRemoved.connect(function (c) { delete saved[c.internalId.toString()]; });
workspace.numberScreensChanged.connect(screensChanged);
workspace.virtualScreenGeometryChanged.connect(screensChanged);

var initial = workspace.clientList();
for (var i = 0; i < initial.length; i++) watch(initial[i]);
snapshotAll();
log("loaded, tracking " + Object.keys(saved).length + " window(s) on " + workspace.numScreens + " screen(s)");
