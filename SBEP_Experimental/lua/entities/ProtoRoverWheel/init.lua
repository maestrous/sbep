AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()

	self.Entity:SetModel( "models/Slyfo/rover_snowtire.mdl" ) 
	self.Entity:SetName("ProtoRoverWheel")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	--self.Inputs = Wire_CreateInputs( self.Entity, { "Fire" } )
	
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableGravity(true)
		phys:EnableDrag(false)
		phys:EnableCollisions(true)
		phys:SetMass( 1000 )
	end
	
	self.Entity:StartMotionController()
	
	self.PhysObj = self.Entity:GetPhysicsObject()
	
	self.TargetZ = 0
	self.ZVelocity = 50
	self.HSpeed = 30
	self.Hovering = false
	self.Turbo = 1
	self.StrafeSpeed = 0
	
	self.CFSpeed = 0
	self.CWTurn = 0

end

function ENT:PhysicsUpdate()

end

function ENT:Think()
	if self.Pod && self.Pod:IsValid() then
		local Side = 0
		local End = 0
		if self.OffPos.y < 0 then 
			Side = -1
		elseif self.OffPos.y > 0 then 
			Side = 1
		end
		if self.OffPos.x < 0 then 
			End = -1
		elseif self.OffPos.x > 0 then 
			End = 1
		end
		
		
		self.CPL = self.Pod:GetPassenger()
		--print(self.Pod, self.CPL)
		local HOffset = 0
		local DFSpeed = 0
		local DWTurn = 0
		if (self.CPL && self.CPL:IsValid()) then
			
			
			local TurnAmount = 35
						
			if (self.CPL:KeyDown( IN_MOVERIGHT )) then
				HOffset = 10 * Side
				
				if End > 0 then
					DWTurn = -TurnAmount
				end
				
			elseif (self.CPL:KeyDown( IN_MOVELEFT )) then
				HOffset = -10 * Side
				
				if End > 0 then
					DWTurn = TurnAmount
				end
			end
			
			if (self.CPL:KeyDown( IN_JUMP )) then
				self.Brakes = true
			else
				self.Brakes = false
			end
		else
			self.Brakes = true
		end
		
		
		self.CWTurn = math.Approach(self.CWTurn,DWTurn,5)
		
	
		local T={}
		T.start = self.Pod:LocalToWorld(self.OffPos)--w:GetPos()--Vector(0,0,0)
		T.endpos = self.Pod:LocalToWorld(self.OffPos + Vector(0,0,-55))--w:GetPos() + w:GetUp() * -30 --Vector(0,0,20)
		T.filter = self
		
		local tr = util.TraceLine( T )
		local Dist = math.Clamp(tr.Fraction * -55,-55,0)
		--print(Dist)
		self:SetLocalPos(self.OffPos + Vector(0,0,21 + Dist))
		self:SetLocalAngles(Angle(0,self.CWTurn,0))
		if tr.Hit then
			local HVPos = tr.HitPos + (tr.HitNormal * 100)
			if HVPos.z > tr.HitPos.z + 70 then --This controls the maximum incline the jets will function on.
				self.Hovering = true
				self.TargetZ = tr.HitPos.z + 25 + HOffset
				
				
				--print(self.CFSpeed)
				local physi = self.Pod:GetPhysicsObject()
				
				physi:ApplyForceCenter( self:GetForward() * (self.Drv.CFSpeed) )
				--print(self.Pod.CFSpeed)
				--PrintTable(self.Pod:GetTable())
				physi:ApplyForceOffset( self.Entity:GetRight(), self.Pod:GetPos() + self.Entity:GetForward() * 300 )
				--physi:SetVelocity( physi:GetVelocity() * 0.75 )
				physi:AddAngleVelocity(physi:GetAngleVelocity() * -0.75)
			end
		else
			self.Hovering = false
		end
	end
	
	self.Entity:NextThink( CurTime() + 0.01 ) 
	return true
end

function ENT:PhysicsCollide( data, physobj )
	
end

function ENT:OnTakeDamage( dmginfo )
	
end

function ENT:Use( activator, caller )

end

function ENT:PhysicsSimulate( phys, deltatime )

	--print("Simming")
	if !self.Hovering then return SIM_NOTHING end

	if ( self.ZVelocity != 0 ) then
	
		self.TargetZ = self.TargetZ + (self.ZVelocity * deltatime * self.HSpeed)
		self.Entity:GetPhysicsObject():Wake()
	
	end
	
	phys:Wake()
	
	local Pos = phys:GetPos()
	local Vel = phys:GetVelocity()
	local Distance = self.TargetZ - Pos.z
	
	if ( Distance == 0 ) then return end
	
	local Exponent = Distance^2
	
	if ( Distance < 0 ) then
		Exponent = Exponent * -1
	end
	
	Exponent = Exponent * deltatime * 300
	
	local physVel = phys:GetVelocity()
	local zVel = physVel.z
	
	Exponent = Exponent - ( zVel * deltatime * phys:GetMass() )
	// The higher you make this 300 the less it will flop about
	// I'm thinking it should actually be relative to any objects we're connected to
	// Since it seems to flop more and more the heavier the object
	
	Exponent = math.Clamp( Exponent, -5000, 5000 )
	
	
	local FBr = 0.004
	local LBr = 0.004
	
	local RVec = phys:GetVelocity()
	RVec:Rotate(self:GetAngles() * -1)
	
	local BVec = Vector(0,0,0)
	if self.Brakes then
		BVec = self:GetForward() * RVec.x * -FBr * phys:GetMass()
	end
		
	local FVec = (self:GetRight() * RVec.y * LBr * phys:GetMass()) + BVec
	
	--print(FVec)
	
	local Linear = Vector(0,0,0) + FVec
	local Angular = Vector(0,0,0)
	
	Linear.z = Exponent
	
	return Angular, Linear, SIM_GLOBAL_ACCELERATION
	
end
