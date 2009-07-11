AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" ) 

ENT.WireDebugName = "SBEP Elevator Housing"

function ENT:Initialize()	

		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		
		local phys = self:GetPhysicsObject()  	
		if (phys:IsValid()) then  		
			phys:Wake()  	
		end

		//self.OpenStatus      	= false

		self:MakeWire()

end

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16 + Vector(0,0,65.1)
	local RotAng   = Angle(0 , 0 , 0)
	
	local ent = ents.Create( "sbep_elev_housing" )
	ent:SetPos( SpawnPos )
	ent:SetAngles( RotAng )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:MakeWire()
	self.Inputs = Wire_CreateInputs(self.Entity, { "Call" })
	//self.Outputs = WireLib.CreateOutputs(self.Entity,{""})
end

function ENT:TriggerInput(k,v)
	
	if k == "Call" and v == 1 then
		self.Controller:SetCallFloorNum( self.FloorNum )
	end

end