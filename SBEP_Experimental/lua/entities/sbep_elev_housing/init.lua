AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" ) 

ENT.WireDebugName = "SBEP Elevator Housing"

function ENT:Initialize()
	
	self.PD = {} --Part Data
	self.PD.HO = 0

	self:PhysicsInitialize()

end

function ENT:PhysicsInitialize()

	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
		
	local phys = self:GetPhysicsObject()  	
	if ValidEntity(phys) then
		phys:EnableMotion( false )
		phys:Wake() 
	end

end

function ENT:MakeWire()
	
	if self.PD.MultiFloor then
		self.Inputs = Wire_CreateInputs(self.Entity, self.PD.SBEPLiftWireInputs )
	elseif !self.PD.IsShaft then
		self.Inputs = Wire_CreateInputs(self.Entity, { "Call" })
	end
	--self.Outputs = WireLib.CreateOutputs(self.Entity,{""})
end

function ENT:TriggerInput(k,v)
	
	if self.PD.SBEPLiftWireInputs then
		for m,n in ipairs( self.PD.SBEPLiftWireInputs ) do
			if k == n && v == 1 then
				self.Controller:SetCallFloorNum( self.PD.FN[m] )
			end
		end
	else
		if k == "Call" && v == 1 then
			self.Controller:SetCallFloorNum( self.PD.FN )
		end
	end

end

function ENT:UpdatePartData( DT , cont , n )

	local P = self
	
	P.PD.LT  = DT.LT --Lift Type
	P.PD.ZUD = DT.ZUD --Z Up Distance
	P.PD.ZDD = DT.ZDD --Z Down Distance
	P.PD.AT  = table.Copy( DT.AT ) --Access Table
	P.PD.LTC = string.Left( P.PD.LT , 1) --Lift Type Class
	
	P.PD.IsShaft = P.PD.LTC == "S"
	P.PD.IsVisor = P.PD.LTC == "V"
	P.PD.IsHub   = P.PD.LTC == "H"
	P.PD.IsDH    = string.Right( P.PD.LT , 2) == "dh"
	P.PD.Inv     = P.PD.Roll ~= 0
	P.PD.Usable  = cont.Usable && !P.PD.IsShaft
	
	if DT.MFT then
		P.PD.IsMultiFloor = true
		P.PD.FO = DT.MFT --Floor Offsets Table
		P.PD.SBEPLiftWireInputs = {}
		for k,v in ipairs( P.PD.FO ) do
			P.PD.SBEPLiftWireInputs[k] = "Call "..tostring( k )
		end
	else
		P.PD.IsMultiFloor = false
	end

	--Setting up the part height offset values--
	if n > 1 then
		P.PD.HO = cont.PT[n - 1].PD.HO
		if cont.PT[n - 1].PD.Inv then
			P.PD.HO = P.PD.HO + cont.PT[n - 1].PD.ZDD
		else
			P.PD.HO = P.PD.HO + cont.PT[n - 1].PD.ZUD
		end
		if P.PD.Inv then
			P.PD.HO = P.PD.HO + P.PD.ZUD
		else
			P.PD.HO = P.PD.HO + P.PD.ZDD
		end
	else
		P.PD.HO = 0
		if P.PD.Inv && P.PD.IsDH then
			P.PD.HO = 130.2
		end
	end
end

function ENT:RefreshPart( PartNum )

	local n = tonumber( PartNum )
	local P = self.PT[ n ]
	
	local DT = LMT[self.Size[1]][ P.PD.model ]
	P.PD.model = "models/SmallBridge/Elevators,"..self.Size[3].."/sb"..self.Size[2].."elev"..string.sub( P.PD.model , 43 )
	
	P:SetModel( P.PD.model )
	
	CheckSkin( self.Entity , P , self.Skin )
	
	self.ST.PC = #self.PT
	
	P:UpdatePartData( DT , cont )
	
	P:SetPos( self.StartPos + Vector(0,0, P.PD.HO ) )
	P:SetAngles( Angle( 0 , P.PD.Yaw , P.PD.Roll ) )

	for k,v in ipairs( self.PT ) do		
		if k > n then
			self:RefreshPart( k )
		end
	end
	
	return P

end

function ENT:Use()

	if !self.PD.MultiFloor && self.PD.Usable && self.Controller && self.Controller:IsValid() then
		self.Controller:AddCallFloorNum( self.PD.FN )
	end

end

function ENT:PreEntityCopy()
	local dupeInfo = {}
	
	if WireAddon then
		dupeInfo.WireData = WireLib.BuildDupeInfo( self.Entity )
	end
	
	duplicator.StoreEntityModifier(self, "SBEPElevHousingDupeInfo", dupeInfo)
end
duplicator.RegisterEntityModifier( "SBEPElevHousingDupeInfo" , function() end)

function ENT:PostEntityPaste(pl, Ent, CreatedEntities)

	if(Ent.EntityMods && Ent.EntityMods.SBEPElevHousingDupeInfo.WireData) then
		WireLib.ApplyDupeInfo( pl, Ent, Ent.EntityMods.SBEPElevHousingDupeInfo.WireData, function(id) return CreatedEntities[id] end)
	end

end