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
	if !self.DT or !self.SBEPEnableWire then return end

	self.SBEPWireInputs = {}
	self.SBEPWireOutputs = {}
	
	for k,v in ipairs( self.DT ) do
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

function ENT:AddAnimDoors( animdata )	
	self.AnimData = animdata
	self.DT = {}
	for k,v in pairs( animdata ) do
		local D = ents.Create( "sbep_base_door" )
			D:Spawn()
			D:SetDoorType( v[1] )
			/*print(v[1])
			print(v[2])
			print(v[3])*/
			D:Attach( self.Entity , v[2] , v[3] )
		D:SetController( self.Entity , k )
		table.insert( self.DT , D )
	end
end

function ENT:Use( activator, caller )
	if !self.EnableUseKey or self.DisableUse then return end

	for k,v in pairs( self.DT ) do
		if !v.Locked then
			v.OpenTrigger = !v.OpenTrigger
		end
	end
end

function ENT:Think()
	local skin = self:GetSkin()
	if self:SkinCount() > 5 then
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
	
	for m,n in ipairs(self.DT) do
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

function ENT:PreEntityCopy()
	local dupeInfo = {}

	dupeInfo.AnimData 		= self.AnimData
	dupeInfo.SBEPEnableWire = self.SBEPEnableWire
	dupeInfo.EnableUseKey 	= self.EnableUseKey
	dupeInfo.DT = {}
	for m,n in ipairs(self.DT) do
		dupeInfo.DT[m] = n:EntIndex()
	end
	
	if WireAddon then
		dupeInfo.WireData = WireLib.BuildDupeInfo( self.Entity )
	end
	
	duplicator.StoreEntityModifier(self, "SBEPDC", dupeInfo)
end
duplicator.RegisterEntityModifier( "SBEPDC" , function() end)

function ENT:PostEntityPaste(pl, Ent, CreatedEntities)

	self.AnimData 		= Ent.EntityMods.SBEPDC.AnimData
	self.SBEPEnableWire = Ent.EntityMods.SBEPDC.SBEPEnableWire
	self.EnableUseKey 	= Ent.EntityMods.SBEPDC.EnableUseKey
	self.DT			= {}
	for k,v in ipairs( Ent.EntityMods.SBEPDC.DT ) do
		if v then
			self.DT[k] = CreatedEntities[v]
		end
	end
	self:MakeWire()
	
	if(Ent.EntityMods and Ent.EntityMods.SBEPDC.WireData) then
		WireLib.ApplyDupeInfo( pl, Ent, Ent.EntityMods.SBEPDC.WireData, function(id) return CreatedEntities[id] end)
	end

end