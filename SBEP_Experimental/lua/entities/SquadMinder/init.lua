
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('entities/base_wire_entity/init.lua') --Thanks to DuneD for this bit.
include( 'shared.lua' )

function ENT:Initialize()

	self.Entity:SetModel( "models/Slyfo/util_tracker.mdl" ) 
	self.Entity:SetName("Squad")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	local inNames = {"ObjectiveType","ObjectiveVector","ObjectiveEnt"}
	local inTypes = {"NORMAL","VECTOR","NORMAL"}
	self.Inputs = WireLib.CreateSpecialInputs( self.Entity,inNames,inTypes)
	--self.Outputs = Wire_CreateOutputs( self.Entity, { "ShotsLeft", "CanFire" })
	self.Entity:SetKeyValue("rendercolor", "255 255 255")
		
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableGravity(false)
		phys:EnableDrag(false)
		phys:EnableCollisions(false)
		phys:SetMass( 0.001 )
	end
	self.PhysObj = self.Entity:GetPhysicsObject()
	
	self.ObjectiveType = 0
	self.ObjectiveVec = Vector(0,0,0)
	self.ObjectiveEnt = nil
end

function ENT:TriggerInput(iname, value)		
	if (iname == "ObjectiveType") then
		if (value > 0) then
			self.ObjectiveType = value
		end
		
	elseif (iname == "ObjectiveVector") then
		self.ObjectiveVec = value
		self.ObjectiveType = 1
	end
end

function ENT:PhysicsUpdate()

end

function ENT:Think()

end

function ENT:PhysicsCollide( data, physobj )
	
end

function ENT:OnTakeDamage( dmginfo )
	
end

function ENT:Use( activator, caller )

end