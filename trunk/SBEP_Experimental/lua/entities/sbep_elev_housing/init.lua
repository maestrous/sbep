AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" ) 

local LMT = {}
LMT.S = {
		[ "B" 	 ] = { model = "models/SmallBridge/Elevators,Small/sbselevb.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,1,0,0} } ,
		[ "BE" 	 ] = { model = "models/SmallBridge/Elevators,Small/sbselevbe.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,1,0,1} } ,
		[ "BEdh" ] = { model = "models/SmallBridge/Elevators,Small/sbselevbedh.mdl" , ZUD = 195.3 	, ZDD =  65.1 	, AT = {0,1,0,1} , IsDH = true } ,
		[ "BEdw" ] = { model = "models/SmallBridge/Elevators,Small/sbselevbedw.mdl" , ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,1,0,1} } ,
		[ "BR" 	 ] = { model = "models/SmallBridge/Elevators,Small/sbselevbr.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,0,0} } ,
		[ "BT" 	 ] = { model = "models/SmallBridge/Elevators,Small/sbselevbt.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,1,0} } ,
		[ "BX" 	 ] = { model = "models/SmallBridge/Elevators,Small/sbselevbx.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,1,1} } ,

		[ "M" 	 ] = { model = "models/SmallBridge/Elevators,Small/sbselevm.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,1,0,0} } ,
		[ "ME" 	 ] = { model = "models/SmallBridge/Elevators,Small/sbselevme.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,1,0,1} } ,
		[ "MEdh" ] = { model = "models/SmallBridge/Elevators,Small/sbselevmedh.mdl" , ZUD = 195.3 	, ZDD =  65.1 	, AT = {0,1,0,1} , IsDH = true } ,
		[ "MEdw" ] = { model = "models/SmallBridge/Elevators,Small/sbselevmedw.mdl" , ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,1,0,1} } ,
		[ "MR" 	 ] = { model = "models/SmallBridge/Elevators,Small/sbselevmr.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,0,0} } ,
		[ "MT" 	 ] = { model = "models/SmallBridge/Elevators,Small/sbselevmt.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,1,0} } ,
		[ "MX" 	 ] = { model = "models/SmallBridge/Elevators,Small/sbselevmx.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,1,1} } ,

		[ "T" 	 ] = { model = "models/SmallBridge/Elevators,Small/sbselevt.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,1,0,0} } ,
		[ "TE" 	 ] = { model = "models/SmallBridge/Elevators,Small/sbselevte.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,1,0,1} } ,
		[ "TEdh" ] = { model = "models/SmallBridge/Elevators,Small/sbselevtedh.mdl" , ZUD = 195.3 	, ZDD =  65.1 	, AT = {0,1,0,1} , IsDH = true } ,
		[ "TEdw" ] = { model = "models/SmallBridge/Elevators,Small/sbselevtedw.mdl" , ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,1,0,1} } ,
		[ "TR" 	 ] = { model = "models/SmallBridge/Elevators,Small/sbselevtr.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,0,0} } ,
		[ "TT" 	 ] = { model = "models/SmallBridge/Elevators,Small/sbselevtt.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,1,0} } ,
		[ "TX" 	 ] = { model = "models/SmallBridge/Elevators,Small/sbselevtx.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,1,1} } ,

		[ "S" 	 ] = { model = "models/SmallBridge/Elevators,Small/sbselevs.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,0,0,0} , IsShaft = true } ,
		[ "S2" 	 ] = { model = "models/SmallBridge/Elevators,Small/sbselevs2.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,0,0,0} , IsShaft = true } ,

		[ "BV" 	 ] = { model = "models/SmallBridge/Station Parts/sbbridgevisorb.mdl", ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,0,0,0} , IsVisor = true , IsSpecial = true } ,
		[ "MV" 	 ] = { model = "models/SmallBridge/Station Parts/sbbridgevisorm.mdl", ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,0,0,0} , IsVisor = true , IsSpecial = true } ,
		[ "TV" 	 ] = { model = "models/SmallBridge/Station Parts/sbbridgevisort.mdl", ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,0,0,0} , IsVisor = true , IsSpecial = true } ,

		[ "H" 	 ] = { model = "models/SmallBridge/Station Parts/sbhuble.mdl" 		, ZUD = 195.3 	, ZDD = 195.3 	, AT = {0,0,0,0} , IsHub = true , IsSpecial = true , FO = { 0 , 130.2 , 260.4 } }
			}

LMT.L = {
		[ "B" 	 ] = { model = "models/SmallBridge/Elevators,Large/sblelevb.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,0,0,1} } ,
		[ "BE" 	 ] = { model = "models/SmallBridge/Elevators,Large/sblelevbe.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,1,0,1} } ,
		[ "BEdh" ] = { model = "models/SmallBridge/Elevators,Large/sblelevbedh.mdl" , ZUD = 195.3 	, ZDD =  65.1 	, AT = {0,1,0,1} , IsDH = true } ,
		[ "BR" 	 ] = { model = "models/SmallBridge/Elevators,Large/sblelevbr.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,0,0} } ,
		[ "BT" 	 ] = { model = "models/SmallBridge/Elevators,Large/sblelevbt.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,1,0} } ,
		[ "BX" 	 ] = { model = "models/SmallBridge/Elevators,Large/sblelevbx.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,1,1} } ,

		[ "M" 	 ] = { model = "models/SmallBridge/Elevators,Large/sblelevm.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,0,0,1} } ,
		[ "ME" 	 ] = { model = "models/SmallBridge/Elevators,Large/sblelevme.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,1,0,1} } ,
		[ "MEdh" ] = { model = "models/SmallBridge/Elevators,Large/sblelevmedh.mdl" , ZUD = 195.3 	, ZDD =  65.1 	, AT = {0,1,0,1} , IsDH = true } ,
		[ "MR" 	 ] = { model = "models/SmallBridge/Elevators,Large/sblelevmr.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,0,0} } ,
		[ "MT" 	 ] = { model = "models/SmallBridge/Elevators,Large/sblelevmt.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,1,0} } ,
		[ "MX" 	 ] = { model = "models/SmallBridge/Elevators,Large/sblelevmx.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,1,1} } ,

		[ "T" 	 ] = { model = "models/SmallBridge/Elevators,Large/sblelevt.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,0,0,1} } ,
		[ "TE" 	 ] = { model = "models/SmallBridge/Elevators,Large/sblelevte.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,1,0,1} } ,
		[ "TEdh" ] = { model = "models/SmallBridge/Elevators,Large/sblelevtedh.mdl" , ZUD = 195.3 	, ZDD =  65.1 	, AT = {0,1,0,1} , IsDH = true } ,
		[ "TR" 	 ] = { model = "models/SmallBridge/Elevators,Large/sblelevtr.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,0,0} } ,
		[ "TT" 	 ] = { model = "models/SmallBridge/Elevators,Large/sblelevtt.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,1,0} } ,
		[ "TX" 	 ] = { model = "models/SmallBridge/Elevators,Large/sblelevtx.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,1,1} } ,

		[ "S" 	 ] = { model = "models/SmallBridge/Elevators,Large/sblelevs.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,0,0,0} , IsShaft = true } ,
		[ "S2" 	 ] = { model = "models/SmallBridge/Elevators,Large/sblelevs2.mdl" 	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,0,0,0} , IsShaft = true } ,
			}

ENT.WireDebugName = "SBEP Elevator Housing"

function ENT:Initialize()
	
	self.PD 		= {} --Part Data
	self.PD.HO		= 0
	self.PD.Yaw		= 0
	self.PD.Roll	= 0

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

	local wire = {}
	if self.PD.IsMultiFloor then
		self.PD.SBEPLiftWireInputs = {}
		for k,v in ipairs( self.PD.FO ) do
			self.PD.SBEPLiftWireInputs[k] = "Call "..tostring( k )
		end
		wire = self.PD.SBEPLiftWireInputs
	elseif !self.PD.IsShaft then
		wire = { "Call" }
	end
	self.Inputs = Wire_CreateInputs(self.Entity, wire )
	--self.Outputs = WireLib.CreateOutputs(self.Entity,{""})
end

function ENT:TriggerInput(k,v)
	
	if self.PD.SBEPLiftWireInputs then
		for m,n in ipairs( self.PD.SBEPLiftWireInputs ) do
			if k == n && v == 1 then
				self.Cont:AddCallFloorNum( self.PD.FN[m] )
			end
		end
	elseif k == "Call" && v == 1 then
		self.Cont:AddCallFloorNum( self.PD.FN )
	end

end

function ENT:SetPartType( type )

	if self.PD.T == type then return end

	local data = LMT[ self.Cont.Size[1] ][ type ]
	if !data then return end

	self.PD = table.Merge( self.PD , data )
	self.PD.T = type
	self.PD.TC = string.Left( type , 1)
	self.PD.TF = string.sub( type , 2)
	self.PD.AT = table.Copy( self.PD.AT )
	self.PD.IsMultiFloor = self.PD.MFT && true
	self.PD.Usable  = self.Cont.Usable && !self.PD.IsShaft && !self.PD.IsMultiFloor
	
	self:SetModel( self.PD.model )
end

function ENT:GetPartType()
	return self.PD.T
end

function ENT:SetPartClass( class )
	local t = class..string.sub( self:GetPartType() , 2 )
	if LMT[ self.Cont.Size[1] ][ t ] then
		self:SetPartType( t )
	end
end

function ENT:SetPartForm( form )
	local t = string.Left( self:GetPartType() , 1 )..form
	if LMT[ self.Cont.Size[1] ][ t ] then
		self:SetPartType( t )
	end
end

function ENT:UpdateHeightOffsets()

	if self.PD.PN > 1 then
		local P1 = self.Cont.PT[self.PD.PN - 1].PD
		local P2 = self.PD
		local C1 = math.Clamp( P1.Roll , 0 , 1 )
		local C2 = math.abs( C1 - 1 )
		local C3 = math.Clamp( P2.Roll , 0 , 1 )
		local C4 = math.abs( C3 - 1 )
		
		P2.HO = P1.HO + (C1*P1.ZDD + C2*P1.ZUD) + (C3*P2.ZUD + C4*P2.ZDD)
	else
		local P2 = self.PD
		local C3 = math.Clamp( P2.Roll , 0 , 1 )
		local C4 = math.abs( C3 - 1 )
		
		P2.HO = C3*( P2.ZUD - P2.ZDD )
	end
	
	self:RefreshPos()	
end

function ENT:RefreshPos()
	self:SetPos( self.Cont:LocalToWorld( Vector(0,0, self.PD.HO + 60.45 ) ) )
end

function ENT:RefreshAng()
	self.Entity:SetAngles( Angle( 0 , self.PD.Yaw , self.PD.Roll ) )
	self.PD.Inv = self.PD.Roll ~= 0
end

function ENT:RotatePartYaw( yaw )
	self.PD.Yaw = (self.PD.Yaw + yaw) % 360
	self:RefreshAng()
end

function ENT:RotatePartRoll( roll )
	self.PD.Roll = (self.PD.Roll + roll) % 360
	self:RefreshAng()
end

function ENT:CheckSkin( skin )
	if self:SkinCount() > 5 then
		self:SetSkin( skin * 2 )
	else
		self:SetSkin( skin )
	end
end

function ENT:Use()
	if self.PD.IsMultiFloor || !self.PD.Usable || !self.Cont || !self.Cont:IsValid() then return end
	
	self.Cont:AddCallFloorNum( self.PD.FN )
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