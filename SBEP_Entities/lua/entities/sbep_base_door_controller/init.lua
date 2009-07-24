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
			phys:EnableMotion( false )
		end

	self.SpawnTime = CurTime()
	
end

function ENT:MakeWire( adjust )
	if !self.Door or !self.SBEPEnableWire then return end

	self.SBEPWireInputs = {}
	self.SBEPWireOutputs = {}
	
	for k,v in ipairs( self.Door ) do
		table.insert(self.SBEPWireInputs , "Open_"..tostring( k ) )
		table.insert(self.SBEPWireInputs , "Lock_"..tostring( k ) )
		
		table.insert(self.SBEPWireOutputs , "Open_"..tostring( k ) )
		table.insert(self.SBEPWireOutputs , "Locked_"..tostring( k ) )
	end

	if self.EnableUseKey then
		table.insert(self.SBEPWireInputs , "Disable Use" )
	end

	if adjust then
		Wire_AdjustInputs(self.Entity, self.SBEPWireInputs )
		Wire_AdjustOutputs(self.Entity, self.SBEPWireOutputs)
	else
		self.Inputs = Wire_CreateInputs(self.Entity, self.SBEPWireInputs )
		self.Outputs = Wire_CreateOutputs(self.Entity, self.SBEPWireOutputs)
	end
end

function ENT:AddAnimDoors()
	if !self.AnimData then return end
	
	self.Door = {}
	for k,v in pairs( self.AnimData ) do
		self.Door[k] = ents.Create( "sbep_base_door" )

			self.Door[k]:Spawn()
			self.Door[k]:SetDoorType( v[1] )

			if v[2] then
				self.Door[k]:SetPos( self:GetPos() + v[2] )
			else
				self.Door[k]:SetPos( self:GetPos() )
			end
			if v[3] then
				self.Door[k]:SetAngles( self:GetAngles() + v[3] )
			else
				self.Door[k]:SetAngles( self:GetAngles() )
			end
			
			constraint.Weld( self.Door[k], self, 0, 0, 0, true )
			
			self.Door[k]:SetSkin( self:GetSkin() )

			self.Door[k].Controller = self.Entity
			self.Door[k].SysDoorNum = k

			self.Door[k].OpenTrigger = false
			
			self.Door[k]:GetPhysicsObject():EnableMotion( true )

			self:DeleteOnRemove( self.Door[k] )
	end
end

function ENT:Use( activator, caller )

	if !self.EnableUseKey or self.DisableUse then return end

	for k,v in pairs( self.Door ) do
		if !v.Locked then
			v.OpenTrigger = !v.OpenTrigger
		end
	end
end

function ENT:Think()

	
	local skin = self:GetSkin()
	local skincount = self:SkinCount()
	if skincount > 5 then
		self.Skin = math.floor( skin / 2 )
	else
		self.Skin = skin
	end

	self.Entity:NextThink( CurTime() + 1 )
	
	return true

end

function ENT:TriggerInput(k,v)
	
	if k == "Disable Use" then
		if v > 0 then
			self.DisableUse = true
		else
			self.DisableUse = false
		end
	end
	
	for m,n in ipairs(self.Door) do
		if (k == "Lock_"..tostring(m)) then
			if v > 0 then
				n.OpenTrigger = false
				n.Locked = true
				WireLib.TriggerOutput(self.Entity,"Locked_"..tostring(m),1)
			else		
				n.Locked = false
				WireLib.TriggerOutput(self.Entity,"Locked_"..tostring(m),0)
			end
		end
		
		if k == "Open_"..tostring(m) then
			if !n.Locked then
				if v > 0 then
					n.OpenTrigger = true
				else
					n.OpenTrigger = false
				end
			end
		end
	end
end

function ENT:BuildDupeInfo()
	local info = self.BaseClass.BuildDupeInfo(self) or {}
	info.Door = {}
	info.AnimData 		= self.AnimData
	info.SBEPEnableWire = self.SBEPEnableWire
	info.EnableUseKey 	= self.EnableUseKey
	for m,n in ipairs(self.Door) do
		if ValidEntity(n) then
			info.Door[i] = n:EntIndex()
		end
	end
	return info
end

function ENT:ApplyDupeInfo(ply, ent, info, GetEntByID)
	self.BaseClass.ApplyDupeInfo(self, ply, ent, info, GetEntByID)
	self.AnimData 		= info.AnimData
	self.SBEPEnableWire = info.SBEPEnableWire
	self.EnableUseKey 	= info.EnableUseKey
	for i = 1, #info.Door do
		if (info.Door[i]) then
			GetEntByID(info.Door[i]):Remove()
		end
	end
	self:AddAnimDoors()
	self:MakeWire()
end