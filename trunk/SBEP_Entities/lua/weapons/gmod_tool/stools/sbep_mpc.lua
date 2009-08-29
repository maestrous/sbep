TOOL.Category		= "SBEP"
TOOL.Name			= "#Mobile Platform Controller"
TOOL.Command		= nil
TOOL.ConfigName 	= ""

if CLIENT then
	language.Add( "Tool_sbep_mpc_name"	, "SBEP MPC Tool" 				)
	language.Add( "Tool_sbep_mpc_desc"	, "Create an SBEP Mobile Platform Controller." 		)
	language.Add( "Tool_sbep_mpc_0"		, "Left click to spawn an MPC. Right click to copy the model of whatever you're looking at. Press Reload to replace the target prop with an MPC." )
	language.Add( "undone_SBEP MPC"		, "Undone SBEP MPC"				)
	
	local function SBEPMPCModelToolError( ply, cmd, args )
		GAMEMODE:AddNotify( args[1] , 1 , 4 )
	end
	concommand.Add( "SBEPMPCTool_ModelError_cl" , SBEPMPCModelToolError )
	
	local function SBEPMPCModelToolConfirm( ply, cmd, args )
		GAMEMODE:AddNotify( args[1] , 0 , 4 )
	end
	concommand.Add( "SBEPMPCTool_ModelConfirm_cl" , SBEPMPCModelToolConfirm )
end

TOOL.ClientConVar[ "model" ] = "models/SmallBridge/Panels/sbdooriris.mdl"
TOOL.ClientConVar[ "skin"  ] = 0

local MST = { "models/SmallBridge/Elevators,Small/sbselevp0.mdl" ,
			  "models/SmallBridge/Panels/sbdooriris.mdl" 		 ,
			  "models/props_phx/construct/metal_plate2x2.mdl" 	 ,
			  "models/props_phx/construct/metal_plate1x2.mdl" 	 ,
			  "models/props_junk/TrashDumpster02b.mdl"	}
	

function TOOL:LeftClick( tr )

	local model = self:GetClientInfo( "model" )
	local skin  = tonumber(self:GetClientNumber( "skin" ))
	local pos   = tr.HitPos
	local ply   = self:GetOwner()

	local MPCEnt = ents.Create( "MobilePlatformController" )
		MPCEnt:SetPos( pos + Vector(0,0,50) )
		MPCEnt:Spawn()
		MPCEnt:Initialize()
		MPCEnt:Activate()
		MPCEnt:GetPhysicsObject():EnableMotion( false )
		
		MPCEnt.SPL 		= ply
		MPCEnt.PlModel 	= model
		if skin ~= 0 then
			MPCEnt.Skin = skin
		end
		
		MPCEnt:Think()
		
		if MPCEnt.Plat && MPCEnt.Plat:IsValid() then
			MPCEnt:SetPos( pos - Vector(0,0,MPCEnt.Plat:OBBMins().z ) )
			MPCEnt.Plat:SetPos( MPCEnt:GetPos() )
		end
	
	undo.Create("SBEP MPC")
		undo.AddEntity( MPCEnt )
		undo.SetPlayer( ply )
	undo.Finish()
	
	return true
	
end

function TOOL:RightClick( tr )

	if ( !tr.Hit || !tr.Entity || !tr.Entity:IsValid() ) then return end
	
	local PlModel = tr.Entity:GetModel()
	local skin	  = tr.Entity:GetSkin()
	local vec	  = tr.Entity:OBBMaxs()
	
	if !util.IsValidModel( PlModel ) then
		RunConsoleCommand( "SBEPMPCTool_ModelError_cl" , "Invalid Model" )
		return
	end
	
	RunConsoleCommand( "sbep_mpc_model" , PlModel )
	RunConsoleCommand( "sbep_mpc_skin"  , skin    )
	
	RunConsoleCommand( "SBEPMPCTool_ModelConfirm_cl" , "Copied Model!" )

	umsg.Start("SBEP_MPCTool_Model", RecipientFilter():AddPlayer( self:GetOwner() ) )
	    umsg.String( PlModel )
		umsg.Vector( vec )
		umsg.Char( skin )
	umsg.End()
	
	return true

end

function TOOL:Reload( tr )

	if !tr.Hit || !tr.Entity || !tr.Entity:IsValid() then return end

	local model = tr.Entity:GetModel()
	local skin  = tr.Entity:GetSkin()
	local pos   = tr.Entity:GetPos()
	local ang   = tr.Entity:GetAngles()
	local ply   = self:GetOwner()

	local MPCEnt = ents.Create( "MobilePlatformController" )
		MPCEnt:SetPos( pos )
		MPCEnt:SetAngles( ang )
		MPCEnt:Spawn()
		MPCEnt:Initialize()
		MPCEnt:Activate()
		MPCEnt:GetPhysicsObject():EnableMotion( false )
		
		MPCEnt.SPL 		= ply
		MPCEnt.PlModel 	= model
		if skin ~= 0 then
			MPCEnt.Skin = skin
		end
	
	undo.Create("SBEP MPC")
		undo.AddEntity( MPCEnt )
		undo.SetPlayer( ply )
	undo.Finish()
	
	tr.Entity:Remove()
	
	return true

end

function TOOL.BuildCPanel( panel )

	panel:SetSpacing( 10 )
	panel:SetName( "SBEP Mobile Platform Controller" )
	
	ModelDispLabel = vgui.Create( "DLabel" )
		ModelDispLabel:SetText("Copied Model:")
	panel:AddItem( ModelDispLabel )
	
	ModelDisp = vgui.Create( "DModelPanel" )
		ModelDisp:SetSize( 100,200 )
		ModelDisp:SetModel( "models/SmallBridge/Panels/sbdooriris.mdl" )
		ModelDisp:SetCamPos( Vector( 100, 100, 100 ) )
		ModelDisp:SetLookAt( -1 * ModelDisp:GetCamPos() )
	panel:AddItem( ModelDisp )
	
	function SBEP_MPCTool_Model( um )
	    ModelDisp:SetModel( um:ReadString() )
		ModelDisp:SetCamPos( 2.2 * um:ReadVector() )
		ModelDisp:SetLookAt( -1 * ModelDisp:GetCamPos() )
		ModelDisp.Entity:SetSkin( um:ReadChar() )
	end
	usermessage.Hook("SBEP_MPCTool_Model", SBEP_MPCTool_Model)
	
	ModelSelect = vgui.Create( "PropSelect" )
		ModelSelect:SetConVar( "sbep_mpc_model" )
		ModelSelect.Label:SetText( "Default Models:" )
		for m,n in pairs( MST ) do
			ModelSelect:AddModel( n , {} )
		end
	panel:AddItem( ModelSelect )

end
