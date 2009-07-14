TOOL.Category		= "SBEP"
TOOL.Name			= "#SBEP Weapon Mount"
TOOL.Command		= nil
TOOL.ConfigName 	= ""

local ModelSelectTable = list.Get( "SBEP_WeaponMountModels" )

if CLIENT then
	language.Add( "Tool_sbep_weapon_mount_name"	, "SBEP Weapon Mount Tool" 							)
	language.Add( "Tool_sbep_weapon_mount_desc"	, "Create an SBEP weapon mount."					)
	language.Add( "Tool_sbep_weapon_mount_0"	, "Left click to spawn a hardpointed weapon mount." )
	language.Add( "undone_SBEP Weapon Mount"	, "Undone SBEP Weapon Mount"						)
end

TOOL.ClientConVar[ "model_1" 	] = "models/Spacebuild/milcock4_wing1.mdl"
TOOL.ClientConVar[ "model_2" 	] = "models/Slyfo/rover1_backpanel.mdl"
TOOL.ClientConVar[ "activecat"  ] = 1

function TOOL:LeftClick( trace )

	local model = self:GetClientInfo( "model_"..tostring( self:GetClientNumber( "activecat" ) ) )
	local DataTable = ModelSelectTable[ model ]
	local pos = trace.HitPos
	
	local WeaponMountEnt = ents.Create( "sbep_base_weapon_mount" )
		WeaponMountEnt.MountName = DataTable[1]
		WeaponMountEnt.MountData = {}
		WeaponMountEnt.MountData["model"] = model

		WeaponMountEnt.HP = {}
		local val = 5
		local val2 = 1
		while DataTable[val] do
			WeaponMountEnt.HP[val2] = DataTable[val]
			val = val + 1
			val2 = val2 + 1
		end
		
		WeaponMountEnt.HPType = DataTable[2]
		WeaponMountEnt.APPos  = DataTable[3]
		WeaponMountEnt.APAng  = DataTable[4]
		
		WeaponMountEnt.SPL = self:GetOwner()
		
		WeaponMountEnt:SetPos( pos + Vector(0,0,50) )
		WeaponMountEnt:Spawn()
		WeaponMountEnt:Activate()
	
	undo.Create("SBEP Weapon Mount")
		undo.AddEntity( WeaponMountEnt )
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
		panel:SetName( "SBEP Weapon Mount" )
	
	local CategoryTable = {
					{ "Wings"			, "Wing"	} ,
					{ "Rover Parts" 	, "Rover"	}
						}

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
			ModelCollapsibleCategories[k][3]:SetConVar( "sbep_weapon_mount_model_"..tostring(k) )
			ModelCollapsibleCategories[k][3].Label:SetText( "Model:" )
			for m,n in pairs( ModelSelectTable ) do
				if n[1] == v[2] then
					ModelCollapsibleCategories[k][3]:AddModel( m , {} )
				end
			end
		ModelCollapsibleCategories[k][2]:AddItem( ModelCollapsibleCategories[k][3] )
	end
	ModelCollapsibleCategories[1][1]:SetExpanded( true )
	RunConsoleCommand( "sbep_weapon_mount_activecat", 1 )
	
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
									RunConsoleCommand( "sbep_weapon_mount_activecat", k )
							end
	end

end