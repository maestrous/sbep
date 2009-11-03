TOOL.Category		= "SBEP"
TOOL.Name			= "#Door"
TOOL.Command		= nil
TOOL.ConfigName 	= ""

local MST = list.Get( "SBEP_DoorControllerModels" )

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

local CategoryTable = {
					{ name = "Doors"			, cat = "Door"	 	, model = "models/SmallBridge/Panels/sbpaneldoor.mdl" 		 } ,
					{ name = "ModBridge Doors"	, cat = "Modbridge" , model = "models/Cerus/Modbridge/Misc/Doors/door11a.mdl" 	 } ,
					{ name = "Hatches (Base)" 	, cat = "Hatch_B"	, model = "models/SmallBridge/Elevators,Small/sbselevb.mdl"  } ,
					{ name = "Hatches (Mid)" 	, cat = "Hatch_M"	, model = "models/SmallBridge/Elevators,Small/sbselevm.mdl"  } ,
					{ name = "Hatches (Top)"	, cat = "Hatch_T"	, model = "models/SmallBridge/Elevators,Small/sbselevt.mdl"  } ,
					{ name = "Other"			, cat = "Other"	 	, model = "models/SmallBridge/Station Parts/sbbaydps.mdl" 	 }
						}

for k,v in ipairs( CategoryTable ) do
	TOOL.ClientConVar[ "model_"..tostring(k) ] = v.model
end
TOOL.ClientConVar[ "activecat"  ] = 1
TOOL.ClientConVar[ "skin"  		] = 0
TOOL.ClientConVar[ "wire"  		] = 1
TOOL.ClientConVar[ "enableuse"	] = 1

function TOOL:LeftClick( trace )

	if CLIENT then return end

	if tonumber(self:GetClientNumber( "wire" )) == 0 and self:GetClientNumber( "enableuse" ) == 0 then
		RunConsoleCommand( "SBEPDoorToolError_cl" , "Cannot be both unusable and unwireable." , 1 , 4)
		return
	end

	local model = self:GetClientInfo( "model_"..tostring( self:GetClientNumber( "activecat" ) ) )

	local pos = trace.HitPos

	local DoorController = ents.Create( "sbep_base_door_controller" )
		DoorController:SetModel( model )

		DoorController:SetSkin( tonumber( self:GetClientNumber( "skin" ) ) )

		DoorController.EnableUseKey = self:GetClientNumber( "enableuse" ) == 1

		DoorController:Spawn()
		DoorController:Activate()
		
		DoorController:SetPos( pos - Vector(0,0, DoorController:OBBMins().z ) )
	
		DoorController.AnimData = table.Copy( MST[model].doors )
		
		DoorController:AddAnimDoors()
	
		DoorController.SBEPEnableWire = tonumber(self:GetClientNumber( "wire" )) == 1
		DoorController:MakeWire()

	
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

	--[[local MCC = vgui.Create( "SBEPMultiPropSelect" )
		for k,v in ipairs( CategoryTable ) do
			MCC:AddMCategory( v.name , v.cat , MST , "sbep_door" )
		end
	panel:AddItem( MCC )]]
		
	local MCC = {}
	
	for k,v in pairs(CategoryTable) do
		MCC[k] = {}
		MCC[k][1] = vgui.Create("DCollapsibleCategory")
			MCC[k][1]:SetExpanded( false )
			MCC[k][1]:SetLabel( v.name )
		panel:AddItem( MCC[k][1] )
	 
		MCC[k][2] = vgui.Create( "DPanelList" )
			MCC[k][2]:SetAutoSize( true )
			MCC[k][2]:SetSpacing( 5 )
			MCC[k][2]:EnableHorizontal( false )
			MCC[k][2]:EnableVerticalScrollbar( false )
		MCC[k][1]:SetContents( MCC[k][2] )

		MCC[k][3] = vgui.Create( "PropSelect" )
			MCC[k][3]:SetConVar( "sbep_door_model_"..tostring(k) )
			MCC[k][3].Label:SetText( "Model:" )
			for m,n in pairs( MST ) do
				if n.cat == v.cat then
					MCC[k][3]:AddModel( m , {} )
				end
			end
		MCC[k][2]:AddItem( MCC[k][3] )
	end
	MCC[1][1]:SetExpanded( true )
	RunConsoleCommand( "sbep_door_activecat", 1 )
	
	for k,v in pairs( MCC ) do
		v[1].Header.OnMousePressed = function()
									for m,n in pairs(MCC) do
										if n[1]:GetExpanded() then
											n[1]:Toggle()
										end
									end
									if !v[1]:GetExpanded() then
										v[1]:Toggle()
									end
									RunConsoleCommand( "sbep_door_activecat", k )
							end
	end

end
