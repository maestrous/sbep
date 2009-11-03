TOOL.Category		= "SBEP"
TOOL.Name			= "#Fighter"
TOOL.Command		= nil
TOOL.ConfigName 	= ""

local ModelSelectTable = list.Get( "SBEP_FighterModels" )

if CLIENT then
	language.Add( "Tool_sbep_fighter_name"	, "SBEP Fighter Tool" 				)
	language.Add( "Tool_sbep_fighter_desc"	, "Create an SBEP Fighter."			)
	language.Add( "Tool_sbep_fighter_0"	, "Left click to spawn a fighter." 		)
	language.Add( "undone_SBEP Fighter"	, "Undone SBEP Fighter"					)
end

local CategoryTable = {
			{ "Fighters"		, "Fighters"		, "models/Slyfo/sword.mdl"			 				} ,
			{ "Corvettes" 		, "Corvettes"		, "models/SmallBridge/Station Parts/SBdockCs.mdl" 	}
					}
for k,v in ipairs( CategoryTable ) do
	TOOL.ClientConVar[ "model_"..tostring(k) ] = v[3]
end
TOOL.ClientConVar[ "activecat"  ] = 1

function TOOL:LeftClick( trace )

	if CLIENT then return end
	local model = self:GetClientInfo( "model_"..tostring( self:GetClientNumber( "activecat" ) ) )
	local DataTable = table.Copy( ModelSelectTable[ model ]	)
	local pos = trace.HitPos
	
	local FighterEnt = ents.Create( "base_fighter" )
		FighterEnt:SetName( DataTable.name )
		
		FighterEnt:Spawn()
		FighterEnt:Activate()
		
		FighterEnt:SetPos( pos - Vector(0,0,FighterEnt:OBBMins().z) )
		
		FighterEnt.ExitPoint = DataTable.exit
		FighterEnt:CreateFighterParts( DataTable.parts )
	
	undo.Create("SBEP Fighter")
		undo.AddEntity( FighterEnt )
		undo.SetPlayer( self:GetOwner() )
	undo.Finish()

end

function TOOL:RightClick( trace )

end

function TOOL:Reload( trace )

end

function TOOL.BuildCPanel( panel )

		panel:SetSpacing( 10 )
		panel:SetName( "SBEP Fighter" )

	local ModelCollapsibleCategories = {}
	
	for k,v in pairs(CategoryTable) do
		ModelCollapsibleCategories[k] = {}
			ModelCollapsibleCategories[k][1] = vgui.Create("DCollapsibleCategory")
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
			ModelCollapsibleCategories[k][3]:SetConVar( "sbep_fighter_model_"..tostring(k) )
			ModelCollapsibleCategories[k][3].Label:SetText( "Model:" )
			for m,n in pairs( ModelSelectTable ) do
				if n.category == v[2] then
					ModelCollapsibleCategories[k][3]:AddModel( m , {} )
				end
			end
		ModelCollapsibleCategories[k][2]:AddItem( ModelCollapsibleCategories[k][3] )
	end
	ModelCollapsibleCategories[1][1]:SetExpanded( true )
	RunConsoleCommand( "sbep_fighter_activecat", 1 )
	
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
									RunConsoleCommand( "sbep_fighter_activecat", k )
							end
	end

end