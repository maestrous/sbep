AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

--util.PrecacheSound( "SB/SteamEngine.wav" )

function ENT:Initialize()
	
	self.Entity:SetModel( "models/Slyfo/rover_winchhookclosed.mdl" ) 
	self.Entity:SetName( "GrapplingHook" )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )

	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableGravity(true)
		phys:EnableDrag(true)
		phys:EnableCollisions(false)
		phys:SetMass(5)
	end
	self.Entity:StartMotionController()
	self.PhysObj = self.Entity:GetPhysicsObject()


	self.ATime = 0
	
	
end

function ENT:Think()
	if (self.Active && !self.Impact) then
				
		local physi = self.Entity:GetPhysicsObject()
		physi:SetVelocity(self.Entity:GetForward() * 5000)
		--physi:EnableGravity(false)
		
		if CurTime() >= self.ATime then
			local trace = {}
			trace.start = self.Entity:GetPos()
			trace.endpos = self.Entity:GetPos() + self.Entity:GetForward() * 100
			trace.filter = self.Entity
			local tr = util.TraceLine( trace )
			if tr.HitNonWorld && tr.Entity && tr.Entity:IsValid() then
				self.Entity:SetModel("models/Slyfo/rover_winchhookopen.mdl")
				self.Impact = true
				self.ITime = CurTime()
				self.Active = false
				self.Entity:SetPos(tr.HitPos + self.Entity:GetForward() * 10)
				local Weld = constraint.Weld(self.Entity, tr.Entity, 0, 0, 0, true)
				if self.ParL && self.ParL:IsValid() then
					local Vec = tr.Entity:WorldToLocal(self.Entity:GetPos() + (self.Entity:GetForward() * -16)) -- 
					self.ParL:Latch( self.Entity, Vec, tr.Entity )
				end
				local effectdata = EffectData()
				effectdata:SetOrigin( self.Entity:GetPos() )
				effectdata:SetStart( self.Entity:GetPos() )
				effectdata:SetAngle( self.Entity:GetAngles() )
				effectdata:SetNormal( self.Entity:GetForward() )
				util.Effect( "HookImpact", effectdata )
				self.Entity:EmitSound("Metal_Barrel.BulletImpact")
			elseif tr.HitWorld then
				local effectdata = EffectData()
				effectdata:SetOrigin( self.Entity:GetPos() )
				effectdata:SetStart( self.Entity:GetPos() )
				effectdata:SetAngle( self.Entity:GetAngles() )
				effectdata:SetNormal( self.Entity:GetForward() )
				util.Effect( "HookImpact", effectdata )
				self.Entity:EmitSound("Metal_Barrel.BulletImpact")
				self.Entity:Remove()
			end
		end
	end
	
	if self.Impact then
		if self.ParL && self.ParL:IsValid() then
			if self.ParL.Disengaging then
				if self.Rope && self.Rope:IsValid() then
					self.Rope:Remove()
				end
				if self.Elastic && self.Elastic:IsValid() then
					self.Elastic:Remove()
				end
				self:Fire("kill", "", 5 + math.random() * 5)
			end
			if self.Rope && self.Rope:IsValid() then
				if self.ITime < self.ParL.LChange then
					if self.CLength - self.ParL.DLength < self.ParL.ReelRate && self.CLength - self.ParL.DLength > -self.ParL.ReelRate then
						self.CLength = self.ParL.DLength
					end
					if self.CLength > self.ParL.DLength then
						self.CLength = self.CLength - self.ParL.ReelRate
					elseif self.CLength < self.ParL.DLength then
						self.CLength = self.CLength + self.ParL.ReelRate
					end
					self.Elastic:Fire("SetSpringLength",self.CLength,0)
					self.Rope:Fire("SetLength",self.CLength,0)
				end
			end
		else
			self:Fire("kill", "", 5 + math.random() * 5)
		end
	end

	self.Entity:NextThink( CurTime() + 0.01 ) 
	return true
end

--function ENT:SetActive()
--	self.Active = true
--	self.ATime = CurTime() + 0.5
--	self.Entity:GetPhysicsObject():Wake()
--	self.Entity:GetPhysicsObject():EnableMotion( true )
--end

function ENT:PhysicsCollide( data, physobj )

end

function ENT:OnRemove()
	if self.Rope && self.Rope:IsValid() then
		self.Rope:Remove()
	end
	if self.Elastic && self.Elastic:IsValid() then
		self.Elastic:Remove()
	end
end

function ENT:OnTakeDamage( dmginfo )
	
end

function ENT:Touch( ent )

end