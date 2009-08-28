AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()

	self.Entity:SetModel( "models/props_c17/consolebox01a.mdl" ) 
	self.Entity:SetName("MPC")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	local inNames = {"X", "Y", "Z", "Vector", "Pitch", "Yaw", "Roll", "Angle", "Duration", "Speed", "Teleport", "AbsVec", "AbsAng", "Disable"}
	local inTypes = {"NORMAL","NORMAL","NORMAL","VECTOR","NORMAL","NORMAL","NORMAL","ANGLE","NORMAL","NORMAL","NORMAL","NORMAL","NORMAL","NORMAL"}
	self.Inputs = WireLib.CreateSpecialInputs( self.Entity,inNames,inTypes)
	self.Entity:SetUseType( 3 )

	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableGravity(true)
		phys:EnableDrag(true)
		phys:EnableCollisions(true)
		phys:SetMass(20)
	end

	self.PhysObj = self.Entity:GetPhysicsObject()
	
	self.Plat = nil	
	self.PlModel = nil
		
	self.XCo = 0
	self.YCo = 0
	self.ZCo = 0
	
	self.Yaw = 0
	self.Roll = 0
	self.Pitch = 0
	
	self.AbsVec = false
	self.AbsAng = false
	self.Recip = false
	
	self.Disabled = false
	
	self.TPD = 0
	
	self.Speed = 1000000000
	
	self.Duration = 0.000000001
	
	self.Vel = 0.1
	
	self.ShadowParams = {}
		self.ShadowParams.maxangular = 100000000 //What should be the maximal angular force applied
		self.ShadowParams.maxangulardamp = 10000000 // At which force/speed should it start damping the rotation
		self.ShadowParams.maxspeed = 100000000 // Maximal linear force applied
		self.ShadowParams.maxspeeddamp = 10000000 // Maximal linear force/speed before  damping
		self.ShadowParams.dampfactor = 0.8 // The percentage it should damp the linear/angular force if it reachs it's max ammount
		self.ShadowParams.teleportdistance = 0 // If it's further away than this it'll teleport (Set to 0 to not teleport)

	self:StartMotionController()
end

function ENT:TriggerInput(iname, value)
	
	if (iname == "X") then
		self.XCo = value
		
	elseif (iname == "Y") then
		self.YCo = value
		
	elseif (iname == "Z") then
		self.ZCo = value
		
	elseif (iname == "Vector") then
		self.XCo = value.x
		self.YCo = value.y
		self.ZCo = value.z
		
	elseif (iname == "Pitch") then
		self.Pitch = value
		
	elseif (iname == "Yaw") then
		self.Yaw = value
		
	elseif (iname == "Roll") then
		self.Roll = value
		
	elseif (iname == "Angle") then
		self.Yaw = value.y
		self.Roll = value.r
		self.Pitch = value.p
		
	elseif (iname == "Duration") then
		if (value >= 0) then
			self.Duration = math.Clamp(value,0.000000001,1000)
		end
		
	elseif (iname == "Teleport") then
		if (value >= 0) then
			self.TPD = value
		end
		
	elseif (iname == "AbsVec") then
		if (value > 0) then
			self.AbsVec = true
		else
			self.AbsVec = false
		end
		
	elseif (iname == "AbsAng") then
		if (value > 0) then
			self.AbsAng = true
		else
			self.AbsAng = false
		end
		
	elseif (iname == "Reciprocate") then
		if (value > 0) then
			self.Recip = true
		else
			self.Recip = false
		end
		
	elseif (iname == "Vel") then
		self.Vel = value
		
	elseif (iname == "Disable") then
		if (value > 0) then
			self.Disabled = true
		else
			self.Disabled = false
		end
	end
	
end
/*
function ENT:PhysicsSimulate( phys, deltatime )

	if self.Recip then
		local OVel = phys:GetVelocity()
		--local Phys = self.Entity:GetPhysicsObject()
		--Phys:AddAngleVelocity((Phys:GetAngleVelocity() * -1) + self.Plat:LocalToWorldAngles(Ang * -1))
		local RPos = self.Plat:GetPos() + (self.Entity:GetUp() * self.ZCo * -1) + (self.Entity:GetForward() * self.YCo * -1) + (self.Entity:GetRight() * self.XCo * -1)
		--Phys:SetVelocity(RPos - self.Entity:GetPos())
		phys:Wake()
				
		self.ShadowParams.secondstoarrive = self.Duration
		self.ShadowParams.pos = RPos
		--if self.AbsAng then
		self.ShadowParams.angle = self.Entity:GetAngles()
		--else
		--	self.ShadowParams.angle = self.Controller:LocalToWorldAngles(Ang)
		--end
		self.ShadowParams.deltatime = deltatime
		self.ShadowParams.teleportdistance = self.TPD
		self.ShadowParams.maxangular = self.Speed
		self.ShadowParams.maxangulardamp = self.Speed * 0.1
		self.ShadowParams.maxspeed = self.Speed
		self.ShadowParams.maxspeeddamp = self.Speed * 0.1
		
		phys:ComputeShadowControl(self.ShadowParams)
		
		local NVel = phys:GetVelocity()
		
		local CVel = OVel - NVel
		
		self.ShadowParams.pos = RPos + CVel
		
		phys:ComputeShadowControl(self.ShadowParams)
	end
end


function ENT:PhysicsUpdate( phys )
	if self.Recip then
		local OVel = phys:GetVelocity()
		local RPos = self.Plat:GetPos() + (self.Entity:GetUp() * self.ZCo * -1) + (self.Entity:GetForward() * self.YCo * -1) + (self.Entity:GetRight() * self.XCo * -1)
		
		NVel = ((OVel / self.Vel) - ((RPos - self.Entity:GetPos()) * self.Vel)) + ((RPos - self.Entity:GetPos()) * self.Vel)
		phys:SetVelocity(NVel)
	end
end

*/
--[[
function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit || !tr.Entity || !tr.Entity:IsValid() ) then return end
		
	local SpawnPos = tr.HitPos + tr.HitNormal * 16 + Vector(0,0,50)
	
	local PlModel = tr.Entity:GetModel()
	
	if !util.IsValidModel( PlModel ) then
		print("Invalid Model")
		return
	end
	
	local ent = ents.Create( "MobilePlatformController" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Initialize()
	ent:Activate()
	ent.SPL = ply
	
	ent.PlModel = PlModel
		
	return ent
	
end
]]--

function ENT:Think()

	if (!self.Plat || !self.Plat:IsValid()) and self.PlModel then
		self.Plat = ents.Create( "MobilePlatform" )
		self.Plat:SetModel( self.PlModel )
		self.Plat:SetPos( self.Entity:GetPos() )
		self.Plat.Controller = self.Entity
		self.Plat:Spawn()
		self.Plat:Initialize()
		self.Plat:Activate()
		self.PNoc = constraint.NoCollide(self.Entity,self.Plat,0,0)
		if self.Skin then
			self.Plat:SetSkin( self.Skin )
		end
		--self.MWeld = constraint.Weld(self.Entity,self.Plat,0,0,0,true)
		--self.Plat:SetParent(self.Entity)
	end
	
	--self.Plat:SetLocalPos(Vector(self.XCo, self.YCo, self.ZCo))
	--self.Plat:SetLocalAngles(Vector(self.Pitch, self.Yaw, self.Roll))
	
	/*
	if !self.AbsAng then
		local RAng = self.Entity:GetAngles()
		
		RAng.y = math.fmod(RAng.y + self.Yaw,360)
		RAng.r = math.fmod(RAng.r + self.Roll,360)
		RAng.p = math.fmod(RAng.p + self.Pitch,360)
	
		self.Plat.Yaw = RAng.y
		self.Plat.Roll = RAng.r
		self.Plat.Pitch = RAng.p
	else
	*/
		self.Plat.Yaw = self.Yaw
		self.Plat.Roll = self.Roll
		self.Plat.Pitch = self.Pitch
	--end
	
	self.Plat.AbsAng = self.AbsAng
	
	if !self.AbsVec then
		local RPos = self.Entity:GetPos() + (self.Entity:GetUp() * self.ZCo) + (self.Entity:GetForward() * self.YCo) + (self.Entity:GetRight() * self.XCo)
		
		self.Plat.XCo = RPos.x
		self.Plat.YCo = RPos.y
		self.Plat.ZCo = RPos.z		
	else
		self.Plat.XCo = self.XCo
		self.Plat.YCo = self.YCo
		self.Plat.ZCo = self.ZCo
	end
	
	self.Plat.Duration = self.Duration
	
	self.Plat.TPD = self.TPD
	
	self.Plat.Speed = self.Speed
	
	local phys = self.Entity:GetPhysicsObject()
	
	if self.Recip then
		local RPos = self.Plat:GetPos() + (self.Entity:GetUp() * self.ZCo * -1) + (self.Entity:GetForward() * self.YCo * -1) + (self.Entity:GetRight() * self.XCo * -1)
		
		local NVel = ((RPos - self.Entity:GetPos()) * self.Vel)
		phys:SetVelocity(NVel)
	end
		
	self.Entity:NextThink( CurTime() + 0.1 ) 
	return true
end

function ENT:PhysicsCollide( data, physobj )
	
end

function ENT:Touch( ent )
	
end