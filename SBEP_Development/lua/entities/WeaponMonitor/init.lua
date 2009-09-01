
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()

	self.Entity:SetModel( "models/props_combine/combine_emitter01.mdl" ) 
	self.Entity:SetName("ShipAIWeap")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	--local inNames = {"MoveVector", "TargetVector", "Angle", "Stance"}
	--local inTypes = {"VECTOR","VECTOR","ANGLE","NORMAL"}
	--self.Inputs = WireLib.CreateSpecialInputs( self.Entity,inNames,inTypes)
	self.Inputs = Wire_CreateInputs( self.Entity, { "Priority", "CanFire", "Range", "PitchArc", "YawArc" } )
	self.Outputs = WireLib.CreateSpecialOutputs(self.Entity, { "Firing", "TVec", "InRange" }, { "NORMAL", "VECTOR", "NORMAL" })
		
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableGravity(true)
		phys:EnableDrag(true)
		phys:EnableCollisions(true)
		phys:SetMass( 1 )
	end
	
	self.Entity:StartMotionController()
	
	self.Entity:SetKeyValue("rendercolor", "255 255 255")
	self.PhysObj = self.Entity:GetPhysicsObject()
	
	self.Priority = 0
	self.FReady = false
	self.Range = 4000
	self.PArc = 15
	self.YArc = 15
	self.Master = nil
end

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	
	local ent = ents.Create( "WeaponMonitor" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	ent.SPL = ply
	
	return ent
	
end

function ENT:TriggerInput(iname, value)
	
	if (iname == "Priority") then
		self.Priority = value
		
	elseif (iname == "CanFire") then
		if value > 0 then
			self.FReady = true
		else
			self.FReady = false
		end
		
	elseif (iname == "Range") then
		self.Range = value
		
	elseif (iname == "PitchArc") then
		self.PArc = value
		
	elseif (iname == "YawArc") then
		self.YArc = value
		
	end
end

function ENT:Think()

	local InRange = 0	
	local Firing = 0

	if self.Master && self.Master:IsValid() && self.Master.TFound then
		local RAng = (self.Master.TVec - self.Entity:GetPos()):Angle()
		local SAng = self.Entity:GetAngles()
		if math.abs(math.AngleDifference(SAng.p,RAng.p)) < self.PArc && math.abs(math.AngleDifference(SAng.y,RAng.y)) < self.YArc && self.Entity:GetPos():Distance(self.Master.TVec) < self.Range then
			InRange = 1
			if self.Master.Stance > 1 then
				Firing = 1
			end
		end
		Wire_TriggerOutput( self.Entity, "TVec", self.Master.TVec )
	end
	
	Wire_TriggerOutput( self.Entity, "Firing", 0 )
	Wire_TriggerOutput( self.Entity, "Firing", Firing )
	Wire_TriggerOutput( self.Entity, "InRange", InRange )
	
	
	self.Entity:NextThink( CurTime() + 0.01 ) 
	return true
end

function ENT:Touch( ent )
	--print("Touching")
	if ent.IsShipController && (!self.Master || !self.Master:IsValid()) then
		table.insert(ent.Weaponry,self.Entity)
		self.Master = ent
		--print("Linking")
	end
end
