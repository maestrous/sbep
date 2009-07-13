AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" ) 

ENT.WireDebugName = "SBEP Door Controller"

function ENT:Initialize()	

		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
		
		local phys = self:GetPhysicsObject()  	
		if (phys:IsValid()) then  		
			phys:Wake()  	
		end
		
		self.WireOpen = {}

end

function ENT:MakeWire()
	if !self.AnimData or type( self.AnimData ) != "table" or self.SBEPWire == 0 then return end

		self.WireInputs = {}
		for i = 1, #self.AnimData do
			self.WireInputs[#self.WireInputs + 1] = "Open_"..tostring( i )
			self.WireInputs[#self.WireInputs + 1] = "Lock_"..tostring( i )
		end
		if self.EnableUseKey == 1 then
			self.WireInputs[#self.WireInputs + 1] = "Disable Use"
		end
	
		self.WireOutputs = {}
		for i = 1, #self.AnimData do
			self.WireOutputs[#self.WireOutputs + 1] = "Open_"..tostring( i )
			self.WireOutputs[#self.WireOutputs + 1] = "Locked_"..tostring( i )
		end

	self.Inputs = Wire_CreateInputs(self.Entity, self.WireInputs )
	self.Outputs = WireLib.CreateOutputs(self.Entity, self.WireOutputs)
end

function ENT:AddAnimDoors()
	if !self.AnimData then return end
	
	self.Door = {}
	for k,v in pairs( self.AnimData ) do
		self.Door[k] = ents.Create( "sbep_base_door" )
			self.Door[k]:Spawn()
			self.Door[k]:InitDoorData( v )

			self:SetAngles( Angle(0,0,0) )
			self.Door[k]:SetPos(self:GetPos() 		+ v[5] )
			self.Door[k]:SetAngles(self:GetAngles() + v[6] )
			
			constraint.Weld( self.Door[k], self, 0, 0, 0, true )
			
			self.Door[k]:SetSkin( self:GetSkin() )
			
			self.Door[k].OpenSounds 				= v[7]
			self.Door[k].CloseSounds 				= v[8]

			self.Door[k].Controller = self.Entity
			self.Door[k].SysDoorNum = k

			self.Door[k]:GetSequenceData()
			self.Door[k]:Close()

			self:DeleteOnRemove( self.Door[k] )
	end
end

function ENT:Use( activator, caller )

	if self.EnableUseKey == 0 or self.DisableUse then return end

		for k,v in pairs( self.Door ) do
			if v:GetSequence() == v.CloseSequence and not v.OpenStatus then

				v:Open()

			elseif v:GetSequence() == v.OpenSequence and v.OpenStatus then

				v:Close()
	
			end
		end
end

function ENT:Think()
	
	/*----------------
	for i = 1, #self.AnimData do
		if !self.Door[i] or !self.Door[i]:IsValid() then
			self:AddAnimDoors()
		end
	end
	-----------------*/
	
	self.Entity:NextThink( CurTime() + 0.05 )
	
	return true
end

function ENT:TriggerInput(k,v)
	
	for i = 1, #self.AnimData do
	
		if k == "Open_"..tostring(i) then
			self.WireOpen[i] = v
			if v > 0 then
				if not self.Door[i].Locked and not self.Door[i]:CheckDoorAnim() then
					self.Door[i]:Open()
				end
			else
				if not self.Door[i].Locked and self.Door[i]:CheckDoorAnim() then
					self.Door[i]:Close()
				end
			end
		end
		
		if (k == "Lock_"..tostring(i)) then
			if v > 0 then
				if self.Door[i]:CheckDoorAnim() then
					self.Door[i]:Close()
				end
				self.Door[i].Locked = true
				WireLib.TriggerOutput(self.Entity,"Locked_"..tostring(i),1)
			else		
				self.Door[i].Locked = false
				WireLib.TriggerOutput(self.Entity,"Locked_"..tostring(i),0)
				if self.WireOpen[i] > 0 then
					self.Door[i]:Open()
				end
			end
		end
		
		if k == "Disable Use" then
			if v > 0 then
				self.DisableUse = true
			else
				self.DisableUse = false
			end
		end
	end
end

function ENT:BuildDupeInfo()
	local info = self.BaseClass.BuildDupeInfo(self) or {}
	info.Door = {}
	info.AnimData 		= self.AnimData
	info.SBEPWire 		= self.SBEPWire
	//info.Skin 			= self.Skin
	info.EnableUseKey 	= self.EnableUseKey
	for i = 1, #self.Door do
		if (self.Door[i]) then
			info.Door[i] = self.Door[i]:EntIndex()
		end
	end
	return info
end

function ENT:ApplyDupeInfo(ply, ent, info, GetEntByID)
	self.BaseClass.ApplyDupeInfo(self, ply, ent, info, GetEntByID)
	self.AnimData 		= info.AnimData
	//self.Skin 			= info.Skin
	self.SBEPWire 		= info.SBEPWire
	self.EnableUseKey 	= info.EnableUseKey
	for i = 1, #info.Door do
		if (info.Door[i]) then
			GetEntByID(info.Door[i]):Remove()
		end
	end
	//self:SetSkin( self.Skin )
	self:AddAnimDoors()
	self:MakeWire()
end