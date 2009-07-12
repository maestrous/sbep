TOOL.Category		= "SBEP"
TOOL.Name			= "#SBEP Door"
TOOL.Command		= nil
TOOL.ConfigName 	= ""

local ModelSelectTable = list.Get( "SBEP_DoorControllerModels" )

local DoorDataTable    = list.Get( "SBEP_DoorModelData" )

if CLIENT then
	language.Add( "Tool_sbep_door_name"	, "SBEP Door Tool" 				)
	language.Add( "Tool_sbep_door_desc"	, "Create an SBEP door." 		)
	language.Add( "Tool_sbep_door_0"	, "Left click to spawn a door." )
	language.Add( "undone_SBEP Door"	, "Undone SBEP Door"			)
end

TOOL.ClientConVar[ "model" 		] = "models/SmallBridge/Panels/sbpaneldoor.mdl"
TOOL.ClientConVar[ "skin"  		] = 1
TOOL.ClientConVar[ "wire"  		] = 1
TOOL.ClientConVar[ "enableuse"	] = 1

function TOOL:LeftClick( trace )

	local model = self:GetClientInfo( "model" )
	
	local pos = trace.HitPos
	
	local DoorController = ents.Create( "sbep_base_door_controller" )
		DoorController:SetModel( model )
		
		DoorController.Skin = self:GetClientNumber( "skin" )
		DoorController:SetSkin( DoorController.Skin )
		
		DoorController.EnableUseKey = self:GetClientNumber( "enableuse" )
		
		DoorController:SetPos( pos + Vector(0,0,ModelSelectTable[model]) )
		DoorController:Spawn()
		DoorController:Activate()
	
		DoorController.AnimData = {}
		for k,v in pairs( DoorDataTable[model] ) do
			DoorController.AnimData[k] = v
		end
	
		DoorController:AddAnimDoors()
	
		DoorController.SBEPWire = self:GetClientNumber( "wire" )
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

    local ModelPropSelect = vgui.Create( "PropSelect" )
		ModelPropSelect:SetConVar( "sbep_door_model" )
		ModelPropSelect.Label( "Door Model:" )
		for k,v in pairs( ModelSelectTable ) do
			ModelPropSelect:AddModel( k , {} )
		end
	panel:AddItem( ModelPropSelect )

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