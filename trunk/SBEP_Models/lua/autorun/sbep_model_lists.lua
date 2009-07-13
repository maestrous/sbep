local DoorControllerTable = {
			[ "models/SmallBridge/Panels/sbpaneldoor.mdl"			] = { 65.1  , "Door" 	} ,
			[ "models/SmallBridge/Panels/sbpaneldoorsquare.mdl"		] = { 65.1  , "Door" 	} ,
			[ "models/SmallBridge/Panels/sbpaneldooriris.mdl"		] = { 65.1  , "Door" 	} ,
			[ "models/SmallBridge/Panels/sbpaneliris.mdl"			] = { 65.1  , "Door" 	} ,
			[ "models/SmallBridge/Panels/sbpaneldoorwide2.mdl"		] = { 65.1  , "Door" 	} ,
			[ "models/SmallBridge/Panels/sbpaneldoordw.mdl"			] = { 65.1  , "Door" 	} ,
			[ "models/SmallBridge/Panels/sbpaneldoordw2.mdl"		] = { 65.1  , "Door" 	} ,
			[ "models/SmallBridge/Panels/sbpaneldoorsquaredw.mdl"	] = { 65.1  , "Door" 	} ,
			[ "models/SmallBridge/Panels/sbpaneldockin.mdl"			] = { 65.1  , "Door" 	} ,
			[ "models/SmallBridge/Panels/sbpaneldockout.mdl"		] = { 65.1  , "Door" 	} ,
			[ "models/SmallBridge/Ship Parts/sbhulldse.mdl"			] = { 65.1  , "Door" 	} ,
			[ "models/SmallBridge/Ship Parts/sbhulldseb.mdl"		] = { 65.1  , "Door" 	} ,
			[ "models/SmallBridge/Ship Parts/sbhulldst.mdl"			] = { 65.1  , "Door" 	} ,
			[ "models/SmallBridge/Ship Parts/sbhulldsdwe.mdl"		] = { 65.1  , "Door" 	} ,
			[ "models/SmallBridge/Panels/sbpaneldbsmall.mdl"		] = { 65.1  , "Door" 	} ,
			[ "models/Slyfo/SLYpaneldoor1.mdl"						] = { 0		, "Door" 	} ,

			[ "models/SmallBridge/Elevators,Small/sbselevb.mdl" 	] = { 65.1  , "Hatch_B" } ,
			[ "models/SmallBridge/Elevators,Small/sbselevbe.mdl" 	] = { 65.1  , "Hatch_B" } ,
			[ "models/SmallBridge/Elevators,Small/sbselevbedh.mdl" 	] = { 65.1  , "Hatch_B" } ,
			[ "models/SmallBridge/Elevators,Small/sbselevbedw.mdl" 	] = { 65.1  , "Hatch_B" } ,
			[ "models/SmallBridge/Elevators,Small/sbselevbr.mdl" 	] = { 65.1  , "Hatch_B" } ,
			[ "models/SmallBridge/Elevators,Small/sbselevbt.mdl" 	] = { 65.1  , "Hatch_B" } ,
			[ "models/SmallBridge/Elevators,Small/sbselevbx.mdl" 	] = { 65.1  , "Hatch_B" } ,
			[ "models/SmallBridge/Elevators,Small/sbselevm.mdl" 	] = { 65.1  , "Hatch_M" } ,
			[ "models/SmallBridge/Elevators,Small/sbselevme.mdl" 	] = { 65.1  , "Hatch_M" } ,
			[ "models/SmallBridge/Elevators,Small/sbselevmedh.mdl" 	] = { 65.1  , "Hatch_M" } ,
			[ "models/SmallBridge/Elevators,Small/sbselevmedw.mdl" 	] = { 65.1  , "Hatch_M" } ,
			[ "models/SmallBridge/Elevators,Small/sbselevmr.mdl" 	] = { 65.1  , "Hatch_M" } ,
			[ "models/SmallBridge/Elevators,Small/sbselevmt.mdl" 	] = { 65.1  , "Hatch_M" } ,
			[ "models/SmallBridge/Elevators,Small/sbselevmx.mdl" 	] = { 65.1  , "Hatch_M" } ,
			[ "models/SmallBridge/Elevators,Small/sbselevt.mdl" 	] = { 65.1  , "Hatch_T" } ,
			[ "models/SmallBridge/Elevators,Small/sbselevte.mdl" 	] = { 65.1  , "Hatch_T" } ,
			[ "models/SmallBridge/Elevators,Small/sbselevtedh.mdl"	] = { 65.1  , "Hatch_T" } ,
			[ "models/SmallBridge/Elevators,Small/sbselevtedw.mdl"	] = { 65.1  , "Hatch_T" } ,
			[ "models/SmallBridge/Elevators,Small/sbselevtr.mdl" 	] = { 65.1  , "Hatch_T" } ,
			[ "models/SmallBridge/Elevators,Small/sbselevtt.mdl" 	] = { 65.1  , "Hatch_T" } ,
			[ "models/SmallBridge/Elevators,Small/sbselevtx.mdl" 	] = { 65.1  , "Hatch_T" }
						}

for k,v in pairs( DoorControllerTable ) do
	list.Set( "SBEP_DoorControllerModels", k , v )
end

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