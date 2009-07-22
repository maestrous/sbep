AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()

	self.Entity:SetModel( "models/props_c17/consolebox01a.mdl" ) 
	self.Entity:SetName("CargoCrate")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	local inNames = {"X", "Y", "Z", "Vector", "Pitch", "Yaw", "Roll", "Angle", "Duration", "Speed", "Teleport", "AbsVec", "AbsAng" }
	local inTypes = {"NORMAL","NORMAL","NORMAL","VECTOR","NORMAL","NORMAL","NORMAL","ANGLE","NORMAL","NORMAL","NORMAL","NORMAL","NORMAL"}
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
	
	self.TPD = 0
	
	self.Speed = 1000000000
	
	self.Duration = 0.000000001
	
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
				
	end
	
end

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

function ENT:Think()
	--print(self.PlModel)
	if !self.Plat || !self.Plat:IsValid() then
		self.Plat = ents.Create( "MobilePlatform" )
		self.Plat:SetModel( self.PlModel )
		self.Plat:SetPos( self.Entity:GetPos() )
		self.Plat.Controller = self.Entity
		self.Plat:Spawn()
		self.Plat:Initialize()
		self.Plat:Activate()
		self.PNoc = constraint.NoCollide(self.Entity,self.Plat,0,0)
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
		
	self.Entity:NextThink( CurTime() + 0.01 ) 
	return true
end

function ENT:PhysicsCollide( data, physobj )
	
end

function ENT:Touch( ent )
	
end