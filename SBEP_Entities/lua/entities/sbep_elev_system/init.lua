AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" ) 

ENT.WireDebugName = "SBEP Elevator System"

local LMT = {
		[ "models/SmallBridge/Elevators,Small/sbselevb.mdl" 	]	= { "B"		,  65.1 	,  65.1 	, {0,1,0,0} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevbe.mdl" 	]	= { "BE"	,  65.1 	,  65.1 	, {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevbedh.mdl" 	]	= { "BEdh"	, 195.3 	,  65.1 	, {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevbedw.mdl" 	]	= { "BEdw"	,  65.1 	,  65.1 	, {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevbr.mdl" 	]	= { "BR"	,  65.1 	,  65.1 	, {1,1,0,0} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevbt.mdl" 	]	= { "BT"	,  65.1 	,  65.1 	, {1,1,1,0} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevbx.mdl" 	]	= { "BX"	,  65.1 	,  65.1 	, {1,1,1,1} } ,
		
		[ "models/SmallBridge/Elevators,Small/sbselevm.mdl" 	]	= { "M"		,  65.1 	,  65.1 	, {0,1,0,0} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevme.mdl" 	]	= { "ME"	,  65.1 	,  65.1 	, {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevmedh.mdl" 	]	= { "MEdh"	, 195.3 	,  65.1 	, {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevmedw.mdl" 	]	= { "MEdw"	,  65.1 	,  65.1 	, {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevmr.mdl" 	]	= { "MR"	,  65.1 	,  65.1 	, {1,1,0,0} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevmt.mdl" 	]	= { "MT"	,  65.1 	,  65.1 	, {1,1,1,0} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevmx.mdl" 	]	= { "MX"	,  65.1 	,  65.1 	, {1,1,1,1} } ,
		
		[ "models/SmallBridge/Elevators,Small/sbselevt.mdl" 	]	= { "T"		,  65.1 	,  65.1 	, {0,1,0,0} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevte.mdl" 	]	= { "TE"	,  65.1 	,  65.1 	, {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevtedh.mdl" 	]	= { "TEdh"	, 195.3 	,  65.1 	, {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevtedw.mdl" 	]	= { "TEdw"	,  65.1 	,  65.1 	, {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevtr.mdl" 	]	= { "TR"	,  65.1 	,  65.1 	, {1,1,0,0} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevtt.mdl" 	]	= { "TT"	,  65.1 	,  65.1 	, {1,1,1,0} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevtx.mdl" 	]	= { "TX"	,  65.1 	,  65.1 	, {1,1,1,1} } ,
		
		[ "models/SmallBridge/Elevators,Small/sbselevs.mdl" 	]	= { "S"		,  65.1 	,  65.1 	, {0,0,0,0} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevs2.mdl" 	]	= { "S2"	,  65.1 	,  65.1 	, {0,0,0,0} } ,

		[ "models/SmallBridge/Station Parts/sbbridgevisorb.mdl" ]	= { "VB"	,  65.1 	,  65.1 	, {0,0,0,0} } ,
		[ "models/SmallBridge/Station Parts/sbbridgevisorm.mdl" ]	= { "VM"	,  65.1 	,  65.1 	, {0,0,0,0} } ,
		[ "models/SmallBridge/Station Parts/sbbridgevisort.mdl" ]	= { "VT"	,  65.1 	,  65.1 	, {0,0,0,0} } ,

		[ "models/SmallBridge/Station Parts/sbhuble.mdl" 		]	= { "H"		, 195.3 	, 195.3 	, {0,0,0,0} , { 0 , 130.2 , 260.4 } }
			}

local LMTL = {
		[ "models/SmallBridge/Elevators,Large/sblelevb.mdl" 	]	= { "B"		,  65.1 	,  65.1 	, {0,0,0,1} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevbe.mdl" 	]	= { "BE"	,  65.1 	,  65.1 	, {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevbedh.mdl" 	]	= { "BEdh"	, 195.3 	,  65.1 	, {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevbr.mdl" 	]	= { "BR"	,  65.1 	,  65.1 	, {1,1,0,0} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevbt.mdl" 	]	= { "BT"	,  65.1 	,  65.1 	, {1,1,1,0} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevbx.mdl" 	]	= { "BX"	,  65.1 	,  65.1 	, {1,1,1,1} } ,
		
		[ "models/SmallBridge/Elevators,Large/sblelevm.mdl" 	]	= { "M"		,  65.1 	,  65.1 	, {0,0,0,1} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevme.mdl" 	]	= { "ME"	,  65.1 	,  65.1 	, {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevmedh.mdl" 	]	= { "MEdh"	, 195.3 	,  65.1 	, {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevmr.mdl" 	]	= { "MR"	,  65.1 	,  65.1 	, {1,1,0,0} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevmt.mdl" 	]	= { "MT"	,  65.1 	,  65.1 	, {1,1,1,0} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevmx.mdl" 	]	= { "MX"	,  65.1 	,  65.1 	, {1,1,1,1} } ,
		
		[ "models/SmallBridge/Elevators,Large/sblelevt.mdl" 	]	= { "T"		,  65.1 	,  65.1 	, {0,0,0,1} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevte.mdl" 	]	= { "TE"	,  65.1 	,  65.1 	, {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevtedh.mdl" 	]	= { "TEdh"	, 195.3 	,  65.1 	, {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevtr.mdl" 	]	= { "TR"	,  65.1 	,  65.1 	, {1,1,0,0} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevtt.mdl" 	]	= { "TT"	,  65.1 	,  65.1 	, {1,1,1,0} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevtx.mdl" 	]	= { "TX"	,  65.1 	,  65.1 	, {1,1,1,1} } ,
		
		[ "models/SmallBridge/Elevators,Large/sblelevs.mdl" 	]	= { "S"		,  65.1 	,  65.1 	, {0,0,0,0} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevs2.mdl" 	]	= { "S2"	,  65.1 	,  65.1 	, {0,0,0,0} }

			}

local PMT = {
		"models/SmallBridge/Elevators,Small/sbselevp0.mdl"	,
		"models/SmallBridge/Elevators,Small/sbselevp1.mdl"	,
		"models/SmallBridge/Elevators,Small/sbselevp2e.mdl"	,
		"models/SmallBridge/Elevators,Small/sbselevp2r.mdl"	,
		"models/SmallBridge/Elevators,Small/sbselevp3.mdl"
			}

local PMTL = {
		"models/SmallBridge/Elevators,Large/sblelevp0.mdl"	,
		"models/SmallBridge/Elevators,Large/sblelevp1.mdl"	,
		"models/SmallBridge/Elevators,Large/sblelevp2e.mdl"	,
		"models/SmallBridge/Elevators,Large/sblelevp2r.mdl"	,
		"models/SmallBridge/Elevators,Large/sblelevp3.mdl"
			}

function ENT:Initialize()
	
	if self.Large then
		self:SetModel( "models/SmallBridge/Elevators,Large/sblelevp3.mdl" ) 
	else
		self:SetModel( "models/SmallBridge/Elevators,Small/sbselevp3.mdl" ) 
	end

	self.PT = {}
	self.PC = 0
	self.FC = 0
	self.MAT = table.Copy({0,0,0,0})
	self.Activated = false
	self.FN = 1
	self.CP = 1
	self.CF = 1
	self.INC = -60.45
	self.TO = -60.45
	self.AYO = 90
	self.ShadowParams = {}
		self.ShadowParams.maxangular = 5000 //What should be the maximal angular force applied
		self.ShadowParams.maxangulardamp = 10000 // At which force/speed should it start damping the rotation
		self.ShadowParams.maxspeed = 1000000 // Maximal linear force applied
		self.ShadowParams.maxspeeddamp = 10000// Maximal linear force/speed before  damping
		self.ShadowParams.dampfactor = 0.8 // The percentage it should damp the linear/angular force if it reachs it's max ammount
		self.ShadowParams.teleportdistance = 0 // If it's further away than this it'll teleport (Set to 0 to not teleport)

	if self.Skin then
		local skincount = self:SkinCount()
		if skincount > 5 then
			self:SetSkin( self.Skin * 2 )
		else
			self:SetSkin( self.Skin )
		end
	end
	
	self:PhysicsInitialize()
	
	self:StartMotionController()

end

function ENT:PhysicsInitialize()

	self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		
		local phys = self:GetPhysicsObject()  	
		if ValidEntity(phys) then  		
			phys:Wake() 
			phys:EnableGravity(false)
		end

end

function ENT:CreatePart( PartNum )

	local n = tonumber(PartNum)

	local NP = ents.Create( "sbep_elev_housing" )
	
	self.PT[ n ] = NP
	self.PC = #self.PT
	self:SetNetworkedInt( "SBEP_LiftPartCount" , self.PC )
	
	NP.Controller = self.Entity
	NP.HO = 0
	
	NP:Spawn()
	
	self:DeleteOnRemove( NP )
	
	return NP
end

function ENT:RefreshPart( PartNum )

	local n = tonumber( PartNum )
	local P = self.PT[ n ]
	
	local DT = {}
	if self.Large then
		P.model = "models/SmallBridge/Elevators,Large/sblelev"..string.sub( P.model , 43 )
		DT = LMTL[ P.model ]
	else
		DT = LMT[ P.model ]
	end
	
	P:SetModel( P.model )
	P.LT  = DT[1]
	P.ZUD = DT[2]
	P.ZDD = DT[3]
	P.AT  = table.Copy( DT[4] )
	P.LTC = string.Left( P.LT , 1)
	
	if self.Skin then
		local skincount = P:SkinCount()
		if skincount > 5 then
			P:SetSkin( self.Skin * 2 )
		else
			P:SetSkin( self.Skin )
		end
	end
	
	self.PC = #self.PT
	
	if P.LTC == "S" then
		P.IsShaft = true
	else
		P.IsShaft = false
	end
	
	if P.LTC == "V" then
		P.IsVisor = true
	else
		P.IsVisor = false
	end
	
	if P.LTC == "H" then
		P.IsHub = true
	else
		P.IsHub = false
	end
	
	if DT[5] then
		P.MultiFloor = true
		P.FO = DT[5]
		P.SBEPLiftWireInputs = {}
		for k,v in ipairs( P.FO ) do
			P.SBEPLiftWireInputs[k] = "Call "..tostring( k )
		end
	else
		P.MultiFloor = false
	end
	
	if string.Right( P.LT , 2) == "dh" then
		P.IsDH = true
	else
		P.IsDH = false
	end
	
	if P.Roll != 0 then
		P.Inv = true
	else
		P.Inv = false
	end

	if self.Usable and !P.IsShaft then
		P.Usable = true
	else
		P.Usable = false
	end
		
	if n > 1 then
		P.HO = self.PT[n - 1].HO
		if self.PT[n - 1].Inv then
			P.HO = P.HO + self.PT[n - 1].ZDD
		else
			P.HO = P.HO + self.PT[n - 1].ZUD
		end
		if P.Inv then
			P.HO = P.HO + P.ZUD
		else
			P.HO = P.HO + P.ZDD
		end
	else
		P.HO = 0
		if P.Inv and P.IsDH then
			P.HO = 130.2
		end
	end
	
	P:SetPos( self.StartPos + Vector(0,0, P.HO ) )
	P:SetAngles( Angle( 0 , P.Yaw , P.Roll ) )

	for k,v in ipairs( self.PT ) do		
		if k > n then
			self:RefreshPart( k )
		end
	end
	
	return P

end

function ENT:Think()

	if !self.Activated then return end
	
	self.INC = self.INC + math.Clamp( ( self.TO - self.INC) , -0.6 , 0.6 )
	if 	( math.Round(self.INC) == math.Round( self.TO ) ) then
		self.AtTargetLocation = true
	else
		self.AtTargetLocation = false
	end
	
	local endloop = false
	for k,v in ipairs( self.FT ) do
		if endloop or ( k == #self.FT ) then break end
		if math.abs(self.INC) < math.abs( ( v + self.FT[k + 1] ) / 2 ) then
			self.CF = k
			endloop = true
		else
			self.CF = k + 1
		end
	end
	
	if self.CF != self.OldCF then
		WireLib.TriggerOutput( self , "Floor" , self.CF )
	end
	self.OldCF = self.CF
	
	if self.TO > self.INC then
		self.Direction = "UP"
	else
		self.Direction = "DOWN"
	end

	if self.UseHatches then
		self:CheckHatchStatus()
	end
	
	if self.UseDoors then
		if self.AtTargetLocation != self.OldATL then
			self:CheckDoorStatus()
		end
		self.OldATL = self.AtTargetLocation
	end
	
	self.Entity:NextThink( CurTime() + 0.01 )

	return true
end

function ENT:PhysicsSimulate( phys, deltatime )

	if !self.Activated then return SIM_NOTHING end

	local Pos1 = self.PT[1]:GetPos()
	local Pos2 = self.PT[self.PC]:GetPos()
	
	self.ShaftDirectionVector = Pos2 - Pos1
	self.ShaftDirectionVector:Normalize()
	
	self.CurrentElevPos = Pos1 + (self.ShaftDirectionVector * self.INC)
	self.CurrentElevAng = self.PT[1]:GetAngles()
	if self.PT[1].Inv then
		self.CurrentElevAng = self.CurrentElevAng + Angle( 0 , 0 , 180 )
	end
	self.CurrentElevAng:RotateAroundAxis( self.ShaftDirectionVector , self.AYO )

	phys:Wake()
	
	self.ShadowParams.secondstoarrive = 0.01
	self.ShadowParams.pos = self.CurrentElevPos
	self.ShadowParams.angle = self.CurrentElevAng
	self.ShadowParams.deltatime = deltatime
	
	return phys:ComputeShadowControl(self.ShadowParams)

end

function ENT:CheckHatchStatus()
	if 	!self.UseHatches 		or
		!self.Activated 		or
		self.AtTargetLocation 	or
		!self.HT then return end

	for k,v in ipairs( self.HT ) do
		if self.Direction == "UP" then
			if self.INC > ( v.HO + 20 ) then
				v.OpenTrigger = false
			elseif self.INC > ( v.HO - 110 ) then
				v.OpenTrigger = true
			end
		elseif self.Direction == "DOWN" then
			if self.INC < ( v.HO - 80 ) then
				v.OpenTrigger = false
			elseif self.INC < ( v.HO + 50 ) then
				v.OpenTrigger = true
			end
		end
	end
end

function ENT:CheckDoorStatus()
	if  !self.UseDoors		or
		!self.Activated		or
		!self.FDT	then return end
		
	if self.AtTargetLocation then
		for k,v in ipairs( self.FDT[ self.FN ] ) do
			v.OpenTrigger = true
		end
	else
		for k,v in ipairs( self.FDT ) do
			for m,n in ipairs( v ) do
				n.OpenTrigger = false
			end
		end
	end
end

function ENT:FinishSystem()

	for k,v in ipairs( self.PT ) do
		self:RefreshPart( k )
	end

	self.PT[ #self.PT ]:Remove()
	self.PT[ #self.PT ] = nil
	self.PC = #self.PT
	
	if self.PT[ 1 ].IsVisor then
		if self.PT[ 1 ].Inv then
			self.PT[ 1 ].model = ( "models/SmallBridge/Station Parts/sbbridgevisort.mdl" )
		else
			self.PT[ 1 ].model = ( "models/SmallBridge/Station Parts/sbbridgevisorb.mdl" )
		end
	else
		if self.Large then
			if self.PT[ 1 ].Inv then
				self.PT[ 1 ].model = ( "models/SmallBridge/Elevators,Large/sblelevt"..string.sub( self.PT[ 1 ].model , 44 ) )
			else
				self.PT[ 1 ].model = ( "models/SmallBridge/Elevators,Large/sblelevb"..string.sub( self.PT[ 1 ].model , 44 ) )
			end
		else
			if self.PT[ 1 ].Inv then
				self.PT[ 1 ].model = ( "models/SmallBridge/Elevators,Small/sbselevt"..string.sub( self.PT[ 1 ].model , 44 ) )
			else
				self.PT[ 1 ].model = ( "models/SmallBridge/Elevators,Small/sbselevb"..string.sub( self.PT[ 1 ].model , 44 ) )
			end
		end
	end
	self:RefreshPart( 1 )
	
	if self.PT[ self.PC ].IsVisor then
		if self.PT[ self.PC ].Inv then
			self.PT[ self.PC ].model = ( "models/SmallBridge/Station Parts/sbbridgevisorb.mdl" )
		else
			self.PT[ self.PC ].model = ( "models/SmallBridge/Station Parts/sbbridgevisort.mdl" )
		end
	else
		if self.Large then
			if self.PT[ self.PC ].Inv then
				self.PT[ self.PC ].model = ( "models/SmallBridge/Elevators,Large/sblelevb"..string.sub( self.PT[ self.PC ].model , 44 ) )
			else
				self.PT[ self.PC ].model = ( "models/SmallBridge/Elevators,Large/sblelevt"..string.sub( self.PT[ self.PC ].model , 44 ) )
			end
		else
			if self.PT[ self.PC ].Inv then
				self.PT[ self.PC ].model = ( "models/SmallBridge/Elevators,Small/sbselevb"..string.sub( self.PT[ self.PC ].model , 44 ) )
			else
				self.PT[ self.PC ].model = ( "models/SmallBridge/Elevators,Small/sbselevt"..string.sub( self.PT[ self.PC ].model , 44 ) )
			end
		end
	end
	self:RefreshPart( self.PC )

	for k,v in ipairs( self.PT ) do
		v:SetColor( 255 , 255 , 255 , 255 )
		self:CalcPanelModel( k )
		v:Initialize()
	end
	self:PhysicsInitialize()
	
	if self.Skin then
		local skincount = self:SkinCount()
		if skincount > 5 then
			self:SetSkin( self.Skin * 2 )
		else
			self:SetSkin( self.Skin )
		end
	end
	
	self:StartMotionController()
	
	self:WeldSystem()
	
	self.FC = 0
	self.FT = {}
	for k,v in ipairs( self.PT ) do
		if !v.IsShaft then
			v:MakeWire()
			if v.MultiFloor then
				v.FN = {}
				for m,n in ipairs( v.FO ) do
					self.FC = self.FC + 1
					self.FT[self.FC] = v.HO - v.ZDD + n + 4.65
					v.FN[m] = self.FC
				end
			else
				self.FC = self.FC + 1
				if v.Inv then
					self.FT[self.FC] = v.HO - v.ZUD + 4.65
				else
					self.FT[self.FC] = v.HO - v.ZDD + 4.65
				end
				v.FN = self.FC
			end
		end
	end
	self.FC = #self.FT
	
	if self.UseHatches then
		self:CreateHatches()
	elseif self.UseDoors then
		self:CreateDoors()
	end
	
	self:MakeWire()
	
	self.Activated = true

end

function ENT:CreateHatches()
	
	self.HT = {}
	local HI = 0
	for k,v in ipairs(self.PT) do
		if !(k == #self.PT) then
			if not (v.IsShaft and self.PT[k + 1].IsShaft) then
				HI = HI + 1
				self.HT[HI] = ents.Create( "sbep_base_door" )
				local NH = self.HT[HI]
				NH:Spawn()
				if self.Large then
					NH:SetDoorType( "Door_ElevHatch_L" )
				else
					NH:SetDoorType( "Door_ElevHatch" )
				end
				NH:SetAngles( v:GetAngles() )
				
				local weldpart = 0
				if self.PT[k + 1].IsShaft then
					if v.Inv then
						NH.PO = v.ZDD - 4.65
					else
						NH.PO = v.ZUD - 4.65
					end
				else
					if v.Inv then
						NH.PO = v.ZDD + 4.65
					else
						NH.PO = v.ZUD + 4.65
					end
					weldpart = 1
				end
				NH.HO = v.HO + NH.PO
				NH:SetPos( self.StartPos + Vector(0,0,NH.HO) )
				constraint.Weld( NH, self.PT[k + weldpart] , 0, 0, 0, true )
				
				if self.Skin then
					NH:SetSkin( self.Skin )
				end

				NH.OpenTrigger = false
				self:DeleteOnRemove(NH)
			end
		end
	end
	self.HC = #self.HT
end

function ENT:CreateDoors()

	self.FDT = {}
	local FDI = 0
	for k,v in ipairs( self.PT ) do
		if !v.IsShaft then
			FDI = FDI + 1
			self.FDT[ FDI ] = {}
			local inc = 0
			for m,n in ipairs( v.AT ) do
				if n == 1 then
					inc = inc + 1
					self.FDT[ FDI ][ inc ] = ents.Create( "sbep_base_door" )
					local vec = Vector(-60.45,0,0)
					
					if self.Large then
						if v.IsDH then
							self.FDT[ FDI ][ inc ]:SetDoorType( "Door_DWDH" )
						else
							self.FDT[ FDI ][ inc ]:SetDoorType( "Door_DW" )
						end
						vec = Vector(-176.7,0,0)
					else
						if v.IsDH then
							self.FDT[ FDI ][ inc ]:SetDoorType( "Door_Anim3dh" )
						else
							self.FDT[ FDI ][ inc ]:SetDoorType( "Door_Anim3" )
						end
					end
					
					vec:Rotate( Angle(0, (-90) * m ,0) )
					self.FDT[ FDI ][ inc ]:SetPos( v:GetPos() + vec )
					self.FDT[ FDI ][ inc ]:SetAngles( Angle( 0 , 90 * m , 0 ) )
					self.FDT[ FDI ][ inc ]:Spawn()
					self.FDT[ FDI ][ inc ]:Activate()
					
					constraint.Weld( self.FDT[ FDI ][ inc ] , v , 0 , 0 , 0 , true )
					self.FDT[ FDI ][ inc ]:GetPhysicsObject():EnableMotion( true )
					
					if self.Skin then
						self.FDT[ FDI ][ inc ]:SetSkin( self.Skin )
					end
					
					self:DeleteOnRemove( self.FDT[ FDI ][ inc ] )
				end
			end
		end
	end
	self.FDC = #self.FDT
	self.DoorTrig = true

end

function ENT:WeldSystem() //Welds and nocollides the system once completed.
	
	if self.PC > 1 then

		for k,v in ipairs( self.PT ) do
			if ValidEntity( v ) and ValidEntity(self.PT[k + 1]) then
				constraint.Weld( v , self.PT[k + 1] , 0 , 0 , 0 , true )
			end
			if ValidEntity( v ) and ValidEntity(self.PT[k + 2]) and (k/2 == math.floor(k/2)) then
				constraint.Weld( v , self.PT[k + 2] , 0 , 0 , 0 , true )
			end
			if ValidEntity( v ) and ValidEntity(self) then
				constraint.NoCollide( v , self , 0 , 0 )
			end
		end

		if ValidEntity(self.PT[1]) and ValidEntity(self.PT[self.PC]) then
			constraint.Weld( self.PT[1] , self.PT[self.PC] , 0 , 0 , 0 , true )
		end
	end
end

function ENT:CalcPanelModel( PartNum )

	local P = self.PT[ PartNum ]
	
	if P.LTC == "R" and P.Inv then
		P.AT = table.Copy( {0,1,1,0} )
	end
	
	function RotateAT()
		table.insert( P.AT , P.AT[1] )
		table.remove( P.AT , 1 )
	end
	//Rotating the part access table.----------------
	if P.LTC != "X" then
		if P.Yaw == 90 then
			RotateAT()
		elseif P.Yaw == 180 then
			RotateAT()
			RotateAT()
		elseif P.Yaw == 270 then
			RotateAT()
			RotateAT()
			RotateAT()
		end
	end
	//----------------------
	
	//Adds any new open access points to the model access table.------------------
	if P.AT[1] > self.MAT[1] then
		self.MAT[1] = P.AT[1]
	end
	if P.AT[2] > self.MAT[2] then
		self.MAT[2] = P.AT[2]
	end
	if P.AT[3] > self.MAT[3] then
		self.MAT[3] = P.AT[3]
	end
	if P.AT[4] > self.MAT[4] then
		self.MAT[4] = P.AT[4]
	end
	
	self.MATSum = self.MAT[1] + self.MAT[2] + self.MAT[3] + self.MAT[4]
	
	local DMT = {}
	if self.Large then
		DMT = PMTL
	else
		DMT = PMT
	end
	
	//Using the model access table to work out the model and rotation of the elevator panel.-----------------
	if self.MATSum == 4 then
		self:SetModel( DMT[1] )
		self.AYO = 0
	elseif self.MATSum == 1 then 
		self:SetModel( DMT[5] )
		self.AYO = ((self.MAT[4] * 90) + (self.MAT[3] * 180) + (self.MAT[2] * 270) )
	elseif self.MATSum == 3 then 
		self:SetModel( DMT[2] )
		self.AYO = (((self.MAT[1] - 1) * -90) + ((self.MAT[4] - 1) * -180) + ((self.MAT[3] - 1) * -270))
	elseif self.MATSum == 2 then 
		if self.MAT[1] == self.MAT[3] then
			self:SetModel( DMT[3] )
			self.AYO = (self.MAT[2] * 90)
		elseif self.MAT[1] == self.MAT[2] or self.MAT[2] == self.MAT[3] then
			self:SetModel( DMT[4] )
			if self.MAT[1] == 1 then
				self.AYO =  (self.MAT[2] * -90) % 360
			elseif self.MAT[3] == 1 then
				self.AYO =  ((self.MAT[4] * 90) + (self.MAT[2] * 180)) % 360
			end
		end
	end
	//----------------------------------------------

end

function ENT:MakeWire() //Adds the appropriate wire inputs.
	self.SBEP_WireInputsTable = {}
	self.SBEP_WireInputsTable[1] = "FloorNum"
	for i = 1, self.FC do
		self.SBEP_WireInputsTable[i + 1] = "Floor "..tostring(i)
	end
	self.Inputs = Wire_CreateInputs(self.Entity, self.SBEP_WireInputsTable)
	
	self.Outputs = WireLib.CreateOutputs(self.Entity,{"Floor"})
end

function ENT:TriggerInput(k,v)

	if k == "FloorNum" then
		self.FN = v
		self.TO = self.FT[self.FN]
	end
	
	for i = 1, self.FC do
		if k == ("Floor "..tostring(i)) and v == 1 then
			self.FN = i
			self.TO = self.FT[self.FN]
		end
	end
end

function ENT:SetCallFloorNum( num )

	self.FN = num
	self.TO = self.FT[self.FN]

end

function ENT:PreEntityCopy()
	local dupeInfo = {}
	dupeInfo.PC = self.PC
	dupeInfo.PT = {}
	dupeInfo.Data = {}
	for k,v in ipairs( self.PT ) do
		dupeInfo.PT[k]    			= v:EntIndex()
		dupeInfo.Data[k]			= {}
		dupeInfo.Data[k].model 		= v.model
		dupeInfo.Data[k].Yaw 		= v.Yaw
		dupeInfo.Data[k].Roll 		= v.Roll
		dupeInfo.Data[k].FN 		= v.FN
	end
	dupeInfo.FT 		= self.FT
	dupeInfo.MAT 		= self.MAT
	dupeInfo.AYO 		= self.AYO
	dupeInfo.Usable 	= self.Usable
	dupeInfo.model 		= self:GetModel()
	duplicator.StoreEntityModifier(self, "SBEPLiftSysDupeInfo", dupeInfo)
end
duplicator.RegisterEntityModifier( "SBEPLiftSysDupeInfo" , function() end)

function ENT:PostEntityPaste(pl, Ent, CreatedEntities)
	self.PC = Ent.EntityMods.SBEPLiftSysDupeInfo.PC
	for i = 1, self.PC do
		self.PT[i] = CreatedEntities[Ent.EntityMods.SBEPLiftSysDupeInfo.PT[i]]
		self.PT[i].Controller 	= self.Entity
		self.PT[i].model 		= Ent.EntityMods.SBEPLiftSysDupeInfo.Data[i].model
		self.PT[i].Yaw 			= Ent.EntityMods.SBEPLiftSysDupeInfo.Data[i].Yaw
		self.PT[i].Roll 		= Ent.EntityMods.SBEPLiftSysDupeInfo.Data[i].Roll
		self.PT[i].FN 			= Ent.EntityMods.SBEPLiftSysDupeInfo.Data[i].FN
	end
	self.FT			= Ent.EntityMods.SBEPLiftSysDupeInfo.FT
	self.FC			= #self.FT
	self.MAT 		= Ent.EntityMods.SBEPLiftSysDupeInfo.MAT
	self.model 		= Ent.EntityMods.SBEPLiftSysDupeInfo.model
	self.AYO 		= Ent.EntityMods.SBEPLiftSysDupeInfo.AYO
	self.Usable		= Ent.EntityMods.SBEPLiftSysDupeInfo.Usable
	
	self:PasteRefreshSystem()

end

function ENT:PasteRefreshSystem()
	
	for n,P in ipairs( self.PT ) do
		
		P.LT  = LMT[ P.model ][1]
		P.ZUD = LMT[ P.model ][2]
		P.ZDD = LMT[ P.model ][3]
		P.AT  = LMT[ P.model ][4]
		P.LTC = string.Left( P.LT , 1)
		
		if P.LTC == "S" then
			P.IsShaft = true
		else
			P.IsShaft = false
		end
		
		if P.LTC == "V" then
			P.IsVisor = true
		else
			P.IsVisor = false
		end
		
		if P.LTC == "H" then
			P.IsHub = true
		else
			P.IsHub = false
		end
		
		if LMT[ P.model ][5] then
			P.MultiFloor = true
			P.FO = LMT[ P.model ][5]
			P.SBEPLiftWireInputs = {}
			for k,v in ipairs( P.FO ) do
				P.SBEPLiftWireInputs[k] = "Call "..tostring( k )
			end
		else
			P.MultiFloor = false
		end
		
		if string.Right( P.LT , 2) == "dh" then
			P.IsDH = true
		else
			P.IsDH = false
		end
		
		if self.Usable then
			P.Usable = true
		else
			P.Usable = false
		end
		
		if P.Roll != 0 then
			P.Inv = true
		else
			P.Inv = false
		end

		if n > 1 then
			P.HO = self.PT[n - 1].HO
			if self.PT[n - 1].Inv then
				P.HO = P.HO + self.PT[n - 1].ZDD
			else
				P.HO = P.HO + self.PT[n - 1].ZUD
			end
			if P.Inv then
				P.HO = P.HO + P.ZUD
			else
				P.HO = P.HO + P.ZDD
			end
		else
			P.HO = 0
			if P.Inv and P.IsDH then
				P.HO = 130.2
			end
		end
		
		P:MakeWire()
	end
	
	self:SetModel( self.model )
	self:PhysicsInitialize()
	self:StartMotionController()
	self:MakeWire()
	self.Activated = true

end