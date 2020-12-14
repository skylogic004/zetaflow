var codeWithFormatting = [];
var codeCount;
var core;

var ed_levelOpen=false;
var ed_prevSelection=[];
var ed_autoBackup_intervalID;

var coreAIwindow;

function editorMode(showFileMenu, newDocument) {
	gotoAndStop("game");	
	campaignMode = false;
	gallery.removeMovieClip();

	//***FPS
	if (fpsCounter==undefined) toggleFPScounter();
	
	//***TUTORIAL WINDOW ???No longer showing tutorial by default
	// if (newDocument)
		// attachMovie("editor.tutorial", "tutorial", d_edTutorial);
		
	//***LIBRARY WINDOW
	attachMovie("editor.library", "library", d_library);
	library._x = STAGE_W - library._width - 10;
	library._y = 0;
	with (library) {
		bar.onPress = function () {
			startDrag();
		}

		com.boundingBox_mc._alpha = 0;
		com.onLoad = function () {
			for (var i in com.tmp_mc) { //For each part in library.parts
				//Set default colour (amongst other unnecessary properties)
				com.tmp_mc[i].onEnterFrame = function () {
					this.__proto__ = _root["e_"+this.link].prototype;
					this.init();
					this.onEnterFrame=null;
				}
				
				com.tmp_mc[i].onPress = function () {
					_root.editor_attachPart(this.link);
				}
				com.tmp_mc[i].onRollOver = function () {
					var nameTxt = (this.niceName!=undefined) ? this.niceName : this.link;
					_root.ideHelpTxt.setTxt(nameTxt);					
				}
				com.tmp_mc[i].onRollOut = function () {
					_root.ideHelpTxt.setTxt();
				}
			}
		}	
		
		com.advancedView = function () {
			for (var i in com.tmp_mc) { //For each part in library.parts
				com.tmp_mc[i].onPress = function () {
					_root.editor_attachPart(this.link);
				}
				com.tmp_mc[i].onRollOver = function () {
					var nameTxt = "Name: "+this.link;
					_root.ideHelpTxt.setTxt(nameTxt);					
				}
				com.tmp_mc[i].onRollOut = function () {
					_root.ideHelpTxt.setTxt();
				}
			}
			
			_root.library.com.advancedViewEnabled = true;
		}
	}
	
	//***TOOLS WINDOW
	attachMovie("editor.tools", "tools", d_tools);
	tools._x = 10;
	tools._y = 0;
	with (tools) {
		bar.onPress = function () {
			startDrag();
		}

		playBtn.onPress = function () {
			_root.editor_convertToGame();
		}
		playBtn.onRollOver = function () {
			_root.ideHelpTxt.setTxt("<b>["+_root.codeName[_root.key_pause]+"]</b> Play your creation. You can always come back here later");
		}
		playBtn.onRollOut = function () {
			_root.ideHelpTxt.setTxt();
		}

		helperBtn.onPress = function () {//same as ? key
			_root.editor_toggleHelper();
		}
		helperBtn.onRollOver = function () {
			_root.ideHelpTxt.setTxt("<b>[?]</b> (Forward slash key)\nToggle helper to see how/where parts are linked (parent part)\n<font color=\"#FFCC33\">Orange</font> lines snap to closest part\n<font color=\"#FF1111\">Red</font> lines are locked (toggle lock with ["+_root.codeName[_root.key_ed_lock]+"])");
		}
		helperBtn.onRollOut = function () {
			_root.ideHelpTxt.setTxt();
		}
	//	_root.editor_toggleHelper(); //turn this one on by default
		editor_viewHierarchy();
		tools.helperMC.gotoAndStop(2);

		coreAIBtn.onPress = function () {
			_root.editor_toggleCoreAIwindow();
		}
		coreAIBtn.onRollOver = function () {
			_root.ideHelpTxt.setTxt("<b>[F2]</b> Set the core's AI");
		}
		coreAIBtn.onRollOut = function () {
			_root.ideHelpTxt.setTxt();
		}
		
		/*
		loginBtn.onPress = function () {
			_root.editor_toggleLoginWin();
		}
		loginBtn.onRollOver = function () {
			_root.ideHelpTxt.setTxt("<b>[L]</b> Login. This will allow you to save your level");
			//Login btn is used as Levels button after login. See enableLogin()
		}
		loginBtn.onRollOut = function () {
			_root.ideHelpTxt.setTxt();
		}
		*/
		
		saveAsBtn.onPress = function () {
			_root.editor_toggleSaveAsWin();
		}
		saveAsBtn.onRollOver = function () {
			_root.ideHelpTxt.setTxt("<b>[CTRL s]</b> Save your masterpiece!");
		}
		saveAsBtn.onRollOut = function () {
			_root.ideHelpTxt.setTxt();
		}
		
		tutorialBtn.onPress = function () {
			attachMovie("editor.tutorial", "tutorial", d_edTutorial);
		}
		tutorialBtn.onRollOver = function () {
			_root.ideHelpTxt.setTxt("<b>[F1]</b> View the default controls for this editor.\nControls can be changed in the options menu");
		}
		tutorialBtn.onRollOut = function () {
			_root.ideHelpTxt.setTxt();
		}

		textEditBtn.onPress = function () {
			_root.editor_toggleTextEdit();
		}
		textEditBtn.onRollOver = function () {
			_root.ideHelpTxt.setTxt("<b>[F3]</b> Manually edit pieces in text");
		}
		textEditBtn.onRollOut = function () {
			_root.ideHelpTxt.setTxt();
		}

		// exitBtn.onPress = function () {
			// _root.editor_toMenu();
		// }
		// exitBtn.onRollOver = function () {
			// _root.ideHelpTxt.setTxt("Exit to main menu\nUnsaved changes <b>will be lost</b>!");
		// }
		// exitBtn.onRollOut = function () {
			// _root.ideHelpTxt.setTxt();
		// }
		menuBtn.onPress = function () {
			_root.editor_toggleFileMenuWin();
		}
		menuBtn.onRollOver = function () {
			_root.ideHelpTxt.setTxt("<b>[M]</b> Open Menu");
		}
		menuBtn.onRollOut = function () {
			_root.ideHelpTxt.setTxt()	
		}
	}
	
	//***PROPERTIES
	attachMovie("editor.properties", "properties", d_properties);
	properties._x = 0;
	properties._y = tools._y + tools._height + 10;
	
	with (properties) {
		bar.onPress = function () {
			startDrag();
		}
		
		//Tooltips for input fields:
		xBtn.onRollOver = function () {
			_root.ideHelpTxt.setTxt("Selection's X coordinate");
		}
		xBtn.onRollOut = function () {_root.ideHelpTxt.setTxt();}
		
		yBtn.onRollOver = function () {
			_root.ideHelpTxt.setTxt("Selection's Y coordinate");
		}
		yBtn.onRollOut = function () {_root.ideHelpTxt.setTxt();}
		
		angleBtn.onRollOver = function () {
			_root.ideHelpTxt.setTxt("Selection's angle in degrees");
		}
		angleBtn.onRollOut = function () {_root.ideHelpTxt.setTxt();}
		
		widthBtn.onRollOver = function () {
			_root.ideHelpTxt.setTxt("Selection's width");
		}
		widthBtn.onRollOut = function () {_root.ideHelpTxt.setTxt();}
		
		heightBtn.onRollOver = function () {
			_root.ideHelpTxt.setTxt("Selection's height");
		}
		heightBtn.onRollOut = function () {_root.ideHelpTxt.setTxt();}
		
		parentBtn.onRollOver = function () {
			_root.ideHelpTxt.setTxt("Selection's link (parent part)");
		}
		parentBtn.onRollOut = function () {_root.ideHelpTxt.setTxt();}
		
		//Buttons
		mirrorHorizBtn.onRelease = function () {
			_root.editor_mirror(true,false);
		}
		mirrorHorizBtn.onRollOver = function () {
			_root.ideHelpTxt.setTxt("<b>[z]</b> Mirror selection along the vertical axis");
		}
		mirrorHorizBtn.onRollOut = function () {
			_root.ideHelpTxt.setTxt();
		}
		
		mirrorVertBtn.onRelease = function () {
			_root.editor_mirror(false,true);
		}
		mirrorVertBtn.onRollOver = function () {
			_root.ideHelpTxt.setTxt("<b>[x]</b> Mirror selecion along the horizontal axis");
		}
		mirrorVertBtn.onRollOut = function () {
			_root.ideHelpTxt.setTxt();
		}
		
		mirrorBothBtn.onRelease = function () {
			_root.editor_mirror(true,true);
		}
		mirrorBothBtn.onRollOver = function () {
			_root.ideHelpTxt.setTxt("<b>[c]</b> Mirror selection along both axis");
		}
		mirrorBothBtn.onRollOut = function () {
			_root.ideHelpTxt.setTxt();
		}
		
		duplicateBtn.onRelease = function () {
			_root.editor_duplicate();
		}
		duplicateBtn.onRollOver = function () {
			var str = "<b>[CTRL d]</b> Duplicate the selection";
			if (_root.key_ed_duplicate==undefined) str+="\n(Can set an alternate key in the options menu)";
			else str+="\n<b>["+_root.codeName[_root.key_ed_duplicate]+"]</b> Alternate key for above";
			_root.ideHelpTxt.setTxt(str);
		}
		duplicateBtn.onRollOut = function () {
			_root.ideHelpTxt.setTxt();
		}
		
		selectAllBtn.onRelease = function () {
			_root.editor_selectAll();
		}
		selectAllBtn.onRollOver = function () {
			var str = "<b>[CTRL a]</b> Select (or deselect) all pieces";
			if (_root.key_ed_selAll==undefined) str+="\n(Can set an alternate key in the options menu)";
			else str+="\n<b>["+_root.codeName[_root.key_ed_selAll]+"]</b> Alternate key for above";
			_root.ideHelpTxt.setTxt(str);
		}
		selectAllBtn.onRollOut = function () {
			_root.ideHelpTxt.setTxt();
		}
		
		selectCoreBtn.onRelease = function () {
			_root.editor_selectOb(_root.core);
		}
		selectCoreBtn.onRollOver = function () {
			var str = "<b>[CTRL h]</b> Select the core";
			if (_root.key_ed_selCore==undefined) str+="\n(Can set an alternate key in the options menu)";
			else str+="\n <b>["+_root.codeName[_root.key_ed_selCore]+"]</b> Alternate key for above";
			_root.ideHelpTxt.setTxt(str);
		}
		selectCoreBtn.onRollOut = function () {
			_root.ideHelpTxt.setTxt();
		}
		
		//Color Picker. See MC for in-timeline code.
		colourPicker.color_main.onRollOver = function () {
			var str = "Pick a color to apply to the selected parts.";
			_root.ideHelpTxt.setTxt(str);
		}
		colourPicker.color_main.onRollOut = function () {
			_root.ideHelpTxt.setTxt();
		}
	}
	
	
	//***LOGGED IN ALREADY?
	//Logged in locally?
	if (loginOb.loggedIn) {
		enableLogin();
	} else {
		//Login credentials saved?
		/// not using SharedObjects anymore. instead lets delete any existing SO, so as to not leave a mess of on users' computers
		//Check local SharedObject:
		// if (login_so.data.username!=null) {
			// editor_login(login_so.data.username, login_so.data.pw, false, true);
		// }
		
		//Delete SO
		delete login_so.data.username;
		delete login_so.data.pw;
		login_so.flush();
		
	}
	//INITIATE LEVEL (EMPTY OR PREMADE)
	createEmptyMovieClip("enemies", d_allEnemies);
	if (showFileMenu) {
		editor_toggleFileMenuWin();
	}
	
	if (newDocument) { //Open a blank 'document'. Initiate core.
		var newcore = editor_attachPart("core", 400, 300, 0, 1, 1, null, d_e++);
		editor_setCore(newcore);
		currentLvlObject = {};
		ed_levelOpen=true;
	} else {
		//Only level owner can edit their level:
		if ((loginOb.loggedIn and loginOb.username==currentLvlObject.username) or (currentLvlObject.username==undefined and currentLvlObject.LID==undefined)) {//add 'or true' to disable security
			//******Load premade level
			for (var i=0; i<currentLvlObject.code.length; i++) {
				if (currentLvlObject.code[i][7]==0) {
					var newcore = editor_attachPart.apply(_root, currentLvlObject.code[i]);
					editor_setCore(newcore);
				} else {
					editor_attachPart.apply(_root, currentLvlObject.code[i]);
				}
			}

			currentLvlObject.editor_gun = currentLvlObject.AI.shift(); //get and remove first element
			currentLvlObject.editor_ai = currentLvlObject.AI; //remaining elements go into array

			//Strip "AI_" from each function string (hide it from player, as he doesn't need to see it)
			currentLvlObject.editor_gun = currentLvlObject.editor_gun.substr(3);
			for (var j=0; j<currentLvlObject.editor_ai.length; j++) {
				if (currentLvlObject.editor_ai[j][0]==undefined) {
					currentLvlObject.editor_ai[j] = [currentLvlObject.editor_ai[j].substr(3)]; //added [...] - It was treating single elements as a string instead of a 2D array with 1 element. So it was trying to use the string's length instead
				} else {
					currentLvlObject.editor_ai[j][0] = currentLvlObject.editor_ai[j][0].substr(3);
				}
			}
			//*****End
			ed_levelOpen=true;
		} else {
			if (!loginOb.loggedIn) {
				checkWebLogin(true);
				messageTrace("Checking if you have logged in...");
			} else {
				//Is logged in, but current user doesn't own this level
				messageTrace("Sorry, you can only edit your own levels.", "0xFF0000");
			}
		}
	}
	
	editor_createCoreAIwindow(); //create the AI code window, also fills its text field with the proper AI code (which has "AI_" stripped from it) from the editor_ai variable, however this variable does not maintain having no "AI_" (Text edit and display output cause it to have AI_ again).

	keyListener.onKeyDown = editor_detectKeys;
	
	this.onEnterFrame = editorLoop;
	this.onMouseUp = function () {
		stopDrag(); //should this really be here during gameplay? Yes, pause menu can be dragged
		
		//Round (or "snap") to nearest pixel, to avoid glitches with 0.9999999999999 pixels and such. Also does this onRelease
		//Was rounding everywhere, but now only doing it here to avoid messing with the required precision of trigonometry (rotating multiple pieces)
		library.selected[0]._x = Math.round(library.selected[0]._x);
		library.selected[0]._y = Math.round(library.selected[0]._y);
	}
	
	//Start automatically saving backups
	ed_autoBackup_intervalID = setInterval( editor_localSave, 30000 ); 
}

function editorLoop() {
	editor_selectionFollow();
	
	editor_refreshHierarchy();
}

function clearEditorMode() {
	codeCount=0;
	removeMovieClip(enemies);
	removeMovieClip(library);
	removeMovieClip(output);
	removeMovieClip(tools);
	removeMovieClip(coreAIwindow);
	coreAIwindow = undefined;
	removeMovieClip(hierarchyLine);
	removeMovieClip(properties);
	removeMovieClip(gallery);
	removeMovieClip(messageWin);
	removeMovieClip(saveAsWin);
	removeMovieClip(textEdit);
	keyListener.onKeyDown=null;
	this.onEnterFrame = null;
	this.onMouseDown = null;
	this.onKeyDown = null;
	this.onMouseMove = null;
	d_e=0;
	ideHelpTxt.setTxt();
	clearInterval(ed_autoBackup_intervalID);
	ed_autoBackup_intervalID = null;
}
function editor_toMenu() {
	getURL(rootURL, "_self");
}

function editor_attachPart(type, x, y, rotation, xscale, yscale, parent, me, colour) {
	//ob.children is set dynamically in editor_make_AI_code();
	//ob.permaParent: When tabbing, this var will be set to true and ob.parent will be set to parent that cannot be changed via auto createHierarchy. PermaParent will also be true when loading/reloading a level.

	if (arguments.length==1) { //New part
		var ob;
		ob = _root.attachPart(type, 0, 0, 0, 1, 1, null, d_e++);
	
		ob._x = _root._xmouse;
		ob._y = _root._ymouse;
		editor_click(ob);

		ob.permaParent = false;
	} else { //Loading premade part
		var ob;
		if (me >= d_e) d_e = int(me) + 1;
		ob = _root.attachPart(type, x, y, rotation, xscale, yscale, parent, me, colour);
		ob.permaParent = true;
	}
	
	//All editor parts have the following (except the core's onPress/Release should be overwritten via setCore): //No longer overwritten 23-12-07
	ob.onPress = function () {
		editor_click(this);
	}
	ob.onRelease = function () {
		_x = Math.round(_x);
		_y = Math.round(_y);
	}

	ob.onRollOver = function () {
		if (library.com.advancedViewEnabled) {
			var nameTxt = "Name: "+this.link;
			
			var parent = this.parent + ""; //_level0.enemies.StringIWant (concept from editor_getCode())
			parent = parent.substr(16);
			
			nameTxt+="\nPart #"+this.me;
			nameTxt+="\nParent: "+parent;	
			
			if (this.isGun) {
				nameTxt+="\n"+gunHelper[this.link];
			}
		} else {
			var nameTxt = (this.niceName!=undefined) ? this.niceName : this.link;
			nameTxt+="\nPart #"+this.me;
		}
		_root.ideHelpTxt.setTxt(nameTxt);
	}
	ob.onRollOut = function () {
		_root.ideHelpTxt.setTxt();
	}

	return ob;
}

//Note: See editor.properties for applying text settings to the target ob
function editor_click(btn) {  //The only thing this function does differently from selectOb is that it applies startDrag()
	if (Key.isDown(16)) { //Shift - group pieces together
		editor_selectOb(btn, true);
	} else { //Behave normally
		editor_selectOb(btn);
		btn.startDrag();
	}
}
function editor_selectionFollow() {
	//library.selected[0]._x = Math.round(library.selected[0]._x);
	//library.selected[0]._y = Math.round(library.selected[0]._y);
	
	var deltaX = library.selected[0]._x - ed_prevSelection[0];
	var deltaY = library.selected[0]._y - ed_prevSelection[1];
	
	var deltaAngle = library.selected[0]._rotation - ed_prevSelection[2];
	
	if (ed_prevSelection[3]==0)
		var deltaXScale=0;
	else if (ed_prevSelection[3]==undefined)
		var deltaXScale=1;
	else
		var deltaXScale = library.selected[0]._xscale / ed_prevSelection[3];
		
	if (ed_prevSelection[4]==0)
		var deltaYScale = 1;
	else if (ed_prevSelection[4]==undefined)
		var deltaYScale=1;
	else
		var deltaYScale = library.selected[0]._yscale / ed_prevSelection[4];
		
	var deltaPermaParent = ed_prevSelection[5] != library.selected[0].permaParent
	var deltaParent = ed_prevSelection[6] != library.selected[0].parent
	var deltaTargetSelection = ed_prevSelection[7] != library.selected[0];
	
	for (var i=1; i<library.selected.length; i++) { //Don't have the target selection, namely element 0, in this loop
		var ob = library.selected[i];

		ob._x += deltaX;
		ob._y += deltaY;
		//ob._x = Math.round(ob._x); //was rounding here
		//ob._y = Math.round(ob._y); //was rounding here
		
		if (deltaAngle!=0) { //Angle has changed
			ob._rotation += deltaAngle;
			
			var xDist = ob._x - library.selected[0]._x;
			var yDist = ob._y - library.selected[0]._y;
			var angleInitial = Math.atan2(yDist,xDist); //radians
			var angleNew = angleInitial + (deltaAngle*PI_180);
			
			if (ob.ed_c==undefined) //lock on to a specific radius when rotating (set it once, not every frame, to overcome issue with flash rounding to 2 decimal places)
				ob.ed_c = Math.sqrt(xDist*xDist + yDist*yDist);
				
			var x = Math.cos(angleNew) * ob.ed_c; //c is radius/hypotenuse/z/distance/etc
			var y = Math.sin(angleNew) * ob.ed_c;

			ob._x = x + library.selected[0]._x;
			ob._y = y + library.selected[0]._y;
		}
		
		ob._xscale *= deltaXScale;
		ob._yscale *= deltaYScale;
		
		//if parent lock has changed, other parts in the selection change too:
		if (deltaPermaParent)
			ob.permaParent = library.selected[0].permaParent;
		
		//if target ob's parent has changed, and target ob is using a permaParent, and the new parent is not in the current selection, and target selection has not changed since last time, then set each parent to be the same as target's parent
		if (deltaParent and library.selected[0].permaParent and !existsInArray(library.selected[0].parent, library.selected) and !deltaTargetSelection) {
			ob.parent = library.selected[0].parent;
		}
	}
	ed_prevSelection = [library.selected[0]._x, library.selected[0]._y, library.selected[0]._rotation, library.selected[0]._xscale, library.selected[0]._yscale, library.selected[0].permaParent, library.selected[0].parent, library.selected[0]];
}
function editor_selectOb(ob, addToGroup) {
	if (addToGroup) { //Add to previous selection or deselect
		if (!existsInArray(ob, library.selected)) { //Add ob to group if it's not there already
			library.selected.push(ob);
			editor_highlight(ob, 0);
		} else { //Deselect btn
			for (var i=0; i<library.selected.length; i++) {
				if (ob==library.selected[i]) {
					if (i==0) { //Need to change target before removing this ob
						if (library.selected.length>1) {
							editor_selectOb(library.selected[1], false);
							i=1;
						}
					}
				
					//Reset colour, then remove it from selection
					editor_unhighlight(ob);
					library.selected.splice(i,1);
				}
			}
		}
	} else if (existsInArray(ob, library.selected)) { //Ob is already selected, just make it the target (element 0)
		if (ob != library.selected[0]) {//Not already the target
			for (var i=1; i<library.selected.length; i++) { 
				library.selected[i].ed_c = undefined; //Reset every c (radius) value
				
				if (ob == library.selected[i]) //which index is the ob?
					var ii=i;
			}
			
			//Move target to the found index, then place the new ob (which existed in the found index) into element 0
			
			library.selected[ii] = library.selected[0];
			library.selected[0] = ob;
			
			ed_prevSelection = [library.selected[0]._x, library.selected[0]._y, library.selected[0]._rotation, library.selected._xscale[0], library.selected._yscale[0], library.selected[0].permaParent, library.selected[0]];
			
			//Colour old target to be normal selection colour
			editor_highlight(library.selected[ii], 0);			
			//Colour new target as target colour
			editor_highlight(ob, 1);
		}
	} else { //Start a new selection, the default bahavior
		for (var i=0; i<library.selected.length; i++) { //Forget previous selection
			library.selected[i].ed_c=undefined;
			library.selected[i].dragging=null;
			
			// setColour(library.selected[i], library.selected[i].col);
			editor_unhighlight(library.selected[i]);
		}
		library.selected = [];

		library.selected.push(ob);
		
		editor_highlight(ob, 1);
		
		ed_prevSelection = [library.selected[0]._x, library.selected[0]._y, library.selected[0]._rotation, library.selected._xscale[0], library.selected._yscale[0], library.selected[0].permaParent, library.selected[0]];
	}
}

function editor_convertToGame() {
	editor_make_AI_code();
	clearEditorMode();
	
	if (currentLvlObject.name==undefined) {
		currentLvlObject.name = "ZetaFlow-untitled";
	}
	gameMode(currentLvlObject);
}
function editor_detectKeys() {
	if (Key.isDown(16)) { //Shift
		/**All Shift combos:*/
		if (Key.isDown(key_ed_rotateLeft1)) { //w
			library.selected[0]._rotation -= 45;
		}
		if (Key.isDown(key_ed_rotateRight1)) { //r
	 		library.selected[0]._rotation += 45;
		}
		
		if (Key.isDown(key_ed_left) or Key.isDown(Key.LEFT)) { //left
			library.selected[0]._x -= 10;
		}
		if (Key.isDown(key_ed_right) or Key.isDown(Key.RIGHT)) { //right
			library.selected[0]._x += 10;
		}
		if (Key.isDown(key_ed_up) or Key.isDown(Key.UP)) {//up
			library.selected[0]._y -= 10;
		}
		if (Key.isDown(key_ed_down) or Key.isDown(Key.DOWN)) { //down
			library.selected[0]._y += 10;
		}
	} else {
		if (Key.isDown(17) and Key.isDown(83)) {//^s = Save as
			tools.saveAsBtn.onPress();
			return;
		}
		
		//Show output
		if (Key.isDown(17) and Key.isDown(192)) { //^` = Console
			attachMovie("editor.output", "output", d_output);
			output._x = 250;
			output._y = 250;
			with (output) {
				bar.onPress = function () {
					startDrag();
				}
				close.onRelease = function () {
					this._parent._visible = false;
				}
				refresh.onRelease = function () {
					_root.editor_showOutput();
				}
			}
			_root.editor_showOutput();
			return;
		}
	
		if ( (Key.isDown(17) and Key.isDown(68)) or Key.isDown(key_ed_duplicate) ) { //^d = duplicate
			editor_duplicate();
			return;
		}
		if ( (Key.isDown(17) and Key.isDown(72)) or Key.isDown(key_ed_selCore) ) { //^h = select core
			editor_selectOb(_root.core);
			return;
		}
		if ( (Key.isDown(17) and Key.isDown(65)) or Key.isDown(key_ed_selAll) ) { //^a = select all
			editor_selectAll();
			return;
		}
	
		if (Key.isDown(key_ed_delete) or Key.isDown(46)) { //spacebar, delete = delete
			editor_deleteSelection();
			return;
		}
		
		if (Key.isDown(key_ed_lock)) { //V   toggle lock parent
			if (library.selected[0].permaParent) {
				library.selected[0].permaParent=false;
			} else {
				library.selected[0].permaParent=true;
			}
			return;
		}

		if (Key.isDown(191)) { //forward slash / ?
			editor_toggleHelper();
		}
		
		if (Key.isDown(key_ed_nextParent)) { //G
			editor_tabToParent(1);
		}
		if (Key.isDown(key_ed_prevParent)) { //A
			editor_tabToParent(-1);
		}
		
		if (Key.isDown(key_ed_xscale)) {
			editor_mirror(true,false);
		}
		if (Key.isDown(key_ed_yscale)) {
			editor_mirror(false,true);
		}
		if (Key.isDown(key_ed_xyscale)) {
			editor_mirror(true,true);
		}
		
		if (Key.isDown(key_pause)) { //p
			editor_convertToGame();
		}
		
		if (Key.isDown(112)) { //Tutorial -> F1
			tools.tutorialBtn.onPress();
		}
		if (Key.isDown(113)) {//Core AI -> F2
			tools.coreAIBtn.onPress();
		}
		if (Key.isDown(114)) {//Text edit -> F3
			tools.textEditBtn.onPress();
		}
		if (Key.isDown(76)) {//Login or show Levels -> L
			tools.loginBtn.onPress();
		}
		
		if (Key.isDown(key_ed_rotateLeft1)) { //w = rotate left
			library.selected[0]._rotation -= 1;
		}
		if (Key.isDown(key_ed_rotateRight1)) { //r = rotate right
	 		library.selected[0]._rotation += 1;
		}
		if (Key.isDown(key_ed_rotateLeft45)) { //q
			library.selected[0]._rotation -= 45;
		}
		if (Key.isDown(key_ed_rotateRight45)) { //t
			library.selected[0]._rotation += 45;
		}
		if (Key.isDown(key_ed_left) or Key.isDown(Key.LEFT)) { //left
			library.selected[0]._x -= 1;
		}
		if (Key.isDown(key_ed_right) or Key.isDown(Key.RIGHT)) { //right
			library.selected[0]._x += 1;
		}
		if (Key.isDown(key_ed_up) or Key.isDown(Key.UP)) {//up
			library.selected[0]._y -= 1;
		}
		if (Key.isDown(key_ed_down) or Key.isDown(Key.DOWN)) { //down
			library.selected[0]._y += 1;
		}
		
		if (Key.isDown(77)) editor_toggleFileMenuWin();
	}
}

function editor_make_AI_code () {
	//Concatenate editor_gun and editor_ai together to form a complete AI array
	currentLvlObject.AI = [];
	currentLvlObject.AI[0] = currentLvlObject.editor_gun;

	currentLvlObject.AI = currentLvlObject.AI.concat(  removeWhitespace(currentLvlObject.editor_ai)  ); //Remove whitespace from user-inputted text (ONLY) then concat with coreGun which is set by dropdown list component

	//Append "AI_" to function names
	for (var j=0; j<currentLvlObject.AI.length; j++) { //editor can only use AI_ functions
		if (currentLvlObject.AI[j] != undefined and currentLvlObject.AI[j] != "" and currentLvlObject[j] != "\n") {
			if (currentLvlObject.AI[j][0] == undefined) {
				if (currentLvlObject.AI[j].substr(0,3) != "AI_") {
					currentLvlObject.AI[j] = "AI_"+currentLvlObject.AI[j];
				}
			} else {
				if (currentLvlObject.AI[j][0].substr(0,3) != "AI_") {
					currentLvlObject.AI[j][0] = "AI_"+currentLvlObject.AI[j][0];
				}
			}
		}
	}
	
	_root.codeCount=0;	
	currentLvlObject.code = [];
	currentLvlObject.code[0] = ["core", core._x, core._y, core._rotation, core._xscale/100, core._yscale/100, -1, 0, core.colR+core.colG+core.colB];

	editor_createChildList();
	loopThrough(core, editor_getCode); //getCode in order of existence

	//Remove whitespace from code
	currentLvlObject.code = removeWhitespace(currentLvlObject.code);

	_root.codeCount=null;
}

function editor_createChildList() {
	for (var h in enemies) {
		enemies[h].children = [];
	}
	for (var i in enemies) {
		var ob = enemies[i];
		ob.parent.children.push(ob); //set children to be used with loopThrough
	}
}

function editor_getCode(ob) {
	var parent = ob.parent;

	var x = ob._x - parent._x;
	var y = ob._y - parent._y;

	parent = parent + ""; //_level0.enemies.StringIWant
	parent = parent.substr(16);
	codeCount++;
	currentLvlObject.code[codeCount] = [ob.link, x, y, ob._rotation, ob._xscale/100, ob._yscale/100, parent, ob.me, ob.colR+ob.colG+ob.colB];
}
function editor_viewHierarchy() {
	createEmptyMovieClip("hierarchyLine", d_hierarchyLines);

	for (var i in enemies) {
		var ob = enemies[i];
		if (ob.parent != null) {
			if (!ob.permaParent) {
				hierarchyLine.lineStyle(1, "0xFFCC33", 90);
			} else {
				hierarchyLine.lineStyle(1, "0xFF1111", 90);
			}
		
			hierarchyLine.moveTo(ob._x, ob._y);
			hierarchyLine.lineTo(ob.parent._x, ob.parent._y);

			hierarchyLine.d++;
			hierarchyLine.attachMovie("b.round", "end_"+hierarchyLine.d, hierarchyLine.d);
			hierarchyLine["end_"+hierarchyLine.d]._alpha = 20;
			hierarchyLine["end_"+hierarchyLine.d]._x = ob._x;
			hierarchyLine["end_"+hierarchyLine.d]._y = ob._y;

			hierarchyLine.d++;
			hierarchyLine.attachMovie("b.square", "start_"+hierarchyLine.d, hierarchyLine.d);
			hierarchyLine["start_"+hierarchyLine.d]._alpha = 30;
			hierarchyLine["start_"+hierarchyLine.d]._x = ob.parent._x;
			hierarchyLine["start_"+hierarchyLine.d]._y = ob.parent._y;
			hierarchyLine["start_"+hierarchyLine.d]._rotation = Math.atan2(ob.parent._y-ob._y, ob.parent._x-ob._x) / PI_180 +180;
		}
	}
}
function editor_toggleHelper() {
	if (hierarchyLine==null) { //if off
		editor_viewHierarchy();
		tools.helperMC.gotoAndStop(2);
	} else { //on
		hierarchyLine.removeMovieClip();
		tools.helperMC.gotoAndStop(1);
	}
}

function editor_createHierarchy(selectedOb) {
	if (!selectedOb.permaParent) {
		var closestDist = 999999;
		var closestOb = null;

		for (var i in enemies) {
			var ob = enemies[i];

			var isGun=false;
			for (var k=0; k<gunArray.length; k++) { //A gun cannot be a parent
				if (gunArray[k] == ob) {
					isGun=true;
				}
			}
		
			if (ob != selectedOb and selectedOb != core) {
				var xDist = ob._x - selectedOb._x;
				var yDist = ob._y - selectedOb._y;
				var dist = Math.sqrt(xDist*xDist + yDist*yDist);
				if (dist < closestDist) {
					var linked = false;
					if (ob==core) {
						linked = true;
					} else {
						var theparent = ob.parent;
						var loop = true;
						while (loop) { //This is similar to editor_checkCoreInAncestry i think???
							if (theparent == selectedOb) {
								linked = false;
								loop=false;
								break;
							}

							if (theparent != undefined) {
								if (theparent == core) {
									linked = true;
									loop = false;
								}
							} else {
								linked = false;
								loop = false;
							}

							theparent = theparent.parent;
						}
					}

					if (linked and !isGun) {
						closestDist = dist;
						closestOb = ob;
					}
				}
			}
		}
		if (selectedOb != core and closestOb != null) {
			selectedOb.parent = closestOb;
		}
	}
}

function editor_tabToParent(dir, selectedOb) { //-1 is forward (because of post discovery that FOR loop starts at either last created object or highest depth). 1 is backward
	if (selectedOb==undefined)
		var selectedOb = library.selected[0];
		
	if (selectedOb != core) { //If the core could have a parent, we'd get a fun infinite loop of child parent child parent child...
		//Let's start by finding selectedOb's parent's place within the collection:
		var prevOb = null;
		var getNextOb=false;
		for (var i in enemies) {
			if (selectedOb.parent == enemies[i]) {//Found the selectedOb's parent, which direction are we going?
				if (dir==-1) { //Going forwards, need to figure out which ob is ahead of this one
					//Set this flag for later
					getNextOb=true;
					continue;
				} else
				if (dir==1) { //Going backwards, so use the prevOb, apply+close
					if (prevOb==null) { //At the start of the collection, wait to get last ob
						waitForLast=true;
						continue;
					} else { //Go backward normally
						selectedOb.parent = prevOb;
						selectedOb.permaParent=true;
						if (!editor_checkCoreInAncestry(selectedOb.parent,selectedOb)) editor_tabToParent(dir, selectedOb); //If core not found in ancestry, run this function again to pick the next ob (worst case screnario: selects core as parent after tons of recursion)
						return;
					}
				}
			} else
			if (getNextOb) { //Previous iteration set flag to use the next ob, apply+close
				if (selectedOb==enemies[i]) { //Skip itself
					continue;
				}
				
				selectedOb.parent = enemies[i];
				selectedOb.permaParent=true;
				getNextOb=false;
				if (!editor_checkCoreInAncestry(selectedOb.parent,selectedOb)) editor_tabToParent(dir, selectedOb); //If core not found in ancestry, run this function again to pick the next ob (worst case screnario: selects core as parent after tons of recursion)
				return;
			} else {
				if (enemies[i] != selectedOb) { //Skip itself
					prevOb = enemies[i];
				}
			}
		}
		
		//**Special conditions:	
		//When going FORWARD
		if (getNextOb) { //The above loop finished, but we haven't got the new parent yet
			//Enter the same loop again from the beginning
			for (var i in enemies) {
				if (selectedOb==enemies[i]) { //Skip itself
					continue;
				}
				
				selectedOb.parent = enemies[i];
				selectedOb.permaParent = true;
				if (!editor_checkCoreInAncestry(selectedOb.parent,selectedOb)) editor_tabToParent(dir, selectedOb); //If core not found in ancestry, run this function again to pick the next ob (worst case screnario: selects core as parent after tons of recursion)
				return;
			}
		}
		
		//When going BACKWARD
		if (waitForLast) { //Above loop should have set prevOb to be the last ob (and should verify that prevOb!=self)
			if (prevOb!=null) {
				selectedOb.parent = prevOb;
				selectedOb.permaParent=true;
				if (!editor_checkCoreInAncestry(selectedOb.parent,selectedOb)) editor_tabToParent(dir, selectedOb); //If core not found in ancestry, run this function again to pick the next ob (worst case screnario: selects core as parent after tons of recursion)
				return;
			}
		}
		//Uh oh, nothing above worked (probably only 1 part on the stage).
		//Lets just set the parent as the core, assuming they didn't delete the core :D
		selectedOb.parent = core;
		selectedOb.permaParent=true;
	}
}
function editor_checkCoreInAncestry(ob, startOb) {
	if (ob == core)
		return true;
	else if (ob == startOb or ob == undefined)
		return false;
	else
		return editor_checkCoreInAncestry(ob.parent, startOb);
}

function editor_getStringFromLevel() { //uses currentLvlObject's AI and code, (make function is called)
	editor_make_AI_code();

	var saveStr=""; //FORMAT: AI_coreGun_spread|AI_rotatePart,4,0.5,-45,90,0|AI_randomWaypoints<>core,300,200,0,-1,0|rhombus,-51,90,180,e0,3|and so on
	
	saveStr+=currentLvlObject.AI[0];
	for(var i=1; i<currentLvlObject.AI.length; i++) {
		if (currentLvlObject.AI[i] != undefined and currentLvlObject.AI[i] != "" and currentLvlObject.AI[i][0]!="" and currentLvlObject.AI[i]!="\n" and currentLvlObject.AI[i][0]!="\n" and currentLvlObject.AI[i]!="\t" and currentLvlObject.AI[i][0]!="\t") {
			saveStr+="|";
			for (var j=0; j<currentLvlObject.AI[i].length; j++) {
				if(currentLvlObject.AI[i][j]!=undefined) {
					saveStr+=currentLvlObject.AI[i][j];
					
					if (j<currentLvlObject.AI[i].length-1) saveStr+=",";
				}
			}
		}
	}

	saveStr+="<>";
	for (var k=0; k<currentLvlObject.code.length; k++) {
		if (currentLvlObject.code[k] != undefined) {
			if (k!=0) saveStr+="|";
			for (var l=0; l<currentLvlObject.code[k].length; l++) {
				saveStr+=currentLvlObject.code[k][l];
				if (l<currentLvlObject.code[k].length-1) saveStr+=",";
			}
		}
	}
	return saveStr;
}

function editor_getLevelFromString(str) {
	str = removeWhitespace(str);

	var strArray = str.split("<>");

	var levelAI = strArray[0].split("|");
	var levelCode = strArray[1].split("|");
	
	for (var i=0; i<levelAI.length; i++) {
		if (levelAI[i].indexOf(",") != -1) {
			levelAI[i] = levelAI[i].split(",");
		}
	}
	for (var i=0; i<levelCode.length; i++) {
		levelCode[i] = levelCode[i].split(",");
	}

	level = {AI:levelAI, code:levelCode};
	return level;
}

function removeWhitespace(arr) {//arr:Object or String
	if (typeof arr == "object") { //is an array
			for (var i=0; i<arr.length; i++) { //for each element in the array
				arr[i] = removeWhitespace(arr[i], canDelete);

				if (arr[i]=="" or arr[i].length==0) //empty string, delete it from array
					arr.splice(i,1);
			}
	} else
	if (typeof arr == "string") {
		arr = removeStringWhitespace(arr);
	}
	
	return arr;
}
function removeStringWhitespace(str) { //str:String
	//Get rid of 'Enter' s
	var strArray=[];
	strArray = str.split(String.fromCharCode(13));
	var newStr="";
	for (var i=0; i<strArray.length; i++) {
		newStr += strArray[i];
	}
	
	//Get rid of newline chars
	str = newStr;
	newStr="";
	strArray=[];
	strArray = str.split("\n");
	var newStr;
	for (var i=0; i<strArray.length; i++) {
		newStr += strArray[i];
	}
	
	str = newStr;
	newStr="";
	strArray=[];
	strArray = str.split(newline);
	var newStr;
	for (var i=0; i<strArray.length; i++) {
		newStr += strArray[i];
	}
	
	//Get rid of spaces
	str = newStr;
	newStr="";
	strArray=[];
	strArray = str.split(" ");
	var newStr;
	for (var i=0; i<strArray.length; i++) {
		newStr += strArray[i];
	}
	
	//Get rid of tabs
	str = newStr;
	newStr="";
	strArray=[];
	strArray = str.split("	");
	var newStr;
	for (var i=0; i<strArray.length; i++) {
		newStr += strArray[i];
	}
	str = newStr;
	newStr="";
	strArray=[];
	strArray = str.split("\t");
	var newStr;
	for (var i=0; i<strArray.length; i++) {
		newStr += strArray[i];
	}

	return newStr;
}

function editor_save(nameInput, typeData, linkInput, hidden) {
	if (loginOb.loggedIn and loginOb.username != null) {
		saveAsWin.gotoAndStop(2);

		varsIn = new LoadVars;
		varsOut = new LoadVars;
		
		varsOut.username = loginOb.username;
		varsOut.pw = loginOb.pw;
		
		if (nameInput.length==0 or nameInput.length==undefined) {
			saveAsWin.gotoAndStop(1);
			saveAsWin.outputTxt = "You must provide a name.";
			return;
		}
		
		if (linkInput<0) { //!!!Todo: Only allow linking to user's levels, not public
			saveAsWin.gotoAndStop(1);
			saveAsWin.outputTxt = "Invalid link ID";
			return;
		} else {
			varsOut.link = currentLvlObject.link = linkInput;
		}
		
		varsOut.hidden = currentLvlObject.hidden = hidden;
		
		varsOut.name = currentLvlObject.name = nameInput;
		varsOut.type = currentLvlObject.type = typeData;
		varsOut.level = _root.editor_getStringFromLevel();
		if (currentLvlObject.lives>=-1) varsOut.lives = currentLvlObject.lives;
		else varsOut.lives = -1;

		varsOut.sendAndLoad(saveLevelURL, varsIn, "POST"); 
		varsIn.onLoad = function (success) {
			if(success) {
				if (varsIn.success=="true") {
					messageTrace(varsIn.result, "0x00FF00");
					saveAsWin.close.onRelease();
				} else {
					saveAsWin.gotoAndStop(1);
					saveAsWin.outputTxt = varsIn.result;
				}
			} else {
				saveAsWin.gotoAndStop(1);
				saveAsWin.outputTxt = "Something didn't work :(  Perhaps try again.";
			}
		}
	} else {
		saveAsWin.outputTxt = "Please login first";
	}
}

function editor_localSave() {
	if (!fileMenuWin._visible) {
		editorBackup_so.data.level = _root.editor_getStringFromLevel();
		editorBackup_so.data.username = currentLvlObject.username;
		editorBackup_so.data.name = currentLvlObject.name;
		editorBackup_so.data.LID = currentLvlObject.LID;
		editorBackup_so.data.lives = currentLvlObject.lives;
		editorBackup_so.data.rating = currentLvlObject.rating;
		editorBackup_so.data.link = currentLvlObject.link;
		editorBackup_so.data.type = currentLvlObject.type;
		editorBackup_so.data.hidden = currentLvlObject.hidden;
		
		editorBackup_so.flush();
	}
}
function editor_localLoad() {
	var tempLvlOb = editor_getLevelFromString(editorBackup_so.data.level);
	tempLvlOb.username = editorBackup_so.data.username;
	tempLvlOb.name = editorBackup_so.data.name;
	tempLvlOb.LID = editorBackup_so.data.LID;
	tempLvlOb.lives = editorBackup_so.data.lives;
	tempLvlOb.rating = editorBackup_so.data.rating;
	tempLvlOb.link = editorBackup_so.data.link;
	tempLvlOb.type = editorBackup_so.data.type;
	tempLvlOb.hidden = editorBackup_so.data.hidden;
	
	_root.currentLvlObject = tempLvlOb;
	clearEditorMode();
	editorMode(false,false);
}
/*
function editor_register(usernameInput, pwInput, emailInput) {
	if (registerWin._currentframe != 2) {
		registerWin.gotoAndStop(2);

		varsIn = new LoadVars;
		varsOut = new LoadVars;
		
		if (usernameInput.length==0 or usernameInput.length==undefined) {
			registerWin.gotoAndStop(4);
			registerWin.outputTxt = "You must provide a name for yourself.";
			return;
		}
		varsOut.username = usernameInput;
		varsOut.pw = pwInput;
		varsOut.email = emailInput;
		
		varsOut.sendAndLoad("http://zf.skylogic.ca/gamePhp/newAccount.php", varsIn, "POST");
		varsIn.onLoad = function (success) {
			if(success) {
				if (varsIn.success=="true") {
					loginOb.username = varsOut.username;
					loginOb.pw = varsOut.pw;
					
					loginWin.usernameInput = loginOb.username;
					loginWin.pwInput = loginOb.pw;
					loginWin.outputTxt = "Success! You now exist. Click login to login with your new account";
					
					registerWin.removeMovieClip();
				} else {
					registerWin.gotoAndStop(4);
					registerWin.outputTxt = varsIn.result;
				}
			} else {
				registerWin.gotoAndStop(4);
				registerWin.outputTxt = "Something didn't work :(  Perhaps try again.";
			}
		}
	}
}
function editor_login(usernameInput, pwInput, rememberMe, fromSave) {
	varsIn = new LoadVars;
	varsOut = new LoadVars;
	
	if (usernameInput.length==0 or usernameInput.length==undefined) {
		loginWin.outputTxt = "You must login (click register if you don't have a username yet)";
		return;
	}
	varsOut.username = usernameInput;
	varsOut.pw = pwInput;
	
	varsOut.sendAndLoad("http://zf.skylogic.ca/gamePhp/login.php", varsIn, "POST"); 
	varsIn.onLoad = function (success) {
		if(success) {
			if (varsIn.success=="true") {
				//Let the player know:
				if (!fromSave)
					messageTrace("Welcome. You can now save, edit, and delete your levels", "0x00FF00");
									
				//Save data for later:
				loginOb.username = varsOut.username;
				loginOb.pw = varsOut.pw;
				loginOb.loggedIn=true;
				
				loginWin._visible=false; //helps editor_autoKeyListener
				loginWin.removeMovieClip();
				editor_autoKeyListener();
				
				//Remap login button to "gallery" ("my levels"):
				enableLogin();
				
				//Optionally save credentials to sharedObject
				if (rememberMe) {
					login_so.data.username=loginOb.username;
					login_so.data.pw=loginOb.pw;
				}
				
				//Check if this login gives player permission to load level
				if (!ed_levelOpen) {
					if (currentLvlObject.username == loginOb.username) {
						clearEditorMode();
						editorMode(false, false); //Reload the level, this time allowing the player to edit it
					}
				} else {
					currentLvlObject.username = loginOb.username;
				}
			} else {
				_root.loginWin.outputTxt = "Login failed. Click register if you don't have an username yet";
			}
		} else {
			_root.loginWin.outputTxt = "Something didn't work :(  Perhaps try again.";
		}
	}
}*/
function enableLogin() {
	with (tools) {
		//loginMC.gotoAndStop(2);
		loginBtn.onPress = function () {
			//_root.editor_openGallery();
			messageTrace("You are already logged in", "0x00FF00");
		}
		loginBtn.onRollOver = function () {
			//_root.ideHelpTxt.setTxt("<b>[L]</b> View, edit, or delete your Levels.");
			_root.ideHelpTxt.setTxt("You are already logged in");
		}
		loginBtn.onRollOut = function () {
			_root.ideHelpTxt.setTxt();
		}
	}
	if (fileMenuWin._visible) {
		with (fileMenuWin) {
			//loginMC.gotoAndStop(2);
			loginBtn.onPress = function () {
				//_root.editor_openGallery();
				messageTrace("You are already logged in", "0x00FF00");
			}
			loginBtn.onRollOver = function () {
				//_root.ideHelpTxt.setTxt("View, edit, or delete your Levels.");
				_root.ideHelpTxt.setTxt("You are already logged in");
			}
			loginBtn.onRollOut = function () {
				_root.ideHelpTxt.setTxt();
			}
		}	
	}
}

//Check if user has already logged in via PHP (CI). The POSTed URL will check if session exists with credentials
function checkWebLogin(loadingALevel) {
	varsIn = new LoadVars;
	varsOut = new LoadVars;
	
	varsOut.sendAndLoad(checkWebLoginURL, varsIn, "POST"); 
	varsIn.onLoad = function (success) {
		if(success) {
			if (varsIn.loggedIn=="true") {
				if (!loadingALevel) messageTrace("Welcome. You can now save, edit, and delete your levels", "0x00FF00");
									
				//Save data for later:
				loginOb.username = varsIn.username;
				loginOb.UID = varsIn.UID; //don't know if this will ever be used, here just in case
				loginOb.loggedIn=true;
				
				loginWin._visible=false; //helps editor_autoKeyListener
				loginWin.removeMovieClip();
				editor_autoKeyListener();
				
				//Remap login button to "gallery" ("my levels"):
				enableLogin();
				
				//Check if this login gives player permission to load level
				if (!ed_levelOpen) {
					//Restart the editor, this time loggedIn will be true
					clearEditorMode();
					editorMode(false, false); //Reload the level, this time allowing the player to edit it
				} else {
					currentLvlObject.username = loginOb.username;
				}
			} else { //Not logged in
				var notLoggedIn;
				if (!loadingALevel) { //Default response
					notLoggedIn = "You are not logged in";
				} else { //Response when user has just entered the editor and is trying to edit a level. i.e. checkWebLogin() was called by editorMode(), not by user clicking on button
					notLoggedIn = "You must login to edit your levels";
				}
				messageTrace(notLoggedIn + "\n\nOnce logged in please click on \"check login\" in the menu. If you scroll down this page you will see the form to login or register. You can also login or register at any page on "+rootURL, "0xFF0000");
				_root.editor_toggleFileMenuWin();
				_root.messageWin._y = 10;
				_root.fileMenuWin._y = _root.messageWin._y + _root.messageWin._height + 10;
			}
		} else {
			if (!loadingALevel) messageTrace("Error. Please try again.", "0xFF0000");
		}
	}
}

function editor_mirror(horiz, vert, ob) {
	if (ob==undefined) {//use default selection if no ob specifically provided
		for (var i=0; i<library.selected.length; i++) {
			editor_mirror(horiz, vert, library.selected[i]);
		}
	} else { //Mirror ob
		//var newob = editor_attachPart(ob.link, ob._x, ob._y, ob._rotation, ob._xscale, ob._yscale, null, d_e++); //Specifying values in order to skip editor_click (required for grouping to work)
		oldob = {};
		oldob._x = ob._x;
		oldob._y = ob._y;
		oldob._xscale = ob._xscale;
		oldob._yscale = ob._yscale;
		oldob._rotation = ob._rotation;

		if (!ob.isGun) {
			ob._rotation = -oldob._rotation;
			if (horiz) {		
				ob._x = core._x*2 - oldob._x;
				ob._xscale = oldob._xscale*-1;
			} else {
				ob._x = oldob._x;
				ob._xscale = oldob._xscale;
			}
			if (vert) {		
				ob._y = core._y*2 - oldob._y;
				ob._yscale = oldob._yscale*-1;
			} else {
				ob._y = oldob._y;
				ob._yscale = oldob._yscale;
			}
		} else {
			ob._xscale = oldob._xscale;
			ob._yscale = oldob._yscale;
			
			if (horiz and vert) ob._rotation = oldob._rotation+180;
			else if (horiz) ob._rotation = -oldob._rotation;
			else if (vert) ob._rotation = 180-oldob._rotation;
			
			if (horiz) {		
				ob._x = core._x*2 - oldob._x;
			} else {
				ob._x = oldob._x;
			}
			if (vert) {	
				ob._y = core._y*2 - oldob._y;
			} else {
				ob._y = oldob._y;
			}
		}
		
		ob.permaParent=false;
		
		ed_prevSelection = [library.selected[0]._x, library.selected[0]._y, library.selected[0]._rotation, library.selected[0]._xscale, library.selected[0]._yscale, library.selected[0].permaParent, library.selected[0].parent, library.selected[0]]; //make sure the other parts DO NOT follow by "hacking" the previous values
		//editor_createHierarchy(newob); //This needs to be after x,y coordinates set
		this.onMouseUp();
	}
}

function editor_duplicate(ob) {
	if (library.selected != null and ob==undefined) {
		for (var i=0; i<library.selected.length; i++) {
			editor_duplicate(library.selected[i]);
		}
	} else if (ob!=undefined) {
		var newob = editor_attachPart(ob.link, ob._x, ob._y, ob._rotation, ob._xscale/100, ob._yscale/100, null, d_e++, ob.colR+ob.colG+ob.colB);
		newob.permaParent=false;
		editor_createHierarchy(newob);
		this.onMouseUp();
	}
}

function editor_attachRegister() {
	_root.ideHelpTxt.setTxt();
	//***REGISTER
	attachMovie("editor.register", "registerWin", d_register);

	registerWin._x = STAGE_W/2 - registerWin._width/2;
	registerWin._y = 400;
	with (registerWin) {
		bar.onPress = function () {
			startDrag();
		}
		close.onRelease = function () {
			this._parent._visible = false;
			_root.keyListener.onKeyDown = _root.editor_detectKeys;
		}
		ok.onRelease = function () {
			_root.editor_register(usernameInput, pwInput, emailInput);
		}
	}
}

function editor_showOutput() {
	editor_make_AI_code();

	output.txt="";
	
	output.txt+="var level# = new Object();";
	
	//Init lives:
	output.txt += "\nlevel#.init = function () {";	
	output.txt += "\n\tlives="+currentLvlObject.lives+";"
	output.txt += "\n\tlifeCount.update();";
	output.txt += "\n}";
	
	//AI code:
	output.txt += "\nLevel#.AI = [\n";
	output.txt+="\t\""+currentLvlObject.AI[0]+"\"";
	for(var i=1; i<currentLvlObject.AI.length; i++) {
		if (currentLvlObject.AI[i] != undefined and currentLvlObject.AI[i] != "" and currentLvlObject.AI[i][0]!="") {
			output.txt+=",\n\t[";
		
			for (var j=0; j<currentLvlObject.AI[i].length; j++) {
				if(currentLvlObject.AI[i][j]!=undefined) {
					var str = ( isNaN(Number(currentLvlObject.AI[i][j])) ) ? true : false; //Strings will be surrounded by quotes (data are strings already, question is, are they not numbers?)
					if(str) output.txt+="\"";
					output.txt+=currentLvlObject.AI[i][j];
					if(str) output.txt+="\"";
					
					if (j<currentLvlObject.AI[i].length-1) output.txt+=", ";
				}
			}
			
			output.txt+="]";
		}
	}
	output.txt+="\n];\n\n";
	output.txt+="level#.code = [\n\t[";
	for (var k=0; k<currentLvlObject.code.length; k++) {
		if (currentLvlObject.code[k] != undefined) {
			if (k!=0) output.txt+=",\n\t[";
			for (var l=0; l<currentLvlObject.code[k].length; l++) {
				var str = (typeof currentLvlObject.code[k][l]=="string") ? true : false; //Strings will be surrounded by quotes (check data type)
				if (str) output.txt+="\"";
				output.txt+=currentLvlObject.code[k][l];
				if (str) output.txt+="\"";
				if (l<currentLvlObject.code[k].length-1) output.txt+=", ";
			}
			output.txt+="]";
		}
	}
	output.txt+="\n];";
}

//***"CORE SETTINGS"
function editor_createCoreAIwindow() {
	if (coreAIwindow==undefined) {
		coreAIwindow = attachMovie("editor.coreAI", "coreAIwindow", d_coreAIwindow+1932+random(1000));
		coreAIwindow._visible = false;
		coreAIwindow._x = 300;
		coreAIwindow._y = 200;

		coreAIwindow.onLoad = function () {
			this.comboboxHandler = function() {
				_root.currentLvlObject.editor_gun = this.coreGunAI_combobox.getValue();
			}
			
			//function checkboxHandler() { inside checkboxes holder
			this.applyChanges = function() {
				var lineArray = [];
				var elementArray = [];
				var txt = this.inputTxt;

				while (txt.indexOf(" ") != -1) {
					var n = txt.indexOf(" ");
					var front = txt.substring(0, n);
					var back = txt.substring(n+1);
					txt = front+back;
				}

				lineArray = txt.split(String.fromCharCode(13));
				var temptxt;
				for (var a=0; a<lineArray.length; a++) {
					temptxt += lineArray[a] + "\n";
				}
				
				lineArray = temptxt.split("\n");
				for (var b=0; b<lineArray.length; b++) {
					if (lineArray[b] == "") {
						lineArray.splice(b, 1);
					}
				}

				for (var i=0; i<lineArray.length; i++) {
					elementArray[i] = lineArray[i].split(",");
				}

				_root.currentLvlObject.editor_ai = elementArray;

				//Lives:
				_root.currentLvlObject.lives = this.livesInput;
			}

			//Insert text via buttons:
			this.insert = function(str) {
				this.inputTxt+=str;
				this.scrollBar.onTextChanged();
				this.scrollBar.setScrollPosition(this.scrollBar.maxPos);
			}
		
			//Prevent hand cursor from showing because of buttons 'below' this window.
			this.dummy.useHandCursor = false;

			//Select coreGun item according to what is saved in the level
			for (var n=0; n < this.coreGunAI_combobox.getLength(); n++) {
				if (this.coreGunAI_combobox.getItemAt(n).data == _root.currentLvlObject.editor_gun) { //n is the index I want selected
					this.coreGunAI_combobox.setSelectedIndex(n);
					break;
				}
			}

			//Set livesInput according to what is saved in the level
			this.livesInput = _root.currentLvlObject.lives;

			//Set AI code according to what is saved in the level
			this.inputTxt = "";
			for (var i=0; i<_root.currentLvlObject.editor_ai.length; i++) {
				this.inputTxt += _root.currentLvlObject.editor_ai[i] + "\n";
			}
			this.scrollBar.onTextChanged(); //show scroll bar properly
			this.scrollBar.setScrollPosition(this.scrollBar.maxPos);
			
			//***
			
			this.bar.onPress = function () {
				this._parent.startDrag();
			}
			this.close.onRelease = function () {
				this._parent._visible = false;
				_root.editor_autoKeyListener();
				this._parent.applyChanges();
			}

			this.attachMenuList = function (x, y) {
				if (this._parent.commandList_list == undefined) {
					var c = this.attachMovie("FListBoxSymbol", "commandList_list", 4);
					c._y = y;
					c._x = x;
					c.onMouseUp = function () {
						if (this._xmouse < 0 || this._ymouse < 0 || this._xmouse > this._width || this._ymouse > this._height) {
							removeMovieClip(this);
						}
					}
					c.setChangeHandler("menuHandler", this);
					return true;
				} else {
					removeMovieClip(this.commandList_list);
					return false;
				}
			}
			
			this.commandListCoreBtn.onRelease = function () {
				var added = this._parent.attachMenuList(this._x, this._y+this._height);
				if (added) {
					with (this._parent.commandList_list) {
						setRowCount(9);
						setWidth(200);
						setAutoHideScrollBar(true);
						addItem("Random Waypoints", "randomWaypoints, [SPEED]");
						addItem("Waypoints", "waypoints, LOOP?0=NO_1=YES, SPEED, X, Y, [X, Y]");
						addItem("Follow Ship", "followShip, [SPEED]");
						addItem("Random Rotate", "randomRotate, [SPEED]");
						addItem("Rotate toward ship", "rotateToShip, [SPEED]");
						addItem("Gun: Double", "coreGun_double");
						addItem("Gun: Spread", "coreGun_spread");
						addItem("Gun: 4 Way, 2 Shot", "coreGun_4way_2shot");
						addItem("Gun: Twin Rapid", "coreGun_twinRapid");
					}
				}
			}
			this.commandListPartsBtn.onRelease = function () {
				var added = this._parent.attachMenuList(this._x, this._y+this._height);
				if (added) {
					with (this._parent.commandList_list) {
						setRowCount(8);
						setWidth(200);
						setAutoHideScrollBar(true);
						addItem("Rotate", "rotatePart, PART#, SPEED, [MIN_ANGLE], [MAX_ANGLE], [START_ANGLE]");
						addItem("Rotate to Ship", "rotatePartToShip, PART#, [MORE_PART#]");
						addItem("Invincible", "makeInvincible, PART#, [MORE_PART#]");
						addItem("Vulnerable", "makeVulnerable, PART#, [MORE_PART#]");
						addItem("Disable Gun", "disableGun, PART#, [MORE_PART#]");
						addItem("Enable Gun", "enableGun, PART#, [MORE_PART#]");
						addItem("Destroy", "destroy, PART#, [MORE_PART#]");
						addItem("Change Colour", "col, HEX_COLOUR, PART#, [MORE_PART#]");
						addItem("Set Distance", "setDistance, DISTANCE, PART#, [MORE_PART#]");
						addItem("Set Width", "setWidth, WIDTH%, PART#, [MORE_PART#]");
						addItem("Set Height", "setHeight, HEIGHT%, PART#, [MORE_PART#]");
						addItem("Set HP", "setHP, HP, PART#, [MORE_PART#]");
						addItem("Set Gun Time", "setGunTime, TIME, PART#, [MORE_PART#]");
					}
				}
			}
			this.commandListAdvancedBtn.onRelease = function () {
				var added = this._parent.attachMenuList(this._x, this._y+this._height);
				if (added) {
					with (this._parent.commandList_list) {
						setRowCount(4);
						setWidth(200);
						setAutoHideScrollBar(true);
						addItem("Death Trigger > Any Command", "makeTrigger, death, SOURCE_PART#, ANY_COMMAND");
						addItem("Time Trigger > Any Command", "makeTrigger, time, START_FRAME, ANY_COMMAND");
						addItem("Repeating Trigger > Any Command", "makeTrigger, timeRepeat, START_FRAME, REPEAT_AFTER_FRAMES, ANY_COMMAND");
						addItem("Stop > Repeating Command", "stop, ANY_REPEATING_COMMAND");
					}
				}
			}
			
			this.menuHandler = function (c) {
				this.insert( "\n"+c.getValue() );
				c.removeMovieClip();
			}
		}
	}
}	
function editor_toggleCoreAIwindow() {
	if (coreAIwindow._visible) {
		coreAIwindow._visible = false;
	} else {
		_root.ideHelpTxt.setTxt();
		coreAIwindow._visible = true;
	}
	editor_autoKeyListener();
}
//***SAVE AS
function editor_toggleSaveAsWin() {
	if (saveAsWin==undefined) {
		attachMovie("editor.saveAs", "saveAsWin", d_saveAs);
		saveAsWin._visible = false;
		saveAsWin._x = STAGE_W/2 - saveAsWin._width/2;
		saveAsWin._y = STAGE_H/2 - saveAsWin._height/2;
		saveAsWin.outputTxt = "Offensive text/graphics are not allowed and will be removed.";

		with (saveAsWin) {
			bar.onPress = function () {
				startDrag();
			}
			close.onRelease = function () {
				this._parent._visible = false;
				_root.keyListener.onKeyDown = _root.editor_detectKeys;
			}
		
			saveBtn.onRelease = function () {
				_root.editor_save(nameInput, typeData, linkInput, hidden);
			}
			
			browseBtn.onRelease = function () {
				_root.editor_toggleGetIDWin();
			}
		}
	}
	
	if (_root.saveAsWin._visible) {
		_root.saveAsWin._visible = false;		
	} else {
		if (loginOb.loggedIn) {
			saveAsWin.gotoAndStop(1);
			
			//Set data as input
			saveAsWin.nameInput = _root.currentLvlObject.name;
			saveAsWin.linkInput = _root.currentLvlObject.link;
			
			if (currentLvlObject.type != undefined)
				saveAsWin["radio_"+currentLvlObject.type].setState(true);
			else 
				saveAsWin.radio_.setState(true); //enable the "none" option
				
			saveAsWin.typeData = saveAsWin.radioGroup.getData();
				
			if (currentLvlObject.hidden=="1")
				saveAsWin.visibilityGroup_1.setState(true);
			else
				saveAsWin.visibilityGroup_0.setState(true);
				
			saveAsWin.hidden = saveAsWin.visibilityGroup.getData();

			saveAsWin._visible = true;		
			_root.ideHelpTxt.setTxt();
		} else {
			editor_toggleLoginWin();
			messageTrace("You must login to save your level");
			messageWin._y = loginWin._y-messageWin._height-20;
		}
	}
	editor_autoKeyListener();
}
//***LOGIN WINDOW
function editor_toggleLoginWin() {
	///No longer allowing login through flash. Let this trigger checkWebLogin() instead
	/*
	if (loginWin==undefined) {
		attachMovie("editor.login", "loginWin", d_login);
		loginWin._visible = false;
		loginWin._x = STAGE_W/2 - loginWin._width/2;
		loginWin._y = STAGE_H/2 - loginWin._height/2;

		with (loginWin) {
			bar.onPress = function () {
				startDrag();
			}
			close.onRelease = function () {
				_root.editor_toggleLoginWin();
			}
			loginBtn.onRelease = function () {
				outputTxt = "Communicating, please wait...";
				_root.editor_login(usernameInput, pwInput, rememberMe);
			}
			registerBtn.onRelease = function () {
				_root.editor_attachRegister();
			}
			registerBtn.onRollOver = function () {
				_root.ideHelpTxt.setTxt("Free registration is required to save levels.");
			}
			registerBtn.onRollOut = function () {
				_root.ideHelpTxt.setTxt();
			}
		}
	}
	
	if (loginWin._visible) {
		loginWin._visible = false;
	} else {
		_root.ideHelpTxt.setTxt();
		loginWin._visible = true;
	}
	editor_autoKeyListener();
	*/
	checkWebLogin(false);
	messageTrace("Checking if you have logged in...");
}

function editor_setCore(ob) { //??? A bit overkill perhaps (this function used to do more than this)
	_root.core = ob;
}

function editor_refreshHierarchy(ob) {
	//Draw lines representing hierarchy:
	if (hierarchyLine!=null) editor_viewHierarchy();
	
	//Always make hierarchy regardless of visibility:
	if (ob==undefined) var ob = library.selected[0];
	editor_createHierarchy(ob);
}

function editor_deleteSelection() {
	for (var i=0; i<library.selected.length; i++) {
		if (library.selected[i]!=core) {
			editor_createChildList();
			var childrenTemp = library.selected[i].children;
			var parentTemp = library.selected[i].parent;
			removeMovieClip(library.selected[i]);
			
			for (var j=0; j<childrenTemp.length; j++) { //Deleted ob's children make the grandparent their parent, or pick their parent automatically
				if (childrenTemp[j].permaParent) {
					childrenTemp[j].parent = parentTemp;
				} else {
					editor_refreshHierarchy(childrenTemp[j]);
				}
			}
		} else { //deselect the core, don't delete it
			resetcol = new Color(library.selected[i]);
			resetColorTransform = { ra: '100', ga: '100', ba: '100', aa: '100'};
			resetcol.setTransform(resetColorTransform);
		}
	}
	ed_prevSelection = [];
	library.selected = [];
	
	editor_selectOb(core);
}

function editor_selectAll() {
	editor_selectOb(core);
	for (var i in enemies) {
		if (enemies[i] != core)
			editor_selectOb(enemies[i], true);
	}
}

/* No longer logging in via flash. All level management is done through web interface now. 2009-06-12
function editor_openGallery() {
	if (loginOb.username!=undefined and loginOb.loggedIn) {
		if (gallery == undefined) {
			attachMovie("editor.gallery", "gallery", d_gallery);
			gallery._x = STAGE_W/2 - gallery._width/2;
			gallery._y = STAGE_H/2 - gallery._height/2;
			gallery.xmlData = [];
			ideHelpTxt.setTxt();
			with (gallery) {
				var levelsXML = new XML();
				var varsOut = new LoadVars();

				varsOut.username=loginOb.username;
			
				varsOut.sendAndLoad ("http://zf.skylogic.ca/gamePhp/getLevelsList.php", levelsXML);
				levelsXML.ignoreWhitespace = true;
				levelsXML.onLoad = function (success) {
					if (success) {
						_root.gallery.levelsListBox.removeAll();
						//***LOOP THROUGH XML:
						var levels = this.firstChild;
						for (var i=0; i<levels.childNodes.length; i++) {
							var level = levels.childNodes[i];
							_root.gallery.xmlData.push([level.childNodes[0].firstChild.nodeValue]);
							var label = level.childNodes[0].firstChild.nodeValue
							label += (level.childNodes[1].firstChild.nodeValue != undefined) ? " -- TYPE "+level.childNodes[1].firstChild.nodeValue : "";
							label += " -- PLAYS "+level.childNodes[2].firstChild.nodeValue
							label += ", WINS "+level.childNodes[3].firstChild.nodeValue
							label += " -- "+level.childNodes[4].firstChild.nodeValue;
							label += (level.childNodes[7].firstChild.nodeValue == 1) ? " -- HIDDEN" : " -- PUBLIC";
							_root.gallery.levelsListBox.addItem(label, i);
						}
						//****
					} else {
						_root.gallery.levelsListBox.addItem("Error Connecting.");
						_root.gallery.levelsListBox.addItem("Are you sure your internet is working?");
					}
				}
			
				bar.onPress = function () {
					startDrag();
				}
				bar.onRelease = function () {
					stopDrag();
				}
				close.onRelease = function () {
					_root.editor_openGallery();
				}
				editBtn.onRelease = function () {
					var username=_root.loginOb.username;
					var name = xmlData[levelsListBox.getSelectedIndex()][0];
					_root.getLevel({username:username, name:name}, 2);
				}
				delBtn.onRelease = function () {
					if (_root.loginOb.username != undefined and _root.loginOb.loggedIn) { //user should be logged in at this point, but you never know
						var varsOut = new LoadVars();
						var varsIn = new LoadVars();
						varsOut.username = _root.loginOb.username;
						varsOut.name = xmlData[levelsListBox.getSelectedIndex()][0];
						varsOut.pw = _root.loginOb.pw;
						varsOut.sendAndLoad("http://zf.skylogic.ca/gamePhp/deleteLevel.php", varsIn);
						_root.messageTrace("Level \""+varsOut.name+"\" has been deleted");
						_root.gallery.removeMovieClip();
					} else {
						_root.messageTrace("Error! You must log in first...wait a second! you shouldn't even see the \"my levels\" button if you're not logged in already...very strange...", "0xFF0000");
					}
				}
				renameBtn.onRelease = function () {
					if (_root.loginOb.username != undefined and _root.loginOb.loggedIn) {
						_root.editor_openGalleryRename(xmlData[levelsListBox.getSelectedIndex()][0]);
					}
				}
			}
		} else
		if (!gallery._visible) {
			_root.ideHelpTxt.setTxt();
			gallery._visible = true;
		} else
		if (gallery._visible) {
			gallery.removeMovieClip();
		}
	} else {
		messageTrace("You must log in first...wait a second! you shouldn't even see the \"my levels\" button if you're not logged in already...very strange...", "0xFF0000");
	}
	editor_autoKeyListener();
}

function editor_openGalleryRename(oldname) {
	_root.ideHelpTxt.setTxt();
	attachMovie("editor.gallery.rename", "renameWin", d_renameWin);
	renameWin._x = STAGE_W/2 - renameWin._width/2;
	renameWin._y = STAGE_H/2 - renameWin._height/2;
	with (renameWin) {
		bar.onPress = function () {
			startDrag();
		}
		bar.onRelease = function () {
			stopDrag();
		}
		close.onRelease = function () {
			this._parent.removeMovieClip();
			_root.editor_autoKeyListener();
		}
		ok.onRelease = function () {
			var varsOut = new LoadVars();
			var varsIn = new LoadVars();
			varsOut.username = _root.loginOb.username;
			varsOut.name = oldname;
			varsOut.newName = newnameInput;
			varsOut.pw = _root.loginOb.pw;
			varsOut.sendAndLoad("http://zf.skylogic.ca/gamePhp/renameLevel.php", varsIn);
			
			varsIn.onLoad = function (success) {
				if (success) {
					if (varsIn.success=="true") {
						_root.messageTrace("Level \""+varsOut.name+"\" has been renamed \""+varsOut.newName+"\"", "0x00FF00");
					} else {
						_root.messageTrace("Error receiving confirmation. Level may or may not be renamed. ~", "0xFF0000");
					}
				} else {
					_root.messageTrace("Error receiving confirmation. Level may or may not be renamed. ~~", "0xFF0000");
				}
				_root.gallery.removeMovieClip();
				_root.renameWin.removeMovieClip();
			}
		}
	}
	editor_autoKeyListener();
}
*/

function editor_toggleGetIDWin() {
	if (loginOb.username!=undefined and loginOb.loggedIn) {
		if (getIDWin == undefined) {
			attachMovie("editor.gallery_getID", "getIDWin", d_gallery_getID);
			getIDWin._x = STAGE_W/2 - getIDWin._width/2;
			getIDWin._y = STAGE_H/2 - getIDWin._height/2;
			getIDWin.xmlData = []; //2D array of [ID, link]
			ideHelpTxt.setTxt();
			with (getIDWin) {
				var levelsXML = new XML();
				var varsOut = new LoadVars();
				varsOut.sendAndLoad (getLevelsListURL, levelsXML);
				levelsXML.ignoreWhitespace = true;
				levelsXML.onLoad = function (success) {
					if (success) {
						_root.getIDWin.levelsListBox.removeAll();
						//***LOOP THROUGH XML:
						messageTrace(this.firstChild.childNodes);
						if (this.firstChild.childNodes[0].nodeValue == "notLoggedIn") {
							_root.getIDWin.levelsListBox.addItem("Error. Not logged in", 0);
						} else {
							var levels = this.firstChild;
							for (var i=0; i<levels.childNodes.length; i++) {
								var level = levels.childNodes[i];
								_root.getIDWin.xmlData.push([level.childNodes[1].firstChild.nodeValue,level.childNodes[2].firstChild.nodeValue]);
								var label = level.childNodes[0].firstChild.nodeValue;
								label += " -- ID "+level.childNodes[1].firstChild.nodeValue;
								label += (level.childNodes[2].firstChild.nodeValue != 0) ? " -- Linked to " + level.childNodes[2].firstChild.nodeValue : " -- No link";
								_root.getIDWin.levelsListBox.addItem(label, i);
							}
						}
						//****
					} else {
						_root.getIDWin.levelsListBox.addItem("Error Connecting.");
						_root.getIDWin.levelsListBox.addItem("Are you sure your internet is working?");
					}
				}
			
				bar.onPress = function () {
					startDrag();
				}
				bar.onRelease = function () {
					stopDrag();
				}
				close.onRelease = function () {
					this._parent.removeMovieClip();
				}
				getIDBtn.onRelease = function () {
					var i = this._parent.levelsListBox.getSelectedIndex();
					_root.saveAsWin.linkInput = this._parent.xmlData[i][0]; //ID
					this._parent.removeMovieClip();
				}
			}
		} else
		if (!getIDWin._visible) {
			_root.ideHelpTxt.setTxt();
			getIDWin._visible = true;
		} else
		if (getIDWin._visible) {
			getIDWin.removeMovieClip();
		}
	} else {
		messageTrace("You must log in first", "0xFF0000");
	}
}

function editor_toggleTextEdit() {
	if (textEdit==undefined) {
		attachMovie("editor.textEdit", "textEdit", d_textEdit);
		textEdit._visible = false;
		textEdit._x = 250;
		textEdit._y = 250;
		with (textEdit) {
			bar.onPress = function () {
				startDrag();
			}
			close.onRelease = function () {
				this._parent.applyChanges();
				this._parent._visible = false;
				_root.editor_autoKeyListener();
			}
			close.onRollOver = function () {
				_root.ideHelpTxt.setTxt("Editor will reload with any changes you make here.\nIf you make a mistake here, you may cause the level to not load properly, so be sure to save before editing the code manually");
			}
			close.onRollOut = function () {
				_root.ideHelpTxt.setTxt();
			}
			refresh.onRelease = function () {
				this._parent.update();
			}
			cancel.onRelease = function () {
				this._parent.update();
				this._parent._visible = false;
				_root.editor_autoKeyListener();
			}
			
			advancedView.onRelease = function () {
				_root.library.com.advancedView();
				this._parent.advancedTxt = "advanced: on";
			}
			advancedView.onRollOver = function () {
				_root.ideHelpTxt.setTxt("Enable advanced view.\nWhen rolling your mouse over a part, the actual name and parent will be shown.\n(Actual name is sometimes different from the displayed name)");
			}
			advancedView.onRollOut = function () {
				_root.ideHelpTxt.setTxt();
			}
		}
		
		textEdit.update = function () {
			editor_make_AI_code();

			this.txt="";

			for (var k=0; k<currentLvlObject.code.length; k++) {
				if (currentLvlObject.code[k] != undefined) {
					if (k!=0) this.txt+="\n";
					for (var l=0; l<currentLvlObject.code[k].length; l++) {
						this.txt+=currentLvlObject.code[k][l];
						if (l<currentLvlObject.code[k].length-1) this.txt+=", ";
					}
				}
			}
		}
		textEdit.update();
		
		textEdit.applyChanges = function() {
			var lineArray = [];
			var elementArray = [];
			var txt = this.txt

			while (txt.indexOf(" ") != -1) {
				var n = txt.indexOf(" ");
				var front = txt.substring(0, n);
				var back = txt.substring(n+1);
				txt = front+back;
			}

			lineArray = txt.split(String.fromCharCode(13));
			var temptxt;
			for (var a=0; a<lineArray.length; a++) {
				temptxt += lineArray[a] + "\n";
			}

			lineArray = temptxt.split("\n");

			for (var b=0; b<lineArray.length; b++) {
				if (_root.removeStringWhitespace(lineArray[b]) == "") {
					lineArray.splice(b, 1);
					b--;
				}
			}

			for (var i=0; i<lineArray.length; i++) {
				lineArray[i] = _root.removeStringWhitespace(lineArray[i]);
				elementArray[i] = lineArray[i].split(",");
			}

			//Convert numbers into primitive numbers rather than strings
			for (var i=0; i<elementArray.length; i++) {
				elementArray[i][1] = Number(elementArray[i][1]);
				elementArray[i][2] = Number(elementArray[i][2]);
				elementArray[i][3] = Number(elementArray[i][3]);
				elementArray[i][4] = Number(elementArray[i][4]);
				elementArray[i][5] = Number(elementArray[i][5]);
				elementArray[i][7] = Number(elementArray[i][7]);
			}
	
			_root.currentLvlObject.code = elementArray;
			_root.clearEditorMode();
			_root.editorMode(false,false);
		}
	}
	
	if (textEdit._visible) {
		textEdit._visible = false;
		editor_autoKeyListener();
	} else {
		_root.ideHelpTxt.setTxt();
		textEdit._visible = true;
		textEdit.update();
		editor_autoKeyListener();
	}
}

function editor_autoKeyListener() {
	//Check if all input windows are gone, if they are, re-enable detectKeys
	if (
		!loginWin._visible and
		!saveAsWin._visible and 
		!registerWin._visible and 
		!coreAIwindow._visible and
		!textEdit._visible and
		!gallery._visible and
		!renameWin._visible and
		!fileMenuWin._visible and
		!keySettings._visible and
		!fileMenuWin._visible and
		!properties.colourPicker.pick_mc._visible
												) {
		keyListener.onKeyDown = editor_detectKeys;
	} else { //Something is open that requires input, ensure that detectKeys is not running
		keyListener.onKeyDown = null;
	}
}

function editor_setColour(col) {
	_root.editor_autoKeyListener();

	for (var i=0; i<library.selected.length; i++) {
		setColour(library.selected[i], col);
		editor_highlight(library.selected[i], 0);
	}
	editor_highlight(library.selected[0], 1);
}

//Highlight selected objects and highlight the target object moreso
function editor_highlight(ob, mag) {
	var r = ob.colR;
	var g = ob.colG;
	var b = ob.colB;
	r = parseInt("0x"+r);
	g = parseInt("0x"+g);
	b = parseInt("0x"+b);

	ob.dr = Math.round( (200-r) / 10 );
	ob.dg = Math.round( (200-g) / 10 );
	ob.db = Math.round( (200-b) / 10 );

	var col = new Color(ob);
	col.setRGB("0xC8C8C8");
	ob.tempcolR = ob.tempcolG = ob.tempcolB = "C8";

	ob.highlightDir=1;
	ob.onEnterFrame = function () {
		this.t++;
		
		if (this.t==11) {
			this.highlightDir=-1;
			var colOb = new Color(this);
			colOb.setRGB("0x"+this.colR+this.colG+this.colB);
			this.tempcolR = this.colR;
			this.tempcolG = this.colG;
			this.tempcolB = this.colB;
			return;
		} else
		if (this.t==22) {
			this.t=0;
			var colOb = new Color(this);
			colOb.setRGB("0xC8C8C8");
			this.ob.tempcolR = this.ob.tempcolG = this.ob.tempcolB = "C8";

			this.highlightDir=1;
			return;
		}		
	
		var r = this.tempcolR;
		var g = this.tempcolG;
		var b = this.tempcolB;
		r = parseInt("0x"+r);
		g = parseInt("0x"+g);
		b = parseInt("0x"+b);	
		
		r-=this.dr*this.highlightDir;
		g-=this.dg*this.highlightDir;
		b-=this.db*this.highlightDir;
		
		if (r<0) r=0;
		if (g<0) g=0;
		if (b<0) b=0;
		if (r>255) r=255;
		if (g>255) g=255;
		if (b>255) b=255;
	
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
function editor_unhighlight(ob) {
	ob.onEnterFrame=null;
	setColour(ob, ob.colR, ob.colG, ob.colB);
}
// function editor_highlightAll() {
	// for (var i in enemies) {
		// editor_unhighlight(enemies[i]);
	// }

	// editor_highlight(library.selected[0], 1);
	
	// for (var i=1; i<library.selected.length; i++) {
		// editor_highlight(library.selected[0], 0);
	// }
// }

function editor_toggleFileMenuWin() {
	if (fileMenuWin==undefined) {
		attachMovie("editor.fileMenuWin", "fileMenuWin", d_fileMenuWin);
		fileMenuWin._x = STAGE_W/2 - fileMenuWin._width/2;
		fileMenuWin._y = STAGE_H/2 - fileMenuWin._height/2;
		with (fileMenuWin) {
			bar.onPress = function () {
				startDrag();
			}
			
			loginBtn.onPress = function () {
				_root.ideHelpTxt.setTxt();
				_root.editor_toggleLoginWin();
				_root.editor_toggleFileMenuWin();
			}
			loginBtn.onRollOver = function () {
				_root.ideHelpTxt.setTxt("Login so you can save and edit your levels");
				//Login btn is used as Levels button after login. See enableLogin()
			}
			loginBtn.onRollOut = function () {
				_root.ideHelpTxt.setTxt();
			}
			
			newBtn.onPress = function () {
				_root.ideHelpTxt.setTxt();
				_root.clearEditorMode();
				_root.editorMode(false,true);
				_root.editor_toggleFileMenuWin();
			}
			newBtn.onRollOver = function () {
				_root.ideHelpTxt.setTxt("Start a new level");
			}
			newBtn.onRollOut = function () {
				_root.ideHelpTxt.setTxt();
			}
			
			recoverBtn.onPress = function () {
				_root.ideHelpTxt.setTxt();
				_root.editor_localLoad();
				_root.editor_toggleFileMenuWin();
			}
			recoverBtn.onRollOver = function () {
				_root.ideHelpTxt.setTxt("Recover an autosave. Autosave occurs every 30 seconds.");
			}
			recoverBtn.onRollOut = function () {
				_root.ideHelpTxt.setTxt();
			}
			
			tutorialBtn.onPress = function () {
				_root.editor_openTutorial();
				_root.editor_toggleFileMenuWin();
			}
			tutorialBtn.onRollOver = function () {
				_root.ideHelpTxt.setTxt("<b>[F1]</b> View the default controls for this editor.\nControls can be changed in the options menu");
			}
			tutorialBtn.onRollOut = function () {
				_root.ideHelpTxt.setTxt();
			}
			
			optionsBtn.onPress = function () {
				_root.openKeySettings();
				
				_root.keySettings.customFunction = function () { //when keySettings closes, restore editor key listener
					_root.editor_autoKeyListener();
				}
				
				_root.editor_toggleFileMenuWin();
			}
			optionsBtn.onRollOver = function () {
				_root.ideHelpTxt.setTxt("Show the default keys for editing");
			}
			optionsBtn.onRollOut = function () {
				_root.ideHelpTxt.setTxt();
			}
			
			exitBtn.onPress = function () {
				_root.fileMenuWin._visible=false; //helps localSave
				_root.editor_localSave();
				_root.editor_toMenu();
			}
			exitBtn.onRollOver = function () {
				_root.ideHelpTxt.setTxt("Autosave and exit to main menu\n(Do NOT rely on the autosave though, save your level properly)");
			}
			exitBtn.onRollOut = function () {
				_root.ideHelpTxt.setTxt();
			}
			
			closeBtn.onPress = function () {
				_root.editor_toggleFileMenuWin();
			}
		}
	} else {
		fileMenuWin._visible=false;
		fileMenuWin.removeMovieClip();
	}
	editor_autoKeyListener();
	_root.ideHelpTxt.setTxt();
}
function editor_openTutorial() {
	attachMovie("editor.tutorial", "tutorial", d_edTutorial);
}