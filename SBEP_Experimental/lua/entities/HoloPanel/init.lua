AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()

	self:SetModel( "models/Slyfo/util_tracker.mdl" )
		self:SetName("HoloPanel")
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
	--self.Inputs = Wire_CreateInputs( self, { "Active" } )
	--self.Outputs = Wire_CreateOutputs( self, { "Value", "CorrectCode", "IncorrectCode" })
	
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableGravity(true)
		phys:EnableDrag(true)
		phys:EnableCollisions(true)
	end
end

function ENT:TriggerInput(iname, value)
	--if iname == "Active" then
	--	self:SetActive( value > 0 )
	--end	
end

function ENT:Think()
	
end

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	
	local ent = ents.Create( "HoloPanel" )
		ent:Spawn()
		ent:Initialize()
		ent:Activate()
	ent:SetPos( tr.HitPos + tr.HitNormal * -1 * ent:OBBMins().z )
	
	return ent
end

function ENT:Use( activator, caller )
	return false
	--if !self:GetActive() then
	--	self:SetActive( true )
	--end
end

function HoloPanelTrigger(player,commandName,args)
	local Pad = ents.GetByIndex(tonumber(args[1]))
	if Pad && Pad:IsValid() then
		Pad.KeyValue = tonumber(args[2])
		Pad.StrValue = args[2]
		Pad.InputTime = CurTime()
		Wire_TriggerOutput( Pad, "Value", Pad.KeyValue )
					
	end	 
end 
concommand.Add("HoloPanelTrigger",HoloPanelTrigger) 
