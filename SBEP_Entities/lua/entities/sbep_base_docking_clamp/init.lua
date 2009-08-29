AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( SIMPLE_USE )
	self.Inputs = Wire_CreateInputs( self.Entity, { "Dock", "UndockDelay" } )
	self.Outputs = Wire_CreateOutputs( self.Entity, { "Status" })
	self.Entity:SetNWInt( "DMode", self.DMode )
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableGravity(false)
		phys:EnableDrag(true)
		phys:EnableCollisions(true)
	end
	self.Entity:StartMotionController()
	self.PhysObj = self.Entity:GetPhysicsObject()
	self.Entity:SetNetworkedEntity( "LinkLock", nil )
		
	self.LinkLock = nil
	self.UDD = false
end

function ENT:TriggerInput(iname, value)		
	if (iname == "Dock") then
		if (value > 0) then
			self.DMode = 2		
			self.Entity:EmitSound("Buttons.snd1")
		else
			self.Entity:EmitSound("Buttons.snd19")
			self.DMode = 1
			if self.LinkLock && self.LinkLock:IsValid() then
				if self.LinkLock.DMode == 3 || self.LinkLock.DMode == 4 then 
					self.LinkLock.DMode = 2
				end
				self.LinkLock.LinkLock = nil
				self.LinkLock:SetNetworkedEntity( "LinkLock", nil )
				self.Entity:SetNetworkedEntity( "LinkLock", nil )
			end
			self.LinkLock = nil
			if self.AWeld then
				if self.AWeld:IsValid() then
					self.AWeld:Remove()
				end
			end
		end
		
	elseif (iname == "UndockDelay") then
		if (value > 0) then
			self.UDD = true
		else
			self.UDD = false
		end
		
	end
end

function ENT:AddDockDoor( DoorData )

	self.Doors = self.Doors or {}
	local doortype, vecoff, angoff = unpack( DoorData )
	vecoff, angoff = vecoff or Vector(0,0,0), angoff or Angle(0,0,0)

	local door = ents.Create( "sbep_base_door" )
	
	door:Spawn()
	door:SetDoorType( doortype )
	door:Attach( self.Entity , vecoff , angoff )
		
	table.insert( self.Doors , door )

end

function ENT:Think()
	if self.Doors then
		if self.DMode == 4 then
			for m,n in ipairs( self.Doors ) do
				n.OpenTrigger = true
			end
		else
			for m,n in ipairs( self.Doors ) do
				n.OpenTrigger = false
			end
		end
	end
	if self.DMode == 2 then
	
		--local mn, mx = self.Entity:WorldSpaceAABB()
		--mn = mn - Vector(20, 20, 20)
		--mx = mx + Vector(20, 20, 20)
		--local T = ents.FindInBox(mn, mx)
		local T = ents.FindInSphere( self.Entity:GetPos(), self.ScanDist)
		
		for _,i in pairs( T ) do
			if( i.Entity && i.Entity:IsValid() && i.Entity != self.Entity && i.IsAirLock && i.DMode == 2) then
				local RollMatch = false
				local PitchMatch = false
				local YawMatch = false
				local TypeMatch = false
			
				for k,e in pairs( self.CompatibleLocks ) do
					if i.ALType == e.Type then
						TypeMatch = true
						
						self.APitch		= e.APitch or 0
						self.AYaw		= e.AYaw or 0
						self.ARoll		= e.ARoll or 0
						self.AF			= e.AF or 0
						self.AR			= e.AR or 0
						self.AU			= e.AU or 0
						self.MF			= e.MF or 700
						self.MR			= e.MR or 700
						self.MU			= e.MU or 700
						self.MPitch		= e.MPitch or 10
						self.MYaw		= e.MYaw or 10
						self.MRoll		= e.MRoll or 10
						self.MDist		= e.MDist or 35
						self.RPitch		= e.RPitch or 0
						self.RYaw		= e.RYaw or 0
						self.RRoll		= e.RRoll or 0
						
						self.CType = k
						
						break
					end
				end
							
				if self.RRoll > 0 then
					for n = 0, 360, self.RRoll do
						if math.AngleDifference(math.fmod((i.Entity:GetAngles().r + self.ARoll + n), 360),self.Entity:GetAngles().r) <= self.MRoll * 3 && math.AngleDifference(math.fmod((i.Entity:GetAngles().r + self.ARoll + n), 360),self.Entity:GetAngles().r) >= self.MRoll * -3 then
							RollMatch = true
							self.CRoll = n
							break
						end
					end
				else
					if math.AngleDifference(math.fmod((i.Entity:GetAngles().r + self.ARoll), 360),self.Entity:GetAngles().r) <= self.MRoll * 3 && math.AngleDifference(math.fmod((i.Entity:GetAngles().r + self.ARoll), 360),self.Entity:GetAngles().r) >= self.MRoll * -3 then
						RollMatch = true
					end
				end
				
				if self.RPitch > 0 then
					for n = 0, 360, self.RPitch do
						if math.AngleDifference(math.fmod((i.Entity:GetAngles().p + self.APitch + n), 360),self.Entity:GetAngles().p) <= self.MPitch * 3 && math.AngleDifference(math.fmod((i.Entity:GetAngles().p + self.APitch + n), 360),self.Entity:GetAngles().p) >= self.MPitch * -3 then
							PitchMatch = true
							self.CPitch = n
							break
						end
					end
				else
					if math.AngleDifference(math.fmod((i.Entity:GetAngles().p + self.APitch), 360),self.Entity:GetAngles().p) <= self.MPitch * 3 && math.AngleDifference(math.fmod((i.Entity:GetAngles().p + self.APitch), 360),self.Entity:GetAngles().p) >= self.MPitch * -3 then
						PitchMatch = true
					end
				end
				
				if self.RYaw > 0 then
					for n = 0, 360, self.RYaw do
						if math.AngleDifference(math.fmod((i.Entity:GetAngles().y + self.AYaw + n), 360),self.Entity:GetAngles().y) <= self.MYaw * 3 && math.AngleDifference(math.fmod((i.Entity:GetAngles().y + self.AYaw + n), 360),self.Entity:GetAngles().y) >= self.MYaw * -3 then
							YawMatch = true
							self.CYaw = n
							break
						end
					end
				else
					if math.AngleDifference(math.fmod((i.Entity:GetAngles().y + self.AYaw), 360),self.Entity:GetAngles().y) <= self.MYaw * 3 && math.AngleDifference(math.fmod((i.Entity:GetAngles().y + self.AYaw), 360),self.Entity:GetAngles().y) >= self.MYaw * -3 then
						YawMatch = true
					end
				end
								
				if YawMatch && PitchMatch && RollMatch then
					self.LinkLock = i
					i.LinkLock = self.Entity
					self.Entity:SetNetworkedEntity( "LinkLock", self.LinkLock )
					self.LinkLock:SetNetworkedEntity( "LinkLock", self.Entity )
					self.DMode = 3
					i.CPitch = -self.CPitch
					i.CRoll = -self.CRoll
					i.CYaw = -self.CYaw
					i.DMode = 3
					i:TypeSet( self.ALType )
					self.Entity:EmitSound("Building_Teleporter.Send")
					return
				end
			end
		end
	end
	
	if self.DMode == 3 && self.LinkLock && self.LinkLock:IsValid() && self.LinkLock:GetPhysicsObject():IsMoveable() then
		local RollMatch = false
		local PitchMatch = false
		local YawMatch = false
		
		--print("Entity Found")
		if math.AngleDifference(math.fmod((self.LinkLock:GetAngles().r + self.ARoll + self.CRoll), 360),self.Entity:GetAngles().r) <= self.MRoll * 1 && math.AngleDifference(math.fmod((self.LinkLock:GetAngles().r + self.ARoll + self.CRoll), 360),self.Entity:GetAngles().r) >= self.MRoll * -1 then
			--print("Roll Match")
			if math.AngleDifference(math.fmod((self.LinkLock:GetAngles().p + self.APitch + self.CPitch), 360),self.Entity:GetAngles().p) <= self.MPitch * 1 && math.AngleDifference(math.fmod((self.LinkLock:GetAngles().p + self.APitch + self.CPitch), 360),self.Entity:GetAngles().p) >= self.MPitch * -1 then
				--print("Pitch Match")
				if math.AngleDifference(math.fmod((self.LinkLock:GetAngles().y + self.AYaw + self.CYaw), 360),self.Entity:GetAngles().y) <= self.MYaw * 1 && math.AngleDifference(math.fmod((self.LinkLock:GetAngles().y + self.AYaw + self.CYaw), 360),self.Entity:GetAngles().y) >= self.MYaw * -1 then
					--print("Yaw Match")
					if (self.Entity:GetPos() + (self.Entity:GetForward() * self.AF) + (self.Entity:GetRight() * self.AR) + (self.Entity:GetUp() * self.AU)):Distance(self.LinkLock:GetPos() + (self.LinkLock:GetForward() * self.LinkLock.AF) + (self.LinkLock:GetRight() * self.LinkLock.AR) + (self.LinkLock:GetUp() * self.LinkLock.AU)) <= self.MDist then
						self.LinkLock.Entity:SetAngles(self.Entity:LocalToWorldAngles(Angle(math.fmod(self.LinkLock.APitch - self.CPitch, 360),math.fmod(self.LinkLock.AYaw - self.CYaw, 360),math.fmod(self.LinkLock.ARoll - self.CRoll, 360))))
						self.LinkLock.Entity:SetPos( self.Entity:GetPos() + (self.Entity:GetForward() * self.AF) + (self.Entity:GetRight() * self.AR) + (self.Entity:GetUp() * self.AU ) + (self.LinkLock:GetForward() * -self.LinkLock.AF) + (self.LinkLock:GetRight() * -self.LinkLock.AR) + (self.LinkLock:GetUp() * -self.LinkLock.AU) )
						self.AWeld = constraint.Weld(self.LinkLock.Entity, self.Entity, 0, 0, 0, true)
						self.LinkLock.AWeld = self.AWeld
						self.DMode = 4
						self.LinkLock.DMode = 4
						self.Entity:EmitSound("Building_Teleporter.Ready")
					end
				end
			end
		end
	end
	
	if self.DMode == 3 then
		if self.LinkLock && self.LinkLock:IsValid() then
			local Physy = self.Entity:GetPhysicsObject()
			
			Physy:Wake()		
			
			local Pos = self.Entity:GetPos()
			local Pos2 = self.LinkLock:GetPos()
			local Vel = Physy:GetVelocity()
			
			local Distance = self.LinkLock:GetPos():Distance(self.Entity:GetPos())
			
			if Distance > self.ScanDist then 
				self.LinkLock.DMode = 2
				self.LinkLock.LinkLock = nil
				self.LinkLock:SetNetworkedEntity( "LinkLock", nil )
				self.Entity:SetNetworkedEntity( "LinkLock", nil )
				self.LinkLock = nil
				self.DMode = 2
				self.Entity:EmitSound("Building_Teleporter.Receive")
				return
			end
			
			if self.LinkLock.DMode != 3 then
				self.Entity:SetNetworkedEntity( "LinkLock", nil )
				self.LinkLock = nil
				self.DMode = 2
				self.Entity:EmitSound("Building_Teleporter.Receive")
				return
			end
			
			TVec = (self.LinkLock:GetPos() + self.LinkLock:GetForward() * self.LinkLock.AF + self.LinkLock:GetRight() * self.LinkLock.AR + self.LinkLock:GetUp() * self.LinkLock.AU ) - (self:GetPos() + self:GetForward() * self.AF + self:GetRight() * self.AR + self:GetUp() * self.AU )
			
			--OVec = Vel * -1
			
			--MVec = OVec + TVec
			
			local Linear = TVec:GetNormal() * math.Clamp(Distance * 10, 0, 100)
			
			
			Physy:SetVelocity( Linear )
			
			local Roll = math.AngleDifference(self.LinkLock:GetAngles().r, math.fmod(self.Entity:GetAngles().r + self.ARoll - self.CRoll,360))
			local Pitch = math.AngleDifference(self.LinkLock:GetAngles().p, math.fmod(self.Entity:GetAngles().p + self.APitch - self.CPitch,360))
			local Yaw = math.AngleDifference(self.LinkLock:GetAngles().y, math.fmod(self.Entity:GetAngles().y + self.AYaw - self.CYaw,360))
			
			Physy:AddAngleVelocity((Physy:GetAngleVelocity() * -1) + Angle(Roll,Pitch,Yaw))
		else
			self.Entity:EmitSound("Building_Teleporter.Receive")
			self.DMode = 2
		end
	end
	
	Wire_TriggerOutput( self.Entity, "Status", self.DMode )
	if self.ClDMode != self.DMode then
		self.Entity:SetNWInt( "DMode", self.DMode )
		self.ClDMode = self.DMode
		--print("Changing DMode to "..self.DMode)
	end
end

function ENT:PhysicsCollide( data, physobj )

end

function ENT:OnTakeDamage( dmginfo )
	
end

function ENT:Touch( ent )

end

function ENT:OnRemove()

end

function ENT:Use( activator, caller )
	if (self.DMode < 2) then
		self.DMode = 2		
		self.Entity:EmitSound("Buttons.snd1")
	else
		self.Entity:EmitSound("Buttons.snd19")
		self.DMode = 1
		if self.LinkLock && self.LinkLock:IsValid() then
			if self.LinkLock.DMode == 3 || self.LinkLock.DMode == 4 then 
				self.LinkLock.DMode = 2
			end
			self.LinkLock.LinkLock = nil
			self.LinkLock:SetNetworkedEntity( "LinkLock", nil )
			self.Entity:SetNetworkedEntity( "LinkLock", nil )
		end
		self.LinkLock = nil
		if self.AWeld then
			if self.AWeld:IsValid() then
				self.AWeld:Remove()
			end
		end
	end
end

function ENT:TypeSet( Type )
	for k,e in pairs( self.CompatibleLocks ) do
		if e.Type == Type then
			TypeMatch = true
			
			self.APitch		= e.APitch or 0
			self.AYaw		= e.AYaw or 0
			self.ARoll		= e.ARoll or 0
			self.AF			= e.AF or 0
			self.AR			= e.AR or 0
			self.AU			= e.AU or 0
			self.MF			= e.MF or 700
			self.MR			= e.MR or 700
			self.MU			= e.MU or 700
			self.MPitch		= e.MPitch or 10
			self.MYaw		= e.MYaw or 10
			self.MRoll		= e.MRoll or 10
			self.MDist		= e.MDist or 35
			self.RPitch		= e.RPitch or 0
			self.RYaw		= e.RYaw or 0
			self.RRoll		= e.RRoll or 0
			
			self.CType = k
			
			break
		end
	end
end

function ENT:PreEntityCopy()
	local dupeInfo = {}
	
	if WireAddon then
		dupeInfo.WireData = WireLib.BuildDupeInfo( self.Entity )
	end
	
	duplicator.StoreEntityModifier(self, "SBEPDockingClampDupeInfo", dupeInfo)
end
duplicator.RegisterEntityModifier( "SBEPDockingClampDupeInfo" , function() end)

function ENT:PostEntityPaste(pl, Ent, CreatedEntities)

	if(Ent.EntityMods and Ent.EntityMods.SBEPDockingClampDupeInfo.WireData) then
		WireLib.ApplyDupeInfo( pl, Ent, Ent.EntityMods.SBEPDockingClampDupeInfo.WireData, function(id) return CreatedEntities[id] end)
	end

end