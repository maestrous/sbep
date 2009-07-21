AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" ) 

ENT.WireDebugName = "SBEP Elevator Housing"

function ENT:Initialize()

		self:PhysicsInitialize()

end

function ENT:PhysicsInitialize()

	self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		
		local phys = self:GetPhysicsObject()  	
		if ValidEntity(phys) then  		
			phys:Wake() 
			phys:EnableMotion( false )
		end

end

function ENT:MakeWire()
		self.Inputs = Wire_CreateInputs(self.Entity, { "Call" })
		//self.Outputs = WireLib.CreateOutputs(self.Entity,{""})
end

function ENT:TriggerInput(k,v)
	
	if k == "Call" and v == 1 then
		self.Controller:SetCallFloorNum( self.FN )
	end

end