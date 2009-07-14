-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
///																	DOORS																      ///
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local DoorControllerTable = {

			[ "models/SmallBridge/Panels/sbpaneldoor.mdl"			] = { 65.1  , "Door" 	, { "Door_Anim1" } } ,
			[ "models/SmallBridge/Panels/sbpaneldoorsquare.mdl"		] = { 65.1  , "Door" 	, { "Door_Anim2" } } ,
			[ "models/SmallBridge/Panels/sbpaneldooriris.mdl"		] = { 65.1  , "Door" 	, { "Door_Iris"  } } ,
			[ "models/SmallBridge/Panels/sbpaneliris.mdl"			] = { 65.1  , "Door" 	, { "Door_Iris"  } } ,
			[ "models/SmallBridge/Panels/sbpaneldoorwide2.mdl"		] = { 65.1  , "Door" 	, { "Door_Wide"  } } ,
			[ "models/SmallBridge/Panels/sbpaneldoordw.mdl"			] = { 65.1  , "Door" 	, { "Door_Anim1" } } ,
			[ "models/SmallBridge/Panels/sbpaneldoordw2.mdl"		] = { 65.1  , "Door" 	, { "Door_Anim1" , Vector(0, 111.6,0) , Angle( 0, 180  ,0) } ,
																							  { "Door_Anim1" , Vector(0,-111.6,0) } } ,
			[ "models/SmallBridge/Panels/sbpaneldoorsquaredw.mdl"	] = { 65.1  , "Door" 	, { "Door_Anim2" } } ,
			[ "models/SmallBridge/Panels/sbpaneldockin.mdl"			] = { 65.1  , "Door" 	, { "Door_Anim2" } } ,
			[ "models/SmallBridge/Panels/sbpaneldockout.mdl"		] = { 65.1  , "Door" 	, { "Door_Anim2" } } ,
			[ "models/SmallBridge/Ship Parts/sbhulldse.mdl"			] = { 65.1  , "Door" 	, { "Door_Hull"  } ,
																							  { "Door_Hull"  , Angle(0,180,0) } } ,
			[ "models/SmallBridge/Ship Parts/sbhulldseb.mdl"		] = { 65.1  , "Door" 	, { "Door_Hull"  } } ,
			[ "models/SmallBridge/Ship Parts/sbhulldst.mdl"			] = { 65.1  , "Door" 	, { "Door_Hull"  } } ,
			[ "models/SmallBridge/Ship Parts/sbhulldsdwe.mdl"		] = { 65.1  , "Door" 	, { "Door_Hull"  , Vector(0,111.6 ,0) } ,
																							  { "Door_Hull"  , Vector(0,-111.6,0) , Angle(0,180,0) } } ,
			[ "models/SmallBridge/Panels/sbpaneldbsmall.mdl"		] = { 65.1  , "Door" 	, { "Door_DBS"   } } ,
			[ "models/Slyfo/SLYpaneldoor1.mdl"						] = { 0		, "Door" 	, { "Door_Sly1"  } } ,

			[ "models/SmallBridge/Elevators,Small/sbselevb.mdl" 	] = { 65.1  , "Hatch_B" , { "Door_ElevHatch" , Vector(0,0,60.45) } } ,
			[ "models/SmallBridge/Elevators,Small/sbselevbe.mdl" 	] = { 65.1  , "Hatch_B" , { "Door_ElevHatch" , Vector(0,0,60.45) } } ,
			[ "models/SmallBridge/Elevators,Small/sbselevbedh.mdl" 	] = { 65.1  , "Hatch_B" , { "Door_ElevHatch" , Vector(0,0,190.65)} } ,
			[ "models/SmallBridge/Elevators,Small/sbselevbedw.mdl" 	] = { 65.1  , "Hatch_B" , { "Door_ElevHatch" , Vector(0,0,60.45) } } ,
			[ "models/SmallBridge/Elevators,Small/sbselevbr.mdl" 	] = { 65.1  , "Hatch_B" , { "Door_ElevHatch" , Vector(0,0,60.45) } } ,
			[ "models/SmallBridge/Elevators,Small/sbselevbt.mdl" 	] = { 65.1  , "Hatch_B" , { "Door_ElevHatch" , Vector(0,0,60.45) } } ,
			[ "models/SmallBridge/Elevators,Small/sbselevbx.mdl" 	] = { 65.1  , "Hatch_B" , { "Door_ElevHatch" , Vector(0,0,60.45) } } ,

			[ "models/SmallBridge/Elevators,Small/sbselevm.mdl" 	] = { 65.1  , "Hatch_M" , { "Door_ElevHatch" , Vector(0,0,60.45 ) } ,
																							  { "Door_ElevHatch" , Vector(0,0,-60.45) } } ,
			[ "models/SmallBridge/Elevators,Small/sbselevme.mdl" 	] = { 65.1  , "Hatch_M" , { "Door_ElevHatch" , Vector(0,0,60.45 ) } ,
																							  { "Door_ElevHatch" , Vector(0,0,-60.45) } } ,
			[ "models/SmallBridge/Elevators,Small/sbselevmedh.mdl" 	] = { 65.1  , "Hatch_M" , { "Door_ElevHatch" , Vector(0,0,190.65) } ,
																							  { "Door_ElevHatch" , Vector(0,0,-60.45) } } ,
			[ "models/SmallBridge/Elevators,Small/sbselevmedw.mdl" 	] = { 65.1  , "Hatch_M" , { "Door_ElevHatch" , Vector(0,0,60.45 ) } ,
																							  { "Door_ElevHatch" , Vector(0,0,-60.45) } } ,
			[ "models/SmallBridge/Elevators,Small/sbselevmr.mdl" 	] = { 65.1  , "Hatch_M" , { "Door_ElevHatch" , Vector(0,0,60.45 ) } ,
																							  { "Door_ElevHatch" , Vector(0,0,-60.45) } } ,
			[ "models/SmallBridge/Elevators,Small/sbselevmt.mdl" 	] = { 65.1  , "Hatch_M" , { "Door_ElevHatch" , Vector(0,0,60.45 ) } ,
																							  { "Door_ElevHatch" , Vector(0,0,-60.45) } } ,
			[ "models/SmallBridge/Elevators,Small/sbselevmx.mdl" 	] = { 65.1  , "Hatch_M" , { "Door_ElevHatch" , Vector(0,0,60.45 ) } ,
																							  { "Door_ElevHatch" , Vector(0,0,-60.45) } } ,

			[ "models/SmallBridge/Elevators,Small/sbselevt.mdl" 	] = { 65.1  , "Hatch_T" , { "Door_ElevHatch" , Vector(0,0,-60.45) } } ,
			[ "models/SmallBridge/Elevators,Small/sbselevte.mdl" 	] = { 65.1  , "Hatch_T" , { "Door_ElevHatch" , Vector(0,0,-60.45) } } ,
			[ "models/SmallBridge/Elevators,Small/sbselevtedh.mdl"	] = { 65.1  , "Hatch_T" , { "Door_ElevHatch" , Vector(0,0,-60.45) } } ,
			[ "models/SmallBridge/Elevators,Small/sbselevtedw.mdl"	] = { 65.1  , "Hatch_T" , { "Door_ElevHatch" , Vector(0,0,-60.45) } } ,
			[ "models/SmallBridge/Elevators,Small/sbselevtr.mdl" 	] = { 65.1  , "Hatch_T" , { "Door_ElevHatch" , Vector(0,0,-60.45) } } ,
			[ "models/SmallBridge/Elevators,Small/sbselevtt.mdl" 	] = { 65.1  , "Hatch_T" , { "Door_ElevHatch" , Vector(0,0,-60.45) } } ,
			[ "models/SmallBridge/Elevators,Small/sbselevtx.mdl" 	] = { 65.1  , "Hatch_T" , { "Door_ElevHatch" , Vector(0,0,-60.45) } } ,
			
			[ "models/SmallBridge/Station Parts/sbbaydps.mdl"		] = { 65.1  , "Other" 	, { "Door_Anim2" , Vector(51.15,0,0     ) } ,
																							  { "Door_Iris"  , Vector(-37.2,0,-60.45) , Angle( 90 , 0 , 0 ) } }

						}


for k,v in pairs( DoorControllerTable ) do
	list.Set( "SBEP_DoorControllerModels", k , v )
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
///															WEAPON MOUNTS																      ///
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local WeaponMountModelTable = {
			[ "Wing1L" ] = { ["model"] = "models/Spacebuild/milcock4_wing1.mdl"		, ["HPType"] = "WingLeft"	, ["APPos"]	= Vector(0,0,0)		, ["APAng"]	= Angle(0,0,90)		} ,
			[ "Wing1R" ] = { ["model"] = "models/Spacebuild/milcock4_wing1.mdl"		, ["HPType"] = "WingRight"	, ["APPos"]	= Vector(0,0,0)		, ["APAng"]	= Angle(0,180,90)	} ,
			[ "Wing2L" ] = { ["model"] = "models/Spacebuild/milcock4_wing2.mdl"		, ["HPType"] = "WingLeft"	, ["APPos"]	= Vector(0,0,0)		, ["APAng"]	= Angle(0,0,90)		} ,
			[ "Wing2R" ] = { ["model"] = "models/Spacebuild/milcock4_wing2.mdl"		, ["HPType"] = "WingRight"	, ["APPos"]	= Vector(0,0,0)		, ["APAng"]	= Angle(180,0,270)	} ,
			[ "Wing3"  ] = { ["model"] = "models/Spacebuild/milcock4_wing3.mdl"		, ["HPType"] = "Wing"		, ["APPos"]	= Vector(0,0,0)		, ["APAng"]	= Angle(0,0,90)		} ,
			[ "Wing4"  ] = { ["model"] = "models/Spacebuild/milcock4_wing4.mdl"		, ["HPType"] = "Wing"		, ["APPos"]	= Vector(0,0,0)		, ["APAng"]	= Angle(0,0,90)		} ,
			[ "Wing5L" ] = { ["model"] = "models/Spacebuild/milcock4_wing5l.mdl"	, ["HPType"] = "WingLeft"	, ["APPos"]	= Vector(0,0,0)		, ["APAng"]	= Angle(0,0,90)		} ,
			[ "Wing5R" ] = { ["model"] = "models/Spacebuild/milcock4_wing5r.mdl"	, ["HPType"] = "WingRight"	, ["APPos"]	= Vector(0,0,0)		, ["APAng"]	= Angle(0,0,270)	} ,
			[ "Wing6"  ] = { ["model"] = "models/Spacebuild/milcock4_wing6.mdl"		, ["HPType"] = "Wing"		, ["APPos"]	= Vector(0,0,0)		, ["APAng"]	= Angle(0,0,90)		} ,
			[ "Wing7"  ] = { ["model"] = "models/Spacebuild/milcock4_wing7.mdl"		, ["HPType"] = "Wing"		, ["APPos"]	= Vector(-5,27,-4)	, ["APAng"]	= Angle(0,0,90)		}
						}

for k,v in pairs( WeaponMountModelTable ) do
	list.Set( "SBEP_WeaponMountModels", k , v )
end