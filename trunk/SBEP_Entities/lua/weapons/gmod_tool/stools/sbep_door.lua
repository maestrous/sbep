TOOL.Category		= "SBEP"
TOOL.Name			= "#Door"
TOOL.Command		= nil
TOOL.ConfigName 	= ""

local MST = list.Get( "SBEP_DoorToolModels" )

if CLIENT then
	language.Add( "Tool_sbep_door_name"	, "SBEP Door Tool" 				)
	language.Add( "Tool_sbep_door_desc"	, "Create an SBEP door." 		)
	language.Add( "Tool_sbep_door_0"	, "Left click to spawn a door." )
	language.Add( "undone_SBEP Door"	, "Undone SBEP Door"			)
	
	function SBEPDoorToolError( ply, cmd, args )
		GAMEMODE:AddNotify( args[1] , tonumber(args[2]) , args[3] )
	end
	concommand.Add( "SBEPDoorToolError_cl" , SBEPDoorToolError )
end

local CategoryTable = {}
CategoryTable[1] = {
	{ name = "Doors"			, cat = "Door"	 	} ,
	{ name = "Hatches (Base)" 	, cat = "Hatch_B"	} ,
	{ name = "Hatches (Mid)" 	, cat = "Hatch_M"	} ,
	{ name = "Hatches (Top)"	, cat = "Hatch_T"	} ,
	{ name = "Other"			, cat = "Other"	 	}
					}

CategoryTable[2] = {
	{ name = "ModBridge Doors"	, cat = "Modbridge" , model = "models/Cerus/Modbridge/Misc/Doors/door11a.mdl" 	 }
					}

TOOL.ClientConVar[ "skin"  		] = 0
TOOL.ClientConVar[ "model"  	] = "models/SmallBridge/Panels/sbpaneldoor.mdl"
TOOL.ClientConVar[ "wire"  		] = 1
TOOL.ClientConVar[ "enableuse"	] = 1

function TOOL:LeftClick( trace )

	if CLIENT then return end

	if tonumber(self:GetClientNumber( "wire" )) == 0 and self:GetClientNumber( "enableuse" ) == 0 then
		RunConsoleCommand( "SBEPDoorToolError_cl" , "Cannot be both unusable and unwireable." , 1 , 4)
		return
	end

	local model = self:GetClientInfo( "model" )
	local pos = trace.HitPos

	local DoorController = ents.Create( "sbep_base_door_controller" )
		DoorController:SetModel( model )
		DoorController:SetSkin( tonumber( self:GetClientNumber( "skin" ) ) )

		DoorController:SetUsable( self:GetClientNumber( "enableuse" ) == 1 )

		DoorController:Spawn()
		DoorController:Activate()
		
		DoorController:SetPos( pos - Vector(0,0, DoorController:OBBMins().z ) )
		
		DoorController:AddDoors()

		DoorController:MakeWire( tonumber(self:GetClientNumber( "wire" )) == 1 )

	
	undo.Create("SBEP Door")
		undo.AddEntity( DoorController )
		undo.SetPlayer( self:GetOwner() )
	undo.Finish()
	
	return true
end

function TOOL:RightClick( trace )

end

function TOOL:Reload( trace )

end

function TOOL.BuildCPanel( panel )

		panel:SetSpacing( 10 )
		panel:SetName( "SBEP Door" )
		
	local HelpB = vgui.Create( "DButton" )
		HelpB.DoClick = function()
								SBEPDoc.OpenPage( "Construction" , "Doors.txt" )
							end
		HelpB:SetText( "Doors Help Page" )
	panel:AddItem( HelpB )
	
	local WireCheckBox = vgui.Create( "DCheckBoxLabel" )
		WireCheckBox:SetText( "Create Wire Inputs" )
		WireCheckBox:SetConVar( "sbep_door_wire" )
		WireCheckBox:SetValue( 1 )
		WireCheckBox:SizeToContents()
	panel:AddItem( WireCheckBox )
		
	local UseCheckBox = vgui.Create( "DCheckBoxLabel" )
		UseCheckBox:SetText( "Enable Use Key" )
		UseCheckBox:SetConVar( "sbep_door_enableuse" )
		UseCheckBox:SetValue( 1 )
		UseCheckBox:SizeToContents()
	panel:AddItem( UseCheckBox )
	
	local PropertySheet = vgui.Create( "DPropertySheet" )
		PropertySheet:SetSize( 50, 580 )
	panel:AddItem( PropertySheet )
	
	for Tab,cl in pairs( MST ) do
		local MCPS = vgui.Create( "MCPropSelect" )
			MCPS:SetConVar( "sbep_door_model" )
			for Cat,mt in pairs( cl ) do
				MCPS:AddMCategory( Cat , mt )
			end
		MCPS:SetCategory( 5 )
		PropertySheet:AddSheet( Tab , MCPS 	, "gui/silkicons/plugin"	, false , false , "SmallBridge Doors" )
	end

end
