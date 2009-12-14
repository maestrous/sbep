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

local CategoryTable = {}
CategoryTable[1] = {
	{ name = "Doors"			, cat = "Door"	 	, model = "models/SmallBridge/Panels/sbpaneldoor.mdl" 		 } ,
	{ name = "Hatches (Base)" 	, cat = "Hatch_B"	, model = "models/SmallBridge/Elevators,Small/sbselevb.mdl"  } ,
	{ name = "Hatches (Mid)" 	, cat = "Hatch_M"	, model = "models/SmallBridge/Elevators,Small/sbselevm.mdl"  } ,
	{ name = "Hatches (Top)"	, cat = "Hatch_T"	, model = "models/SmallBridge/Elevators,Small/sbselevt.mdl"  } ,
	{ name = "Other"			, cat = "Other"	 	, model = "models/SmallBridge/Station Parts/sbbaydps.mdl" 	 }
					}
for k,v in ipairs( CategoryTable[1] ) do
	TOOL.ClientConVar[ "model_1_"..tostring(k) ] = v.model
end

CategoryTable[2] = {
	{ name = "ModBridge Doors"	, cat = "Modbridge" , model = "models/Cerus/Modbridge/Misc/Doors/door11a.mdl" 	 }
					}
for k,v in ipairs( CategoryTable[2] ) do
	TOOL.ClientConVar[ "model_2_"..tostring(k) ] = v.model
end

TOOL.ClientConVar[ "activecat"  ] = 1
TOOL.ClientConVar[ "activetab"  ] = 1
TOOL.ClientConVar[ "skin"  		] = 0
TOOL.ClientConVar[ "wire"  		] = 1
TOOL.ClientConVar[ "enableuse"	] = 1

function TOOL:LeftClick( trace )

	if CLIENT then return end

	if tonumber(self:GetClientNumber( "wire" )) == 0 and self:GetClientNumber( "enableuse" ) == 0 then
		RunConsoleCommand( "SBEPDoorToolError_cl" , "Cannot be both unusable and unwireable." , 1 , 4)
		return
	end

	local model = self:GetClientInfo( "model_"..self:GetClientNumber( "activetab" ).."_"..self:GetClientNumber( "activecat" ) )

	local pos = trace.HitPos

	local DoorController = ents.Create( "sbep_base_door_controller" )
		DoorController:SetModel( model )

		DoorController:SetSkin( tonumber( self:GetClientNumber( "skin" ) ) )

		DoorController.EnableUseKey = self:GetClientNumber( "enableuse" ) == 1

		DoorController:Spawn()
		DoorController:Activate()
		
		DoorController:SetPos( pos - Vector(0,0, DoorController:OBBMins().z ) )
		
		DoorController:AddAnimDoors( table.Copy( MST[model].doors ) )
	
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
		PropertySheet:SetSize( 50, 640 )
	panel:AddItem( PropertySheet )

	SmallBridgeTab = vgui.Create( "DPanelList" )
			SmallBridgeTab:SetSize( PropertySheet:GetSize() )
			SmallBridgeTab:SetSpacing( 5 )
			SmallBridgeTab:EnableHorizontal( false )
			SmallBridgeTab:EnableVerticalScrollbar( false )

	ModBridgeTab = vgui.Create( "DPanelList" )
			ModBridgeTab:SetSize( PropertySheet:GetSize() )
			ModBridgeTab:SetSpacing( 5 )
			ModBridgeTab:EnableHorizontal( false )
			ModBridgeTab:EnableVerticalScrollbar( false )

	PropertySheet:AddSheet( "SmallBridge" , SmallBridgeTab , "gui/silkicons/plugin"	, false , false , "SmallBridge Doors" )
	PropertySheet:AddSheet( "ModBridge"   , ModBridgeTab   , "gui/silkicons/wrench"	, false , false , "ModBridge Doors"   )
	
	PropertySheet.Items[1].Tab.OnMousePressed = function()
												PropertySheet.Items[1].Tab:GetPropertySheet():SetActiveTab( PropertySheet.Items[1].Tab )
												RunConsoleCommand( "sbep_door_activetab" , 1 )
											end
	
	PropertySheet.Items[2].Tab.OnMousePressed = function()
												PropertySheet.Items[2].Tab:GetPropertySheet():SetActiveTab( PropertySheet.Items[2].Tab )
												RunConsoleCommand( "sbep_door_activetab" , 2 )
											end

	--[[local MCC = vgui.Create( "SBEPMultiPropSelect" )
		for k,v in ipairs( SMBCategoryTable ) do
			MCC:AddMCategory( v.name , v.cat , MST , "sbep_door" )
		end
	SmallBridgeTab:AddItem( MCC )]]
		
	local MCC = {}
	
	for k,v in pairs(CategoryTable[1]) do
		MCC[k] = {}
		MCC[k][1] = vgui.Create("DCollapsibleCategory")
			MCC[k][1]:SetExpanded( false )
			MCC[k][1]:SetLabel( v.name )
		SmallBridgeTab:AddItem( MCC[k][1] )
	 
		MCC[k][2] = vgui.Create( "DPanelList" )
			MCC[k][2]:SetAutoSize( true )
			MCC[k][2]:SetSpacing( 5 )
			MCC[k][2]:EnableHorizontal( false )
			MCC[k][2]:EnableVerticalScrollbar( false )
		MCC[k][1]:SetContents( MCC[k][2] )

		MCC[k][3] = vgui.Create( "PropSelect" )
			MCC[k][3]:SetConVar( "sbep_door_model_1_"..tostring(k) )
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
	
	local MCC2 = {}
	
	for k,v in pairs(CategoryTable[2]) do
		MCC2[k] = {}
		MCC2[k][1] = vgui.Create("DCollapsibleCategory")
			MCC2[k][1]:SetExpanded( false )
			MCC2[k][1]:SetLabel( v.name )
		ModBridgeTab:AddItem( MCC2[k][1] )
	 
		MCC2[k][2] = vgui.Create( "DPanelList" )
			MCC2[k][2]:SetAutoSize( true )
			MCC2[k][2]:SetSpacing( 5 )
			MCC2[k][2]:EnableHorizontal( false )
			MCC2[k][2]:EnableVerticalScrollbar( false )
		MCC2[k][1]:SetContents( MCC2[k][2] )

		MCC2[k][3] = vgui.Create( "PropSelect" )
			MCC2[k][3]:SetConVar( "sbep_door_model_2_"..tostring(k) )
			MCC2[k][3].Label:SetText( "Model:" )
			for m,n in pairs( MST ) do
				if n.cat == v.cat then
					MCC2[k][3]:AddModel( m , {} )
				end
			end
		MCC2[k][2]:AddItem( MCC2[k][3] )
	end
	MCC2[1][1]:SetExpanded( true )
	RunConsoleCommand( "sbep_door_activecat", 1 )
	
	for k,v in pairs( MCC2 ) do
		v[1].Header.OnMousePressed = function()
									for m,n in pairs(MCC2) do
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
