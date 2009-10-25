-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
///																	FIGHTERS																      ///
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local FighterTable = {}

	FighterTable["models/Slyfo/sword.mdl"] = {
				        name = "SWORD" ,
						exit = Vector( 150 , 120 , 500 ) ,
						category = "Fighters" ,
				        parts = {
				                {	["model"] = "models/Items/battery.mdl",
									["type"] = "pilot",
									["pos"] = Vector(190,0,30),
									["ang"] =  Angle(0,0,0),
									["gravity"] = false,
									["colour"] = Color(0,0,0,1)				} ,
				                {	["model"] = "models/Slyfo/sword.mdl" ,
									["type"] = "mount",
									["pos"] = Vector(0,0,0),
									["ang"] =  Angle(0,0,0),
									["drive"] = true,
									["HP"] = {	{	["type"] = { "GatRight","Large", "Medium" } ,
													["pos"]  = Vector(-60,-140, 30) ,
													["ang"]  =  Angle( 0 ,  0 ,180)	} ,
												{	["type"] = { "GatLeft","Large", "Medium" } ,
													["pos"]  = Vector(-60,140, 30) ,
													["ang"]  =  Angle( 0 , 0 ,180) } ,
												{	["type"] = { "GatMid","Medium", "Heavy", "Vehicle" } ,
													["pos"]  = Vector(130, 0 , 25) ,
													["ang"]  =  Angle( 0 , 0 ,180) } ,
												{	["type"] = { "Small", "Tiny" } ,
													["pos"]  = Vector(215,-30, 40) ,
													["ang"]  =  Angle( 0 , 0 , 90) } ,
												{	["type"] = { "Small", "Tiny" } ,
													["pos"]  = Vector(215, 30, 40) ,
													["ang"]  =  Angle( 0 , 0 ,270) } } } } }



for k,v in pairs( FighterTable ) do
	list.Set( "SBEP_FighterModels", k , v )
end