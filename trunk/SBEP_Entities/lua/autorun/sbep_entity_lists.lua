local  DoorDataTable = {}

	-----------------------------------------------------------
	//			PANELS			//
	-----------------------------------------------------------
	
	local Door_Anim1 															= { "models/SmallBridge/SEnts/SBADoor1.mdl" 	, 
																						3 , 2   , 1 	,
																						Vector(0,0,0) 	,
																						Angle(0,0,0)  	, 
					{ [0] = "Doors.Move14" , [1.45] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" }  ,
					{ [0] = "Doors.Move14" , [1.45] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } }

	local Door_Anim2 															= { "models/SmallBridge/SEnts/SBADoor2.mdl" 	, 
																						3 , 1   , 2 	, 
																						Vector(0,0,0) 	, 
																						Angle(0,0,0)  	, 
					{ [0] = "Doors.Move14" , [1.95] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" }  ,
					{ [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } }

	local Door_Iris																= { "models/SmallBridge/SEnts/SBADoorIris2.mdl", 
																						3 , 2   , 1 	, 
																						Vector(0,0,0) 	, 
																						Angle(0,0,0)  	, 
					{ [0] = "Doors.Move14" , [0.90] = "Doors.FullOpen8" , [2.65] = "Doors.FullOpen9" }  ,
					{ [0] = "Doors.Move14" , [1.95] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } }

	local Door_Wide																= { "models/SmallBridge/SEnts/SBADoorWide.mdl" , 
																						3 , 1.5 , 1.5 	, 
																						Vector(0,0,0) 	, 
																						Angle(0,0,0)  	, 
		{ [0] = "Doors.Move14" , [0.55] = "Doors.FullOpen8" , [1.15] = "Doors.FullOpen8" , [1.75] = "Doors.FullOpen8" , [2.35] = "Doors.FullOpen8" , [2.85] = "Doors.FullOpen9" } ,
		{ [0] = "Doors.Move14" , [0.55] = "Doors.FullOpen8" , [1.15] = "Doors.FullOpen8" , [1.75] = "Doors.FullOpen8" , [2.35] = "Doors.FullOpen8" , [2.85] = "Doors.FullOpen9" } }

	local Door_Sly1																= { "models/Slyfo/SLYAdoor1.mdl" , 
																						2 , 0.5 , 1.5 	, 
																						Vector(0,0,0) 	, 
																						Angle(0,0,0)  	,
													{ [0] = "Doors.Move14" , [1.80] = "Doors.FullOpen9" } ,
													{ [0] = "Doors.Move14" , [1.80] = "Doors.FullOpen9" } }

		DoorDataTable[ "models/SmallBridge/Panels/sbpaneldoor.mdl"			]	= { table.Copy(Door_Anim1) }
		DoorDataTable[ "models/SmallBridge/Panels/sbpaneldoorsquare.mdl"	]	= { table.Copy(Door_Anim2) }
		DoorDataTable[ "models/SmallBridge/Panels/sbpaneldooriris.mdl"		]	= { table.Copy(Door_Iris)  }
		DoorDataTable[ "models/SmallBridge/Panels/sbpaneliris.mdl"			]	= { table.Copy(Door_Iris)  }
		DoorDataTable[ "models/SmallBridge/Panels/sbpaneldoorwide2.mdl"		]	= { table.Copy(Door_Wide)  }
		DoorDataTable[ "models/SmallBridge/Panels/sbpaneldoordw.mdl"		]	= { table.Copy(Door_Anim1) }
		DoorDataTable[ "models/SmallBridge/Panels/sbpaneldoordw2.mdl"		]	= { table.Copy(Door_Anim1) , table.Copy(Door_Anim1) }
		DoorDataTable[ "models/SmallBridge/Panels/sbpaneldoordw2.mdl"		][1][5] = Vector(0, 111.6,0)
		DoorDataTable[ "models/SmallBridge/Panels/sbpaneldoordw2.mdl"		][1][6] = Angle( 0, 180  ,0)
		DoorDataTable[ "models/SmallBridge/Panels/sbpaneldoordw2.mdl"		][2][5] = Vector(0,-111.6,0)
		DoorDataTable[ "models/SmallBridge/Panels/sbpaneldoorsquaredw.mdl"	]	= { table.Copy(Door_Anim2) }
		DoorDataTable[ "models/SmallBridge/Panels/sbpaneldockin.mdl"		]	= { table.Copy(Door_Anim2) }
		DoorDataTable[ "models/SmallBridge/Panels/sbpaneldockout.mdl"		]	= { table.Copy(Door_Anim2) }
		DoorDataTable[ "models/Slyfo/SLYpaneldoor1.mdl"						]	= { table.Copy(Door_Sly1)  }

	-----------------------------------------------------------
	//			HULLS			//
	-----------------------------------------------------------
	
	local Door_Hull																= { "models/SmallBridge/SEnts/SBAhullDsEb.mdl" , 
																						3 , 1.5 , 1.5 ,
																						Vector(0,0,0) , 
																						Angle(0,0,0)  , 
					{ [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [1.95] = "Doors.FullOpen8" , [2.85] = "Doors.FullOpen9" } ,
					{ [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [1.95] = "Doors.FullOpen8" , [2.90] = "Doors.FullOpen9" } }

		DoorDataTable[ "models/SmallBridge/Ship Parts/sbhulldse.mdl"		]	= { table.Copy(Door_Hull) , table.Copy(Door_Hull) }
		DoorDataTable[ "models/SmallBridge/Ship Parts/sbhulldse.mdl"		][2][6] = Angle(0,180,0)
		DoorDataTable[ "models/SmallBridge/Ship Parts/sbhulldseb.mdl"		]	= { table.Copy(Door_Hull) }
		DoorDataTable[ "models/SmallBridge/Ship Parts/sbhulldst.mdl"		]	= { table.Copy(Door_Hull) }
		DoorDataTable[ "models/SmallBridge/Ship Parts/sbhulldsdwe.mdl"		]	= { table.Copy(Door_Hull) , table.Copy(Door_Hull) }
		DoorDataTable[ "models/SmallBridge/Ship Parts/sbhulldsdwe.mdl"		][1][5] = Vector(0,111.6 ,0)
		DoorDataTable[ "models/SmallBridge/Ship Parts/sbhulldsdwe.mdl"		][2][5] = Vector(0,-111.6,0)
		DoorDataTable[ "models/SmallBridge/Ship Parts/sbhulldsdwe.mdl"		][2][6] = Angle(0,180,0)

	-----------------------------------------------------------
	//			HANGARS			//
	-----------------------------------------------------------

		DoorDataTable[ "models/SmallBridge/Panels/sbpaneldbsmall.mdl"		]	= { "models/SmallBridge/SEnts/SBADoorDBsmall.mdl" ,
																						5 , 4   , 1.5	, 
																						Vector(0,0,0) 	, 
																						Angle(0,0,0)  	,
					{ [0] = "Doors.Move14" , [1.30] = "Doors.FullOpen8" , [2.60] = "Doors.FullOpen8" , [3.90] = "Doors.FullOpen9" , [4.90] = "Doors.FullOpen8" } ,
					{ [0] = "Doors.Move14" , [2.60] = "Doors.FullOpen8" , [3.95] = "Doors.FullOpen8" , [4.90] = "Doors.FullOpen9" } }


	-----------------------------------------------------------
	//		    ELEV HATCHES		//
	-----------------------------------------------------------

	local Door_ElevHatch														= { "models/SmallBridge/SEnts/sbahatchelevs.mdl" 	, 
																						1 , 0.6 , 0.4 	, 
																						Vector(0,0,0) 	, 
																						Angle(0,0,0)  	, 
					{ [0] = "Doors.Move14" , [0.40] = "Doors.FullOpen8" , [0.95] = "Doors.FullOpen9" } 	,
					{ [0] = "Doors.Move14" , [0.40] = "Doors.FullOpen8" , [0.95] = "Doors.FullOpen9" } }
	
	local Door_ElevHatch_Base			= { table.Copy(Door_ElevHatch) }
			Door_ElevHatch_Base[1][5] 	= Vector(0,0,60.45)

	local Door_ElevHatch_Mid			= { table.Copy(Door_ElevHatch) , table.Copy(Door_ElevHatch) }
			Door_ElevHatch_Mid[1][5]  	= Vector(0,0,60.45 )
			Door_ElevHatch_Mid[2][5]  	= Vector(0,0,-60.45)

	local Door_ElevHatch_Top			= { table.Copy(Door_ElevHatch) }
			Door_ElevHatch_Top[1][5]	= Vector(0,0,-60.45)

		DoorDataTable[ "models/SmallBridge/Elevators,Small/sbselevb.mdl"	] 	= Door_ElevHatch_Base
		DoorDataTable[ "models/SmallBridge/Elevators,Small/sbselevbe.mdl"	] 	= Door_ElevHatch_Base
		DoorDataTable[ "models/SmallBridge/Elevators,Small/sbselevbedh.mdl"	] 	= table.Copy(Door_ElevHatch_Base)
		DoorDataTable[ "models/SmallBridge/Elevators,Small/sbselevbedh.mdl"	][1][5] = Vector(0,0,190.65)
		DoorDataTable[ "models/SmallBridge/Elevators,Small/sbselevbedw.mdl"	] 	= Door_ElevHatch_Base
		DoorDataTable[ "models/SmallBridge/Elevators,Small/sbselevbr.mdl"	] 	= Door_ElevHatch_Base
		DoorDataTable[ "models/SmallBridge/Elevators,Small/sbselevbt.mdl"	] 	= Door_ElevHatch_Base
		DoorDataTable[ "models/SmallBridge/Elevators,Small/sbselevbx.mdl"	] 	= Door_ElevHatch_Base

		DoorDataTable[ "models/SmallBridge/Elevators,Small/sbselevm.mdl"	] 	= Door_ElevHatch_Mid
		DoorDataTable[ "models/SmallBridge/Elevators,Small/sbselevme.mdl"	] 	= Door_ElevHatch_Mid
		DoorDataTable[ "models/SmallBridge/Elevators,Small/sbselevmedh.mdl"	] 	= table.Copy(Door_ElevHatch_Mid)
		DoorDataTable[ "models/SmallBridge/Elevators,Small/sbselevmedh.mdl"	][1][5] = Vector(0,0,190.65)
		DoorDataTable[ "models/SmallBridge/Elevators,Small/sbselevmedw.mdl"	] 	= Door_ElevHatch_Mid
		DoorDataTable[ "models/SmallBridge/Elevators,Small/sbselevmr.mdl"	] 	= Door_ElevHatch_Mid
		DoorDataTable[ "models/SmallBridge/Elevators,Small/sbselevmt.mdl"	] 	= Door_ElevHatch_Mid
		DoorDataTable[ "models/SmallBridge/Elevators,Small/sbselevmx.mdl"	] 	= Door_ElevHatch_Mid

		DoorDataTable[ "models/SmallBridge/Elevators,Small/sbselevt.mdl"	] 	= Door_ElevHatch_Top
		DoorDataTable[ "models/SmallBridge/Elevators,Small/sbselevte.mdl"	] 	= Door_ElevHatch_Top
		DoorDataTable[ "models/SmallBridge/Elevators,Small/sbselevtedh.mdl"	] 	= Door_ElevHatch_Top
		DoorDataTable[ "models/SmallBridge/Elevators,Small/sbselevtedw.mdl"	] 	= Door_ElevHatch_Top
		DoorDataTable[ "models/SmallBridge/Elevators,Small/sbselevtr.mdl"	] 	= Door_ElevHatch_Top
		DoorDataTable[ "models/SmallBridge/Elevators,Small/sbselevtt.mdl"	] 	= Door_ElevHatch_Top
		DoorDataTable[ "models/SmallBridge/Elevators,Small/sbselevtx.mdl"	] 	= Door_ElevHatch_Top

for k,v in pairs( DoorDataTable ) do

	list.Set( "SBEP_DoorModelData", k , v )

end