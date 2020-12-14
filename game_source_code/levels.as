/*
Centripetal Bond
AI_coreGun_4way_2shot|AI_rotatePart,26,2,0,360,0|AI_randomWaypoints|AI_randomRotate|AI_<>core,404,312,0,-1,0|spread,0,-16,0,e0,26|stick,136,-2,-90,e26,4|spread,-22,1,0,e4,23|rhombus,-18,-75,135,e4,8|smallbox,-36,-12,-57,e8,11|tri,-27,-15,-166,e11,12|square,-2,20,99,e12,25|rhombus,-17,75,0,e4,7|smallbox,-35,13,57,e7,16|tri,-26,18,-10,e16,18|laser,-39,0,-171,e16,15|stick,-140,-2,90,e26,3|spread,21,0,0,e3,22|rhombus,20,73,135,e3,6|smallbox,35,13,123,e6,17|tri,27,16,9,e17,19|square,1,-17,-82,e19,24|rhombus,21,-73,0,e3,5|smallbox,34,-14,-123,e5,9|tri,26,-17,159,e9,13|laser,19,15,-11,e13,14
*/

//Minimalist: Deceptive Droid
/*
var level# = new Object();
level#.AI = [
	"AI_coreGun_twinRapid",
	[AI_randomWaypoints],
	[AI_randomWaypoints],
	[AI_randomWaypoints],
	[AI_rotateToShip],
	[AI_coreGun_4way_2shot],
	[AI_coreGun_4way_2shot],
	[AI_rotatePart, 25, 1, 0, 180, 0],
	[AI_rotatePart, 26, -1, -180, 0, 0],
	[AI_rotatePart, 28, -1, 0, -90, 0],
	[AI_rotatePart, 30, 1, 0, 90, 0],
	[AI_rotatePart, 45, 1, 0, 180, 0],
	[AI_rotatePart, 46, -1, -180, 0, 0],
	[AI_rotatePart, 47, -1, 0, -90, 0],
	[AI_rotatePart, 44, 1, 0, 90, 0],
	[AI_rotatePart, 49, 1, 0, 180, 0],
	[AI_rotatePart, 50, -1, -180, 0, 0],
	[AI_rotatePart, 51, -1, 0, -90, 0],
	[AI_rotatePart, 52, 1, 0, 90, 0],
	[AI_followShip],
	[AI_makeInvincible, 25, 26, 28, 30, 45, 46, 47, 44, 49, 50, 51, 52, 73, 68, 70, 67, 69, 74],
	[AI_makeSwitch, 31, 74, 73],
	[AI_makeSwitch, 71, 0]
];

level#.code = [
	["core", 216, 237, 90, 0, 0, -1, 0],
	["core", 0, 0, 90, 1.5, 1, "e0", 73],
	["tri", 21, 1, -90, 2, 1, "e0", 71],
	["laser_", -2238, 27, 0, 1, 1, "e71", 74],
	["switch2", -120, -46, 71, 1, -0.2, "e71", 70],
	["switch2", -120, 44, -71, 1, 0.2, "e71", 69],
	["switch2b", -99, -58, 0, 1, 1, "e71", 68],
	["switch2b", -100, 56, 0, 1, 1, "e71", 67],
	["switch1b", -34, 0, 0, 0, 0, "e0", 66],
	["box", 31, 1, 180, 1, 1, "e66", 76],
	["switch1b", -34, 0, -90, 0, 0, "e66", 25],
	["switch1b", 115, 0, 0, 0, 0, "e25", 26],
	["switch2b", 115, 0, 0, 0, 0, "e26", 28],
	["switch1b", 115, 0, 0, 0, 0, "e28", 30],
	["tube2", 50, -1, 0, 1, 1, "e30", 31],
	["tri", 24, -91, 78, 0.7, -2, "e31", 43],
	["smallbox", -22, -80, -12, 1, -1, "e31", 42],
	["switch1b", 0, -73, 0, 0, 0, "e42", 49],
	["switch1b", 0, -50, 0, 0, 0, "e49", 50],
	["switch1b", 0, -50, 0, 0, 0, "e50", 51],
	["switch1b", 0, -50, 0, 0, 0, "e51", 52],
	["oddbox", 18, 190, -90, 0.43, -0.4, "e52", 65],
	["stick2", 12, 170, 0, 0.65, -1, "e52", 64],
	["stick2", -2, 148, 0, 0.65, -1, "e52", 63],
	["smallbox", 0, 123, -12, 1, -1, "e52", 62],
	["tri", 46, 112, 78, 0.7, -2, "e52", 61],
	["stick2", -24, -55, 0, 0.65, -1, "e31", 41],
	["stick2", -10, -33, 0, 0.65, -1, "e31", 40],
	["stick2", -10, 35, 0, 0.65, 1, "e31", 39],
	["stick2", -24, 57, 0, 0.65, 1, "e31", 38],
	["tri", 24, 93, -78, 0.7, 2, "e31", 35],
	["smallbox", -22, 82, 12, 1, 1, "e31", 33],
	["switch1b", 0, 73, 0, 0, 0, "e33", 45],
	["switch1b", 0, 50, 0, 0, 0, "e45", 46],
	["switch1b", 0, 50, 0, 0, 0, "e46", 47],
	["switch1b", 0, 50, 0, 0, 0, "e47", 44],
	["oddbox", 18, -190, 90, 0.43, 0.4, "e44", 60],
	["tri", 46, -112, -78, 0.7, 2, "e44", 59],
	["stick2", 12, -170, 0, 0.65, 1, "e44", 58],
	["stick2", -2, -148, 0, 0.65, 1, "e44", 57],
	["smallbox", 0, -123, 12, 1, 1, "e44", 56],
	["tri", 45, 1, -90, 1.6, 1, "e31", 32]
];
*/

//endLevel = 10 //see code.as for declaration

var level0 = new Object();
level0.init = function () {
	lives=1;
	lifeCount.update();
	attachMovie("tutorial", "tutorial", d_tutorial);
}

//ACTUAL LEVEL 0
level0.AI = [
	"",
	["AI_randomRotate"]
];
level0.code = [
	["core",400,200,0,1,1,-1,0],
	["tri",-33,4,45,1,1,"e0",1],
	["tri",34,4,-45,1,1,"e0",2],
	["jet",48,-34,168,1,1,"e0",5],
	["tri",-13,-36,41,1,1,"e5",7],
	["jet",-48,-34,-167,1,1,"e0",4],
	["tri",13,-36,-41,1,1,"e4",6]
];

var level1 = new Object();
level1.AI = [
	"AI_coreGun_double",
	["AI_randomRotate"],
	["AI_randomWaypoints"]
];
level1.code = [
	["core",400,200,0,1,1,-1,0],
	["rhombus",-51.95,0,180,1,1,"e0",3],
	["single",-23,2,45,1,1,"e3",7],
	["rhombus",-51.95,-37,135,1,1,"e0",2],
	["single",-23,-2,135,1,1,"e2",8],
	["rhombus",52,-37,0,1,1,"e0",1],
	["single",23,-1,-135,1,1,"e1",5],
	["rhombus",52,0,135,1,1,"e0",4],
	["single",24,0,-45,1,1,"e4",6]
];

var level2 = new Object();
level2.AI = [
	"AI_coreGun_4way_2shot",
	["AI_randomRotate"],
	["AI_randomWaypoints"]
];
level2.code = [
	["core",400,200,0,1,1,-1,0],
	["rhombus",-53,-2,0,1,1,"e0",1],
	["box",-18,-65,-90,1,1,"e1",3],
	["tri",28,-40,60,1,1,"e3",7],
	["single",6,-4,-125,1,1,"e7",9],
	["rhombus",-26,27,45,1,1,"e1",11],
	["jet",-30.95,-29,90,1,1,"e11",19],
	["tri",-39,1,90,1,1,"e19",20],
	["spread",-13,1,0,1,1,"e20",22],
	["jet",32,37,-30,1,1,"e11",13],
	["square",16,28,-30,1,1,"e13",16],
	["box",74,-66,-90,1,1,"e0",4],
	["tri",-27,-39,-60,1,1,"e4",8],
	["single",-7,-4,125,1,1,"e8",10],
	["rhombus",52,-1,135,1,1,"e0",2],
	["rhombus",26,27,90,1,1,"e2",12],
	["jet",31,-29,-90,1,1,"e12",17],
	["tri",38,0,-90,1,1,"e17",18],
	["spread",13,0,0,1,1,"e18",21],
	["jet",-32,35,35,1,1,"e12",14],
	["square",-19,27,40,1,1,"e14",15]
];

var level3 = new Object();
level3.AI = [
	"AI_coreGun_4way_2shot",
	["AI_4"]
];
level3.code = [
	["core",400,200,0,1,1,-1,0],
	["smallbox",-46,1,-145,1,1,"e0",3],
	["rhombus",-25,-49,135,1,1,"e3",7],
	["jet",41,-34,85,1,1,"e7",25],
	["tri",8,-21,-25,1,1,"e25",27],
	["single",9,-11,-140,1,1,"e27",29],
	["tri",-33,-22,125,1,1,"e3",5],
	["single",-9,4,70,1,1,"e5",38],
	["box",-28,53,115,1,1,"e3",9],
	["square",17,27,-55,1,1,"e9",33],
	["rhombus",-43,52,160,1,1,"e9",12],
	["single",18,10,-45,1,1,"e12",31],
	["smallbox",-30,-26,175,1,1,"e12",15],
	["single",-1,-13,-150,1,1,"e15",39],
	["jet",-45,-7,140,1,1,"e15",17],
	["jet",-38,-45,-40,1,1,"e17",22],
	["spread",1,2,0,1,1,"e22",36],
	["smallbox",44,3,-35,1,1,"e0",2],
	["tri",33,-22,-125,1,1,"e2",4],
	["single",11,5,-70,1,1,"e4",37],
	["rhombus",-8,-27,0,1,1,"e4",6],
	["jet",-42,-35,-80,1,1,"e6",26],
	["tri",-5,-22,30,1,1,"e26",28],
	["single",-6,-11,145,1,1,"e28",30],
	["box",28,53,65,1,1,"e2",8],
	["square",-17,26,60,1,1,"e8",34],
	["rhombus",41.95,52,155,1,1,"e8",11],
	["single",-20.95,12,45,1,1,"e11",32],
	["smallbox",30,-25,5,1,1,"e11",14],
	["single",6,-17,155,1,1,"e14",40],
	["jet",46,-10,-145,1,1,"e14",16],
	["jet",34,-48,35,1,1,"e16",21],
	["spread",-2,3,0,1,1,"e21",35]
];

var level4 = new Object();
level4.AI = [
	"AI_coreGun_spread",
	["AI_randomRotate"],
	["AI_randomWaypoints"],
	["AI_rotatePart", 1,0.4,-10,90,0],
	["AI_rotatePart", 2,0.4,-10,90,0],
	["AI_rotatePart", 6,0.4,0,90,0],
	["AI_rotatePart", 5,0.4,0,90,0]
];
level4.code = [
	["core",400,200,0,1,1,-1,0], 
	["circle",-51,9,0,1,1,"e0",2], 
	["jet",-39,38,-135,1,1,"e2",3], 
	["single",-10,-15,135,1,1,"e3",14], 
	["circle",10,37,90,1,1,"e3",5], 
	["tri",-17,14.95,-135,1,1,"e5",17], 
	["square",-13,13,45,1,1,"e17",19], 
	["jet",38,0,-90,1,1,"e5",7], 
	["single",7,15.95,0,1,1,"e7",13], 
	["box",75.95,1,180,1,1,"e7",9], 
	["spread",46,32.95,0,1,1,"e9",11], 
	["circle",47.95,-48,180,1,1,"e0",1], 
	["jet",38,-39,45,1,1,"e1",4], 
	["single",10,11,-45,1,1,"e4",16], 
	["circle",-10,-37,-90,1,1,"e4",6], 
	["tri",17,-16,45,1,1,"e6",18], 
	["square",13,-11,-135,1,1,"e18",20], 
	["jet",-38,2,90,1,1,"e6",8], 
	["single",-4,-17,180,1,1,"e8",15], 
	["box",-75.95,-1,0,1,1,"e8",10], 
	["spread",-45,-30,0,1,1,"e10",12]
];

var level5 = new Object();
level5.AI = [
	"AI_coreGun_spread",
	["AI_randomRotate"],
	["AI_randomWaypoints"],
	["AI_rotatePart", 3, 1, 0, 0, 0], //part, vel, min, max, starting
	["AI_rotatePart", 4, -1, 0, 0, 90]
];
level5.code = [
	["core",400,200,0,1,1,-1,0],
	["tri",0,65.95,0,1,1,"e0",25],
	["tri",34,2,-45,1,1,"e0",22],
	["tri",-35,2,45,1,1,"e0",21],
	["tri",17,-57,-135,1,1,"e0",26],
	["tri",-18,-57,135,1,1,"e0",23],
	["tri",-1,-74,0,1,1,"e0",27],
	["stick",-99,-30,180,1,1,"e0",1],
		["circle",-69.95,1,0,1,1,"e1",3],
	["smallbox",1,-56,-90,1,1,"e3",6],
	["square",26,-30,-90,1,1,"e6",17],
	["box",1,-77,90,1,1,"e6",11],
	["single",-31,-44,90,1,1,"e11",16],
	["smallbox",-1,55,90,1,1,"e3",5],
	["square",-24,31,90,1,1,"e5",19],
	["box",-1,76.95,-90,1,1,"e5",12],
	["single",30,45,-90,1,1,"e12",13],
	["stick",98,-31,180,1,1,"e0",2],
		["circle",70,0,0,1,1,"e2",4],
	["smallbox",1,56,90,1,1,"e4",8],
	["square",-23,32,90,1,1,"e8",20],
	["box",-1,76.95,-90,1,1,"e8",9],
	["single",30,44,-90,1,1,"e9",14],
	["smallbox",1,-56,-90,1,1,"e4",7],
	["square",23,-31,-90,1,1,"e7",18],
	["box",0,-77,90,1,1,"e7",10],
	["single",-30,-42,90,1,1,"e10",15]
];

var level6 = new Object();
level6 = editor_getLevelFromString("AI_coreGun_spread|AI_rotatePart,4,1,-45,90,0|AI_rotatePart,3,1,-90,45,-45|AI_randomWaypoints|AI_randomRotate<>core,400,300,0,1,1,-1,0|stick,33,59,-90,1,1,e0,20|tri,-17,34,90,1,1,e20,24|jet,-3,81,102,1,1,e20,22|laser,26,-8,-51,1,1,e22,27|stick,-34,58,90,1,1,e0,19|tri,18,35,-90,1,1,e19,25|spread,16,-2,0,1,1,e25,23|jet,3,81,-101,1,1,e19,21|laser,-26,-8,-126,1,1,e21,26|tube2,51,-61,135,1,1,e0,2|single,-15,-22,146,1,1,e2,15|circle,42,-44,0,1,1,e2,4|tube2,0,-60,-90,1,1,e4,7|smallbox,55,-14,180,1,1,e7,11|laser,30,21,11,1,1,e11,13|tube2,-50,-64,45,1,1,e0,1|single,12,-20,-147,1,1,e1,14|circle,-43,-42,0,1,1,e1,3|tube2,-1,-60,-90,1,1,e3,6|smallbox,-55,-15,0,1,1,e6,10|laser,-29,20,169,1,1,e10,12");

var level7 = new Object();
level7 = editor_getLevelFromString("AI_coreGun_twinRapid|AI_rotatePart,5,1,0,0,0|AI_makeSwitch,18,9,7,8,10,23,24|AI_rotateToShip|AI_followShip|AI_<>core,400,300,0,1,1,-1,0|laser,44,8,90,1,1,e0,20|laser,-42,7,90,1,1,e0,19|switch1,0,76,0,1,1,e0,18|tri,0,-66,0,1,1,e0,6|circle,0,-31,0,1,1,e6,5|laser,0,-27,-90,1,1,e5,4|oddbox,33,-70,-64,1,1,e0,3|forcefieldLine,64,155,90,1,1,e3,23|single,87,8,180,1,1,e3,16|single,102,14,-135,1,1,e3,15|tube,127,36,-64,1,1,e3,12|spread,-19,41,0,1,1,e12,22|forcefieldLine,88,-10,0,1,1,e3,10|forcefieldLine,1,-46,42,1,1,e3,8|oddbox2,-33,-71,66,1,1,e0,1|forcefieldLine,-69,153,90,1,1,e1,24|single,-91,6,180,1,1,e1,17|single,-101,12,135,1,1,e1,14|tube,-128,34,-114,1,1,e1,13|spread,17,41,0,1,1,e13,21|forcefieldLine,-91,-12,180,1,1,e1,9|forcefieldLine,-5,-44,-44,1,1,e1,7");

var level8 = new Object();
level8.AI = [
	"AI_coreGun_spread",
	["AI_rotatePartToShip", 9],
	["AI_rotatePartToShip", 10],
	["AI_randomWaypoints"],
	["AI_randomRotate"],
	["AI_rotatePart", 29,1,0,180,0],
	["AI_rotatePart", 30,1,-180,0,0]
];
level8.code = [
	["core",400,200,0,1,1,-1,0], 
	["rhombus",53,-37,0,1,1,"e0",4], 
	["rhombus",27,-27,45,1,1,"e4",6], 
	["tri",-27,-38,-36,1,1,"e6",28], 
	["square",-29,-17,90,1,1,"e6",18], 
	["rhombus",-51,-38,135,1,1,"e0",3], 
	["rhombus",-27.95,-25,90,1,1,"e3",5], 
	["tri",27.95,-38,38,1,1,"e5",27], 
	["square",27.95,-17,-90,1,1,"e5",17], 
	["oddbox2",40.95,7,-45,1,1,"e0",2], 
	["laser",81.05,85,111,1,1,"e2",30], 
	["smallbox",21.05,80.95,57,1,1,"e2",21], 
	["smallbox",-27,11,81,1,1,"e21",23], 
	["spread",-17,-30.95,0,1,1,"e23",34], 
	["spread",-15,32,0,1,1,"e23",25], 
	["tube2",116.1,-17,114,1,1,"e2",7], 
	["circle",23.95,-55,0,1,1,"e7",9], 
	["single",19,-16,174,1,1,"e9",16], 
	["single",-18,-16,-169,1,1,"e9",15], 
	["single",1,-22,-180,1,1,"e9",14], 
	["oddbox",-41.05,7,45,1,1,"e0",1], 
	["laser",-78.95,88,68,1,1,"e1",29], 
	["smallbox",-19.9,79.95,123,1,1,"e1",20], 
	["smallbox",26.95,10,99,1,1,"e20",22], 
	["spread",12,-28.95,0,1,1,"e22",33], 
	["spread",14,34,0,1,1,"e22",24], 
	["tube2",-115,-16.05,65,1,1,"e1",8], 
	["circle",-26,-54,0,1,1,"e8",10], 
	["single",19,-19,165,1,1,"e10",13], 
	["single",-19,-17,-170,1,1,"e10",12], 
	["single",0,-23,180,1,1,"e10",11]
];

//Singularity level:
var level9 = new Object();
level9.AI = [
	"AI_coreGun_4way_2shot",
	["AI_rotatePart", 22, 0.5, 0, 0, 0],
	["AI_rotatePart", 24, 0.5, 0, 45, 0],
	["AI_rotatePartToShip", 25],
	["AI_rotatePartToShip", 31],
	["AI_makeInvincible", 51],
	["AI_makeSwitch", 61, 50],
	["AI_makeSwitch", 60, 49],
	["AI_makeSwitch", 62, 47],
	["AI_makeSwitch", 63, 48],
	["AI_randomWaypoints"],
	["AI_coreGun_double"]
];

level9.code = [
	["core", 382, 273, 0, 1, 1, -1, 0],
	["switch2", -28, -41, -45, 1, -0.3, "e0", 63],
	["switch2", 28, -41, 45, -1, -0.3, "e0", 62],
	["switch2", 29, 4, -45, -1, 0.3, "e0", 61],
	["switch2", -29, 4, 45, 1, 0.3, "e0", 60],
	["switch1b", 0, 0, 0, 0.01, 0.01, "e0", 22],
	["forcefieldLine", -47, -94, 0, 1, -1, "e22", 50],
	["forcefieldLine", 47, 94, 0, -1, 1, "e22", 48],
	["forcefieldLine", -47, 94, 0, 1, 1, "e22", 47],
	["forcefieldLine", 94, -188, 0, -1, -1, "e47", 49],
	["switch2b", 116, -3, 0, 1, 1, "e22", 24],
	["circle", -1, 0, 0, 0.7, 0.7, "e24", 58],
	["switch3b", -1, 0, 0, 1.3, 1.3, "e58", 59],
	["switch3b", -208, 88, 0, 1.2, 1.2, "e24", 51],
	["singu", -208, 88, 0, 1, 1, "e24", 23],
	["oddbox2", -13, 133, 90, -0.6, 0.8, "e22", 8],
	["oddbox", 15, 133, -90, -0.6, 0.8, "e22", 7],
	["oddbox", 15, -144, 90, -0.6, -0.8, "e22", 6],
	["oddbox2", -13, -144, -90, -0.6, -0.8, "e22", 5],
	["oddbox", -138, 8, 0, -0.6, 0.8, "e22", 4],
	["oddbox2", -138, -19, 180, -0.6, 0.8, "e22", 3],
	["oddbox2", 139, -51, -180, 0.6, 0.5, "e22", 2],
	["switch1", -3, 48, -90, -0.5, 0.4, "e2", 57],
	["switch1", -3, 22, -90, -0.5, 0.4, "e2", 53],
	["switch1", 10, 22, 90, 0.5, 0.4, "e2", 52],
	["circle", -9, -49, 0, 1, 1, "e2", 25],
	["tube2", -1, -66, -90, 1.2, 0.9, "e25", 28],
	["tri", -15, -47, -65, -0.6, 0.5, "e28", 30],
	["tri", 16, -48, 65, 0.6, 0.5, "e28", 29],
	["singu", -1, -123, 0, 1, 1, "e25", 26],
	["oddbox", 139, 42, 0, 0.6, 0.5, "e22", 1],
	["switch1", 11, -46, 90, 0.5, 0.4, "e1", 56],
	["switch1", -3, -21, -90, -0.5, 0.4, "e1", 55],
	["switch1", 11, -21, 90, 0.5, 0.4, "e1", 54],
	["circle", -9, 58, 180, 1, -1, "e1", 31],
	["tube2", 0, -66, -90, 1.2, -0.9, "e31", 32],
	
	["single", -10, -47, -180, 1, 1, "e32", 65],
	["single", -6, -49, -180, 1, 1, "e32", 67],
	["single", -2, -51, -180, 1, 1, "e32", 69],
	["single", 2, -51, -180, 1, 1, "e32", 71],
	["single", 6, -49, -180, 1, 1, "e32", 73],
	["single", 10, -47, -180, 1, 1, "e32", 75],
	
	["tri", -15, -46, -115, -0.6, -0.5, "e32", 34],
	["tri", 16, -46, 115, 0.6, -0.5, "e32", 33]
];

var level10 = new Object();
level10.AI = [
	"AI_coreGun_twinRapid",
	["AI_rotatePart", 7,-0.4,-20,60,0],
	["AI_rotatePart", 5,0.4,-60,20,0],
	["AI_randomWaypoints"],
	["AI_randomRotate"]
];
level10.code = [
	["core",400,200,0,1,1,-1,0], 
	["rhombus",26,25,90,1,1,"e0",18], 
	["singu", 0, -56, 0, 1, 1, "e0", 53],
	["rhombus",37,1,45,1,1,"e18",23], 
	["smallbox",49,14,180,1,1,"e23",26], 
	["laser",-4,-29,-13,1,1,"e26",51], 
	["jet",44,0,-90,1,1,"e26",27], 
	["jet",59,0,90,1,1,"e27",31], 
	["tri",21,-1,-90,1,1,"e31",29], 
	["spread",14,0,0,1,1,"e29",39], 
	["stick",7,85,-90,1,1,"e18",20], 
	["single",-15,48,54,1,1,"e20",38], 
	["single",-15,5,6,1,1,"e20",36], 
	["single",-16,-41,14,1,1,"e20",34], 
	["oddbox2",39,-30,0,1,1,"e20",22], 
	["rhombus",-28,23,-135,1,1,"e0",17], 
	["rhombus",-36,3,90,1,1,"e17",24], 
	["smallbox",-49,11,0,1,1,"e24",25], 
	["laser",1,-27,-169,1,1,"e25",52], 
	["jet",-43,0,90,1,1,"e25",28], 
	["jet",-59,0,-90,1,1,"e28",32], 
	["tri",-21,-1,90,1,1,"e32",30], 
	["spread",-14,0,0,1,1,"e30",40], 
	["stick",-8,84,90,1,1,"e17",19], 
	["single",9,50,-50,1,1,"e19",37], 
	["single",12,9,-13,1,1,"e19",35], 
	["single",15,-38,-18,1,1,"e19",33], 
	["oddbox",-39,-31,0,1,1,"e19",21], 
	["tube2",53,-61,135,1,1,"e0",2], 
	["circle",40,-42,0,1,1,"e2",5], 
	["tube",41,-41,-45,1,1,"e5",14], 
	["laser",-21,-30,-67,1,1,"e14",44], 
	["laser",33,19,-21,1,1,"e14",43], 
	["tube",46,-68,-60,1,1,"e14",15], 
	["tube2",34,34,135,1,1,"e2",4], 
	["circle",40,-39,0,1,1,"e4",6], 
	["tube",58,0,0,1,1,"e6",9], 
	["tube",82,5,6,1,1,"e9",11], 
	["single",46,-10,-135,1,1,"e11",47], 
	["single",31,-22,180,1,1,"e11",46], 
	["spread",35,30,0,1,1,"e11",45], 
	["tube2",-51,-62,46,1,1,"e0",1], 
	["circle",-41,-40,0,1,1,"e1",7], 
	["tube",-43,-41,-135,1,1,"e7",13], 
	["laser",20,-33,-110,1,1,"e13",42], 
	["laser",-35,15,-158,1,1,"e13",41], 
	["tube",-48,-65,-123,1,1,"e13",16], 
	["tube2",-35,33,45,1,1,"e1",3], 
	["circle",-43,-40,0,1,1,"e3",8], 
	["tube",-59,0,180,1,1,"e8",10], 
	["tube",-79,2,177,1,1,"e10",12], 
	["spread",-31,26,0,1,1,"e12",50], 
	["single",-39,-22,135,1,1,"e12",49], 
	["single",-20,-25,180,1,1,"e12",48]
];


function level_custom() {
	return _root.code;
}

//***********AI FUNCTIONS:
function AI_randomRotate_init(paramArray) {
	delFromCoreAIFunctions(AI_randomRotate, false);

	if (paramArray[0]==undefined) var speed = 15;
	else var speed = Number(paramArray[0]);
	
	coreVars.randomRotateTime = 100+random(200);
	coreVars.rotateV = (random(speed)+1) / 10;
	
	return [speed];
}
function AI_randomRotate(paramArray) {
	var speed = paramArray[0];
	
	coreVars.count++;
	if (coreVars.AI_rotateCW) {
		ai_ob._rotation+=coreVars.rotateV;
	} else
	if (coreVars.AI_rotateCCW) {
		ai_ob._rotation-=coreVars.rotateV;
	}

	if (coreVars.count>=coreVars.randomRotateTime) {
		coreVars.count=0;
		coreVars.randomRotateTime = 100+random(200);
		coreVars.rotateV = (random(speed)+1) / 10;
		if (random(2)==0) {
			coreVars.AI_rotateCW=random(2);
			coreVars.AI_rotateCCW = (coreVars.AI_rotateCW==1) ? 0 : 1;
		} else {
			coreVars.AI_rotateCCW=random(2);
			coreVars.AI_rotateCW = (coreVars.AI_rotateCCW==1) ? 0 : 1;
		}

		return true;
	}
	return false;
}

function AI_rotateToShip_init(paramArray) {
	(AI_rotateToShip, false);

	if (paramArray[0]==undefined) var speed = 1;
	else var speed = Number(paramArray[0]);
	
	return [speed];
}
function AI_rotateToShip(paramArray) {
	var speed = paramArray[0];

	var angle = Math.atan2(ai_ob._y - ship._y, ai_ob._x - ship._x) / (PI/180);
	angle-=90;
	var oldangle = ai_ob._rotation;
	
	var dist = oldangle - angle;
	if (dist < -180) angle-=360;
	else if (dist > 180) angle+=360;

	if (Math.abs(oldangle-angle) < 20) return;
	if (oldangle > angle)
		newangle = oldangle-speed;
	else if (oldangle < angle)
		newangle = oldangle+speed;

	ai_ob._rotation = newangle;
}

function AI_followShip_init(paramArray) {
	delFromCoreAIFunctions(AI_followShip, false);

	if (paramArray[0]==undefined) var speed = 1;
	else var speed = Number(paramArray[0]);
	
	return [speed];
}
function AI_followShip(paramArray) {
	var speed = paramArray[0];
	var xDist = ai_ob._x - ship._x;
	var yDist = ai_ob._y - ship._y;

	if (Math.abs(xDist) > 50) {
		if (xDist>0) ai_ob._x -= speed;
		else ai_ob._x += paramArray[0];
	}
	if (Math.abs(yDist) > 50) {
		if (yDist>0) ai_ob._y -= speed;
		else ai_ob._y += paramArray[0];
	}
}
function AI_randomWaypoints_init(paramArray) {
	coreVars.randomWaypoints_wp = [random(STAGE_W), random(STAGE_H)];
	
	delFromCoreAIFunctions(AI_randomWaypoints, false);

	if (paramArray[0]==undefined) var speed = 1;
	else var speed = Number(paramArray[0]);
	
	return [speed];
}
function AI_randomWaypoints(paramArray) {
	var speed = paramArray[0];
	var x = ai_ob._x - coreVars.randomWaypoints_wp[0];
	var y = ai_ob._y - coreVars.randomWaypoints_wp[1];
	var dist = x*x + y*y
	if (Math.abs(dist) < 100) {
		coreVars.randomWaypoints_wp = [random(STAGE_W-400)+200, random(STAGE_H-300)+150];
	}
	if (x > 0)
		ai_ob._x-=speed;
	else if (x < 0)
		ai_ob._x+=speed;
	if (y > 0)
		ai_ob._y-=speed;
	else if (y < 0)
		ai_ob._y+=speed;
}
function AI_rotatePart_init(paramArray) {
	// order of paramArray is partNum, rotateV, min, max, initial
	var partNum = paramArray[0];
	var rotateV = Number(paramArray[1]);
	
	//Min and Max are optional. Assume 0 if undefined.
	if (paramArray[2]==undefined) var min=0;
	else var min = Number(paramArray[2]);
	
	if (paramArray[3]==undefined) var max=0;
	else var max = Number(paramArray[3]);
	
	//initial angle is optional. Do nothing if undefined.
	if (paramArray[4] != undefined) {
		var initial = Number(paramArray[4]);
		enemies["e"+partNum].rotation = initial;
	}

	if (min > max) {
		var temp = min;
		min = max;
		max = temp;
	}
	
	//was ALWAYS returning an array. now checking if speed=0, if so dont let this command repeat (rotating 0° every frame doesnt make much sense)
	if (rotateV == 0)
		return "initOnly";
	else
		return [partNum,rotateV,min,max];
}

function AI_rotatePart(paramArray) {
	var partNum = paramArray[0];
	var rotateV = paramArray[1];
	var min = paramArray[2];
	var max = paramArray[3];

	var ob = enemies["e"+partNum];
	ob.rotation += rotateV;
	ob._rotation += rotateV;
	if (min!=max) {
		if (ob.rotation >= max) {	
			paramArray[1] = -Math.abs(rotateV);
		} else
		if (ob.rotation <= min) {	
			paramArray[1] = Math.abs(rotateV);
		}
	}
}

function AI_rotatePartToShip_init(paramArray) {
//	coreVars.rotatePartToShipAngle=paramArray[1]; //useless?
	return paramArray;
}
function AI_rotatePartToShip(paramArray) {
	for (var i=0; i<paramArray.length; i++) { //Can supply a list of parts
		if (ship!=undefined) {
			var ob = enemies["e"+paramArray[i]];

			var angle = Math.atan2(ob._y - ship._y, ob._x - ship._x) / (PI/180);
			angle-=90;//+coreVars.rotatePartToShipAngle;
			var oldangle = ob.rotation;
			
			var dist = oldangle - angle;
			if (dist < -180) angle-=360;
			else if (dist > 180) angle+=360;

			ob.rotation=-(ob.parent._rotation - ob.parent.origRotation)+ angle;
		}
	}
}

function AI_makeInvincible_init(paramArray) {
	for (var i=0; i<paramArray.length; i++) { //Can supply a list of parts
		var ob = enemies["e"+paramArray[i]];
		//ob.hp = 99999999;
		ob.invincible = true;

		// if (ob.colR == "00" and ob.colG == "66" and ob.colB == "FF" and !ob.isGun)
			// _root.setColour(ob, "8C", "B1", "FF");
		// else if (ob.colR == "66" and ob.colG == "66" and ob.colB == "66" and ob.isGun)
			// _root.setColour(ob, "FC", "B7", "F4");
	}
	
	return "initOnly";
}
function AI_makeVulnerable_init(paramArray) {
	for (var i=0; i<paramArray.length; i++) { //Can supply a list of parts
		var ob = enemies["e"+paramArray[i]];
		ob.__proto__ = _root["e_"+ob.link].prototype;
		//ob.init(true);
		ob.invincible = false;
	}
	
	return "initOnly";
}

function AI_makeSwitch_init(paramArray) { //makeTrigger will replace this function. This one is left here for compatibility 07-01-08
	var ob = enemies["e"+paramArray.shift()]; //One source part per line of player-code

	ob.deathTrigger.push(["destroy"].concat(paramArray));
	
	return "initOnly";
}

function AI_makeTrigger_init(paramArray) {
	/*
	OLD Syntax: makeTrigger, trigger, action, triggerSpecificParams
	NEW Syntax: makeTrigger, death, sourceOb, anyAIcommand
	            makeTrigger, time, frames, anyAIcommand
	*/
	
	var trigger = paramArray.shift();
	if (trigger=="death") {
		if (paramArray[0]==int(paramArray[0])) {//If param after trigger is a number then this is the new syntax, otherwise it is a string and thus an action from the old syntax
			var sourceOb = enemies["e"+paramArray.shift()];
			//paramArray is its own AI command at this point
			sourceOb.deathTrigger.push(paramArray);
		} else { //This section for backward compatibility. I wish i could delete it :P
			var action = paramArray.shift();
			if (action=="col") {
				//IN:           col, source(ob), targets
				//STORED IN OB: col, targets
				var col = paramArray.shift();
				var ob = enemies["e"+paramArray.shift()];
				ob.deathTrigger.push([action].concat([col].concat(paramArray)));
			} else {	
				//Generic:
				//IN:           source(ob), targets
				//STORED IN OB: targets
				
				//Rotate (Possible use of generic):
				//IN:           source(ob), PART#, SPEED, MIN_ANGLE, MAX_ANGLE, START_ANGLE
				//STORED IN OB: PART#, SPEED, MIN_ANGLE, MAX_ANGLE, START_ANGLE
				
				var ob = enemies["e"+paramArray.shift()];
				ob.deathTrigger.push([action].concat(paramArray));
			}
		}
	} else
	if (trigger=="time") {
		//IN:           frameNum, anyAIcode
	
		//Add the timer to gameLoop if necessary
		var alreadyAdded=false;
		for (var i=0; i<currentLvl_coreAIfunctions.length; i++) {
			if (currentLvl_coreAIfunctions[i][0] == timeTriggerCheck) {
				alreadyAdded=true;
			}
		}

		if (!alreadyAdded) {
			addToCoreAIFunctions (timeTriggerCheck, null)
		}
	
		//Add to timeArray
		var frameNum = paramArray.shift(); //aka "action"
		
		if (frameNum>0) {
			frameNum = int(frameNum) + curFrame;
			if (timeArray[frameNum]==undefined) timeArray[frameNum]=[];
			timeArray[frameNum].push([0].concat(paramArray)); //0 means do not repeat
		} else {
			timeTriggerExecute([0].concat(paramArray));
		}
	} else
	if (trigger=="timeRepeat") {
		//IN:           frameNum, repeatInterval, anyAIcode
	
		//Add the timer to gameLoop if necessary
		var alreadyAdded=false;
		for (var i=0; i<currentLvl_coreAIfunctions.length; i++) {
			if (currentLvl_coreAIfunctions[i][0] == timeTriggerCheck) {
				alreadyAdded=true;
			}
		}

		if (!alreadyAdded) {
			addToCoreAIFunctions (timeTriggerCheck, null)
			curFrame=0;
		}
	
		//Add to timeArray
		var frameNum = int(paramArray.shift());
		var repeatInterval = int(paramArray.shift());
		var totalFrameNum = frameNum + curFrame;
		//***INFINITE LOOP CHECKING - THROW AN ERROR
		if (repeatInterval < 1) { //Check for illegal values (a 0 would cause it to call itself infinitely on one frame, trust me i tried it)
			messageTrace("Infinite loops are a bad idea:\nREPEAT_AFTER_FRAMES must be > 0\n\nHere's the guilty command:\nmakeTrigger,timeRepeat,"+frameNum+","+repeatInterval+","+paramArray);
			return;
		}
		//Check for many triggers happening at once. Perhaps too limiting, so I am not using this.
		// var eventCount = timeArray[totalFrameNum].length;
		// if (eventCount > 500) {
			// messageTrace("Too many triggers ("+eventCount+"). Deleting triggers for this frame and pausing the game.\n\nHere's the guilty command:\nmakeTrigger,timeRepeat,"+frameNum+","+repeatInterval+","+paramArray);
			// delete timeArray[totalFrameNum];
			// openPauseMenu();
			// return;
		// }
		//***
		
		if (frameNum>0) {
			if (timeArray[totalFrameNum]==undefined) timeArray[totalFrameNum]=[];
			timeArray[totalFrameNum].push([1, repeatInterval].concat(paramArray)); //1 means do repeat
		} else {
			timeTriggerExecute([1, repeatInterval].concat(paramArray));
		}
	}
	
	//DOCUMENTATION
	/*
	The frame num is relative to the current time.
	In most uses it will be the start of the level, so 0 + whateverFrame
	However, both deathTriggers and timeTriggers can create timeTriggers. In these cases time is currentFrame + whateverFrame
	The params for a timeTrigger are exactly those that can be used in the AI code window. Thus allowing for as much recurrence as desired.
	*/
	
	return "initOnly";
}

function AI_disableGun_init(paramArray) {
	for (var i=0; i<paramArray.length; i++) { //Can supply a list of parts
		var ob = enemies["e"+paramArray[i]];
		setGunEnable( ob, false );
	}
	
	return "initOnly";
}
function AI_enableGun_init(paramArray) {
	for (var i=0; i<paramArray.length; i++) { //Can supply a list of parts
		var ob = enemies["e"+paramArray[i]];
		setGunEnable( ob, true );
	}
	
	return "initOnly";
}

function AI_destroy_init(paramArray) {
	for (var i=0; i<paramArray.length; i++) { //Can supply a list of parts
		var ob = enemies["e"+paramArray[i]];
		removeHP(ob, ob.hp, true);
		checkHP(ob);
	}
	
	return "initOnly";
}
function AI_col_init(paramArray) {
	var col = paramArray.shift();
	
	for (var i=0; i<paramArray.length; i++) { //Can supply a list of parts
		var ob = enemies["e"+paramArray[i]];
		setColour(ob, col);
	}
	
	return "initOnly";
}
function AI_setGunTime_init(paramArray) {
	var newDelay = paramArray.shift();

	for (var i=0; i<paramArray.length; i++) { //Can supply a list of parts
		var ob = enemies["e"+paramArray[i]];
		ob.delay = newDelay;
	}
	
	return "initOnly";
}
function AI_setWidth_init(paramArray) {
	var newWidth = paramArray.shift();

	for (var i=0; i<paramArray.length; i++) { //Can supply a list of parts
		var ob = enemies["e"+paramArray[i]];
		ob._width = newWidth;
	}
	
	return "initOnly";
}
function AI_setHeight_init(paramArray) {
	var newHeight = paramArray.shift();

	for (var i=0; i<paramArray.length; i++) { //Can supply a list of parts
		var ob = enemies["e"+paramArray[i]];
		ob._height = newHeight;
	}
	
	return "initOnly";
}
function AI_setHP_init(paramArray) {
	var newHP = paramArray.shift();

	for (var i=0; i<paramArray.length; i++) { //Can supply a list of parts
		var ob = enemies["e"+paramArray[i]];
		ob.hp = newHP;
	}
	
	return "initOnly";
}
function AI_setDistance_init(paramArray) {
	var newC = paramArray.shift();

	for (var i=0; i<paramArray.length; i++) { //Can supply a list of parts
		var ob = enemies["e"+paramArray[i]];
		ob.c = newC;
	}
	
	return "initOnly";
}
//Waypoints
//Syntax: waypoints, loop, speed, x, y, x2, y2, x3, y3, etc
function AI_waypoints_init(paramArray) {
	delFromCoreAIFunctions(AI_waypoints,false);

	for (var i=0; i<paramArray.length; i++) {
		paramArray[i] = Number(paramArray[i]);
	}
	
	coreVars.waypoints_count = 2;
	
	return paramArray;
}
function AI_waypoints(paramArray) {
	var speed = paramArray[1];
	var x = paramArray[coreVars.waypoints_count];
	var y = paramArray[coreVars.waypoints_count+1];
	
	var xDist = x - ai_ob._x;
	var yDist = y - ai_ob._y;
	var dist = Math.sqrt((xDist*xDist)+(yDist*yDist));

	if (dist < speed) {
		ai_ob._x = x;
		ai_ob._y = y;
	} else {
		var px = xDist/dist;
		var py = yDist/dist;
		ai_ob._x += px*speed;
		ai_ob._y += py*speed;
	}
	
	if (ai_ob._x == x && ai_ob._y == y) {
		if (coreVars.waypoints_count < paramArray.length-2) { //still more waypoints to go
			coreVars.waypoints_count+=2;
		} else { //End of the list of waypoints.
			if (paramArray[0]) //If loop
				coreVars.waypoints_count=2;
			else
				delFromCoreAIFunctions(waypoints,false);
		}
	}
}

function AI_stop_init(paramArray) {
	var funcStr = paramArray.shift();
	var func = _root["AI_"+funcStr];
	
	if (func != undefined) { //Has a repeating function (not repeating only have a _init function)
		delFromCoreAIFunctions(func,true,paramArray);
	} else if (funcStr=="makeTrigger") {
		var trigger = paramArray.shift();
		if (trigger=="timeRepeat") {
			var frameNum = paramArray.shift();
			var repeatInterval = paramArray.shift();
			var lookingForThese = [1, repeatInterval].concat(paramArray);

			var maxFramesAway = int(frameNum) + int(repeatInterval);
			for (var i=0; i<=maxFramesAway; i++) { //i = frames numbers after curFrame to check for the function to delete

				if (timeArray[curFrame+i] != undefined) {
					for (var j=0; j<timeArray[curFrame+i].length; j++) { //For every event. j=event num for this time
						var eventParams = timeArray[curFrame+i][j];
						var equal=true;
						for (var k=0; k<lookingForThese.length; k++) { //k=event element in lookingForThese and eventParams
							if (lookingForThese[k]!=eventParams[k] and eventParams[k]!=undefined) {
								equal=false;
							}
						}
						
						if (equal) {
							delete timeArray[curFrame+i][j];//Found the next occurence of a repeating time trigger, kill it.
							return;
						}
					}
				}
			}
		}
	}
		
	return "initOnly";
}
//**************  AI  *********************
//LEVEL 4
function AI_4_init() {
	coreVars.waypoint = [random(STAGE_W), random(STAGE_H)];
	coreVars.randomTime = random(240) + 90;
}
function AI_4() {
	coreVars.aiCount++;
	if (coreVars.aiCount == coreVars.randomTime) {
		coreVars.randomTime = random(240) + 90;
		coreVars.aiCount=0;
		if (random(100) < 80) {
			coreVars.AIrotateMode = AI_randomRotate;
		} else {
			coreVars.AIrotateMode = AI_rotateToShip;
		}
		if (random(100) < 80) {
			coreVars.AImoveMode = AI_randomWaypoints;
		} else {
			coreVars.AImoveMode = AI_followShip;
		}
	}

	coreVars.AImoveMode();
	coreVars.AIrotateMode();
}

//SOUNDS:
volumeMasterSnd = new Sound(this);
volumeMasterSnd.setVolume(op_volume);//Master. Ex: 50% here will cause volume30 to be 15%
delete op_volume; //just a temp variable. because it is set prior to volumeMasterSnd existing

createEmptyMovieClip("volume15", 701);
volume15Snd = new Sound(volume15);
volume15Snd.setVolume(15);

createEmptyMovieClip("volume30", 700);
volume30Snd = new Sound(volume30);
volume30Snd.setVolume(30);

createEmptyMovieClip("volume60", 702);
volume60Snd = new Sound(volume60);
volume60Snd.setVolume(60);

createEmptyMovieClip("volume100", 703);
volume100Snd = new Sound(volume100);
volume100Snd.setVolume(100);

expSnd = new Sound(volume100);
expSnd.attachSound("expSnd");

tinyShotSnd = new Sound(volume100);
tinyShotSnd.attachSound("tinyShotSnd");

tinyShot2Snd = new Sound(volume100);
tinyShot2Snd.attachSound("tinyshot2Snd");

//played from MC bulletExp's timeline
bulletExpSnd = new Sound(volume100);
bulletExpSnd.attachSound("deepQuickHit.wav");

//played from MC invincibleBulletExp's timeline
invincibleBulletExpSnd = new Sound(volume60);
invincibleBulletExpSnd.attachSound("lightQuickHit.mp3");

roundSnd = new Sound(volume100);
roundSnd.attachSound("roundSnd");

laser2Snd = new Sound(volume100); //not used, still in library
laser2Snd.attachSound("laser2Snd");

//from osabisi.sakura.ne.jp:
squareSnd = new Sound(volume60);
squareSnd.attachSound("bosu33.wav");

spikeSnd = new Sound(volume30);
spikeSnd.attachSound("cursor04.wav");

laserSnd_start = new Sound(volume15);
laserSnd_start.attachSound("eco03(slow).wav");

singularitySnd = new Sound(volume30);
singularitySnd.attachSound("Fire.mp3");

//CLASSES
//*** GUN BEHAVIORS USED IN GUNS: ***
function AI_coreGun_spread() {
	ai_ob.delay++;
	if (ai_ob.delay==100) { //'shockwave'
		roundSnd.start(0,0);
		for (var g=0; g<25; g++) {
			enemy_fireBullet(ai_ob, "round", g*14.4, enemy_pixelBullets, true);
		}
		ai_ob.gun_a = random(25);
	}
	if (ai_ob.delay>=180) { //'spiral'
		ai_ob.gun_a++;
		enemy_fireBullet(ai_ob, "round", ai_ob.gun_a*14.4, enemy_pixelBullets, true);
		
		if (ai_ob.delay%2) roundSnd.start(0,0);
	}
	if (ai_ob.delay>=180+6) {
		ai_ob.gun_a = 0;
		ai_ob.delay=0;
	}
}

function AI_coreGun_4way_2shot() {
	ai_ob.delay++;
	if (ai_ob.delay==50) {
		roundSnd.start(0,0);
	
		for (var g=0; g<4; g++) {
			enemy_fireBullet(ai_ob, "round", (g*90)-5 + ai_ob.gun_a, enemy_pixelBullets, true);
			enemy_fireBullet(ai_ob, "round", (g*90)+5 + ai_ob.gun_a, enemy_pixelBullets, true);
		}
		ai_ob.gun_a = random(360);
		ai_ob.delay=0;
	}
}

function AI_coreGun_double() {
	ai_ob.delay++;
	if (ai_ob.delay == 90) {
		var a = random(360);
		enemy_fireBullet(ai_ob, "spike", a, enemy_pixelBullets, true);
		enemy_fireBullet(ai_ob, "spike", a+10, enemy_pixelBullets, false);
		ai_ob.delay=0;
	}
}

function AI_coreGun_twinRapid() {
	ai_ob.delay++;
	if (ai_ob.delay >= 90) {
		ai_ob.delay2++;
		if (ai_ob.delay2==3) {
			enemy_fireBullet(ai_ob, "spike", ai_ob.gun_a, enemy_pixelBullets, true);
			enemy_fireBullet(ai_ob, "spike", 180 - ai_ob.gun_a, enemy_pixelBullets, false);
			ai_ob.gun_a += 8;
			ai_ob.delay2=0;
			
			if (ai_ob.delay >= 158) {
				ai_ob.delay=0;
				ai_ob.gun_a = random(360);
			}
		}
	}
}

//*********PARTS
e_Rhombus = function () {};
e_Rhombus.prototype = new MovieClip;
e_Rhombus.prototype.init = function () {
	this.hp = 1200;
	_root.setColour(this, "0066FF");
}

e_Box = function () {};
e_Box.prototype = new MovieClip;
e_Box.prototype.init = function () {
	this.hp = 2200;
	_root.setColour(this, "0066FF");
}
e_Oddbox = function () {};
e_Oddbox.prototype = new MovieClip;
e_Oddbox.prototype.init = function () {
	this.hp = 2800;
	_root.setColour(this, "0066FF");
}
e_Oddbox2 = function () {};
e_Oddbox2.prototype = new MovieClip;
e_Oddbox2.prototype.init = function () {
	this.hp = 2800;
	_root.setColour(this, "0066FF");
}

e_Circle = function () {};
e_Circle.prototype = new MovieClip;
e_Circle.prototype.init = function () {
	this.hp = 3000;
	_root.setColour(this, "0066FF");
}

e_Jet = function () {};
e_Jet.prototype = new MovieClip;
e_Jet.prototype.init = function () {
	this.hp = 800;
	_root.setColour(this, "0066FF");
}

e_Smallbox = function () {};
e_Smallbox.prototype = new MovieClip;
e_Smallbox.prototype.init = function () {
	this.hp = 1000;
	_root.setColour(this, "0066FF");
}

e_Tri = function () {};
e_Tri.prototype = new MovieClip;
e_Tri.prototype.init = function () {
	this.hp = 800;
	_root.setColour(this, "0066FF");
}
e_RightTri = function () {};
e_RightTri.prototype = new MovieClip;
e_RightTri.prototype.init = function () {
	this.hp = 1000;
	_root.setColour(this, "0066FF");
}

e_Rect = function () {};
e_Rect.prototype = new MovieClip;
e_Rect.prototype.init = function () {
	this.hp = 1000;
	_root.setColour(this, "0066FF");
}

e_Core = function () {};
e_Core.prototype = new MovieClip;
e_Core.prototype.init = function () {
	this.hp = 1000;
	_root.setColour(this, "0066FF");
}
e_Core.prototype.gunAI = function() {
	currentLvl_coreGunAI();
}

e_Stick = function () {};
e_Stick.prototype = new MovieClip;
e_Stick.prototype.init = function () {
	this.hp = 2000;
	_root.setColour(this, "0066FF");
}
e_Stick2 = function () {};
e_Stick2.prototype = new MovieClip;
e_Stick2.prototype.init = function () {
	this.hp = 2000;
	_root.setColour(this, "0066FF");
}

e_Tube = function () {};
e_Tube.prototype = new MovieClip;
e_Tube.prototype.init = function () {
	this.hp = 1500;
	_root.setColour(this, "0066FF");
}
e_Tube2 = function () {};
e_Tube2.prototype = new MovieClip;
e_Tube2.prototype.init = function () {
	this.hp = 1500;
	_root.setColour(this, "0066FF");
}
e_forcefieldLine = function () {};
e_forcefieldLine.prototype = new MovieClip;
e_forcefieldLine.prototype.init = function () {
	this.invincible = true;
	this.hp = 99999999;
	_root.setColour(this, "82B4FF");
}

e_switch1 = function () {};
e_switch1.prototype = new MovieClip;
e_switch1.prototype.init = function () {
	this.hp = 600;
	_root.setColour(this, "0C6666"); //146600
}
e_switch1b = function () {};
e_switch1b.prototype = new MovieClip;
e_switch1b.prototype.init = function () {
	this.hp = 600;
	_root.setColour(this, "0C6666");
}

e_switch2 = function () {};
e_switch2.prototype = new MovieClip;
e_switch2.prototype.init = function () {
	this.hp = 600;
	_root.setColour(this, "952966");
}
e_switch2b = function () {};
e_switch2b.prototype = new MovieClip;
e_switch2b.prototype.init = function () {
	this.hp = 600;
	_root.setColour(this, "952966");
}
e_switch3 = function () {};
e_switch3.prototype = new MovieClip;
e_switch3.prototype.init = function () {
	this.hp = 600;
	_root.setColour(this, "0646B3");
}
e_switch3b = function () {};
e_switch3b.prototype = new MovieClip;
e_switch3b.prototype.init = function () {
	this.hp = 600;
	_root.setColour(this, "0646B3");
}
e_switch4 = function () {};
e_switch4.prototype = new MovieClip;
e_switch4.prototype.init = function () {
	this.hp = 600;
	_root.setColour(this, "8F79FE");
}
e_switch4b = function () {};
e_switch4b.prototype = new MovieClip;
e_switch4b.prototype.init = function () {
	this.hp = 600;
	_root.setColour(this, "8F79FE");
}

e_c = function () {};
e_c.prototype = new MovieClip;
e_c.prototype.init = function () {
	this.hp = 2000;
	_root.setColour(this, "0066FF");
}

//******************WEAPONS
gunHelper = [];

e_Spread = function () {};
e_Spread.prototype = new MovieClip;
e_Spread.prototype.init = function () {
	this.hp = 1000;
	_root.setColour(this, "666666");
	
	var count=0;
	for (var i=0; i<gunArray.length; i++) {
		if (gunArray[i].link=="spread") {
			count++;
		}
	}
	this.isGun=true;
	this.delay = (count*30)%492;
	if (this.delay >= 260)
		this.anim.gotoAndPlay(this.delay - 259);
	
	gunArray.push(this);
}
e_Spread.prototype.gunAI = function () {
	this.delay++;
	if (this.delay >= 260) {
		if (this.delay==265) {
			this.anim.play();
		} else
		if (this.delay==300 or this.delay==320) {
			for (var g=0; g<12; g++) {
				enemy_fireBullet(this, "round", g*30, enemy_pixelBullets);
			}
		} else
		if (this.delay>=480) {
			this.gun_a++;
			enemy_fireBullet(this, "round", this.gun_a*30, enemy_pixelBullets);

			if (this.delay>=492) {
				this.gun_a = 0;
				this.delay=0;
			}
		}
	}
}
gunHelper["spread"] = "Firing: 300, 320, 480-492";

e_Single = function () {};
e_Single.prototype = new MovieClip;
e_Single.prototype.init = function () {
	this.hp = 1000;
	_root.setColour(this, "666666");
	
	var count=0;
	for (var i=0; i<gunArray.length; i++) {
		if (gunArray[i].link=="single") {
			count++;
		}
	}
	this.isGun=true;	
	this.delay = (count*15)%120;
	//this.startDelay = 100;
	
	_root.gunArray.push(this);
}
e_Single.prototype.gunAI = function () {
	this.delay++;
	if (this.delay==100) {
		enemy_fireBullet(this, "round", this._rotation+90, enemy_pixelBullets);
		this.turret.play();
	} else
	if (this.delay>=120) {
		enemy_fireBullet(this, "round", this._rotation+90, enemy_pixelBullets);
		this.delay=0;
		this.turret.play();
	}
}
gunHelper["single"] = "Firing times: 100, 120";

e_Square = function () {};
e_Square.prototype = new MovieClip;
e_Square.prototype.init = function () {
	this.hp = 1200;
	_root.setColour(this, "666666");
	
	var count=0;
	for (var i=0; i<gunArray.length; i++) {
		if (gunArray[i].link=="square") {
			count++;
		}
	}
	this.isGun=true;	
	this.delay = (count*5)%170;
	
	_root.gunArray.push(this);
}
e_Square.prototype.gunAI = function () {
	this.delay++;
	if (this.delay==110) { //130
		//enemy_fireBullet(this, "square", this._rotation+90, enemy_destroyableBullets);
		this.fire.play();
	} else 
	if (this.delay>=170) {
		this.delay=0;
	}
}
gunHelper["square"] = "Note: Firing is independent animation.\nFiring sequence cannot be stopped once started.\nStart time: 110\nEnd time: 170";

e_Laser = function () {};
e_Laser.prototype = new MovieClip;
e_Laser.prototype.init = function () {
	this.hp = 1000;
	_root.setColour(this, "666666");
	
	var count=0;
	for (var i=0; i<gunArray.length; i++) {
		if (gunArray[i].link=="laser" or gunArray[i].link=="laser_") {
			count++;
		}
	}
	this.isGun=true;
	this.delay = (Math.floor(count/2)*15) % 120;
	
	_root.gunArray.push(this);
}
e_Laser.prototype.gunAI = function () {
	this.delay++;
	if (this.delay==50) {
		enemy_fireBullet(this, "laser", this._rotation, enemy_shapeBullets);
	} else
	if (this.delay>=120) {
		this.delay=0;
	}
}
gunHelper["laser"] = "Firing time: 50\nEnd time: 120";

e_Laser_ = function () {}; //Copy of laser. New laser is rotated 90 degrees in order to work properly, old laser still exists for compatibility
e_Laser_.prototype = new MovieClip;
e_Laser_.prototype.init = function() {
	this.hp = 1000;
	_root.setColour(this, "666666");
	
	var count=0;
	for (var i=0; i<gunArray.length; i++) {
		if (gunArray[i].link=="laser_") {
			count++;
		}
	}
	this.isGun=true;
	this.delay = (Math.floor(count/2)*15) % 120;
	
	_root.gunArray.push(this);
}
e_Laser_.prototype.gunAI = function () {
	this.delay++;
	if (this.delay==50) {
		enemy_fireBullet(this, "laser_", this._rotation, enemy_shapeBullets);
	} else
	if (this.delay>=120) {
		this.delay=0;
	}
}
gunHelper["laser_"] = "Firing time: 50\nEnd time: 120";

e_Singu = function () {};
e_Singu.prototype = new MovieClip;
e_Singu.prototype.init = function () {
	this.hp = 1000;
	_root.setColour(this, "666666");
	this.isGun=true;
	
	var count=0;
	for (var i=0; i<gunArray.length; i++) {
		if (gunArray[i].link=="singu") {
			count++;
		}
	}
	this.delay = (count*20+count)%300;
	
	
	_root.gunArray.push(this);
}
e_Singu.prototype.gunAI = function () {
	this.delay++;
	if (this.delay==70) {
		enemy_fireBullet(this, "Singularity", this._rotation, enemy_shapeBullets);
		this.anim.play();
	} else
	if (this.delay==90) {
		enemy_fireBullet(this, "Singularity", this._rotation, enemy_shapeBullets);
		this.anim.play();
	} else
	if (this.delay==110) {
		enemy_fireBullet(this, "Singularity", this._rotation, enemy_shapeBullets);
		this.anim.play();
	} else
	if (this.delay>=300) {
		enemy_fireBullet(this, "Singularity", this._rotation, enemy_shapeBullets);
		this.anim.play();
		this.delay=0;
	}
}
gunHelper["singu"] = "Firing times: 70, 90, 110, 300";
//****************BULLETS
b_Round = function () {};
b_Round.prototype = new MovieClip;
b_Round.prototype.init = function (angle) {
	this.angle = angle;
	this.angleRad = angle * (PI/180);
	this.v = 8;
}

b_Square = function () {};
b_Square.prototype = new MovieClip;
b_Square.prototype.init = function (angle) {
	this.angle = angle;
	this.angleRad = angle * (PI/180);
	this.v = 7;
};
b_Square.prototype.a = function () {
	this.lifetime++;
	if (this.lifetime > 120) return;

	//Homing rocket:
	var oldangle = this.angleRad / (PI/180);
	oldangle %= 360;

	var angle = Math.atan2(this._y - ship._y, this._x - ship._x) / (PI/180);

	var dist = oldangle - angle;

	if (dist < -180) angle-=360;
	else if (dist > 180) angle+=360;

	if (oldangle > angle)
		newangle = oldangle+5;
	else if (oldangle < angle)
		newangle = oldangle-5;

	this._rotation = newangle;
	this.angleRad = newangle * (PI/180);

	this.vx = Math.cos(this.angleRad) * this.v;
	this.vy = Math.sin(this.angleRad) * this.v;
};
b_Spike = function () {};
b_Spike.prototype = new MovieClip;
b_Spike.prototype.init = function (angle) {
	this.angle = angle;
	this.angleRad = angle * (PI/180);
	this.v = 15;
}
b_Laser = function () {};
b_Laser.prototype = new MovieClip;
b_Laser.prototype.init = function (angle) {
	this.angle = angle;
	this.angleRad = angle * (PI/180);
	this.v = 0;
};
b_Laser.prototype.a = function () {
	this.lifetime++;
	if (this.lifetime > 90) this.removeMovieClip();
	//if (this.lifetime==50) laserSnd_end.start(0,0);

	this._rotation = this.shooter._rotation;
	this._x = this.shooter._x;
	this._y = this.shooter._y;

	if (this.shooter._x==undefined) this.removeMovieClip();
};

b_Laser_ = function () {};
b_Laser_.prototype = new MovieClip;
b_Laser_.prototype.init = function (angle) {
	this.angle = angle;
	this.angleRad = angle * (PI/180);
	this.v = 0;
};
b_Laser_.prototype.a = function () {
	this.lifetime++;
	if (this.lifetime > 90) this.removeMovieClip();
	//if (this.lifetime==50) laserSnd_end.start(0,0);

	this._rotation = this.shooter._rotation;
	this._x = this.shooter._x;
	this._y = this.shooter._y;

	if (this.shooter._x==undefined) this.removeMovieClip();
};
b_Singularity = function () {};
b_Singularity.prototype = new MovieClip;
b_Singularity.prototype.init = function (angle) {
	this.angle = angle;
	this.angleRad = angle * (PI/180);
	this.v = 0;
};