AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()

	--self.Entity:SetModel( "models/props_c17/consolebox01a.mdl" ) 
	self.Entity:SetName("MobilePlatform")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )

	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableGravity(false)
		phys:EnableDrag(true)
		phys:EnableCollisions(true)
		phys:SetMass(200)
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
		
	self.Duration = 0.005
	
	self.TPD = 0
		
	self.ShadowParams = {}
		self.ShadowParams.maxangular = 100000000 //What should be the maximal angular force applied
		self.ShadowParams.maxangulardamp = 10000000 // At which force/speed should it start damping the rotation
		self.ShadowParams.maxspeed = 100000000 // Maximal linear force applied
		self.ShadowParams.maxspeeddamp = 10000000 // Maximal linear force/speed before  damping
		self.ShadowParams.dampfactor = 0.8 // The percentage it should damp the linear/angular force if it reachs it's max ammount
		self.ShadowParams.teleportdistance = 0 // If it's further away than this it'll teleport (Set to 0 to not teleport)

	self:StartMotionController()
end

function ENT:PhysicsSimulate( phys, deltatime )

	if !self.Controller || !self.Controller:IsValid() then return SIM_NOTHING end
	
	phys:Wake()
	local Ang = Angle(0,0,0)
	Ang.y = self.Yaw
	Ang.r = self.Roll
	Ang.p = self.Pitch
	
	if self.TPD == 1 then
		self.Entity:SetPos(Vector(self.XCo,self.YCo,self.ZCo))
		if self.AbsAng then
			self.Entity:SetAngles(Ang)
		else
			self.Entity:SetAngles(self.Controller:LocalToWorldAngles(Ang))
		end
	end
	
	self.ShadowParams.secondstoarrive = self.Duration
	self.ShadowParams.pos = Vector(self.XCo,self.YCo,self.ZCo)
	if self.AbsAng then
		self.ShadowParams.angle = Ang
	else
		self.ShadowParams.angle = self.Controller:LocalToWorldAngles(Ang)
	end
	self.ShadowParams.deltatime = deltatime
	self.ShadowParams.teleportdistance = self.TPD
	self.ShadowParams.maxangular = self.Speed
	self.ShadowParams.maxangulardamp = self.Speed * 0.1
	self.ShadowParams.maxspeed = self.Speed
	self.ShadowParams.maxspeeddamp = self.Speed * 0.1
	
	local RPos = self.Entity:GetPos() + (self.Controller:GetUp() * -self.ZCo) + (self.Controller:GetForward() * -self.YCo) + (self.Controller:GetRight() * -self.XCo) + (phys:GetVelocity() * 0.8)
	
	return phys:ComputeShadowControl(self.ShadowParams)

end

function ENT:Think()
	if !self.Controller || !self.Controller:IsValid() then
		self.Entity:Remove()
	end
end