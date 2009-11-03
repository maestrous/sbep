TOOL.Category		= "SBEP"
TOOL.Name			= "#Docking Clamp"
TOOL.Command		= nil
TOOL.ConfigName 	= ""

local ModelSelectTable = list.Get( "SBEP_DockingClampModels" )

if CLIENT then
	language.Add( "Tool_sbep_docking_clamp_name"	, "SBEP Docking Clamp Tool" 						)
	language.Add( "Tool_sbep_docking_clamp_desc"	, "Create an SBEP docking clamp."					)
	language.Add( "Tool_sbep_docking_clamp_0"		, "Left click to spawn a docking clamp." 			)
	language.Add( "undone_SBEP Docking Clamp"		, "Undone SBEP Docking Clamp"						)
	
	--[[
	function SBEP_AddDockCLEffectsTable( um )
	
		local CLDockEnt = um:ReadEntity()
		local NumPoints = um:ReadShort()

		local EfPoints = {}
		for i = 1, NumPoints do
			EfPoints[i] = {}
			local Vec = um:ReadVector()
			local sp  = um:ReadShort()
			print( tostring( Vec ) )
			EfPoints[i]["x" ] = Vec.x
			EfPoints[i]["y" ] = Vec.y
			EfPoints[i]["z" ] = Vec.z
			EfPoints[i]["sp"] = sp
			print( tostring( sp ) )
		end
		CLDockEnt:AddEfPointsTable( EfPoints )
	end
	usermessage.Hook("SBEP_AddDockCLEffectsTable_cl", SBEP_AddDockCLEffectsTable)
	]]--
end

local CategoryTable = {
			{ "SmallBridge"			, "SmallBridge"	  , "models/SmallBridge/Ship Parts/sblanduramp.mdl"  } ,
			{ "MedBridge"		 	, "MedBridge"	  , "models/Slyfo/airlock_docksys.mdl" 			     } ,
			{ "ElevatorSmall"		, "ElevatorSmall" , "models/SmallBridge/Elevators,Small/sbselevt.mdl"} ,
			{ "PHX"					, "PHX" 		  , "models/props_phx/construct/metal_wire1x1.mdl"	 }
					}

for k,v in ipairs( CategoryTable ) do
	TOOL.ClientConVar[ "model_"..tostring(k) ] = v[3]
end
TOOL.ClientConVar[ "activecat"  ] = 1
TOOL.ClientConVar[ "allowuse"   ] = 1

function TOOL:LeftClick( trace )

	if CLIENT then return end
	local model = self:GetClientInfo( "model_"..tostring( self:GetClientNumber( "activecat" ) ) )
	local DataTable = ModelSelectTable[ model ]
	
	local pos = trace.HitPos
	
	local DockEnt = ents.Create( "sbep_base_docking_clamp" )
				
		DockEnt.SPL = self:GetOwner()
				
		DockEnt.ALType  = DataTable.ALType or ""

		DockEnt:SetModel( model )
		DockEnt:SetName( DataTable.ALType )
		
		DockEnt.CompatibleLocks = DataTable.Compatible
		DockEnt.Usable = GetConVarNumber( "sbep_docking_clamp" ) == 1
		--DataTable.EfPoints = table.Copy( DataTable.EfPoints )

		DockEnt:Spawn()
		DockEnt:Initialize()
		DockEnt:Activate()
		
		for k,v in pairs( DataTable.EfPoints ) do
			DockEnt:SetNetworkedVector("EfVec"..k, v.vec)
			DockEnt:SetNetworkedInt("EfSp"..k, v.sp)
		end
		
		--[[
		umsg.Start("SBEP_AddDockCLEffectsTable_cl", RecipientFilter():AddAllPlayers())
		    umsg.Entity( DockEnt )
			umsg.Short( #DataTable.EfPoints )
			for k,v in pairs( DataTable.EfPoints ) do
				umsg.Vector( v.vec )
				umsg.Short( v.sp )
			end
		umsg.End()
		]]--

		DockEnt:SetPos( pos - Vector(0,0,DockEnt:OBBMins().z) )
		
		if DataTable.Doors then
			for m,n in ipairs( DataTable.Doors ) do
				DockEnt:AddDockDoor( n )
			end
		end
	
	undo.Create("SBEP Docking Clamp")
		undo.AddEntity( DockEnt )
		undo.SetPlayer( self:GetOwner() )
	undo.Finish()

end

function TOOL:RightClick( trace )

end

function TOOL:Reload( trace )

end

function TOOL.BuildCPanel( panel )

		panel:SetSpacing( 10 )
		panel:SetName( "SBEP Docking Clamp" )

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
			ModelCollapsibleCategories[k][3]:SetConVar( "sbep_docking_clamp_model_"..tostring(k) )
			ModelCollapsibleCategories[k][3].Label:SetText( "Model:" )
			for m,n in pairs( ModelSelectTable ) do
				if n["ListCat"] == v[2] then
					ModelCollapsibleCategories[k][3]:AddModel( m , {} )
				end
			end
		ModelCollapsibleCategories[k][2]:AddItem( ModelCollapsibleCategories[k][3] )
	end
	ModelCollapsibleCategories[1][1]:SetExpanded( true )
	RunConsoleCommand( "sbep_docking_clamp_activecat", 1 )
	
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
									RunConsoleCommand( "sbep_docking_clamp_activecat", k )
							end
	end

end