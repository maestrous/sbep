-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
///																	DOORS																      ///
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local DCT = {}

			DCT[ "models/SmallBridge/Panels/sbpaneldoor.mdl"			] = { 65.1  , "Door" 	, { "Door_Anim1" } }
			DCT[ "models/SmallBridge/Panels/sbpaneldoorsquare.mdl"		] = { 65.1  , "Door" 	, { "Door_Anim3" } }
			DCT[ "models/SmallBridge/Panels/sbpaneldooriris.mdl"		] = { 65.1  , "Door" 	, { "Door_Iris"  } }
			DCT[ "models/SmallBridge/Panels/sbpaneliris.mdl"			] = { 65.1  , "Door" 	, { "Door_Iris"  } }
			DCT[ "models/SmallBridge/Panels/sbpaneldoorwide.mdl"		] = { 65.1  , "Door" 	, { "Door_DW"	 } }
			DCT[ "models/SmallBridge/Panels/sbpaneldoordh.mdl"			] = { 65.1  , "Door" 	, { "Door_Anim3dh"}}
			DCT[ "models/SmallBridge/Panels/sbpaneldoordhdw.mdl"		] = { 65.1  , "Door" 	, { "Door_DWDH"  } }
			DCT[ "models/SmallBridge/Panels/sbpaneldoordw.mdl"			] = { 65.1  , "Door" 	, { "Door_Anim1" } }
			DCT[ "models/SmallBridge/Panels/sbpaneldoordw2.mdl"			] = { 65.1  , "Door" 	, { "Door_Anim1" , Vector(0, 111.6,0) , Angle( 0, 180  ,0) } ,
																								  { "Door_Anim1" , Vector(0,-111.6,0) } }
			DCT[ "models/SmallBridge/Panels/sbpaneldoorsquaredw.mdl"	] = { 65.1  , "Door" 	, { "Door_Anim3" } }
			DCT[ "models/SmallBridge/Panels/sbpaneldoorsquaredw2.mdl"	] = { 65.1  , "Door" 	, { "Door_Anim3" , Vector(0, 111.6,0) , Angle( 0, 180  ,0) } ,
																								  { "Door_Anim3" , Vector(0,-111.6,0) } }
			DCT[ "models/SmallBridge/Panels/sbpaneldockin.mdl"			] = { 65.1  , "Door" 	, { "Door_Anim3" } }
			DCT[ "models/SmallBridge/Panels/sbpaneldockout.mdl"			] = { 65.1  , "Door" 	, { "Door_Anim3" } }
			DCT[ "models/SmallBridge/Ship Parts/sbhulldse.mdl"			] = { 65.1  , "Door" 	, { "Door_Hull"  } ,
																								  { "Door_Hull"  , 			nil 	  , Angle(0,180,0) } }
			DCT[ "models/SmallBridge/Ship Parts/sbhulldseb.mdl"			] = { 65.1  , "Door" 	, { "Door_Hull"  } }
			DCT[ "models/SmallBridge/Ship Parts/sbhulldst.mdl"			] = { 65.1  , "Door" 	, { "Door_Hull"  } }
			DCT[ "models/SmallBridge/Ship Parts/sbhulldsdwe.mdl"		] = { 65.1  , "Door" 	, { "Door_Hull"  , Vector(0,111.6 ,0) } ,
																								  { "Door_Hull"  , Vector(0,-111.6,0) , Angle(0,180,0) } }
			DCT[ "models/SmallBridge/Panels/sbpaneldbsmall.mdl"			] = { 65.1  , "Door" 	, { "Door_DBS"   } }
			DCT[ "models/Slyfo/SLYpaneldoor1.mdl"						] = { 0		, "Door" 	, { "Door_Sly1"  } }

			DCT[ "models/Cerus/Modbridge/Misc/Doors/door11a.mdl"		] = { 0		,"Modbridge", { "Door_ModBridge_11a"  } }
			DCT[ "models/Cerus/Modbridge/Misc/Doors/door12a.mdl"		] = { 0		,"Modbridge", { "Door_ModBridge_12a"  } }
			
			DCT[ "models/SmallBridge/Elevators,Small/sbselevb.mdl" 		] = { 65.1  , "Hatch_B" , { "Door_ElevHatch" , Vector( 0,0,60.45) } ,
																								  { "Door_Anim3"	 , Vector( 60.45,0,0) } }
			DCT[ "models/SmallBridge/Elevators,Small/sbselevbe.mdl" 	] = { 65.1  , "Hatch_B" , { "Door_ElevHatch" , Vector( 0,0,60.45) } ,
																								  { "Door_Anim3"	 , Vector( 60.45,0,0) } ,
																								  { "Door_Anim3"	 , Vector(-60.45,0,0) , Angle(0,180,0) } }
			DCT[ "models/SmallBridge/Elevators,Small/sbselevbedh.mdl" 	] = { 65.1  , "Hatch_B" , { "Door_ElevHatch" , Vector(0,0,190.65) } ,
																								  { "Door_Anim3dh"	 , Vector( 60.45,0,0) } ,
																								  { "Door_Anim3dh"	 , Vector(-60.45,0,0) , Angle(0,180,0) } }
			DCT[ "models/SmallBridge/Elevators,Small/sbselevbedw.mdl" 	] = { 65.1  , "Hatch_B" , { "Door_ElevHatch" , Vector( 0,0,60.45) } ,
																								  { "Door_Anim3"	 , Vector( 60.45,0,0) } ,
																								  { "Door_Anim3"	 , Vector(-60.45,0,0) , Angle(0,180,0) } }
			DCT[ "models/SmallBridge/Elevators,Small/sbselevbr.mdl" 	] = { 65.1  , "Hatch_B" , { "Door_ElevHatch" , Vector( 0,0,60.45) } ,
																								  { "Door_Anim3"	 , Vector( 60.45,0,0) } ,
																								  { "Door_Anim3"	 , Vector( 0,60.45,0) , Angle(0,270,0) } }
			DCT[ "models/SmallBridge/Elevators,Small/sbselevbt.mdl" 	] = { 65.1  , "Hatch_B" , { "Door_ElevHatch" , Vector( 0,0,60.45) } ,
																								  { "Door_Anim3"	 , Vector( 60.45,0,0) } ,
																								  { "Door_Anim3"	 , Vector( 0,60.45,0) , Angle(0, 90,0) } ,
																								  { "Door_Anim3"	 , Vector(0,-60.45,0) , Angle(0,-90,0) } }
			DCT[ "models/SmallBridge/Elevators,Small/sbselevbx.mdl" 	] = { 65.1  , "Hatch_B" , { "Door_ElevHatch" , Vector( 0,0,60.45) } ,
																								  { "Door_Anim3"	 , Vector( 60.45,0,0) } ,
																								  { "Door_Anim3"	 , Vector(-60.45,0,0) , Angle(0,180,0) } ,
																								  { "Door_Anim3"	 , Vector( 0,60.45,0) , Angle(0, 90,0) } ,
																								  { "Door_Anim3"	 , Vector(0,-60.45,0) , Angle(0,-90,0) } }

			DCT[ "models/SmallBridge/Elevators,Small/sbselevm.mdl" 		] = { 65.1  , "Hatch_M" , { "Door_ElevHatch" , Vector(0,0,60.45 ) } ,
																								  { "Door_ElevHatch" , Vector(0,0,-60.45) } ,
																								  { "Door_Anim3"	 , Vector( 60.45,0,0) } }
			DCT[ "models/SmallBridge/Elevators,Small/sbselevme.mdl" 	] = { 65.1  , "Hatch_M" , { "Door_ElevHatch" , Vector(0,0,60.45 ) } ,
																								  { "Door_ElevHatch" , Vector(0,0,-60.45) } ,
																								  { "Door_Anim3"	 , Vector( 60.45,0,0) } ,
																								  { "Door_Anim3"	 , Vector(-60.45,0,0) , Angle(0,180,0) } }
			DCT[ "models/SmallBridge/Elevators,Small/sbselevmedh.mdl" 	] = { 65.1  , "Hatch_M" , { "Door_ElevHatch" , Vector(0,0,190.65) } ,
																								  { "Door_ElevHatch" , Vector(0,0,-60.45) } ,
																								  { "Door_Anim3dh"	 , Vector( 60.45,0,0) } ,
																								  { "Door_Anim3dh"	 , Vector(-60.45,0,0) , Angle(0,180,0) } }
			DCT[ "models/SmallBridge/Elevators,Small/sbselevmedw.mdl" 	] = { 65.1  , "Hatch_M" , { "Door_ElevHatch" , Vector(0,0,60.45 ) } ,
																								  { "Door_ElevHatch" , Vector(0,0,-60.45) } ,
																								  { "Door_Anim3"	 , Vector( 60.45,0,0) } ,
																								  { "Door_Anim3"	 , Vector(-60.45,0,0) , Angle(0,180,0) } }
			DCT[ "models/SmallBridge/Elevators,Small/sbselevmr.mdl" 	] = { 65.1  , "Hatch_M" , { "Door_ElevHatch" , Vector(0,0,60.45 ) } ,
																								  { "Door_ElevHatch" , Vector(0,0,-60.45) } ,
																								  { "Door_Anim3"	 , Vector( 60.45,0,0) } ,
																								  { "Door_Anim3"	 , Vector( 0,60.45,0) , Angle(0,270,0) } }
			DCT[ "models/SmallBridge/Elevators,Small/sbselevmt.mdl" 	] = { 65.1  , "Hatch_M" , { "Door_ElevHatch" , Vector(0,0,60.45 ) } ,
																								  { "Door_ElevHatch" , Vector(0,0,-60.45) } ,
																								  { "Door_Anim3"	 , Vector( 60.45,0,0) } ,
																								  { "Door_Anim3"	 , Vector( 0,60.45,0) , Angle(0, 90,0) } ,
																								  { "Door_Anim3"	 , Vector(0,-60.45,0) , Angle(0,-90,0) } }
			DCT[ "models/SmallBridge/Elevators,Small/sbselevmx.mdl" 	] = { 65.1  , "Hatch_M" , { "Door_ElevHatch" , Vector(0,0,60.45 ) } ,
																								  { "Door_ElevHatch" , Vector(0,0,-60.45) } ,
																								  { "Door_Anim3"	 , Vector( 60.45,0,0) } ,
																								  { "Door_Anim3"	 , Vector(-60.45,0,0) , Angle(0,180,0) } ,
																								  { "Door_Anim3"	 , Vector( 0,60.45,0) , Angle(0, 90,0) } ,
																								  { "Door_Anim3"	 , Vector(0,-60.45,0) , Angle(0,-90,0) } }

			DCT[ "models/SmallBridge/Elevators,Small/sbselevt.mdl" 		] = { 65.1  , "Hatch_T" , { "Door_ElevHatch" , Vector(0,0,-60.45) } }
			DCT[ "models/SmallBridge/Elevators,Small/sbselevte.mdl" 	] = { 65.1  , "Hatch_T" , { "Door_ElevHatch" , Vector(0,0,-60.45) } ,
																								  { "Door_Anim3"	 , Vector( 60.45,0,0) } ,
																								  { "Door_Anim3"	 , Vector(-60.45,0,0) , Angle(0,180,0) } }
			DCT[ "models/SmallBridge/Elevators,Small/sbselevtedh.mdl"	] = { 65.1  , "Hatch_T" , { "Door_ElevHatch" , Vector(0,0,-60.45) } ,
																								  { "Door_Anim3dh"	 , Vector( 60.45,0,0) } ,
																								  { "Door_Anim3dh"	 , Vector(-60.45,0,0) , Angle(0,180,0) } }
			DCT[ "models/SmallBridge/Elevators,Small/sbselevtedw.mdl"	] = { 65.1  , "Hatch_T" , { "Door_ElevHatch" , Vector(0,0,-60.45) } ,
																								  { "Door_Anim3"	 , Vector( 60.45,0,0) } ,
																								  { "Door_Anim3"	 , Vector(-60.45,0,0) , Angle(0,180,0) } }
			DCT[ "models/SmallBridge/Elevators,Small/sbselevtr.mdl" 	] = { 65.1  , "Hatch_T" , { "Door_ElevHatch" , Vector(0,0,-60.45) } ,
																								  { "Door_Anim3"	 , Vector( 60.45,0,0) } ,
																								  { "Door_Anim3"	 , Vector( 0,60.45,0) , Angle(0,270,0) } }
			DCT[ "models/SmallBridge/Elevators,Small/sbselevtt.mdl" 	] = { 65.1  , "Hatch_T" , { "Door_ElevHatch" , Vector(0,0,-60.45) } ,
																								  { "Door_Anim3"	 , Vector( 60.45,0,0) } ,
																								  { "Door_Anim3"	 , Vector( 0,60.45,0) , Angle(0, 90,0) } ,
																								  { "Door_Anim3"	 , Vector(0,-60.45,0) , Angle(0,-90,0) } }
			DCT[ "models/SmallBridge/Elevators,Small/sbselevtx.mdl" 	] = { 65.1  , "Hatch_T" , { "Door_ElevHatch" , Vector(0,0,-60.45) } ,
																								  { "Door_Anim3"	 , Vector( 60.45,0,0) } ,
																								  { "Door_Anim3"	 , Vector(-60.45,0,0) , Angle(0,180,0) } ,
																								  { "Door_Anim3"	 , Vector( 0,60.45,0) , Angle(0, 90,0) } ,
																								  { "Door_Anim3"	 , Vector(0,-60.45,0) , Angle(0,-90,0) } }
			
			DCT[ "models/SmallBridge/Station Parts/sbbaydps.mdl"		] = { 65.1  , "Other" 	, { "Door_Anim3" , Vector(51.15,0,0     ) } ,
																								  { "Door_Iris"  , Vector(-37.2,0,-60.45) , Angle( 90 , 0 , 0 ) } }

for k,v in pairs( DCT ) do
	list.Set( "SBEP_DoorControllerModels", k , v )
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
///															WEAPON MOUNTS																      ///
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local WMMT = {}
			WMMT[ "models/Spacebuild/milcock4_wing1.mdl"  ] = { "Wing"	, "Wing"		, Vector(0,0,0)		, Angle(0,0,90) , 
																	{ Ent = nil , Type = {"Small","Tiny"} , Pos	= Vector(0,24 ,0 ) , ["Angle"] = Angle(0,0,180) } }
			WMMT[ "models/Spacebuild/milcock4_wing2.mdl"  ] = { "Wing"	, "Wing"		, Vector(0,0,0)		, Angle(0,0,90)	, 
																	{ Ent = nil , Type = {"Small","Tiny"} , Pos	= Vector(0,16 ,0 ) , ["Angle"] = Angle(0,0,180) } }
			WMMT[ "models/Spacebuild/milcock4_wing3.mdl"  ] = { "Wing"	, "Wing"		, Vector(0,0,0)		, Angle(0,0,90)	, 
																	{ Ent = nil , Type = {"Small","Tiny"} , Pos	= Vector(0,21 ,5 ) , ["Angle"] = Angle(0,0,0  ) } ,
																	{ Ent = nil , Type = {"Small","Tiny"} , Pos	= Vector(0,21 ,-5) , ["Angle"] = Angle(0,0,180) } ,
																	{ Ent = nil , Type = {"Small","Tiny"} , Pos	= Vector(0,192,2 ) , ["Angle"] = Angle(0,0,0  ) } ,
																	{ Ent = nil , Type = {"Small","Tiny"} , Pos	= Vector(0,192,-2) , ["Angle"] = Angle(0,0,180) } }
			WMMT[ "models/Spacebuild/milcock4_wing4.mdl"  ] = { "Wing"	, "Wing"		, Vector(0,0,0)		, Angle(0,0,90)	, 
																	{ Ent = nil , Type = {"Small","Tiny"} , Pos	= Vector(0,64 ,5 ) , ["Angle"] = Angle(0,0,0  ) } ,
																	{ Ent = nil , Type = {"Small","Tiny"} , Pos	= Vector(0,64 ,-5) , ["Angle"] = Angle(0,0,180) } }
			WMMT[ "models/Spacebuild/milcock4_wing5l.mdl" ] = { "Wing"	, "Wing"		, Vector(0,0,0)		, Angle(0,0,90)	, 
																	{ Ent = nil , Type = {"Small","Tiny"} , Pos	= Vector(-11,28,5) , ["Angle"] = Angle(0,0,180) } }
			WMMT[ "models/Spacebuild/milcock4_wing5r.mdl" ] = { "Wing"	, "Wing"		, Vector(0,0,0)		, Angle(0,0,-90), 
																	{ Ent = nil , Type = {"Small","Tiny"} , Pos	= Vector(-11,-28,5), ["Angle"] = Angle(0,0,180) } }
			WMMT[ "models/Spacebuild/milcock4_wing6.mdl"  ] = { "Wing"	, "Wing"		, Vector(0,0,0)		, Angle(0,0,90)	, 
																	{ Ent = nil , Type = {"Small","Tiny"} , Pos	= Vector(0,96 ,0 ) , ["Angle"] = Angle(0,0,-90) } }
			WMMT[ "models/Spacebuild/milcock4_wing7.mdl"  ] = { "Wing"	, "Wing"		, Vector(-5,27,-4)	, Angle(0,0,90)	, 
																	{ Ent = nil , Type = {"Small","Tiny"} , Pos	= Vector(-5,-4,14) , ["Angle"] = Angle(0,0,0  ) } ,
																	{ Ent = nil , Type = {"Small","Tiny"} , Pos	= Vector(-5,-4,-6) , ["Angle"] = Angle(0,0,180) } }

			WMMT[ "models/Slyfo/rover1_backpanel.mdl"	  	] = { "Rover"	, "RBackPanel"	, Vector(0,0,-6)	, Angle(0,0,0) , 
																	{ ["Ent"] = nil , ["Type"] = "Small" , ["Pos"]	= Vector(0,14,-12) } }
			WMMT[ "models/Slyfo/rover1_leftpanel.mdl"	  	] = { "Rover"	, "RLeftPanel"	, Vector(0,0,0)	, Angle(0,0,0) }
			WMMT[ "models/Slyfo/rover1_leftpanelmount.mdl"	] = { "Rover"	, "RLeftPanel"	, Vector(0,0,0)	, Angle(0,0,0) , 
																	{ ["Ent"] = nil , ["Type"] = {"Tiny","Small"}  , ["Pos"] = Vector(-6,6,-2) , ["Angle"] = Angle(0,0,270) } }
			WMMT[ "models/Slyfo/rover1_rightpanel.mdl"	  	] = { "Rover"	, "RRightPanel"	, Vector(0,0,0)	, Angle(0,0,0) }
			WMMT[ "models/Slyfo/rover1_rightpanelmount.mdl"	] = { "Rover"	, "RRightPanel"	, Vector(0,0,0)	, Angle(0,0,0) , 
																	{ ["Ent"] = nil , ["Type"] = {"Tiny","Small"}  , ["Pos"] = Vector(-6,-6,-2), ["Angle"] = Angle(0,0,90 ) } }

for k,v in pairs( WMMT ) do
	list.Set( "SBEP_WeaponMountModels", k , v )
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
///																HANGARS																	      ///
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local HMT = {}
			HMT[ "models/Slyfo/cdeck_single.mdl"  					] = { "Deck"				, "MedBridge"   , { Deck  = { ship = nil , weld = nil , pos = Vector(0,0,256) , 
																												 canface = { Angle(0,90,0)  ,Angle(0,270,0)  ,Angle(0,180,0)  ,Angle(0,0,0),
																															 Angle(0,90,180),Angle(0,270,180),Angle(0,180,180),Angle(0,0,180)} } } }
			HMT[ "models/Slyfo/cdeck_double.mdl"  					] = { "DeckDouble"			, "MedBridge"   , { Right = { ship = nil , weld = nil , pos = Vector(0,256,256) , 
																												 canface = { Angle(0,90,0)	,Angle(0,270,0)	 ,Angle(0,180,0)  ,Angle(0,0,0),
																															 Angle(0,90,180),Angle(0,270,180),Angle(0,180,180),Angle(0,0,180)} } ,
																												Left  = { ship = nil , weld = nil , pos = Vector(0,-256,256) , 
																												 canface = { Angle(0,90,0)  ,Angle(0,270,0)  ,Angle(0,180,0)  ,Angle(0,0,0),
																															 Angle(0,90,180),Angle(0,270,180),Angle(0,180,180),Angle(0,0,180)} } } }
			HMT[ "models/Slyfo/cdeck_doublewide.mdl"  				] = { "DeckDoubleWide"		, "MedBridge"   , { Right = { ship = nil , weld = nil , pos = Vector(0,512,256) , 
																												 canface = { Angle(0,90,0)  ,Angle(0,270,0)  ,Angle(0,180,0)  ,Angle(0,0,0),
																															 Angle(0,90,180),Angle(0,270,180),Angle(0,180,180),Angle(0,0,180)} } ,
																												Left  = { ship = nil , weld = nil , pos = Vector(0,-512,256) , 
																												 canface = { Angle(0,90,0)  ,Angle(0,270,0)  ,Angle(0,180,0)  ,Angle(0,0,0),
																															 Angle(0,90,180),Angle(0,270,180),Angle(0,180,180),Angle(0,0,180)} } } }
			HMT[ "models/Slyfo/hangar_singleside.mdl"  			] = { "SWORDHangarSingle"	, "MedBridge"   , { Side  = { ship = nil , weld = nil , pos = Vector(0,-172,-20) ,
																												 canface = { Angle(0,0,0)   ,Angle(0,180,0)  ,Angle(0,0,180)  ,Angle(0,180,180)} ,
																												 pexit   = Vector(0,100,-100)} } }
			HMT[ "models/Slyfo/shangar.mdl"  						] = { "mbhangarside2"		, "MedBridge"   , { Side  = { ship = nil , weld = nil , pos = Vector(0,214,0) , 
																												 canface = {Angle(0,0,0),Angle(0,180,0),Angle(0,0,180),Angle(0,180,180)} ,
																												 pexit   = Vector(0,100,-100) } } }
			HMT[ "models/SmallBridge/Station Parts/SBdockCs.mdl"  	] = { "sbclamp"				, "SmallBridge" , { Clamp = { ship = nil , weld = nil , pos = Vector(-128,0,0) , 
																												 canface = {Angle(0,90,0),Angle(0,270,0),Angle(0,90,180),Angle(0,270,180)} ,
																												 pexit   = Vector(0,0,0) } } }
			HMT[ "models/SmallBridge/Hangars/sbdb3m.mdl"  			] = { "sbHangar"			, "SmallBridge" , { Bay   = { ship = nil , weld = nil , pos = Vector(0,0,0) , 
																												 canface = {Angle(0,0,0), Angle(0,180,0)} ,
																												 pexit   = Vector(0,0,10) } } }
			HMT[ "models/SmallBridge/Station Parts/SBhangarLu.mdl" ] = { "sbfighterbay1"		, "SmallBridge" , { Right = { ship = nil , weld = nil , pos = Vector(0,320,80) , 
																												 canface = {Angle(0,0,0),Angle(0,180,0)} ,
																												 pexit   = Vector(0,256,0) } ,
																												Left  = { ship = nil , weld = nil , pos = Vector(0,-320,80) , 
																												 canface = {Angle(0,0,0),Angle(0,180,0)} ,
																												 pexit   = Vector(0,-256,0) } } }
			HMT[ "models/SmallBridge/Station Parts/SBhangarLud.mdl"] = { "sbfighterbay2"		, "SmallBridge" , { Right = { ship = nil , weld = nil , pos = Vector(0,320,80) , 
																												 canface = {Angle(0,0,0),Angle(0,180,0)} ,
																												 pexit   = Vector(0,256,0) } ,
																												Left  = { ship = nil , weld = nil , pos = Vector(0,-320,80) , 
																												 canface = {Angle(0,0,0),Angle(0,180,0)} ,
																												 pexit   = Vector(0,-256,0) } } }
			HMT[ "models/SmallBridge/Station Parts/SBhangarLd.mdl" ] = { "sbfighterbay3"		, "SmallBridge" , { Right = { ship = nil , weld = nil , pos = Vector(0,320,80) , 
																												 canface = {Angle(0,0,0),Angle(0,180,0)} ,
																												 pexit   = Vector(0,256,0) } ,
																												Left  = { ship = nil , weld = nil , pos = Vector(0,-320,80) , 
																												 canface = {Angle(0,0,0),Angle(0,180,0)} ,
																												 pexit   = Vector(0,-256,0) } } }
			HMT["models/SmallBridge/Station Parts/SBhangarLud2.mdl"] = { "sbfighterbay4"		, "SmallBridge" , { Right = { ship = nil , weld = nil , pos = Vector(0,448,0) , 
																												 canface = {Angle(0,0,0),Angle(0,180,0)} ,
																												 pexit   = Vector(0,320,0) } ,
																												Left  = { ship = nil , weld = nil , pos = Vector(0,-448,0) , 
																												 canface = {Angle(0,0,0),Angle(0,180,0)} ,
																												 pexit   = Vector(0,-320,0) } } }
			HMT[ "models/SmallBridge/Hangars/SBDBcomp1.mdl"  		] = { "sbHangar"			, "SmallBridge" , { Bay   = { ship = nil , weld = nil , pos = Vector(0,0,0) , 
																												 canface = {Angle(0,0,0), Angle(0,180,0)} ,
																												 pexit   = Vector(-250,0,10) } } }
			HMT[ "models/Slyfo/hangar1.mdl"  						] = { "SWORDHangar"			, "MedBridge"   , { Right = { ship = nil , weld = nil , pos = Vector(0,400,-40) , 
																												 canface = {Angle(0,0,0),Angle(0,180,0),Angle(0,0,180),Angle(0,180,180)} ,
																												 pexit   = Vector(0,200,-100) } ,
																												Left  = { ship = nil , weld = nil , pos = Vector(0,-400,-40) , 
																												 canface = {Angle(0,0,0),Angle(0,180,0),Angle(0,0,180),Angle(0,180,180)} ,
																												 pexit   = Vector(0,-200,-100) } } }
			HMT[ "models/Slyfo/hangar2.mdl"  						] = { "SWORDHangarLarge"	, "MedBridge"   , { ["Top Right"] = { ship = nil , weld = nil , pos = Vector(0, 400, -20) , 
																												 canface = {Angle(0,0,0),Angle(0,180,0),Angle(0,0,180),Angle(0,180,180)} ,
																												 pexit   = Vector(0, 200, -100) } ,
																												["Top Left"]  = { ship = nil , weld = nil , pos = Vector(0,-400, -20) , 
																												 canface = {Angle(0,0,0),Angle(0,180,0),Angle(0,0,180),Angle(0,180,180)} ,
																												 pexit   = Vector(0,-200,-100) } ,
																												["Bottom Right"] = { ship = nil , weld = nil , pos = Vector(0, 400, -220) , 
																												 canface = {Angle(0,0,0),Angle(0,180,0),Angle(0,0,180),Angle(0,180,180)} ,
																												 pexit   = Vector(0, 200,-300) } ,
																												["Botton Left"]  = { ship = nil , weld = nil , pos = Vector(0,-400, -220) , 
																												 canface = {Angle(0,0,0),Angle(0,180,0),Angle(0,0,180),Angle(0,180,180)} ,
																												 pexit   = Vector(0,-200,-300) } } }
			HMT[ "models/Slyfo/hangar3.mdl"  						] = { "SWORDHangarSpacious" , "MedBridge"   , { Right = { ship = nil , weld = nil , pos = Vector(0, 400, -150) , 
																												 canface = {Angle(0,0,0),Angle(0,180,0),Angle(0,0,180),Angle(0,180,180)} ,
																												 pexit   = Vector(0, 200,-300) } ,
																												Left  = { ship = nil , weld = nil , pos = Vector(0,-400, -150) , 
																												 canface = {Angle(0,0,0),Angle(0,180,0),Angle(0,0,180),Angle(0,180,180)} ,
																												 pexit   = Vector(0,-200,-300) } } }
			HMT[ "models/Slyfo/capturehull1.mdl"  					] = { "DockingClamp"		, "MedBridge"   , { Right = { ship = nil , weld = nil , pos = Vector(425,0,80) , 
																												 canface = {Angle(0,90,0),Angle(0,270,0),Angle(0,90,180),Angle(0,270,180)} ,
																												 pexit   = Vector(150,0,10) } } }
			HMT[ "models/Slyfo/doubleclamp.mdl"  					] = { "DockingClampT"		, "MedBridge"   , { Right = { ship = nil , weld = nil , pos = Vector(0,-600,-20) , 
																												 canface = {Angle(0,0,0),Angle(0,180,0),Angle(0,0,180),Angle(0,180,180)} ,
																												 pexit   = Vector(0,-300,-85) } ,
																												Left  = { ship = nil , weld = nil , pos = Vector(0, 600,-20) , 
																												 canface = {Angle(0,0,0),Angle(0,180,0),Angle(0,0,180),Angle(0,180,180)} ,
																												 pexit   = Vector(0, 300,-85) } } }
			HMT[ "models/Slyfo/doubleclamp_x.mdl"  				] = { "DockingClampX"		, "MedBridge"   , { Right = { ship = nil , weld = nil , pos = Vector(0,-600,-20) , 
																												 canface = {Angle(0,0,0),Angle(0,180,0),Angle(0,0,180),Angle(0,180,180)} ,
																												 pexit   = Vector(0,-300,-85) } ,
																												Left  = { ship = nil , weld = nil , pos = Vector(0, 600,-20) , 
																												 canface = {Angle(0,0,0),Angle(0,180,0),Angle(0,0,180),Angle(0,180,180)} ,
																												 pexit   = Vector(0,  300,-85) } } }
			HMT[ "models/Spacebuild/pad.mdl"  						] = { "LandingPad"			, "MedBridge"   , { Pad   = { ship = nil , weld = nil , pos = Vector(0,0,175) , 
																												 canface = {Angle(0,90,0),Angle(0,270,0),Angle(0,180,0),Angle(0,0,0)} ,
																												 pexit   = Vector(-300,-225,2) } } }

for k,v in pairs( HMT ) do
	list.Set( "SBEP_HangarModels", k , v )
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
///															DOCKING CLAMPS																      ///
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local DCMT = {}
			DCMT[ "models/SmallBridge/Ship Parts/sblandramp.mdl"  	] = { ListCat = "SmallBridge"	, ALType = "SWSHA", 
																	Compatible = { 	{ Type = "SWSHB", AF = -4.65, AYaw = 180 } } , 
																	EfPoints = 	{	{ x =  -65 , y = -110 , z =   50 , sp = 0 } , 
																					{ x =  -90 , y =   95 , z =  -60 , sp = 3 } , 
																					{ x =   90 , y =   95 , z =  -60 , sp = 0 } , 
																					{ x =   65 , y = -110 , z =   50 , sp = 1 } } }
			DCMT[ "models/SmallBridge/Ship Parts/sblanduramp.mdl"  	] = { ListCat = "SmallBridge"	, ALType = "SWSHB",
																	Compatible = { 	{ Type = "SWSHA", AF = -4.65, AYaw = 180 } } ,
																	EfPoints = {	{ x =  -65 , y =  100 , z =   60 , sp = 0 } , 
																					{ x =  -90 , y = -110 , z =  -50 , sp = 3 } , 
																					{ x =   90 , y = -110 , z =  -50 , sp = 0 } , 
																					{ x =   65 , y =  100 , z =   60 , sp = 1 } } }
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			DCMT[ "models/SmallBridge/Panels/sbpaneldockin.mdl"  	] = { ListCat = "SmallBridge"	, ALType = "PLockA", 
																	Compatible = { 	{ Type = "PLockB", AF = -4.65 } }, 
																	EfPoints = {	{ x =  -60 , y =  -10 , z =   60 , sp = 1 } , 
																					{ x =  -95 , y =  -10 , z =    0 , sp = 0 } , 
																					{ x =  -87 , y =  -10 , z =  -60 , sp = 3 } , 
																					{ x =   87 , y =  -10 , z =  -60 , sp = 0 } , 
																					{ x =   95 , y =  -10 , z =    0 , sp = 5 } , 
																					{ x =   60 , y =  -10 , z =   60 , sp = 0 } } ,
																	Doors	 = {	{ "Door_Anim3" } } }
			DCMT[ "models/SmallBridge/Panels/sbpaneldockout.mdl"  	] = { ListCat = "SmallBridge"	, ALType = "PLockB",
																	Compatible = { 	{ Type = "PLockA", AF = 4.65 } },  
																	EfPoints = {	{ x =  -60 , y =   10 , z =   60 , sp = 0 } , 
																					{ x =  -95 , y =   10 , z =    0 , sp = 2 } , 
																					{ x =  -87 , y =   10 , z =  -60 , sp = 0 } , 
																					{ x =   87 , y =   10 , z =  -60 , sp = 4 } , 
																					{ x =   95 , y =   10 , z =    0 , sp = 5 } , 
																					{ x =   60 , y =   10 , z =   60 , sp = 6 } } ,
																	Doors	 = {	{ "Door_Anim3" } } }
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			DCMT[ "models/Slyfo/airlock_docksys.mdl"			  	] = { ListCat = "MedBridge"		, ALType = "MedGLB",
																	Compatible = { 	{ Type = "MedGLB", AYaw = 180 } },
																	EfPoints = {	{ x =  -70 , y =  -30 , z =  125 , sp = 0 } , 
																					{ x = -190 , y =  -30 , z =   60 , sp = 5 } , 
																					{ x = -195 , y =  -30 , z = -115 , sp = 0 } , 
																					{ x =  195 , y =  -30 , z = -125 , sp = 3 } , 
																					{ x =  195 , y =  -30 , z =   60 , sp = 2 } , 
																					{ x =   70 , y =  -30 , z =  125 , sp = 1 } } }
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			DCMT[ "models/SmallBridge/Ship Parts/sblandrampdw.mdl"  ] = { ListCat = "SmallBridge"	, ALType = "DWSHA",
																	Compatible = {  { Type = "DWSHB", AF = -4.65, AYaw = 180} } , 
																	EfPoints = 	{	{ x = -175 , y = -110 , z =   50 , sp = 0 } , 
																					{ x = -200 , y =   95 , z =  -60 , sp = 3 } , 
																					{ x =  200 , y =   95 , z =  -60 , sp = 0 } , 
																					{ x =  175 , y = -110 , z =   50 , sp = 1 } } }
			DCMT[ "models/SmallBridge/Ship Parts/sblandurampdw.mdl"  ] = { ListCat = "SmallBridge"	, ALType = "DWSHB",
																	Compatible = {  { Type = "DWSHA", AF = -4.65, AYaw = 180} } , 
																	EfPoints = 	{	{ x = -175 , y =  100 , z =   60 , sp = 0 } , 
																					{ x = -200 , y = -110 , z =  -50 , sp = 3 } , 
																					{ x =  200 , y = -110 , z =  -50 , sp = 0 } , 
																					{ x =  175 , y =  100 , z =   60 , sp = 1 } } }
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			DCMT[ "models/SmallBridge/Ship Parts/sblandrampdwdh.mdl" ] = { ListCat = "SmallBridge", ALType = "DWDHA", 
																	Compatible = {  { Type = "DWDHB", AF = -4.65, AYaw = 180} } ,
																	EfPoints = 	{	{ x = -175 , y = -110 , z =  180 , sp = 0 } , 
																					{ x = -200 , y =   90 , z =  -60 , sp = 3 } , 
																					{ x =  200 , y =   90 , z =  -60 , sp = 0 } , 
																					{ x =  175 , y = -110 , z =  180 , sp = 1 } } }
			DCMT[ "models/SmallBridge/Ship Parts/sblandurampdwdh.mdl"] = { ListCat = "SmallBridge"	, ALType = "DWDHB",
																	Compatible = {  { Type = "DWDHA", AF = -4.65, AYaw = 180} } ,
																	EfPoints = 	{	{ x = -175 , y =  100 , z =  190 , sp = 0 } , 
																					{ x = -200 , y = -120 , z =  -60 , sp = 3 } , 
																					{ x =  200 , y = -120 , z =  -60 , sp = 0 } , 
																					{ x =  175 , y =  100 , z =  190 , sp = 1 } } }
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			DCMT[ "models/SmallBridge/Elevators,Small/sbselevb.mdl"] = { ListCat = "ElevatorSmall"	, ALType = "ElevSU" ,
																	Compatible = { 	{ Type = "ElevSU", AU = 65.1, RYaw = 90, ARoll = 180 }, 
																					{ Type = "ElevSD", AU = 65.1, RYaw = 90 } },
																	EfPoints = 	{	{ x = -60.45 , y =  60.45 , z =  69.75 , sp = 1 } , 
																					{ x = -60.45 , y = -60.45 , z =  69.75 , sp = 0 } , 
																					{ x =  60.45 , y = -60.45 , z =  69.75 , sp = 3 } , 
																					{ x =  60.45 , y =  60.45 , z =  69.75 , sp = 0 } } ,
																	Doors	 = {	{ "Door_ElevHatch" , Vector(0,0, 60.45) } } }
			DCMT[ "models/SmallBridge/Elevators,Small/sbselevt.mdl"] = { ListCat = "ElevatorSmall"	, ALType = "ElevSD" , 
																	Compatible = { 	{ Type = "ElevSD", AU = -65.1, RYaw = 90, ARoll = 180 }, 
																					{ Type = "ElevSU", AU = -65.1, RYaw = 90 } },
																	EfPoints = 	{	{ x = -60.45 , y =  60.45 , z =  -69.75 , sp = 0 } , 
																					{ x = -60.45 , y = -60.45 , z =  -69.75 , sp = 2 } , 
																					{ x =  60.45 , y = -60.45 , z =  -69.75 , sp = 0 } , 
																					{ x =  60.45 , y =  60.45 , z =  -69.75 , sp = 4 } } ,
																	Doors	 = {	{ "Door_ElevHatch" , Vector(0,0,-60.45) } } }

for k,v in pairs( DCMT ) do
	list.Set( "SBEP_DockingClampModels", k , v )
end