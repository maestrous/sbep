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
			phys:EnableMotion( false )
			phys:Wake() 
		end

end

function ENT:MakeWire()
	
	if self.MultiFloor then
		self.Inputs = Wire_CreateInputs(self.Entity, self.SBEPLiftWireInputs )
	elseif !self.IsShaft then
		self.Inputs = Wire_CreateInputs(self.Entity, { "Call" })
	end
		//self.Outputs = WireLib.CreateOutputs(self.Entity,{""})
end

function ENT:TriggerInput(k,v)
	
	if self.SBEPLiftWireInputs then
		for m,n in ipairs( self.SBEPLiftWireInputs ) do
			if k == n and v == 1 then
				self.Controller:SetCallFloorNum( self.FN[m] )
			end
		end
	else
		if k == "Call" and v == 1 then
			self.Controller:SetCallFloorNum( self.FN )
		end
	end

end

function ENT:Use()

	if !self.MultiFloor and self.Usable then
		self.Controller:SetCallFloorNum( self.FN )
	end

end