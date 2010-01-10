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
	self.Outputs = Wire_CreateOutputs( self, { "TestValue1" , "TestValue2" , "TestValue3"})
	
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

function HoloEleOut(player,commandName,args)
	local Panel = ents.GetByIndex(tonumber(args[1]))
	if Panel && Panel:IsValid() then
		Wire_TriggerOutput( Panel, args[2], tonumber(args[3]) )
	end
	--print(args[1],args[2],args[3])
end 
concommand.Add("HoloEleOut",HoloEleOut) 
