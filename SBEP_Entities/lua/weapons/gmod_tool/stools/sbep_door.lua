TOOL.Category		= "SBEP"
TOOL.Name			= "#SBEP Door"
TOOL.Command		= nil
TOOL.ConfigName 	= ""

local ModelSelectTable = {
			{ "models/SmallBridge/Panels/sbpaneldoor.mdl" 			, 65.1  } ,
			{ "models/SmallBridge/Panels/sbpaneldoorsquare.mdl" 	, 65.1  } ,
			{ "models/SmallBridge/Panels/sbpaneldooriris.mdl" 		, 65.1  } ,
			{ "models/SmallBridge/Panels/sbpaneliris.mdl"	 		, 65.1  } ,
			{ "models/SmallBridge/Panels/sbpaneldoorwide2.mdl" 		, 65.1  } ,
			{ "models/SmallBridge/Panels/sbpaneldoordw.mdl" 		, 65.1  } ,
			{ "models/SmallBridge/Panels/sbpaneldoordw2.mdl" 		, 65.1  } ,
			{ "models/SmallBridge/Panels/sbpaneldoorsquaredw.mdl" 	, 65.1  } ,
			{ "models/SmallBridge/Panels/sbpaneldockin.mdl" 		, 65.1  } ,
			{ "models/SmallBridge/Panels/sbpaneldockout.mdl" 		, 65.1  } ,
			{ "models/SmallBridge/Ship Parts/sbhulldse.mdl" 		, 65.1  } ,
			{ "models/SmallBridge/Ship Parts/sbhulldseb.mdl" 		, 65.1  } ,
			{ "models/SmallBridge/Ship Parts/sbhulldst.mdl" 		, 65.1  } ,
			{ "models/SmallBridge/Ship Parts/sbhulldsdwe.mdl" 		, 65.1  } ,
			{ "models/SmallBridge/Panels/sbpaneldbsmall.mdl" 		, 130.2 } ,
			{ "models/Slyfo/SLYpaneldoor1.mdl"						, 0		}
						}
						
local  DoorDataTable = {}
		DoorDataTable[1]	= { { "models/SmallBridge/SEnts/SBADoor1.mdl" 		, 3 , 2   , 1 	, Vector(0,0,0) 	, Angle(0,0,0)  	, 
															{ [0] = "Doors.Move14" , [1.45] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } ,
															{ [0] = "Doors.Move14" , [1.45] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } } }

		DoorDataTable[2]	= { { "models/SmallBridge/SEnts/SBADoor2.mdl" 		, 3 , 1   , 2 	, Vector(0,0,0) 	, Angle(0,0,0)  	, 
															{ [0] = "Doors.Move14" , [1.95] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } ,
															{ [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } } }

		DoorDataTable[3]	= { { "models/SmallBridge/SEnts/SBADoorIris2.mdl"	, 3 , 2   , 1 	, Vector(0,0,0) 	, Angle(0,0,0)  	, 
															{ [0] = "Doors.Move14" , [0.90] = "Doors.FullOpen8" , [2.65] = "Doors.FullOpen9" } ,
															{ [0] = "Doors.Move14" , [1.95] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } } }

		DoorDataTable[4]	= { { "models/SmallBridge/SEnts/SBADoorIris2.mdl"	, 3 , 2   , 1 	, Vector(0,0,0) 	, Angle(0,0,0)  	, 
															{ [0] = "Doors.Move14" , [0.90] = "Doors.FullOpen8" , [2.65] = "Doors.FullOpen9" } ,
															{ [0] = "Doors.Move14" , [1.95] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } } }

		DoorDataTable[5]	= { { "models/SmallBridge/SEnts/SBADoorWide.mdl" 	, 3 , 1.5 , 1.5 , Vector(0,0,0) 	, Angle(0,0,0)  	, 
															{ [0] = "Doors.Move14" , [0.55] = "Doors.FullOpen8" , [1.15] = "Doors.FullOpen8" , [1.75] = "Doors.FullOpen8" , [2.35] = "Doors.FullOpen8" , [2.85] = "Doors.FullOpen9" } ,
															{ [0] = "Doors.Move14" , [0.55] = "Doors.FullOpen8" , [1.15] = "Doors.FullOpen8" , [1.75] = "Doors.FullOpen8" , [2.35] = "Doors.FullOpen8" , [2.85] = "Doors.FullOpen9" } } }

		DoorDataTable[6]	= { { "models/SmallBridge/SEnts/SBADoor1.mdl" 		, 3 , 2   , 1 	, Vector(0,0,0) 	, Angle(0,0,0)  	, 
															{ [0] = "Doors.Move14" , [1.45] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } ,
															{ [0] = "Doors.Move14" , [1.45] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } } }

		DoorDataTable[7]	= { { "models/SmallBridge/SEnts/SBADoor1.mdl" 		, 3 , 2   , 1 	, Vector(0,111.6,0) , Angle(0,180,0)  	, 
															{ [0] = "Doors.Move14" , [1.45] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } ,
															{ [0] = "Doors.Move14" , [1.45] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } } ,
								{ "models/SmallBridge/SEnts/SBADoor1.mdl" 		, 3 , 2   , 1 	, Vector(0,-111.6,0), Angle(0,0,0)  	, 
															{ [0] = "Doors.Move14" , [1.45] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } ,
															{ [0] = "Doors.Move14" , [1.45] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } } }

		DoorDataTable[8]	= { { "models/SmallBridge/SEnts/SBADoor2.mdl" 		, 3 , 1   , 2 	, Vector(0,0,0) 	, Angle(0,0,0)  	, 
															{ [0] = "Doors.Move14" , [1.95] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } ,
															{ [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } } }

		DoorDataTable[9]	= { { "models/SmallBridge/SEnts/SBADoor2.mdl" 		, 3 , 1   , 2 	, Vector(0,0,0) 	, Angle(0,0,0)  	, 
															{ [0] = "Doors.Move14" , [1.95] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } ,
															{ [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } } }

		DoorDataTable[10]	= { { "models/SmallBridge/SEnts/SBADoor2.mdl" 		, 3 , 1   , 2 	, Vector(0,0,0) 	, Angle(0,0,0)  	, 
															{ [0] = "Doors.Move14" , [1.95] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } ,
															{ [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } } }

		DoorDataTable[11]	= { { "models/SmallBridge/SEnts/SBAhullDsEb.mdl" 	, 3 , 1.5 , 1.5 , Vector(0,0,0) 	, Angle(0,0,0)  	, 
															{ [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [1.95] = "Doors.FullOpen8" , [2.85] = "Doors.FullOpen9" } ,
															{ [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [1.95] = "Doors.FullOpen8" , [2.90] = "Doors.FullOpen9" } } , 
								{ "models/SmallBridge/SEnts/SBAhullDsEb.mdl" 	, 3 , 1.5 , 1.5 , Vector(0,0,0) 	, Angle(0,180,0)  	, 
															{ [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [1.95] = "Doors.FullOpen8" , [2.85] = "Doors.FullOpen9" } ,
															{ [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [1.95] = "Doors.FullOpen8" , [2.90] = "Doors.FullOpen9" } } }

		DoorDataTable[12]	= { { "models/SmallBridge/SEnts/SBAhullDsEb.mdl" 	, 3 , 1.5 , 1.5 , Vector(0,0,0) 	, Angle(0,0,0)  	, 
															{ [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [1.95] = "Doors.FullOpen8" , [2.85] = "Doors.FullOpen9" } ,
															{ [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [1.95] = "Doors.FullOpen8" , [2.90] = "Doors.FullOpen9" } } }

		DoorDataTable[13]	= { { "models/SmallBridge/SEnts/SBAhullDsEb.mdl" 	, 3 , 1.5 , 1.5 , Vector(0,0,0) 	, Angle(0,0,0)  	, 
															{ [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [1.95] = "Doors.FullOpen8" , [2.85] = "Doors.FullOpen9" } ,
															{ [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [1.95] = "Doors.FullOpen8" , [2.90] = "Doors.FullOpen9" } } }

		DoorDataTable[14]	= { { "models/SmallBridge/SEnts/SBAhullDsEb.mdl" 	, 3 , 1.5 , 1.5 , Vector(0,111.6,0) , Angle(0,0,0)  	, 
															{ [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [1.95] = "Doors.FullOpen8" , [2.85] = "Doors.FullOpen9" } ,
															{ [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [1.95] = "Doors.FullOpen8" , [2.90] = "Doors.FullOpen9" } } ,
								{ "models/SmallBridge/SEnts/SBAhullDsEb.mdl" 	, 3 , 1.5 , 1.5 , Vector(0,-111.6,0), Angle(0,180,0)  	, 
															{ [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [1.95] = "Doors.FullOpen8" , [2.85] = "Doors.FullOpen9" } ,
															{ [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [1.95] = "Doors.FullOpen8" , [2.90] = "Doors.FullOpen9" } } }

		DoorDataTable[15]	= { { "models/SmallBridge/SEnts/SBADoorDBsmall.mdl" , 5 , 4   , 1.5	, Vector(0,0,0) 	, Angle(0,0,0)  	,
															{ [0] = "Doors.Move14" , [1.30] = "Doors.FullOpen8" , [2.60] = "Doors.FullOpen8" , [3.90] = "Doors.FullOpen9" , [4.90] = "Doors.FullOpen8" } ,
															{ [0] = "Doors.Move14" , [2.60] = "Doors.FullOpen8" , [3.95] = "Doors.FullOpen8" , [4.90] = "Doors.FullOpen9" } } }

		DoorDataTable[16]	= { { "models/Slyfo/SLYAdoor1.mdl" 					, 2 , 0.5 , 1.5 , Vector(0,0,0) 	, Angle(0,0,0)  	,
															{ [0] = "Doors.Move14" , [1.80] = "Doors.FullOpen9" } ,
															{ [0] = "Doors.Move14" , [1.80] = "Doors.FullOpen9" } } }

if CLIENT then
	language.Add( "Tool_sbep_door_name"	, "SBEP Door Tool" 				)
	language.Add( "Tool_sbep_door_desc"	, "Create an SBEP door." 		)
	language.Add( "Tool_sbep_door_0"	, "Left click to spawn a door." )
	language.Add( "undone_SBEP Door"	, "Undone SBEP Door"			)
end

TOOL.ClientConVar[ "model" ] = "models/SmallBridge/Panels/sbpaneldoor.mdl"
TOOL.ClientConVar[ "skin"  ] = 1
TOOL.ClientConVar[ "wire"  ] = 1

function TOOL:LeftClick( trace )

	local model = self:GetClientInfo( "model" )
	local ModelNumber = 1
	
	for k,v in pairs( ModelSelectTable ) do
		if string.lower(v[1]) == string.lower(model) then
			ModelNumber = k
		end
	end		
	
	local pos = trace.HitPos
	
	local DoorController = ents.Create( "sbep_base_door_controller" )
		DoorController:SetModel( model )
		
		DoorController.Skin = self:GetClientInfo( "skin" )
		DoorController:SetSkin( DoorController.Skin )
		
		DoorController:SetPos( pos + Vector(0,0,ModelSelectTable[ModelNumber][2]) )
		DoorController:Spawn()
		DoorController:Activate()
	
		DoorController.AnimData = {}
		for k,v in pairs( DoorDataTable[ModelNumber] ) do
			DoorController.AnimData[k] = v
		end
	
		DoorController:AddAnimDoors()
	
		DoorController.Wire = self:GetClientInfo( "wire" )
		DoorController:MakeWire()
	
	undo.Create("SBEP Door")
		undo.AddEntity( DoorController )
		undo.SetPlayer( self:GetOwner() )
	undo.Finish()

end

function TOOL:RightClick( trace )

	

	//return true
end

function TOOL:Reload( trace )

	

	//return true
end

function TOOL.BuildCPanel( panel )

		panel:SetSpacing( 10 )
		panel:SetName( "SBEP Door" )

    local dpropselect = vgui.Create( "PropSelect" )
		dpropselect:SetConVar( "sbep_door_model" )
		for i = 1, #ModelSelectTable do
			dpropselect:AddModel( ModelSelectTable[i][1] , {} )
		end
	panel:AddItem( dpropselect )

	local WireCheckBox = vgui.Create( "DCheckBoxLabel" )
		WireCheckBox:SetText( "Create Wire Inputs" )
		WireCheckBox:SetConVar( "sbep_door_wire" )
		WireCheckBox:SetValue( 1 )
		WireCheckBox:SizeToContents()
	panel:AddItem( WireCheckBox )

	local SkinMenu = vgui.Create("DButton")
	SkinMenu:SetText( "Skin" )
	SkinMenu:SetSize( 100, 20 )

	local SkinTable = {
			"Scrappers"  ,
			"Advanced"   ,
			"SlyBridge"  ,
			"MedBridge2" ,
			"Jaanus"
				}

	SkinMenu.DoClick = function ( btn )
			local SkinMenuOptions = DermaMenu()
			for i = 1, #SkinTable do
				SkinMenuOptions:AddOption( SkinTable[i] , function() RunConsoleCommand( "sbep_door_skin", (i - 1) ) end )
			end
			SkinMenuOptions:Open()
						end
	panel:AddItem( SkinMenu )

end