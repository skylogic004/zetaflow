/*
*****************************
*         Zeta Flow         *
*   made by Matthew Dirks   *
*****************************
*/
//Depths:
var d_ship = 1;
var d_shipAimer = 2;
var d_lifeCount = 3;
var d_fpsCounter = 4;
var d_allEnemies = 100;
var d_allEnemyBullets = 101;
var d_allEnemyBullets2 = 102;
var d_allEnemyBullets3 = 103;
var d_allBullets = 104;
var d_coreExplosion = 108;
var d_coreTemp = 109;
var d_allExp = 110;
var d_tutorial = 300
var d_hierarchyLines = 499;
var d_library = 500;
var d_output = 501;
var d_tools = 502;
var d_coreAIwindow = 503;
var d_saveAs = 504;
var d_register = 505;
var d_gallery = 506;
var d_edTutorial = 507;
var d_pauseMenu = 508; //keep keySettings above this
var d_miniPauseMenu = 509;
var d_countdown = 510;
var d_properties = 511;
var d_login = 512;
var d_renameWin = 513;
var d_gallery_getID = 514;
var d_textEdit = 515;
var d_fileMenuWin = 516;
var d_mochiad = 517;
var d_keySettings = 518;

var d_bullets = 0; //independent
var d_maxBullets = 1000; //d_bullets will return to 0 when it hits this number
var d_bulletsDestroyable = d_maxBullets+1;
var d_e = 0; //independent
var d_exp = 0; //independent

var d_levelMsgWin = 200;
var d_ideHelpTxt = 604;
var d_messageWin = 605;
var d_onEnterFrameFix = 606;

//700+ will be used for sound volume MCs

var startingLives = 1;
var mouseDown=false;
var lives;
var livesSpent;

//Level specific:
var currentLvl = 0;
var endLevel = 10;
var currentLvl_coreGunAI;
var currentLvl_coreAIfunctions = [];
var coreVars = new Object();
var ai_ob;
var currentLvlObject={};

var campaignMode;

//Other values:
var STAGE_W = 800;
var STAGE_H = 600;

var SHIP_GUN_DELAY = 3; //3
var SHIP_GUN_DAMAGE = 100;
var SHIP_SPEED = 8;

var keyReleased=false;
var PI = Math.PI;
var PI_180 = Math.PI / 180;

var bulletSpeed = 10;

var destroyChildrenArray = [];
var gunArray = [];

var bonusHP = 300;

var temp; //Used in coreExplode
var temp2;//Used in coreExplode

var loginOb = {}; //username, pw, bool loggedIn. With PHP logins working, this will also contain email, power, language, ID

var curFrame; ///reset to 0 in AI_makeTrigger_init(), incremented in timeTriggerCheck. add to gameLoop if want to use elsewhere.
			  //moved incrementation from timeTriggerCheck to gameLoop, using this variable for timeFramesSpent statistic
			  //moved reset from AI_makeTrigger_init() to gameMode()
			  //2009-05-07 (CI)
var timeArray = [];

var keyListener = new Object();
Key.addListener(keyListener);

//Has user saved their settings? (in a sharedobject)
var userSettings_so = SharedObject.getLocal("userSettings");
var login_so = SharedObject.getLocal("zfsave");
var editorBackup_so = SharedObject.getLocal("editorBackup");

//URLs
var saveRatingURL = "http://zetaflow.skylogic.ca/backend/saveRating/";
var saveLevelURL = "http://zetaflow.skylogic.ca/backend/saveLevel/";
var getLevelURL = "http://zetaflow.skylogic.ca/backend/getLevel/";
var getLevelsListURL = "http://zetaflow.skylogic.ca/backend/getLevelsList/";
var checkWebLoginURL = "http://zetaflow.skylogic.ca/backend/checkWebLogin/";
var savePlayURL = "http://zetaflow.skylogic.ca/backend/savePlay/";
var saveWinURL = "http://zetaflow.skylogic.ca/backend/saveWin/";
var rootURL = "http://zetaflow.skylogic.ca/";

//***KEY BINDS
//keyword: SharedObject
//Declare variables:
var key_aim;
var key_move;
var detectKeys_function;

var key_left;
var key_right;
var key_up;
var key_down;
var key_aimLeft;
var key_aimRight;
var key_aimDown;
var key_aimUp;
var key_shoot;
var key_pause;

var key_ed_up;
var key_ed_down;
var key_ed_left;
var key_ed_right;
var key_ed_rotateLeft1;
var key_ed_rotateRight1;
var key_ed_rotateLeft45;
var key_ed_rotateRight45;
var key_ed_delete;
var key_ed_lock;
var key_ed_nextParent;
var key_ed_prevParent;
var key_ed_xscale;
var key_ed_yscale;
var key_ed_xyscale;
var key_ed_duplicate;
var key_ed_selAll;
var key_ed_selCore;

//KEY CODE LIST
codeName = [];
codeName[3] = "break";
codeName[8] = "backspace";
codeName[9] = "tab";
codeName[12] = "clear"; 
codeName[13] = "enter"; 
codeName[16] = "shift"; 
codeName[17] = "control"; 
codeName[18] = "alt"; 
codeName[19] = "pause";
codeName[20] = "capslock"; 
codeName[27] = "escape"; 
codeName[32] = "spacebar"; 
codeName[33] = "pageup"; 
codeName[34] = "pagedown";
codeName[35] = "end";
codeName[36] = "home";
codeName[37] = "left";
codeName[38] = "up";
codeName[39] = "right";
codeName[40] = "down";
codeName[45] = "insert";
codeName[46] = "delete";
codeName[47] = "help";
codeName[48] = "0";
codeName[49] = "1";
codeName[50] = "2";
codeName[51] = "3";
codeName[52] = "4";
codeName[53] = "5";
codeName[54] = "6";
codeName[55] = "7";
codeName[56] = "8";
codeName[57] = "9";
codeName[65] = "A";
codeName[66] = "B";
codeName[67] = "C";
codeName[68] = "D";
codeName[69] = "E";
codeName[70] = "F";
codeName[71] = "G";
codeName[72] = "H";
codeName[73] = "I";
codeName[74] = "J";
codeName[75] = "K";
codeName[76] = "L";
codeName[77] = "M";
codeName[78] = "N";
codeName[79] = "O";
codeName[80] = "P";
codeName[81] = "Q";
codeName[82] = "R";
codeName[83] = "S";
codeName[84] = "T";
codeName[85] = "U";
codeName[86] = "V";
codeName[87] = "W";
codeName[88] = "X";
codeName[89] = "Y";
codeName[90] = "Z";
codeName[91] = "Windows key";
codeName[93] = "Context menu";
codeName[96] = "numbpad0";
codeName[97] = "numbpad1";
codeName[98] = "numbpad2";
codeName[99] = "numbpad3";
codeName[100] = "numbpad4";
codeName[101] = "numbpad5";
codeName[102] = "numbpad6";
codeName[103] = "numbpad7";
codeName[104] = "numbpad8";
codeName[105] = "numbpad9";
codeName[106] = "numbpad*";
codeName[107] = "numbpad+";
codeName[108] = "numbpadenter";
codeName[109] = "numbpad-";
codeName[110] = "numbpad.";
codeName[111] = "numbpad/";
codeName[112] = "F1";
codeName[113] = "F2";
codeName[114] = "F3";
codeName[115] = "F4";
codeName[116] = "F5";
codeName[117] = "F6";
codeName[118] = "F7";
codeName[119] = "F8";
codeName[120] = "F9";
codeName[121] = "F10";
codeName[122] = "F11";
codeName[123] = "F12";
codeName[124] = "F13";
codeName[125] = "F14";
codeName[126] = "F15";
codeName[144] = "numlock";
codeName[145] = "Scroll lock";
codeName[186] = ";";
codeName[187] = "=";
codeName[188] = ",";
codeName[189] = "-";
codeName[190] = ".";
codeName[191] = "/";
codeName[192] = "`";
codeName[219] = "[";
codeName[220] = "\\";
codeName[221] = "]";
codeName[222] = "'";

function setDefaultControls() {
	//keyword: SharedObject
	op_volume = 100;

	key_aim = "auto"; //else "expert"
	key_move = "mouse"; //else "keyboard"
	detectKeys_function = detectKeys_auto_mouse; //redundant, is set in gameMode

	key_left = 37;
	key_right = 39;
	key_up = 38;
	key_down = 40;
	
	key_aimUp = 69;
	key_aimDown = 68;
	key_aimLeft = 83;
	key_aimRight = 70;
	
	key_shoot = 90;
	key_pause = 80;

	key_ed_up = 69;
	key_ed_down = 68;
	key_ed_left = 83;
	key_ed_right = 70;
	key_ed_rotateLeft1 = 87;
	key_ed_rotateRight1 = 82;
	key_ed_rotateLeft45 = 81;
	key_ed_rotateRight45 = 84;
	key_ed_delete = 32;
	key_ed_lock = 86;
	key_ed_nextParent = 71;
	key_ed_prevParent = 65;
	key_ed_xscale = 90;
	key_ed_yscale = 88;
	key_ed_xyscale = 67;
	
	key_ed_duplicate = undefined;
	key_ed_selAll = undefined;
	key_ed_selCore = undefined;
}

if (userSettings_so.data.left != undefined){
	//keyword: SharedObject
	op_volume = userSettings_so.data.volume;
	_quality = userSettings_so.data.qual;
	if (userSettings_so.data.showFPS == (fpsCounter==undefined))
		toggleFPScounter();
	
	key_aim = userSettings_so.data.aim;
	key_move = userSettings_so.data.move;

	key_left = userSettings_so.data.left;
	key_right = userSettings_so.data.right;
	key_up = userSettings_so.data.up;
	key_down = userSettings_so.data.down;
	
	key_aimLeft = userSettings_so.data.aimLeft;
	key_aimRight = userSettings_so.data.aimRight;
	key_aimUp = userSettings_so.data.aimUp;
	key_aimDown = userSettings_so.data.aimDown;
	
	key_shoot = userSettings_so.data.shoot;
	key_pause = userSettings_so.data.pause;

	key_ed_up = userSettings_so.data.ed_up;
	key_ed_down = userSettings_so.data.ed_down;
	key_ed_left = userSettings_so.data.ed_left;
	key_ed_right = userSettings_so.data.ed_right;
	key_ed_rotateLeft1 = userSettings_so.data.ed_rotateLeft1;
	key_ed_rotateRight1 = userSettings_so.data.ed_rotateRight1;
	key_ed_rotateLeft45 = userSettings_so.data.ed_rotateLeft45;
	key_ed_rotateRight45 = userSettings_so.data.ed_rotateRight45;
	key_ed_delete = userSettings_so.data.ed_delete;
	key_ed_lock = userSettings_so.data.ed_lock;
	key_ed_nextParent = userSettings_so.data.ed_nextParent;
	key_ed_prevParent = userSettings_so.data.ed_prevParent;
	key_ed_xscale = userSettings_so.data.ed_xscale;
	key_ed_yscale = userSettings_so.data.ed_yscale;
	key_ed_xyscale = userSettings_so.data.ed_xyscale;
	
	key_ed_duplicate = userSettings_so.data.ed_duplicate;
	key_ed_selAll = userSettings_so.data.ed_selAll;
	key_ed_selCore = userSettings_so.data.ed_selCore;
} else {
	setDefaultControls();
}

//IDE helper:
createTextField ("ideHelpTxt",d_ideHelpTxt,0,0,800,100);
ideHelpTxt.autoSize = true;
ideHelpTxt.selectable = false;
ideHelpTxt.background = true;
ideHelpTxt.backgroundColor = "0x444444";
ideHelpTxt.html = true;
ideHelpTxt.setTxt = function (txt) {
	if (txt==undefined) {
		this._visible = false;
	} else {
		this._visible = true;
		this.htmlText = "<font color=\"#FFFFFF\">"+txt+"</font>";
		this._x = _xmouse+20;
		this._y = _ymouse+20;
		
		if (this._y + this._height > STAGE_H)
			this._y = STAGE_H - this._height;
		if (this._x + this._width > STAGE_W)
			this._x = STAGE_W - this._width;
			
		if (this._y < 0)
			this._y = 0;
		if (this._x < 0)
			this._x = 0;
	}
};
ideHelpTxt.setTxt();
ideHelpTxt._alpha = 50;

function gameLoop() {
	detectKeys();	
	updateEnemies();
	updateBullets();
	coreAI();
	
	curFrame++;
}

function gameMode(lvl) { //lvl:Object will contain arrays (AI and code (and sometimes a 3rd, "init")) and other vars
	if (lvl.username != undefined) { //this is a loaded level, update its play count
		// varsOut = new LoadVars;
		// varsIn = new LoadVars;
		// varsOut.username = lvl.username;
		// varsOut.name = lvl.name;
		// varsOut.ID = lvl.ID;
		// varsOut.m = 1;
		// varsOut.sendAndLoad("http://zf.skylogic.ca/game/updateCount.php", varsIn, "POST");
		
		if (lvl.freezeAtFrame == null or lvl.freezeAtFrame == -1) {
			// if freezeAtFrame is NOT being used (for the purpose of automatically taking screenshots)
			// then proceed (otherwise don't add a play count)

			//Update stats_plays (as of CI, uses session to determine which user to save to)
			varsOut = new LoadVars;
			varsIn = new LoadVars;
			varsOut.LID = lvl.LID;
			varsOut.sendAndLoad(savePlayURL, varsIn, "POST");
		}
	}

	currentLvlObject = lvl;

	this.setupGameLoop = function() {
		this.onKeyDown = null;
		this.onMouseDown = null;

		curFrame = 0; //for makeTrigger AI, and for timeFramesSpent statistic. This should, logically, be executed before Parse AI Commands, though maybe not critical

		gunArray=[];

		if (lvl.freezeAtFrame != null and lvl.freezeAtFrame != -1) {
			// if freezeAtFrame is being used (for the purpose of automatically taking screenshots)
			// then we will hide the ship
			shipDisabled = true;

			// and hide FPS text, if any
			removeFPScounter();
		} else {
			shipDisabled = false;
		}
		attachShip(shipDisabled);

		//CREATE LVL:
		//Initiate any custom level stuff: (such as attaching the tutorial for the first level)
		lvl.init();

		//Get code
		var code = lvl.code;

		//Attached specified parts
		for (var i=0; i<code.length; i++) {
			attachPart.apply(_root, code[i]);
		}

		//Get list of ai functions (in an array) where the first element defines a functions to be called when the core should use its guns
		//	var levelAI = lvl.AI;
		var lvlAI_clone=[];
		lvlAI_clone = lvlAI_clone.concat(lvl.AI);

		//Set core's gun ai
		currentLvl_coreGunAI = _root[lvlAI_clone.shift()];
		if (gunArray.length==0) {
			gunArray.push(ai_ob);
		}

		//Set global array of core's ai (to be called every frame)
		currentLvl_coreAIfunctions = [];

		//Parse AI Commands
		for (var i = 0; i < lvlAI_clone.length; i++) {
			if (lvlAI_clone[i][0]==undefined) { //if not 2d array { convert to 2d array where first element is what the whole thing was before
				var tempElement = lvlAI_clone[i];
				lvlAI_clone[i] = [];
				lvlAI_clone[i].push(tempElement);
			}

			//This block just makes tempReturnParamArray equal to params? YES. array1=array2 would make a reference only, not a copy. Passing an array into a function also passes the reference only, and returns a reference.
			var tempReturnParamArray = [];
			for (var j = 1; j < lvlAI_clone[i].length; j++) tempReturnParamArray.push(lvlAI_clone[i][j]);

			tempReturnParamArray = _root[lvlAI_clone[i][0]+"_init"](tempReturnParamArray); //Call all init functions, and alter tempReturnParamArray (paramArray) if needed (ex: rotate part will convert rotate values from strings to numbers)
			//Note: any function using paramArray must return that same (or altered) array in its init() function or can return "initOnly" which means it wont be called every frame
			if (tempReturnParamArray=="initOnly") {
				continue;
			}

			addToCoreAIFunctions(_root[lvlAI_clone[i][0]], tempReturnParamArray); //param1: convert string to function object, param2: array of parameters
		}

		//Set HP
		calculateHP(enemies.e0);
		enemies.e0.hp *= 2;
		loopThrough(enemies.e0, calculateHP);

		//Set desired control scheme:
		if (key_aim=="expert") {
			detectKeys_function = _root["detectKeys_aimExpert_move_"+key_move];
		} else {
			if (key_aim=="auto") {
				if (key_move=="keyboard") {
					detectKeys_function = function () {
						detectKeys_aim_auto();
						detectKeys_move_keyboard();
					}
				} else if (key_move=="mouse") {
					detectKeys_function = function () {
						detectKeys_aim_auto();
						detectKeys_move_mouse();
					}
				}
			} else if (key_aim=="keyboard") {
				if (key_move=="keyboard") {
					detectKeys_function = function () {
						detectKeys_aim_keyboard();
						detectKeys_move_keyboard();
					}
				} else if (key_move=="mouse") {
					detectKeys_function = function () {
						detectKeys_aim_keyboard();
						detectKeys_move_mouse();
					}
				}
			} else if (key_aim=="mouse") {
				if (key_move=="keyboard") {
					detectKeys_function = function () {
						detectKeys_aim_mouse();
						detectKeys_move_keyboard();
					}
				} else if (key_move=="mouse") {
					detectKeys_function = function () {
						detectKeys_aim_mouse();
						detectKeys_move_mouse();
					}
				}
			}
		}
		detectKeys_moving = _root["detectKeys_move"+key_move]; //These lines are copied to openKeySettings()
		detectKeys_aiming = _root["detectKeys_aim"+key_aim];
		this.onMouseDown = function () {
			mouseDown=true;
		}
		this.onMouseUp = function () {
			stopDrag(); //should this really be here during gameplay? Yes, pause menu can be dragged
			mouseDown = false;
		}
		mouseDown = false;
		
		//END
		_root.ideHelpTxt.setTxt();
		
		//This is undefined if the core was destroyed on the 0th frame (By way of destroy command, or timed destroy, or some form of triggers)
		//The destroy code has its own way of dealing with onEnterFrame, and thus we don't want to override onEnterFrame to gameLoop if that is the case
		if (enemies.e0!=undefined) {

			if (lvl.freezeAtFrame != null and lvl.freezeAtFrame != -1) {
				// if freezeAtFrame is being used (for the purpose of automatically taking screenshots)
				// then we manually run the gameLoop n times
				for (var i = 0; i<lvl.freezeAtFrame; i++) {
					gameLoop();
				}
			} else {
				// normal behavior: run gameLoop
				this.onEnterFrame = gameLoop;
			}
		}
	}

	// set number of lives based on level
	if (!campaignMode) {
		lives = lvl.lives;
		livesSpent = 0;
		lifeCount.update();
	} else { //is a campaign
		if (currentLvl==0) lives = startingLives;
	}

	gotoAndStop("game");

	createEmptyMovieClip("enemies", d_allEnemies);
	createEmptyMovieClip("bullets", d_allBullets);
	createEmptyMovieClip("enemy_pixelBullets", d_allEnemyBullets);
	createEmptyMovieClip("enemy_shapeBullets", d_allEnemyBullets2);
	createEmptyMovieClip("enemy_destroyableBullets", d_allEnemyBullets3);
	createEmptyMovieClip("explosions", d_allExp);

	// create level message (or override it using skipLevelMsg="yes")
	if (lvl.skipLevelMsg != null and lvl.skipLevelMsg == "yes") {
		// skip the level message (and the "press any key" condition -- play the level immediately)
		this.setupGameLoop();
	} else {
		// Make level intro screen (has level name, and waits for user to hit any key to play)
		attachMovie("levelMsg", "levelMsg", d_levelMsgWin);
		
		if (!campaignMode) {
			if (lvl.name=="ZetaFlow-untitled") {
				var x = random(4);
				switch (x) {
					case 0:
						levelMsg.txt = "Your masterpiece awaits...";
						break;
					case 1:
						levelMsg.txt = "Get ready...";
						break;
					case 2:
						levelMsg.txt = "Your enemy is ready, are you?";
						break;
					case 3:
						levelMsg.txt = "Attack!!";
						break;
				}
			} else {
				levelMsg.txt = lvl.name;
			}
		} else { //is a campaign
			levelMsg.txt = "Level "+currentLvl;
		}

		// Press any key to begin
		this.onKeyDown = function() {
			removeMovieClip(levelMsg);
			this.setupGameLoop();
		}
		this.onMouseDown = function(){this.onKeyDown();};
	}
}

function attachShip(disabled) {
	attachMovie("ship", "ship", d_ship);
	ship.speed = SHIP_SPEED;
	ship._x = 400;
	ship._y = 500;
	ship.defaultDamage = SHIP_GUN_DAMAGE;
	ship.invincible=true;
	ship.autoAimerTarget=null;
	ship.autoAimerDist = 9999;
	// var a=aimer._rotation;
	attachMovie("aimer", "aimer", d_shipAimer);
	aimer._rotation = ship.turret._rotation = 270;
	
	ship._x = 400;
	ship._y = 500;
	
	//Life count:
	createEmptyMovieClip("lifeCount", d_lifeCount);
	lifeCount.x = lifeCount.y = 30;
	lifeCount.update = function() {//max shown lives: 25
		this.createEmptyMovieClip("shipHolder", 1);

		if (_root.lives<=-1) {
			this.shipHolder.attachMovie("infiniteLives", "infinite", 1);
			this.shipHolder.infinite._x = this.x;
			this.shipHolder.infinite._y = this.y;
		} else if (_root.lives > 5) {
			this.shipHolder.attachMovie("livesNum", "livesNum", 1);
			this.shipHolder.livesNum.txt = _root.lives;
			this.shipHolder.livesNum._x = -10;
			this.shipHolder.livesNum._y = 15;
			this.shipHolder.livesNum._alpha = 50;
		} else {
			for (var i = 0; i<_root.lives; i++) {
				this.shipHolder.attachMovie("ship", "ship"+i, i);
				var ob = this.shipHolder["ship"+i];
				ob._x = this.x + i*ob._width;
				ob._y = this.y;
				ob._alpha = 50;
				var col = new Color(ob);
				col.setRGB(0x999999);
			}
		}
	}
	lifeCount.update();

	if (disabled) {
		//only not visible when, say, automatically taking screenshots
		ship._visible = false; 
		aimer._visible = false;
		ship.gotoAndStop(3); // stop playing the animation (the shield animation). This (helps) makes the ship permanently invincible.
		ship.permanentlyInvincible = true;
	} else {
		ship.permanentlyInvincible = false;
		ship.gotoAndPlay(2);
	}
}

function clearGameMode() {
	ai_ob = null;
	destroyChildrenArray = [];
	currentLvl_coreAIfunctions = null;
	removeMovieClip(enemies);
	removeMovieClip(bullets);
	removeMovieClip(explosions);
	removeMovieClip(ship);
	removeMovieClip(enemy_pixelBullets);
	removeMovieClip(enemy_shapeBullets);
	removeMovieClip(enemy_destroyableBullets);
	removeMovieClip(aimer);
	removeMovieClip(tutorial);
	removeMovieClip(countdown);
	removeMovieClip(lifeCount);
	this.onEnterFrame = null;
	this.onMouseDown = null;
	this.onKeyDown = null;
	code = [];
	gunArray = [];
	timeArray = [];
	coreVars = new Object();
	ideHelpTxt.setTxt();
	tinyShot2Snd.stop("tinyShot2Snd");
}

function detectKeys() {
	detectKeys_moving();
	
	if (Key.isDown(key_pause)) { //P:ause
		openPauseMenu();
	}
}

//*******************Detect keys specialties
function detectKeys_moveKeyboard() {
	var left = Key.isDown(key_left);
	var right = Key.isDown(key_right);
	var up = Key.isDown(key_up);
	var down = Key.isDown(key_down);

	if (left) {
		ship._x -= ship.speed;
		if (ship._x < 0) ship._x = 0;
	} else
	if (right) {
		ship._x += ship.speed;
		if (ship._x > STAGE_W) ship._x = STAGE_W;
	}
	if (up) {
		ship._y -= ship.speed;
		if (ship._y < 0) ship._y = 0;
	} else
	if (down) {
		ship._y += ship.speed;
		if (ship._y > STAGE_H) ship._y = STAGE_H;
	}
	
	detectKeys_aiming(up, down, left, right);
		
	aimer._x = ship._x;
	aimer._y = ship._y;	
	ship.delay++;

	if (Key.isDown(key_shoot) or mouseDown) { //Shoot
		aimer.gotoAndStop(2);
		ship_fireBullet(ship.defaultDamage);
	} else { //not shooting
		aimer.gotoAndStop(1);
		_root.tinyShot2Snd.stop();
	}
}

function detectKeys_moveMouse() {
	var left = _xmouse < ship._x;
	var right = _xmouse > ship._x;
	var up = _ymouse < ship._y
	var down = _ymouse > ship._y;
	
	var xDist = _xmouse-ship._x;
	var yDist = _ymouse-ship._y;
	var dist = Math.sqrt((xDist*xDist)+(yDist*yDist));
	
	if (dist < ship.speed)
		var speed = dist;
	else
		var speed = ship.speed;
	
	var px = xDist/dist;
	var py = yDist/dist;
	ship._x += px*speed;
	ship._y += py*speed;
	
	if (ship._x < 0) ship._x = 0;
	if (ship._x > STAGE_W) ship._x = STAGE_W;
	if (ship._y > STAGE_H) ship._y = STAGE_H;
	if (ship._y < 0) ship._y = 0;

	detectKeys_aiming(up, down, left, right);
	
	aimer._x = ship._x;
	aimer._y = ship._y;	
	ship.delay++;
	if (Key.isDown(key_shoot) or mouseDown) { //Shoot
		aimer.gotoAndStop(2);
		ship_fireBullet(ship.defaultDamage);
	} else { //not shooting
		aimer.gotoAndStop(1);
		_root.tinyShot2Snd.stop();
	}
}

function detectKeys_aimExpert(u, d, l, r) { //Up, Down, Left, Right, Shoot
	if (l) {
		if (u)
			ship_adjustAimer(45);
		else if (d)
			ship_adjustAimer(-45);
		else
			ship_adjustAimer(0);
	} else
	if (r) {
		if (u)
			ship_adjustAimer(135);
		else if (d)
			ship_adjustAimer(-135);
		else
			ship_adjustAimer(180);
	}
	if (u) {
		if (!l and !r)
			ship_adjustAimer(90);
	} else
	if (d) {
		if (!l and !r)
			ship_adjustAimer(-90);
	}
}

function detectKeys_aimAuto(u, d, l, r, shoot) { //up down left right are ignored
	//Get dist of previously closest part (as it will likely be still be the closest)
	var ob = ship.autoAimerTarget;

	if (ob._x==undefined) {
		ship.autoAimerDist = 9999;
	} else {
		var dx = ob._x - ship._x;
		var dy = ob._y - ship._y;
		var dz = Math.sqrt(dx*dx+dy*dy);
		ship.autoAimerDist = dz;
	}
	
	//Find closest enemy part:
	for (var i in enemies) {
		var ob = enemies[i];
		
		if (!ob.invincible) {
			var dx = ob._x - ship._x;
			var dy = ob._y - ship._y;
			var dz = Math.sqrt(dx*dx+dy*dy);
			if (dz < ship.autoAimerDist) {
				ship.autoAimerTarget = ob;
				ship.autoAimerDist = dz;
			}
		}
	}
	//Or find closest enemy missile (destroyable bullet)
	for (var e in enemy_destroyableBullets) {
		var ob = enemy_destroyableBullets[e];
		var dx = ob._x - ship._x;
		var dy = ob._y - ship._y;
		var dz = Math.sqrt(dx*dx+dy*dy);
		if (dz < ship.autoAimerDist) {
			ship.autoAimerTarget = ob;
			ship.autoAimerDist = dz;
		}
	}
	
	//Now aim at the target:
	ob = ship.autoAimerTarget;
	var dx = ob._x - ship._x;
	var dy = ob._y - ship._y;
	var angle = Math.atan2(dy, dx) / PI_180; //converted to degrees
	var oldangle = aimer._rotation;
	
	var dist = oldangle - angle;
	if (dist < -180) angle-=360;
	else if (dist > 180) angle+=360;

	if (oldangle > angle+2)
		aimer._rotation = ship.turret._rotation = oldangle-2;
	else if (oldangle < angle-2)
		aimer._rotation = ship.turret._rotation = oldangle+2;
}

function detectKeys_aimManKeyboard(u,d,l,r,shoot) { //ignore everything except shoot
	var left = Key.isDown(key_aimLeft);
	var right = Key.isDown(key_aimRight);
	var up = Key.isDown(key_aimUp);
	var down = Key.isDown(key_aimDown);

	if (left) {
		if (up) aimer._rotation = ship.turret._rotation = -135;
		else if (down) aimer._rotation = ship.turret._rotation = 135;
		else aimer._rotation = ship.turret._rotation = 180;
	} else
	if (right) {
		if (up) aimer._rotation = ship.turret._rotation = -45;
		else if (down) aimer._rotation = ship.turret._rotation = 45;
		else aimer._rotation = ship.turret._rotation = 0;
	} else
	if (up) {
		aimer._rotation = ship.turret._rotation = -90;
	} else
	if (down) {
		aimer._rotation = ship.turret._rotation = 90;
	}
}

function detectKeys_aimManMouse() { //could accept parameters, but we don't need them in this case
	var dx = _xmouse - ship._x;
	var dy = _ymouse - ship._y;
	aimer._rotation = ship.turret._rotation = Math.atan2(dy, dx) / PI_180;
}

function ship_adjustAimer(angle) {
	if (!Key.isDown(key_shoot) and !mouseDown) {
		aimer._rotation = ship.turret._rotation = Math.round(aimer._rotation);

		var oldangle = aimer._rotation;

		var dist = oldangle - angle;

		if (dist==0) return; //dont need to do anything more

		if (dist < -180) angle-=360;
		else if (dist > 180) angle+=360;

		if (oldangle > angle)
			newangle = oldangle-5;
		else if (oldangle < angle)
			newangle = oldangle+5;

		newangle = Math.round(newangle);
		aimer._rotation = ship.turret._rotation = newangle;
	}
}

function attachPart(type, x, y, rotation, xscale, yscale, parent, me, colour) { //Added colour param 07-01-08
	//Convert strings to numbers
	x = Number(x);
	y = Number(y);
	rotation = Number(rotation);
	me = Number(me);
	//

	parent = _root.enemies[parent];

	enemies.attachMovie("e."+type, "e"+me, me);
	var ob = enemies["e"+me];
	ob.__proto__ = _root["e_"+type].prototype;
	ob.init();
	ob.HPin = ob.hp/3; //Which HP value should the damage indicator activate (set's ob.mc to frame 2, called "part -in" in library)
	ob.link = type;
	ob.me = me;

	ob._rotation = ob.origRotation = rotation;
	ob.rotation = 0;
	ob.c = Math.sqrt(x*x + y*y);
	ob.rotationFromParent = Math.atan2(y, x); //in radians

	ob._x = parent._x + x;
	ob._y = parent._y + y;
	
	ob._xscale = xscale*100;
	ob._yscale = yscale*100;

	ob.parent = parent;
	ob.me = me; //me is an integer
	ob.children = [];
	ob.deathTrigger = [];

	parent.children.push(ob);

	if (parent==undefined) {//must be a core and therefore needs an AI
		ai_ob = ob;
	}
	
	if (colour.length == 6)
		setColour(ob, colour);
	//else part's "class" (prototype) will set this part's default colour
	
	return ob;
}

function updateEnemies() {
	if (ai_ob.hitTest(ship._x, ship._y, true)) {
		hitShip();
	}
	loopThrough(ai_ob, updateChildren);
	for (var i=0; i<gunArray.length; i++) {
		gunArray[i].gunAI();
	}
	
	//Eye candy: damage indicators, only check every n frames to save cpu power
	damageInd_count++;
	if (damageInd_count==3) {
		damageInd_count=0;
		loopThrough(ai_ob, damageIndicators);
		if (ai_ob.hp < 3000) {
			ai_ob.mc.gotoAndStop(2);
		}
	}
}

function updateChildren(ob) {
	ob._rotation = (ob.parent._rotation-ob.parent.origRotation) + ob.origRotation + ob.rotation;

	var parentAngleRadians = (ob.parent._rotation - ob.parent.origRotation) * PI_180;
	var angle = parentAngleRadians + ob.rotationFromParent; //in radians

	var x = Math.cos(angle) * ob.c; //c is radius/hypotenuse/z/etc
	var y = Math.sin(angle) * ob.c;

	ob._x = x + ob.parent._x;
	ob._y = y + ob.parent._y;


	if (ob.hitTest(ship._x, ship._y, true)) {
		hitShip(ob);
	}
}

function damageIndicators(ob) {
	if (ob.hp < ob.HPin) {
		ob.mc.gotoAndStop(2);
	}
}

function loopThrough(child, func, param) {
	for (var i = 0; i<child.children.length; i++) {
		var ob = child.children[i];
 		func(ob, param);
		loopThrough(ob, func, param);
	}
}

function coreAI() {
	for (var i=0; i<currentLvl_coreAIfunctions.length; i++) {
		currentLvl_coreAIfunctions[i][0](currentLvl_coreAIfunctions[i][1]);
	}
}

/**
* @param func  Function object to be called every frame
* @param params  Array of parameters
*/
function addToCoreAIFunctions (func, params) {
	var newElement = [];
	newElement[0] = func; 
	newElement[1] = params;
	
	currentLvl_coreAIfunctions.push(newElement);
}
function delFromCoreAIFunctions (func, justOne, paramArray) {
	for (var i=0; i<currentLvl_coreAIfunctions.length; i++) {
		if (currentLvl_coreAIfunctions[i][0] == func) {
			if (paramArray != undefined) {
				var equal=true;
				for (var a=0; a<paramArray.length; a++) {
					if (String(paramArray[a]) != String(currentLvl_coreAIfunctions[i][1][a]) and currentLvl_coreAIfunctions[i][1][a]!=undefined) {
						equal=false;
					}
				}
				if (equal) {
					currentLvl_coreAIfunctions.splice(i, 1);
					if (justOne) return;
				}
			} else {
				currentLvl_coreAIfunctions.splice(i, 1);
				if (justOne) return;
			}
		}
	}
}
function ship_fireBullet(damage) {
	if (ship.delay>=SHIP_GUN_DELAY) {
		if (d_bullets >= d_maxBullets) d_bullets = 0;
		d_bullets++;
		bullets.attachMovie("b.z", "b"+d_bullets, d_bullets);
		var ob = bullets["b"+d_bullets];
		ob._x = ship._x;
		ob._y = ship._y;
		ob.v = 10;

		var angle = aimer._rotation;
		angle += (random(20) - 10) / 2;
		ob.a = angle * PI_180; //converted to radians
		ob._rotation = angle+90;

		ob.vx = Math.cos(ob.a) * ob.v;
		ob.vy = Math.sin(ob.a) * ob.v;

		ob.damage = damage;
		ob.gotoAndStop( Math.ceil(damage / SHIP_GUN_DAMAGE) );

		//tinyShotSnd.start(0,0);
		//sound effect is turned on inside aimer MC
		ship.delay=0;
	}
}
// function ship_chargeBullet() {
	// if (ship.charge < PI/2) {
		// ship.charge += 0.00872664625997165; //half a radian
		// ship.chargeDamage = 8000 * Math.cos(1.5707963267949-ship.charge) //90 degrees minus charge

		// d_exp++;
		// var fx = explosions.attachMovie("ship.chargeEffect", "chargeEffect"+d_exp, d_exp);
		// fx._rotation = random(360);
		// fx._x = ship._x;
		// fx._y = ship._y;
	// }
// }

function updateBullets() {
	for (var i in bullets) {
		var ob = bullets[i];
		if (ob._x < 0 or ob._x > STAGE_W) {
			ob.removeMovieClip();
			continue;
		}
		if (ob._y < 0 or ob._y > STAGE_H) {
			ob.removeMovieClip();
			continue;
		}

		// var x = Math.cos(ob.a) * r;
		// var y = Math.sin(ob.a) * r;

		ob._x += ob.vx;
		ob._y += ob.vy;

		if (ob.hitTest(enemies)) {
			for (var i in enemies) {
				var ob2 = enemies[i];
				if (ob2.hitTest(ob._x, ob._y, true)) {
					var ob2invinc=ob2.invincible;

					removeHP(ob2, ob.damage, false);
					checkHP(ob2);

					//destroyOb(ob, "bulletExp");
					destroyOb_bullet(ob, ob2invinc);
					continue;
				}
			}
		}
		for (var e in enemy_destroyableBullets) {
			var ob3 = enemy_destroyableBullets[e];
			if (ob.hitTest(ob3)) {
				var obinvinc=ob.invincible;
				var ob3invinc=ob3.invincible;
			
				// destroyOb(ob, "bulletExp");
				// destroyOb(ob3, "bulletExp");
				destroyOb_bullet(ob, ob3invinc);
				destroyOb_bullet(ob3, obinvinc);
				continue;
			}
		}
	}

	for (var j in enemy_pixelBullets) {
		var ob = enemy_pixelBullets[j];
		if (ob._x < 0 or ob._x > STAGE_W) {
			ob.removeMovieClip();
			continue;
		}
		if (ob._y < 0 or ob._y > STAGE_H) {
			ob.removeMovieClip();
			continue;
		}
		ob.a();

		ob._x += ob.vx;
		ob._y += ob.vy;

		if (ship.hitTest(ob._x, ob._y, true)) { //Shape of ship VS center point of shape
			// destroyOb(ob, "bulletExp");
			destroyOb_bullet(ob, ship.invincible);
			hitShip();
			continue;
		}
	}
	
	for (var k in enemy_shapeBullets) {
		var ob = enemy_shapeBullets[k];
		if (ob._x < 0 or ob._x > STAGE_W) {
			ob.removeMovieClip();
			continue;
		}
		if (ob._y < 0 or ob._y > STAGE_H) {
			ob.removeMovieClip();
			continue;
		}
		ob.a();

		ob._x += ob.vx;
		ob._y += ob.vy;

		if (ob.hitTest(ship._x, ship._y, true)) { //Shape of bullet VS center point of ship
			//destroyOb(ob, null); //no sense calling destroyOb if not making an explosion
			ob.removeMovieClip();
			hitShip();
			continue;
		}
	}
	
	for (var k in enemy_destroyableBullets) {
		var ob = enemy_destroyableBullets[k];
		if (ob._x < 0 or ob._x > STAGE_W) {
			ob.removeMovieClip();
		}
		if (ob._y < 0 or ob._y > STAGE_H) {
			ob.removeMovieClip();
		}
		ob.a();

		ob._x += ob.vx;
		ob._y += ob.vy;

		if (ship.hitTest(ob._x, ob._y, true)) {
			//destroyOb(ob, null); //no sense calling destroyOb if not making an explosion
			ob.removeMovieClip();
			hitShip();
			continue;
		}
	}
}

function planDestroyOb(ob, arr) {
	arr.push(ob);
}
function destroyOb(ob, expType) {
	d_exp++;
	if (d_exp > 200) d_exp=0;
	explosions.attachMovie(expType, "exp"+d_exp, d_exp);
	var exp = explosions["exp"+d_exp];
	exp._x = ob._x;
	exp._y = ob._y;

	exp._width = exp._height = (ob._width < ob._height) ? ob._width : ob._height;
	exp._rotation = random(360);

	//Syntax: ob.deathTrigger = [ [AIcommand1], [AIcommand2] ]
	
	for (var t=0; t<ob.deathTrigger.length; t++) { //This section taken from gameMode (parses AIcommand)
		var thisAICommand = ob.deathTrigger[t];
		var action = thisAICommand.shift();
		
		var tempReturnParamArray=[];
		tempReturnParamArray = _root["AI_"+action+"_init"](thisAICommand);
		if (tempReturnParamArray=="initOnly") {
			continue;
		}
		
		addToCoreAIFunctions(_root["AI_"+action], tempReturnParamArray); //param1: convert string to function object, param2: array of parameters
	}
	
	ob.removeMovieClip();
}
function destroyOb_bullet(ob, invincible) {
	if (!invincible)
		destroyOb(ob, "bulletExp");
	else
		destroyOb(ob, "invincibleBulletExp");
}

function removeFPScounter() {
	if (fpsCounter != undefined) {
		fpsCounter.removeMovieClip();
	}
}
function toggleFPScounter() {	
	if (fpsCounter==undefined) {
		attachMovie("fpsCounter", "fpsCounter", d_fpsCounter);
		fpsCounter._y = STAGE_H - fpsCounter._height;
		fpsCounter.onEnterFrame = function () {
			FPStime = getTimer()/1000;
			FPSthistime = FPStime-FPSoldtime;
			if (FPSthistime>=1) {
				this.fpsTxt = FPSframes;
				FPSframes = 0;
				FPSoldtime++;
			}
			else {
				FPSframes++;
			}
		}
	} else {
		fpsCounter.removeMovieClip();
	}
}

function removeHP(ob, amount, forceKill) {
	if (!ob.invincible or forceKill) {
		//ob.play();
		animateHit(ob);
		var percentDamage = (ob.hp - amount) / ob.hp;
		ob.hp -= amount;

		for (var i = 0; i<ob.children.length; i++) {
			var ob2 = ob.children[i];
			var newAmount = ob2.hp - (percentDamage * ob2.hp);
	 		removeHP(ob2, newAmount, false);
		}

		// checkHP(ob);
	}
}
function removeBonusHP(ob, num) {
	ob.parent.hp -= num*bonusHP;

	if (ob.parent.parent!=null)
		removeBonusHP(ob.parent, num);
}

function checkHP (ob) {
	if (ob.hp<=0) {
		if (ai_ob==ob) { //Defeated level? (Keyword=won, victory, level complete)
			if (currentLvlObject.username != undefined) { //this is a loaded level, update its win count
				// var varsOut = new LoadVars;
				// var varsIn = new LoadVars;
				// varsOut.username = currentLvlObject.username;
				// varsOut.name = currentLvlObject.name;
				// varsOut.ID = currentLvlObject.ID;
				// varsOut.m = 2;
				// varsOut.sendAndLoad("http://zf.skylogic.ca/game/updateCount.php", varsIn, "POST"); 
				//Update stats_wins (as of CI, uses session to determine which user to save to)		
				varsOut = new LoadVars;
				varsIn = new LoadVars;
				varsOut.LID = currentLvlObject.LID;
				varsOut.time = curFrame;
				varsOut.lives = livesSpent;
				varsOut.sendAndLoad(saveWinURL, varsIn, "POST");
			}
			
			attachMovie("e.core", "coreTemp", d_coreTemp);
			coreTemp._x = ai_ob._x;
			coreTemp._y = ai_ob._y;
			coreTemp._rotation = ai_ob._rotation;
			coreTemp._xscale = ai_ob._xscale;
			coreTemp._yscale = ai_ob._yscale;
			setColour(coreTemp, ai_ob.colR, ai_ob.colG, ai_ob.colB);
			temp2 = 30;
			this.onEnterFrame = coreExplode;
			
			ship.gotoAndStop(3);
			ship.invincible = true;
			ship.endGame = true;
			_root.tinyShot2Snd.stop();
		}

		//Find and queue all obs to destroy
		var unique = ob.getDepth();
		_root["destroyChildrenArray"+unique] = [];
		var dca = _root["destroyChildrenArray"+unique]; //Reference, so to not force the computer to re-evaluate the variable name. *Replacing all _root["destroyChildrenArray"+unique] with dca, and sending dca as params instead of unique*
		
		planDestroyOb(ob, dca);
		loopThrough(ob, planDestroyOb, dca);

		//Update destroyed object's parent
		removeFromArray(ob,ob.parent.children);

		//Destroy obs in queue
		removeBonusHP(ob, dca.length);
		for (var i=0; i<dca.length; i++) {
			var child = dca[i];

			//Need to be removed from gun array?
			for (var k=0; k<gunArray.length; k++) {
				if (gunArray[k] == child) {
					gunArray.splice(k, 1);
				}
			}

			//Remove it and attach explosion
			destroyOb(child, "exp");
		}
		
		delete dca;
		delete _root["destroyChildrenArray"+unique];
		

		//If core's the only one left, give it some weapons
		if (gunArray.length==0) {
			gunArray.push(ai_ob);
		}
	}
}

function calculateHP(ob) {
	var count=0;
	ob.hp += bonusHP*countChildren(ob, count);
}

function countChildren(ob, count) {
	for (var i = 0; i<ob.children.length; i++) {
		var ob2 = ob.children[i];
		count++;
 		count = countChildren(ob2, count);
	}
	return count;
}

/**
* Enemy's fireBullet
* @param shooter Part MC firing the bullet
* @param type Single, Laser, etc
* @param angle Angle in degrees
* @param box Container clip: enemy_shapeBullets, enemy_pixelBullets, or enemy_destroyableBullets
* @param mute Skip sound effect
*/
function enemy_fireBullet(shooter, type, angle, box, mute) {
	if (d_bullets >= d_maxBullets) d_bullets = 0;
	d_bullets++;

	box.attachMovie("b."+type, "b"+d_bullets, d_bullets);
	var ob = box["b"+d_bullets];

	ob.__proto__ = _root["b_"+type].prototype;
	ob.init(angle);

	ob.vx = Math.cos(ob.angleRad) * ob.v;
	ob.vy = Math.sin(ob.angleRad) * ob.v;

	ob._x = shooter._x;
	ob._y = shooter._y;

	ob._rotation = angle;
	
	ob.shooter = shooter;

	if (!mute) {
		_root[type+"Snd"].start(0,0);
	}
}

function hitShip(ob) {
	if (ship!=undefined) {
		if (!ship.invincible) {
			livesSpent++;
			aimer._x = 2000;
			var x = ship._x;
			var y = ship._y;
			destroyOb(ship, "exp");
			_root.tinyShot2Snd.stop();
			if (lives==0) {  //or undefined? infinite life glitch shouldn't happen, if it does, check for undefined here
				if (!campaignMode) {
					this.onEnterFrame = null;
					attachMovie("Ship.deathAnim", "ShipDeathAnim", d_ship);
					
					ShipDeathAnim._x = x;
					ShipDeathAnim._y = y;
				} else {
					clearGameMode()
					attachMovie("gameover", "gameover", 3575);
					gotoAndStop("menu");
				}
			} else {
				//Attach countdown which will call attachShip when it's done
				attachMovie("shipRespawnCountdown", "countdown", d_countdown);
								
				lives--;
				lifeCount.update();
			}
		} else {
			if (!ship.permanentlyInvincible) {
				//Hit while invincible (but not PERMANENTLY invincible) - renew shields (Also, inside ship movieclip, the shield will set speed to 3)
				ship.gotoAndPlay(3); //frame 3 because frame 2 has actionscript code that we dont want to run here, but the animation actually begins at frame 2 (we lose 1 frame).
			}

			// and push player away from core 
			var angle = Math.atan2(ai_ob._y - ship._y, ai_ob._x - ship._x);
			ship._x -= Math.cos(angle) * SHIP_SPEED;
			ship._y -= Math.sin(angle) * SHIP_SPEED;
		
			if (ship._x > STAGE_W) ship._x = STAGE_W;
			else if (ship._x < 0) ship._x = 0;
			if (ship._y > STAGE_H) ship._y = STAGE_H;
			else if (ship._y < 0) ship._y = 0;
		}
	}
}

function coreExplode() {
	temp++;
	updateBullets();

	if (temp%temp2 == temp2-1 and temp < 150) {
		temp2-=5;
		if (temp2<=0) temp2=2;
		var ob = attachMovie("invisibleShape", "emptyMC", 4000);
		ob._x = coreTemp._x + random(60) - 30;
		ob._y = coreTemp._y + random(60) - 30;
		ob._width = ob._height = 50+random(30);
		destroyOb(ob, "exp"); //expFire
	}
	if (temp==150) {
		var c = attachMovie("coreExplosion", "coreExplosion", d_coreExplosion);
		c._x = coreTemp._x;
		c._y = coreTemp._y;
		c._rotation = coreTemp._rotation;

		c._xscale = coreTemp._xscale;
		c._yscale = coreTemp._yscale;
		setColour(c, coreTemp.colR, coreTemp.colG, coreTemp.colB);
		destroyOb(coreTemp, "expShockwave");
	}
	if (temp==150 + 35) {
		temp=null;
		this.onEnterFrame = null;
		clearGameMode();

		onLevelComplete(true);
	}
}

function traceArray(MDarray) {
	var tracer = "[\n";
	for (var m=0; m<MDarray.length; m++) {
		tracer += "  [" + MDarray[m] + "]\n";
	}
	tracer+="]";
	trace(tracer);
}

function openKeySettings() {
	//_root.pauseMenu.removeMovieClip();
	_root.ideHelpTxt.setTxt();

	if (keySettings == undefined) {
		attachMovie("keySettings", "keySettings", d_keySettings);
		keySettings._x = STAGE_W/2 - keySettings._width/2;
		keySettings._y = STAGE_H/2 - keySettings._height/2;
		
		with (keySettings) {
			bar.onPress = function () {
				startDrag();
			}
			bar.onRelease = function () {
				stopDrag();
			}
			_root.keySettings.closeFunction = function () {
				// get values of the dropdown boxes:
				_root.key_aim = aimingBox.getValue();
				_root.key_move = movingBox.getValue();

				with (_root) {
					//keyword: SharedObject
					userSettings_so.data.volume = _root.volumeMasterSnd.getVolume();
					userSettings_so.data.qual = _quality;
					userSettings_so.data.showFPS = _root.fpsCounter!=undefined;
				
					userSettings_so.data.aim = key_aim;
					userSettings_so.data.move = key_move;

					userSettings_so.data.left = key_left;
					userSettings_so.data.right = key_right;
					userSettings_so.data.up = key_up;
					userSettings_so.data.down = key_down;
					
					userSettings_so.data.aimLeft = key_aimLeft;
					userSettings_so.data.aimRight = key_aimRight;
					userSettings_so.data.aimUp = key_aimUp;
					userSettings_so.data.aimDown = key_aimDown;
					
					userSettings_so.data.shoot = key_shoot;
					userSettings_so.data.pause = key_pause;

					userSettings_so.data.ed_up = key_ed_up;
					userSettings_so.data.ed_down = key_ed_down;
					userSettings_so.data.ed_left = key_ed_left;
					userSettings_so.data.ed_right = key_ed_right;
					userSettings_so.data.ed_rotateLeft1 = key_ed_rotateLeft1;
					userSettings_so.data.ed_rotateRight1 = key_ed_rotateRight1;
					userSettings_so.data.ed_rotateLeft45 = key_ed_rotateLeft45;
					userSettings_so.data.ed_rotateRight45 = key_ed_rotateRight45;
					userSettings_so.data.ed_delete = key_ed_delete;
					userSettings_so.data.ed_lock = key_ed_lock;
					userSettings_so.data.ed_nextParent = key_ed_nextParent;
					userSettings_so.data.ed_prevParent = key_ed_prevParent;
					
					userSettings_so.data.ed_xscale = key_ed_xscale;
					userSettings_so.data.ed_yscale = key_ed_yscale;
					userSettings_so.data.ed_xyscale = key_ed_xyscale;
					
					userSettings_so.data.ed_duplicate = key_ed_duplicate;
					userSettings_so.data.ed_selAll = key_ed_selAll;
					userSettings_so.data.ed_selCore = key_ed_selCore;
					
					userSettings_so.flush();
					
					detectKeys_moving = _root["detectKeys_move"+key_move]; //These lines taken from gameMode() (a bit redundent, but neccessary)
					detectKeys_aiming = _root["detectKeys_aim"+key_aim];
				}

				this._visible=false; //Helps the editor_autoKeyListener work correctly

				// This MUST be the last line that accesses keySettings, otherwise Ruffle crashes.
				// removeMovieClip(this);
				_root.keySettings.removeMovieClip();
			}

			// "save and close" button
			close.onRelease = function () {
				_root.keySettings.customFunction();
				_root.keySettings.closeFunction();
			}
			
			_root.keySettings.deleteFunction = function () {
				with (_root) {
					//keyword: SharedObject
					delete userSettings_so.data.volume;
					delete userSettings_so.data.qual;
					delete userSettings_so.data.showFPS;
				
					delete userSettings_so.data.aim;
					delete userSettings_so.data.move;

					delete userSettings_so.data.left;
					delete userSettings_so.data.right;
					delete userSettings_so.data.up;
					delete userSettings_so.data.down;

					delete userSettings_so.data.aimUp;
					delete userSettings_so.data.aimDown;
					delete userSettings_so.data.aimLeft;
					delete userSettings_so.data.aimRight;
					
					delete userSettings_so.data.shoot;
					delete userSettings_so.data.pause;

					delete userSettings_so.data.ed_up;
					delete userSettings_so.data.ed_down;
					delete userSettings_so.data.ed_left;
					delete userSettings_so.data.ed_right;
					delete userSettings_so.data.ed_rotateLeft1;
					delete userSettings_so.data.ed_rotateRight1;
					delete userSettings_so.data.ed_rotateLeft45;
					delete userSettings_so.data.ed_rotateRight45;
					delete userSettings_so.data.ed_delete;
					delete userSettings_so.data.ed_lock;
					delete userSettings_so.data.ed_nextParent;
					delete userSettings_so.data.ed_prevParent;
					
					delete userSettings_so.data.ed_xscale;
					delete userSettings_so.data.ed_yscale;
					delete userSettings_so.data.ed_xyscale;
					userSettings_so.flush();
					
					setDefaultControls();
				}
				
				this._visible=false; //Helps the editor_autoKeyListener work correctly

				// This MUST be the last line that accesses keySettings, otherwise Ruffle crashes.
				// removeMovieClip(this);
				_root.keySettings.removeMovieClip();
			}

			//"reset settings"
			deleteSave.onRelease = function () {
				_root.keySettings.customFunction();
				_root.keySettings.deleteFunction();
			}
			
			//Audio volume:
			volumeSlider.btn.onPress = function () {
				this._parent.onEnterFrame = function () {
					this._x = this._parent._xmouse;
					
					if (this._x < this._parent.volumeSliderBG._x)
						this._x = this._parent.volumeSliderBG._x;
					else if (this._x > this._parent.volumeSliderBG._x+this._parent.volumeSliderBG._width)
						this._x = this._parent.volumeSliderBG._x+this._parent.volumeSliderBG._width;
						
					this.txt = int(((this._x - this._parent.volumeSliderBG._x) / this._parent.volumeSliderBG._width) * 100);
				}
				
				this._parent.onMouseUp = function () {
					this.onEnterFrame = null;
					_root.volumeMasterSnd.setVolume( int(((this._x - this._parent.volumeSliderBG._x) / this._parent.volumeSliderBG._width) * 100) )
					this.txt = "";
				}
			}
			volumeSlider._x = _root.volumeMasterSnd.getVolume()/100*volumeSliderBG._width + volumeSliderBG._x;
			
			qualityBtn.onRelease = function () {
				toggleHighQuality();
			}
			fpsBtn.onRelease = function () {
				_root.toggleFPScounter();
			}
		}
	} else
	if (!keySettings._visible) {
		keySettings._visible = true;
	}
}

/**
* Stop gameplay, stop certain animations, open pause menu
*/
function openPauseMenu(isMini) {
	if (pauseMenu == undefined) {
		stopAllSounds();

		//Stop animations:
		stopAllIn(enemy_shapeBullets);
		stopAllIn(enemies);
	
		attachMovie("pauseMenu", "pauseMenu", d_pauseMenu);
	
		//MochiAd
		//_root.createEmptyMovieClip("mochiad_mc", d_mochiad);
		//_root.mochiad_mc._x = 470;
		//_root.mochiad_mc._y = 320;
		//_root.MochiAd.showClickAwayAd({id:"22b632805117fda4", clip: _root.mochiad_mc});

		with (pauseMenu) {
			resumeBtn.onRelease = function () {
				//_root.MochiAd.unload(_root.mochiad_mc);
				this.customOnRelease();
			}
			resumeBtn.customOnRelease = function () {
				_root.unpause();
			}
			resumeBtn.onRollOver = function () {
				_root.ideHelpTxt.setTxt("<b>["+_root.codeName[_root.key_pause]+"]</b>");
			}
			resumeBtn.onRollOut = function () {
				_root.ideHelpTxt.setTxt();
			}
			
			optionsBtn.onRelease = function () {
				//_root.MochiAd.unload(_root.mochiad_mc);
				_root.openKeySettings();

				_root.keySettings.customFunction = function () { //executes when keySettings closes
					_root.openPauseMenu();
					_root.onMouseDown = function () {_root.mouseDown=true;};
					_root.keyListener.onKeyDown = null;
				}
				
				this._parent.removeMovieClip();
			}
			optionsBtn.onRollOver = function () {
				_root.ideHelpTxt.setTxt("<b>[O]</b>");
			}
			optionsBtn.onRollOut = function () {
				_root.ideHelpTxt.setTxt();
			}

			editorBtn.onRelease = function () {
				//_root.MochiAd.unload(_root.mochiad_mc);
				with (_root) {
					// onEnterFrame=_root.gameLoop;
					_root.ideHelpTxt.setTxt();
					clearGameMode()
					editorMode(false,false);
				}
				this._parent.removeMovieClip();
			}
			editorBtn.onRollOver = function () {
				_root.ideHelpTxt.setTxt("<b>[E]</b>");
			}
			editorBtn.onRollOut = function () {
				_root.ideHelpTxt.setTxt();
			}
			
			menuBtn.onRelease = function () {
				// _root.MochiAd.unload(_root.mochiad_mc);
				// _root.clearGameMode();
				_root.getURL(_root.rootURL, "_self");
			}
			
			miniBtn.onRelease = function () {
				_root.ideHelpTxt.setTxt();
				//_root.MochiAd.unload(_root.mochiad_mc);
				_root.pauseMenu._visible = false;
				_root.attachMovie("miniPauseMenu", "miniPauseMenu", d_miniPauseMenu);
				_root.center(_root.miniPauseMenu);
				_root.miniPauseMenu.onEnterFrame = function () {
					if (this._alpha>1) {
						this._alpha--;
					} else {
						this._alpha = 0;
						this.onEnterFrame = null;
					}
				}
				_root.miniPauseMenu.onMouseUp = function () {
					this.removeMovieClip();
					_root.unpause();
				}
			}
			miniBtn.onRollOver = function () {
				_root.ideHelpTxt.setTxt("Minimize. Good for taking screenshots");
			}
			miniBtn.onRollUp = function () {
				_root.ideHelpTxt.setTxt();
			}
		}

		// Handle hotkeys -- while in pauseMenu only
		this.onEnterFrame = function () {
			if (!Key.isDown(key_pause)) keyPause_released=true;
			if( (Key.isDown(key_pause) or Key.isDown(13)) and keyPause_released) { //(Pause key or ENTER) and pauseReleasedFromBefore
				keyPause_released=false;
				this.onEnterFrame=function () {
					if (!Key.isDown(key_pause) and !Key.isDown(13)) {
						pauseMenu.resumeBtn.onRelease();
					}
				}
			}
			
			if (Key.isDown(70)) { //f
				keyFPS_down=true;
			} else {
				if (keyFPS_down) {
					keyFPS_down=false;
					_root.toggleFPScounter();
				}
			}
			
			if (Key.isDown(81)) { //q
				keyQ_down=true;
			} else {
				if (keyQ_down) {
					keyQ_down=false;
					toggleHighQuality();
				}
			}

			if (Key.isDown(69)) { //'E' editor
				pauseMenu.editorBtn.onRelease();
			}
			
			if (Key.isDown(79)) { //'O' options menu
				pauseMenu.optionsBtn.onRelease();
			}
			
			// Secret hotkey: skip level in campaign mode by pressing equal key (which is + if holding shift, but + is not bound here)
			if (Key.isDown(187)) { //= +  skip level
				if (campaignMode) {
					clearGameMode();
					currentLvl++;
					gameMode(_root["level"+currentLvl]);
				}
			}
		};
	}
}
function unpause() {
	//Play animations:
	resumeAllIn(enemy_shapeBullets);
	resumeAllIn(enemies);
	
	ideHelpTxt.setTxt();
	pauseMenu.removeMovieClip();
	
	_root.onEnterFrame=_root.gameLoop;
	
	createEmptyMovieClip("onEnterFrameFix", d_onEnterFrameFix);
	onEnterFrameFix.onEnterFrame = function () {
		if (_root.onEnterFrame == undefined) {
			_root.onEnterFrame = _root.gameLoop;
		} else {
			this.onEnterFrame = null;
			this.removeMovieClip();
		}
	}
}
function stopAllIn(ob) {
	for (i in ob) {
		if (typeof(ob[i]=="object") or typeof(ob[i])=="movieclip") {
			ob[i].stop();
			stopAllIn(ob[i]);
		}
	}
}
function resumeAllIn(ob) {
	for (i in ob) {
		if (typeof(ob[i]=="object") or typeof(ob[i])=="movieclip") {
			if (!ob[i].antiPause)
				ob[i].play();
			resumeAllIn(ob[i]);
		}
	}
}

function getLevel(vars, mode, args) {
	var varsIn = new LoadVars;
	var varsOut = new LoadVars;

	if (vars.LID != undefined) {
		varsOut.LID = vars.LID;
	} else {
		varsOut.username = vars.username;
		varsOut.name = vars.name;		
	}

	varsOut.sendAndLoad(getLevelURL, varsIn, "POST");
	varsIn.onLoad = function (success) {
		if (success and this.success == "true") {
			_root.clearEditorMode();
			_root.clearGameMode();
			
			var tempLvlOb = editor_getLevelFromString(unescape(this.level));
			tempLvlOb.username = (this.username!=undefined) ? this.username : varsOut.username;
			tempLvlOb.name = (this.name!=undefined) ? this.name : varsOut.name;
			tempLvlOb.LID = (this.LID!=undefined) ? this.LID : varsOut.LID;
			tempLvlOb.lives = this.lives;
			tempLvlOb.rating = this.rating;
			tempLvlOb.link = this.link;
			tempLvlOb.type = this.type;
			tempLvlOb.hidden = this.hidden;
			tempLvlOb.skipLevelMsg = (args.skipLevelMsg!=null) ? args.skipLevelMsg : null;
			tempLvlOb.freezeAtFrame = (args.freezeAtFrame!=null) ? args.freezeAtFrame : null;

			if (mode==1) {
				gameMode(tempLvlOb);
			} else if (mode==2) {
				_root.currentLvlObject = tempLvlOb;
				editorMode(false,false);
			}
		} else {
			messageTrace("Failed to load level\nRequested level ID: "+varsOut.LID);
		}
	}
}

function onLevelComplete(beaten) {
	if (beaten) currentLvlObject.beaten=true;
	else currentLvlObject.beaten=false;

	clearGameMode();
	if (campaignMode) { //built in level
		campaign_onLevelComplete();
	} else { //custom level
		custom_onLevelComplete();
	}
}

function campaign_onLevelComplete() {
	currentLvl++;
	
	if (currentLvl > endLevel) {
		clearGameMode();
		attachMovie("victory", "victory", 3575);
	} else {
		lives++;
		lifeCount.update();
		gameMode(_root["level"+currentLvl]);
	}
}
function custom_onLevelComplete() {
//	adMessage.removeMovieClip(); //??? does adMessage exist anymore?

	openPauseMenu();

	if (currentLvlObject.link != "" and currentLvlObject.link > 0 and currentLvlObject.beaten) {
		pauseMenu.playTxt = "Play Next Level";
		pauseMenu.resumeBtn.customOnRelease = function () {
			getLevel( {LID:currentLvlObject.link}, 1, {});
			this._parent.removeMovieClip();
		}
	} else {
		pauseMenu.playTxt = "Retry";
		pauseMenu.resumeBtn.customOnRelease = function () {
			gameMode(currentLvlObject, currentLvlObject.name);
			this._parent.removeMovieClip();
		}
	}
	
	pauseMenu.optionsBtn.onRelease = function () {
		_root.openKeySettings();
		_root.keySettings.close.onRelease = function () {
			closeFunction();
			_root.custom_onAdComplete();
			_root.keySettings.removeMovieClip();
		}
	}
}

function messageTrace(txt, col) {
	attachMovie("message", "messageWin", d_messageWin);
	
	messageWin.outputTxt = txt;
	
	messageWin._x = STAGE_W/2 - messageWin._width/2;
	messageWin._y = STAGE_H/2 - messageWin._height/2;

	with (messageWin) {
		bar.onPress = function () {
			startDrag();
		}
		close.onRelease = function () {
			_root.ideHelpTxt.setTxt();
			this._parent.removeMovieClip();
		}
		close.onRollOver = function () {
			_root.ideHelpTxt.setTxt("<b>[ENTER]</b>");
		}
		close.onRollOut = function () {
			_root.ideHelpTxt.setTxt();
		}
		
		myformat = new TextFormat();
		myformat.color = col;
		output.setTextFormat(myformat);
	}
}

function setScale(ob, xscale, yscale) {
	ob._xscale = xscale;
	ob._yscale = yscale;
}

/** ob, 0x0066FF
      ob, 00, 66, FF*/
function setColour (ob, a,b,c) {
	if (arguments.length==2) { //using a 6 hex-digit number
		var colOb = new Color(ob);
		colOb.setRGB("0x"+a);
		
		ob.colR = a.substr(0,2);
		ob.colG = a.substr(2,2);
		ob.colB = a.substr(4,2);
	} else { //using 3 two hex-digit numbers
		var col = new Color(ob);
		col.setRGB("0x"+a+b+c);
		ob.colR=a;
		ob.colG=b;
		ob.colB=c;
	}
}

function animateHit (ob) {
	if (!ob.invincible) {
		ob.t=0;

		var r = ob.colR;
		var g = ob.colG;
		var b = ob.colB;
		r = parseInt("0x"+r);
		g = parseInt("0x"+g);
		b = parseInt("0x"+b);

		ob.dr = (255-r) / 6;
		ob.dg = (255-g) / 6;
		ob.db = (255-b) / 6;

		var col = new Color(ob);

		ob.tempcolR = (255-ob.dr*2).toString(16);
		ob.tempcolG = (255-ob.dg*2).toString(16);
		ob.tempcolB = (255-ob.db*2).toString(16);

		col.setRGB("0x"+ob.tempcolR+ob.tempcolG+ob.tempcolB);
		
		ob.onEnterFrame = function () {
			this.t++;
			if (this.t==4) {
				this.t=0;
				this.onEnterFrame = null;
				var colOb = new Color(this);
				colOb.setRGB("0x"+this.colR+this.colG+this.colB);
				return;
			}
		
			var r = this.tempcolR;
			var g = this.tempcolG;
			var b = this.tempcolB;
			r = parseInt("0x"+r);
			g = parseInt("0x"+g);
			b = parseInt("0x"+b);	
			
			r-=this.dr;
			g-=this.dg;
			b-=this.db;

			this.tempcolR = r.toString(16); //Convert decimal number to hex
			this.tempcolG = g.toString(16);
			this.tempcolB = b.toString(16);

			if (this.tempcolR.length==1) this.tempcolR = "0"+this.tempcolR; //Pad with 0s
			if (this.tempcolG.length==1) this.tempcolG = "0"+this.tempcolG;
			if (this.tempcolB.length==1) this.tempcolB = "0"+this.tempcolB;
			
			var colOb = new Color(this);
			colOb.setRGB("0x"+this.tempcolR+this.tempcolG+this.tempcolB);
		}
	}
}

function setGunEnable(ob,en) {
	removeFromArray(ob,gunArray);

	if (en) {
		gunArray.push(ob);
	}
}

function removeFromArray(item,arr) {
	for (var i=0; i<arr.length; i++) {
		if (arr[i]==item)
			arr.splice(i, 1);
	}
}
function existsInArray(item, arr) { //Check if item exists within array, used by editor_click, and others
	for (var i=0; i<arr.length; i++) {
		if (arr[i] == item) {
			return true;
		}
	}
	return false;
}

function timeTriggerCheck() {
	if (timeArray[curFrame] != undefined) { //There exists event(s)
		for (var i=0; i<timeArray[curFrame].length; i++) { //For every event	
			//***Modified from gameMode (don't actually remember how this works, just going on the assumption that it does indeed work :P)
			var params = timeArray[curFrame][i]; //params is like the ones that go into gameMode except these look like [0,anyAICommand] or [1,repeatInterval,anyAIcommand]
			timeTriggerExecute(params);
			delete timeArray[curFrame][i];
		}
		delete timeArray[curFrame];
	}
}
function timeTriggerExecute(params) {
	var repeat = int(params.shift());
	if (repeat) {
		var repeatInterval = int(params.shift());

		var frameNum = curFrame + repeatInterval;
		if (timeArray[frameNum]==undefined) timeArray[frameNum]=[];
		timeArray[frameNum].push([1, repeatInterval].concat(params));
	}
	
	//Make copy of params, so I don't alter the original.
	var tempReturnParamArray = [];
	for (var j = 1; j < params.length; j++) tempReturnParamArray.push(params[j]);

	//Added "AI_" for timeTriggerCheck only, as it is does elsewhere for main ai code.
	tempReturnParamArray = _root["AI_"+params[0]+"_init"](tempReturnParamArray); //Call all init functions, and alter tempReturnParamArray (paramArray) if needed (ex: rotate part will convert rotate values from strings to numbers)
	//Note: any function using paramArray must return that same (or altered) array in its init() function (otherwise it will be set to undefined)
	if (tempReturnParamArray=="initOnly") {
		return;
	}

	addToCoreAIFunctions(_root["AI_"+params[0]], tempReturnParamArray); //param1: convert string to function object, param2: array of parameters
	//***
}

function center(ob) {
	ob._x = STAGE_W/2 - ob._width/2;
	ob._y = STAGE_H/2 - ob._height/2;
}

function checkIfSkipIntro() {
	skip_button.onRelease = function () {
	  _root.play();
	}

	// If playing a specific level (from user-gallery), then url_blah variables will be non-null.
	if (url_username == null and url_editor == null and url_options == null and url_LID==null) {
		// playing "campaign" mode (i.e. not playing a specific level)
		_root.stop(); // stop in current frame, where the intro is placed on the scene (see flash IDE)
	}
}
function gameLoad() {
	campaignMode = false;
	currentLvl = 0;

	stop();
	Key.addListener(this);

	//HTML/PHP INTERFACE
	if (php_loggedIn == "true") {
		loginOb.loggedIn = true;
		loginOb.username = php_username;
		loginOb.email = php_email;
		loginOb.language = php_language;
		loginOb.power = php_power;
		loginOb.UID = php_UID;
		loginOb.pw = php_password;
	}

	if (url_editor == "true") {
		if (url_LID != null) {
			getLevel({LID:url_LID}, 2, {});
			delete url_LID;
		} else {	
			editorMode(true,true);
		}
		delete url_editor;
	} else
	if (url_LID != null) {
		vars = {LID:url_LID};
		args = {};
		if (url_skipLevelMsg != null) {
			args.skipLevelMsg = url_skipLevelMsg;
			delete url_skipLevelMsg;
		}
		if (url_freezeAtFrame != null) {
			args.freezeAtFrame = url_freezeAtFrame;
			delete url_freezeAtFrame;
		}
		getLevel(vars, 1, args);
		delete url_LID;
	} else
	if (url_username != null) {
		getLevel({username:url_username, name:url_name}, 1, {});
		delete url_username;
		delete url_name;
	} else
	if (url_options == "true") {
		openKeySettings();
		delete url_options;

		_root.keySettings.customFunction = function () {
			getURL(rootURL, "_self");
		}
	} else {
		campaignMode = true;
		gameMode(_root["level"+currentLvl]);
	}

	//Ingame font: 
	//	BankGothic Lt Bt
	//Menu button font: 
	//	Brush455 BT
	//Title screen Fonts:
	//	Brush455 BT
	//	Cataneo Swash BT (Z only)
}

function loadRatingStars(ob) {
	with (ob) {
		if (_root.currentLvlObject.LID == undefined) _x = 9999;

		var left = mask._x;
		var right = mask._x + mask._width;
		var top = mask._y;
		var bottom = mask._y + mask._height;
		var width = mask._width;
		var percentage = 5;

		mask._width = _root.currentLvlObject.rating * width / 100;
		var rate = (_root.currentLvlObject.rating==undefined or _root.currentLvlObject.rating==0) ? "0" : _root.currentLvlObject.rating;
		output = int(_root.currentLvlObject.rating)+"/100\nClick to rate this level!";

		ob.onEnterFrame = function () {
			if (!submitted) {
				if (_xmouse >= left and _xmouse <= right) {
					if (_ymouse >= top and _ymouse <= bottom) {
						mask._width = Math.round((_xmouse - left) / (percentage/100*width)) * (percentage/100*width);
						_root.ideHelpTxt.setTxt(Math.round((_xmouse - left) / (percentage/100*width)) * percentage);
					}				
				}
			}
		}
		var submitted=false;
		starBtn.onRelease = function () {
			if (!submitted) {
				submitted=true;
				this._parent.onEnterFrame = null;	

				var rating = Math.round((_xmouse - left) / (percentage/100*width)) * percentage;
				if (rating < 0) rating=0;
				if (rating > 100) rating=100;
			
				var varsIn = new LoadVars;
				var varsOut = new LoadVars;
				
				varsOut.rating = rating;
				//varsOut.name = _root.currentLvlObject.name;
				//varsOut.username = _root.currentLvlObject.username;
				varsOut.LID = _root.currentLvlObject.LID;
				
				varsOut.sendAndLoad(_root.saveRatingURL, varsIn, "POST");
			
				varsIn.onLoad = function (success) {
					if (success) {
						if (this.error!=null) {
							output = this.error;
						} else {
							_root.currentLvlObject.rating = this.rating;
							mask._width = this.rating*width/100;
							output = int(this.rating)+"/100\nRating submitted";
						}
					}
				}
			}
		}
		starBtn.onRollOut = function () {
			_root.ideHelpTxt.setTxt();
			mask._width = _root.currentLvlObject.rating * width / 100;
		}
	}
}