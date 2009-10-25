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
	
	if self.PD.MultiFloor then
		self.Inputs = Wire_CreateInputs(self.Entity, self.PD.SBEPLiftWireInputs )
	elseif !self.PD.IsShaft then
		self.Inputs = Wire_CreateInputs(self.Entity, { "Call" })
	end
	--self.Outputs = WireLib.CreateOutputs(self.Entity,{""})
end

function ENT:TriggerInput(k,v)
	
	if self.PD.SBEPLiftWireInputs then
		for m,n in ipairs( self.PD.SBEPLiftWireInputs ) do
			if k == n && v == 1 then
				self.Controller:SetCallFloorNum( self.PD.FN[m] )
			end
		end
	else
		if k == "Call" && v == 1 then
			self.Controller:SetCallFloorNum( self.PD.FN )
		end
	end

end

function ENT:Use()

	if !self.PD.MultiFloor && self.PD.Usable && self.Controller && self.Controller:IsValid() then
		self.Controller:AddCallFloorNum( self.PD.FN )
	end

end

function ENT:PreEntityCopy()
	local dupeInfo = {}
	
	if WireAddon then
		dupeInfo.WireData = WireLib.BuildDupeInfo( self.Entity )
	end
	
	duplicator.StoreEntityModifier(self, "SBEPElevHousingDupeInfo", dupeInfo)
end
duplicator.RegisterEntityModifier( "SBEPElevHousingDupeInfo" , function() end)

function ENT:PostEntityPaste(pl, Ent, CreatedEntities)

	if(Ent.EntityMods && Ent.EntityMods.SBEPElevHousingDupeInfo.WireData) then
		WireLib.ApplyDupeInfo( pl, Ent, Ent.EntityMods.SBEPElevHousingDupeInfo.WireData, function(id) return CreatedEntities[id] end)
	end

end