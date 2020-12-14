// imported in frame 1 of keySettings MovieClip (the options menu)

dummy.useHandCursor = false;
//Control styles (combo boxes):
for (var n=0; n < aimingBox.getLength(); n++) {
	if (aimingBox.getItemAt(n).data == _root.key_aim) { //n is the index I want selected
		aimingBox.setSelectedIndex(n);
		break;
	}
}
for (var m=0; m < movingBox.getLength(); m++) {
	if (movingBox.getItemAt(m).data == _root.key_move) { //m is the index I want selected
		movingBox.setSelectedIndex(m);
		break;
	}
}

function aimingHandler() {
	_root.key_aim = aimingBox.getValue();
}
function movingHandler() {
	_root.key_move = movingBox.getValue();
}

//Keyboard binding (text and buttons):
var isBindAll=false;
var bindAll_current = 0;

_root.keyListener.onKeyDown = function () {
	if (waiting._visible) {
		waiting._visible = false;
		_root[varToBind] = Key.getCode();
		txtToChange.text = _root.codeName[Key.getCode()];

		if (isBindAll) {
			bindAll_current++;
			if (bindAll_current == bindList.length) {
				isBindAll = false;
			} else {
				bind(bindList[bindAll_current]);
			}
		}
	}
}
var varToBind;
var txtToChange;
waiting._visible = false;
function bind(value) {
	waiting._visible = true;
	waiting.actionTxt = value;
	waiting.defaultTxt = this["default_"+value];

	varToBind = "key_"+value;
	txtToChange = this[value+"Field"];
}

function bindAll() {
	isBindAll=true;
	bindAll_current = 0;
	bind(bindList[bindAll_current]);
}

//Default keys _root.List
var default_up = "Up arrow";
var default_down = "Down arrow";
var default_left = "Left arrow";
var default_right = "Right arrow";
var default_shoot = "Z";
var default_aimUp = "E";
var default_aimDown = "D";
var default_aimLeft = "S";
var default_aimRight = "F";
var default_pause = "P";
var default_ed_up = "E";
var default_ed_down = "D";
var default_ed_left = "S";
var default_ed_right = "F";
var default_ed_rotateLeft1 = "W";
var default_ed_rotateRight1 = "R";
var default_ed_rotateLeft45 = "Q";
var default_ed_rotateRight45 = "T";
var default_ed_lock = "V";
var default_ed_nextParent = "G";
var default_ed_prevParent = "A";
var default_ed_delete = "Spacebar";
var default_ed_xscale = "Z";
var default_ed_yscale = "X";
var default_ed_xyscale = "C";
var default_ed_duplicate = "CTRL d will always duplicate as well as whichever key you put here";
var default_ed_selAll = "CTRL a will always select all parts as well as whichever key you put here";
var default_ed_selCore = "CTRL h will always select core as well as whichever key you put here";

//Order of bind all keys
var bindList = [
"up",
"down",
"left",
"right",
"shoot",
"aimUp",
"aimDown",
"aimLeft",
"aimRight",
"pause",
"ed_up",
"ed_down",
"ed_left",
"ed_right",
"ed_rotateLeft1",
"ed_rotateRight1",
"ed_rotateLeft45",
"ed_rotateRight45",
"ed_lock",
"ed_nextParent",
"ed_prevParent",
"ed_delete",
"ed_xscale",
"ed_yscale",
"ed_xyscale",
"ed_duplicate",
"ed_selAll",
"ed_selCore"
];

for (var i=0; i < bindList.length; i++) {
	var value = bindList[i];
	var code = _root["key_"+value];
	this[value+"Field"].text = _root.codeName[code];
}

//###### HOTKEY ASSIGNMENT BUTTONS #######
bindAllKeysBtn.onRelease = function () {
	bindAll();
}

hotkeyUpBtn.onRelease = function () {
	bind("up");
}
hotkeyDownBtn.onRelease = function () {
	bind("down");
}
hotkeyLeftBtn.onRelease = function () {
	bind("left");
}
hotkeyRightBtn.onRelease = function () {
	bind("right");
}
hotkeyShootBtn.onRelease = function () {
	bind("shoot");
}
hotkeyAimUpBtn.onRelease = function () {
	bind("aimUp");
}
hotkeyAimDownBtn.onRelease = function () {
	bind("aimDown");
}
hotkeyAimLeftBtn.onRelease = function () {
	bind("aimLeft");
}
hotkeyAimRightBtn.onRelease = function () {
	bind("aimRight");
}
hotkeyPauseBtn.onRelease = function () {
	bind("pause");
}
hotkeyEdUpBtn.onRelease = function () {
	bind("ed_up");
}
hotkeyEdDownBtn.onRelease = function () {
	bind("ed_down");
}
hotkeyEdLeftBtn.onRelease = function () {
	bind("ed_left");
}
hotkeyEdRightBtn.onRelease = function () {
	bind("ed_right");
}
hotkeyEdRotateLeft1Btn.onRelease = function () {
	bind("ed_rotateLeft1");
}
hotkeyEdRotateRight1Btn.onRelease = function () {
	bind("ed_rotateRight1");
}
hotkeyEdRotateLeft45Btn.onRelease = function () {
	bind("ed_rotateLeft45");
}
hotkeyEdRotateRight45Btn.onRelease = function () {
	bind("ed_rotateRight45");
}
hotkeyEdToggleLockBtn.onRelease = function () {
	bind("ed_lock");
}
hotkeyEdNextConBtn.onRelease = function () {
	bind("ed_nextParent");
}
hotkeyEdPrevConBtn.onRelease = function () {
	bind("ed_prevParent");
}
hotkeyEdDeleteBtn.onRelease = function () {
	bind("ed_delete");
}
hotkeyEdMirrorHBtn.onRelease = function () {
	bind("ed_xscale");
}
hotkeyEdMirrorVBtn.onRelease = function () {
	bind("ed_yscale");
}
hotkeyEdMirrorDBtn.onRelease = function () {
	bind("ed_xyscale");
}
hotkeyEdDupBtn.onRelease = function () {
	bind("ed_duplicate");
}
hotkeyEdSelectAllBtn.onRelease = function () {
	bind("ed_selAll");
}
hotkeyEdSelectCoreBtn.onRelease = function () {
	bind("ed_selCore");
}

//###### HELP TEXT #######
qualityBtn.onRollOver = function() {
	_root.ideHelpTxt.setTxt("Toggle vector rendering quality (to improve FPS). Press [Q] to toggle while in pause or options menu.");
}
qualityBtn.onRollOut = function() {
	_root.ideHelpTxt.setTxt();
}

fpsBtn.onRollOver = function() {
	_root.ideHelpTxt.setTxt("Toggle frames-per-second (FPS) display. Press [F] to toggle while in pause or options menu.");
}
fpsBtn.onRollOut = function() {
	_root.ideHelpTxt.setTxt();
}

hotkeyShootBtn.onRollOver = function() {
	_root.ideHelpTxt.setTxt("Key to shoot. If using the mouse, left click will be used instead");
}
hotkeyShootBtn.onRollOut = function() {
	_root.ideHelpTxt.setTxt();
}


hotkeyEdDupBtn.onRollOver = function() {
	_root.ideHelpTxt.setTxt("Alternate key to duplicate the selection ([CTRL d] by default)");
}
hotkeyEdDupBtn.onRollOut = function() {
	_root.ideHelpTxt.setTxt();
}
hotkeyEdSelectAllBtn.onRollOver = function() {
	_root.ideHelpTxt.setTxt("Alternate key to select (or deselect) all pieces ([CTRL a] by default)");
}
hotkeyEdSelectAllBtn.onRollOut = function() {
	_root.ideHelpTxt.setTxt();
}
hotkeyEdSelectCoreBtn.onRollOver = function() {
	_root.ideHelpTxt.setTxt("Alternate key to select the core ([CTRL h] by default)");
}
hotkeyEdSelectCoreBtn.onRollOut = function() {
	_root.ideHelpTxt.setTxt();
}