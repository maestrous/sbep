TOOL.Category		= "SBEP"
TOOL.Name			= "#Part Spawner"
TOOL.Command		= nil
TOOL.ConfigName 	= ""

local SMBModelSelectTable = list.Get( "SBEP_SmallBridgeModels" )

if CLIENT then
	language.Add( "Tool_sbep_part_spawner_name"	, "SBEP Part Spawner" 			)
	language.Add( "Tool_sbep_part_spawner_desc"	, "Spawn SBEP props." 			)
	language.Add( "Tool_sbep_part_spawner_0"	, "Left click to spawn a prop." )
	language.Add( "undone_SBEP Part"			, "Undone SBEP Part"			)
end

local CategoryTable = {
					{ "Hulls, SW"			, "Hulls_SW"		, "models/SmallBridge/Hulls,SW/sbhulle1.mdl" 			} ,
					{ "Hulls, DW"			, "Hulls_DW"		, "models/SmallBridge/Hulls,DW/sbhulldwe1.mdl" 			} ,
					{ "Ship Parts"			, "Ship_Parts"		, "models/SmallBridge/Ship Parts/sbcockpit1.mdl" 		} ,
					{ "Splitters"			, "Splitters"		, "models/SmallBridge/Splitters/sbsplitv.mdl" 			} ,
					{ "Height Transfer"		, "Height_Transfer"	, "models/SmallBridge/Height Transfer/sbhtsrampm.mdl" 	} ,
					{ "Panels"				, "Panels"			, "models/SmallBridge/Panels/sbpanelsolid.mdl" 			} ,
					{ "Elevators, Small"	, "Elev_Small"		, "models/SmallBridge/Elevators,Small/sbselevb.mdl" 	} ,
					{ "Elevators, Large"	, "Elev_Large"		, "models/SmallBridge/Elevators,Large/sblelevb.mdl" 	} ,
					{ "Hangars"				, "Hangars"			, "models/SmallBridge/Hangars/sbdb1m1.mdl" 				} ,
					{ "Station Parts"		, "Station"			, "models/SmallBridge/Station Parts/sbbridgesphere.mdl" } ,
					{ "Walkways"			, "Walkways"		, "models/SmallBridge/Walkways/sbwalkwaye.mdl" 			} ,
					{ "Miscellaneous"		, "Other"			, "models/SmallBridge/Other/sbconsole.mdl" 				} ,
					{ "Wings"				, "Wings"			, "models/SmallBridge/Wings/sbwingm1le.mdl" 			} ,
					{ "Ships and Shuttles"	, "Ships"			, "models/SmallBridge/Ships/hysteria_galapagos.mdl" 	} 
						}

for k,v in ipairs( CategoryTable ) do
	TOOL.ClientConVar[ "model_"..tostring(k) ] = v[3]
end
TOOL.ClientConVar[ "activecat"  ] = 1
TOOL.ClientConVar[ "skin"  		] = 0
TOOL.ClientConVar[ "glass"  	] = 0
TOOL.ClientConVar[ "hab_mod"	] = 0

function TOOL:LeftClick( trace )

	local model 	= self:GetClientInfo( "model_"..tostring( self:GetClientNumber( "activecat" ) ) )
	local hab 		= self:GetClientNumber( "hab_mod" )
	local skin 		= self:GetClientNumber( "skin" )
	local glass 	= self:GetClientNumber( "glass" )
	local pos 		= trace.HitPos
	local data 		= SMBModelSelectTable[model]
	
	local SMBProp = nil
	
	if hab == 1 then
		SMBProp = ents.Create( "sbep_hab_mod" )
	else
		SMBProp = ents.Create( "prop_physics" )
	end
	
	SMBProp:SetModel( model )

	local skincount = SMBProp:SkinCount()
	local skinnum	= nil
	if skincount > 5 then
		skinnum	= skin * 2 + glass
	else
		skinnum = skin
	end
	SMBProp:SetSkin( skinnum )
			
	SMBProp:SetPos( pos - Vector(0,0,SMBProp:OBBMins().z ) )
	
	SMBProp:Spawn()
	SMBProp:Activate()
	
	undo.Create("SBEP Part")
		undo.AddEntity( SMBProp )
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
		panel:SetName( "SBEP Part Spawner" )

	local PropertySheet = vgui.Create( "DPropertySheet" )
		PropertySheet:SetSize( 50, 640 )
	panel:AddItem( PropertySheet )

	SmallBridgeTab = vgui.Create( "DPanelList" )
			SmallBridgeTab:SetSize( PropertySheet:GetSize() )
			SmallBridgeTab:SetSpacing( 5 )
			SmallBridgeTab:EnableHorizontal( false )
			SmallBridgeTab:EnableVerticalScrollbar( false )

	SlyfoTab = vgui.Create( "DPanelList" )
			SlyfoTab:SetAutoSize( true )
			SlyfoTab:SetSpacing( 5 )
			SlyfoTab:EnableHorizontal( false )
			SlyfoTab:EnableVerticalScrollbar( false )

	PropertySheet:AddSheet( "SmallBridge" , SmallBridgeTab , "gui/silkicons/user"  , false , false , "All Hysteria's SmallBridge Props" )
	PropertySheet:AddSheet( "Slyfo"       , SlyfoTab       , "gui/silkicons/group" , false , false , "All Slyfo's MedBridge2 Props"     )

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
				SkinMenuOptions:AddOption( SkinTable[i] , function() RunConsoleCommand( "sbep_part_spawner_skin", (i - 1) ) end )
			end
			SkinMenuOptions:Open()
						end
	SmallBridgeTab:AddItem( SkinMenu )
	
	local GlassCheckBox = vgui.Create( "DCheckBoxLabel" )
		GlassCheckBox:SetText( "Glass" )
		GlassCheckBox:SetConVar( "sbep_part_spawner_glass" )
		GlassCheckBox:SetValue( 0 )
		GlassCheckBox:SizeToContents()
	SmallBridgeTab:AddItem( GlassCheckBox )
	
	local HabCheckBox = vgui.Create( "DCheckBoxLabel" )
		HabCheckBox:SetText( "Habitable Module" )
		HabCheckBox:SetConVar( "sbep_part_spawner_hab_mod" )
		HabCheckBox:SetValue( 0 )
		HabCheckBox:SizeToContents()
	SmallBridgeTab:AddItem( HabCheckBox )

	local ModelCollapsibleCategories = {}
	
	for k,v in pairs(CategoryTable) do
		ModelCollapsibleCategories[k] = {}
		ModelCollapsibleCategories[k][1] = vgui.Create("DCollapsibleCategory")
			//ModelCollapsibleCategories[k][1]:SetSize( 200, 50 )
			ModelCollapsibleCategories[k][1]:SetExpanded( false )
			ModelCollapsibleCategories[k][1]:SetLabel( v[1] )
		SmallBridgeTab:AddItem( ModelCollapsibleCategories[k][1] )
	 
		ModelCollapsibleCategories[k][2] = vgui.Create( "DPanelList" )
			ModelCollapsibleCategories[k][2]:SetAutoSize( true )
			ModelCollapsibleCategories[k][2]:SetSpacing( 5 )
			ModelCollapsibleCategories[k][2]:EnableHorizontal( false )
			ModelCollapsibleCategories[k][2]:EnableVerticalScrollbar( false )
		ModelCollapsibleCategories[k][1]:SetContents( ModelCollapsibleCategories[k][2] )

		ModelCollapsibleCategories[k][3] = vgui.Create( "PropSelect" )
			ModelCollapsibleCategories[k][3]:SetConVar( "sbep_part_spawner_model_"..tostring(k) )
			ModelCollapsibleCategories[k][3].Label:SetText( "Model:" )
			for m,n in pairs( SMBModelSelectTable ) do
				if n[1] == v[2] then
					ModelCollapsibleCategories[k][3]:AddModel( m , {} )
				end
			end
		ModelCollapsibleCategories[k][2]:AddItem( ModelCollapsibleCategories[k][3] )
	end
	ModelCollapsibleCategories[1][1]:SetExpanded( true )
	RunConsoleCommand( "sbep_part_spawner_activecat", 1 )
	
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
									RunConsoleCommand( "sbep_part_spawner_activecat", k )
							end
	end

end
