TOOL.Category		= "SBEP"
TOOL.Name			= "#SBEP Door"
TOOL.Command		= nil
TOOL.ConfigName 	= ""

local ModelSelectTable = list.Get( "SBEP_DoorControllerModels" )

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
					{ "Doors"			, "Door"	, "models/SmallBridge/Panels/sbpaneldoor.mdl" 		} ,
					{ "Hatches (Base)" 	, "Hatch_B"	, "models/SmallBridge/Elevators,Small/sbselevb.mdl" } ,
					{ "Hatches (Mid)" 	, "Hatch_M"	, "models/SmallBridge/Elevators,Small/sbselevm.mdl" } ,
					{ "Hatches (Top)"	, "Hatch_T"	, "models/SmallBridge/Elevators,Small/sbselevt.mdl" } ,
					{ "Other"			, "Other"	, "models/SmallBridge/Station Parts/sbbaydps.mdl" 	}
						}

for k,v in ipairs( CategoryTable ) do
	TOOL.ClientConVar[ "model_"..tostring(k) ] = v[3]
end
TOOL.ClientConVar[ "activecat"  ] = 1
TOOL.ClientConVar[ "skin"  		] = 0
TOOL.ClientConVar[ "wire"  		] = 1
TOOL.ClientConVar[ "enableuse"	] = 1

function TOOL:LeftClick( trace )

	if tonumber(self:GetClientNumber( "wire" )) == 0 and self:GetClientNumber( "enableuse" ) == 0 then
		RunConsoleCommand( "SBEPDoorToolError_cl" , "Cannot be both unusable and unwireable." , 1 , 4)
		return
	end

	local model = self:GetClientInfo( "model_"..tostring( self:GetClientNumber( "activecat" ) ) )
	
	local pos = trace.HitPos
	
	local DoorController = ents.Create( "sbep_base_door_controller" )
		DoorController:SetModel( model )

		DoorController.Skin = tonumber( self:GetClientNumber( "skin" ) )
		DoorController:SetSkin( DoorController.Skin )
		
		if self:GetClientNumber( "enableuse" ) == 1 then
			DoorController.EnableUseKey = true
		else
			DoorController.EnableUseKey = false
		end
		
		DoorController:Spawn()
		DoorController:Activate()
		
		DoorController:SetPos( pos - Vector(0,0, DoorController:OBBMins().z ) )
	
		DoorController.AnimData = {}
		local val = 3
		while ModelSelectTable[model][val] do
			table.insert( DoorController.AnimData , ModelSelectTable[model][val] )
			val = val + 1
		end
		
		DoorController:AddAnimDoors()
	
		if tonumber(self:GetClientNumber( "wire" )) == 1 then
			DoorController.SBEPEnableWire = true
			DoorController:MakeWire()
		else
			DoorController.SBEPEnableWire = false
		end
	
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

	local ModelCollapsibleCategories = {}
	
	for k,v in pairs(CategoryTable) do
		ModelCollapsibleCategories[k] = {}
		ModelCollapsibleCategories[k][1] = vgui.Create("DCollapsibleCategory")
			//ModelCollapsibleCategories[k][1]:SetSize( 200, 50 )
			ModelCollapsibleCategories[k][1]:SetExpanded( false )
			ModelCollapsibleCategories[k][1]:SetLabel( v[1] )
		panel:AddItem( ModelCollapsibleCategories[k][1] )
	 
		ModelCollapsibleCategories[k][2] = vgui.Create( "DPanelList" )
			ModelCollapsibleCategories[k][2]:SetAutoSize( true )
			ModelCollapsibleCategories[k][2]:SetSpacing( 5 )
			ModelCollapsibleCategories[k][2]:EnableHorizontal( false )
			ModelCollapsibleCategories[k][2]:EnableVerticalScrollbar( false )
		ModelCollapsibleCategories[k][1]:SetContents( ModelCollapsibleCategories[k][2] )

		ModelCollapsibleCategories[k][3] = vgui.Create( "PropSelect" )
			ModelCollapsibleCategories[k][3]:SetConVar( "sbep_door_model_"..tostring(k) )
			ModelCollapsibleCategories[k][3].Label:SetText( "Model:" )
			for m,n in pairs( ModelSelectTable ) do
				if n[2] == v[2] then
					ModelCollapsibleCategories[k][3]:AddModel( m , {} )
				end
			end
		ModelCollapsibleCategories[k][2]:AddItem( ModelCollapsibleCategories[k][3] )
	end
	ModelCollapsibleCategories[1][1]:SetExpanded( true )
	RunConsoleCommand( "sbep_door_activecat", 1 )
	
	for k,v in pairs( ModelCollapsibleCategories ) do
		v[1].Header.OnMousePressed = function()
									for m,n in pairs(ModelCollapsibleCategories) do
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
