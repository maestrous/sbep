AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" ) 

ENT.WireDebugName = "SBEP Elevator System"

local LMT = {}
LMT.S = {
		[ "models/SmallBridge/Elevators,Small/sbselevb.mdl" 	]	= { LT = "B"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,1,0,0} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevbe.mdl" 	]	= { LT = "BE"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevbedh.mdl" 	]	= { LT = "BEdh"	, ZUD = 195.3 	, ZDD =  65.1 	, AT = {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevbedw.mdl" 	]	= { LT = "BEdw"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevbr.mdl" 	]	= { LT = "BR"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,0,0} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevbt.mdl" 	]	= { LT = "BT"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,1,0} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevbx.mdl" 	]	= { LT = "BX"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,1,1} } ,

		[ "models/SmallBridge/Elevators,Small/sbselevm.mdl" 	]	= { LT = "M"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,1,0,0} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevme.mdl" 	]	= { LT = "ME"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevmedh.mdl" 	]	= { LT = "MEdh"	, ZUD = 195.3 	, ZDD =  65.1 	, AT = {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevmedw.mdl" 	]	= { LT = "MEdw"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevmr.mdl" 	]	= { LT = "MR"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,0,0} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevmt.mdl" 	]	= { LT = "MT"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,1,0} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevmx.mdl" 	]	= { LT = "MX"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,1,1} } ,

		[ "models/SmallBridge/Elevators,Small/sbselevt.mdl" 	]	= { LT = "T"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,1,0,0} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevte.mdl" 	]	= { LT = "TE"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevtedh.mdl" 	]	= { LT = "TEdh"	, ZUD = 195.3 	, ZDD =  65.1 	, AT = {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevtedw.mdl" 	]	= { LT = "TEdw"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevtr.mdl" 	]	= { LT = "TR"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,0,0} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevtt.mdl" 	]	= { LT = "TT"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,1,0} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevtx.mdl" 	]	= { LT = "TX"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,1,1} } ,

		[ "models/SmallBridge/Elevators,Small/sbselevs.mdl" 	]	= { LT = "S"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,0,0,0} } ,
		[ "models/SmallBridge/Elevators,Small/sbselevs2.mdl" 	]	= { LT = "S2"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,0,0,0} } ,

		[ "models/SmallBridge/Station Parts/sbbridgevisorb.mdl" ]	= { LT = "VB"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,0,0,0} } ,
		[ "models/SmallBridge/Station Parts/sbbridgevisorm.mdl" ]	= { LT = "VM"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,0,0,0} } ,
		[ "models/SmallBridge/Station Parts/sbbridgevisort.mdl" ]	= { LT = "VT"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,0,0,0} } ,

		[ "models/SmallBridge/Station Parts/sbhuble.mdl" 		]	= { LT = "H"	, ZUD = 195.3 	, ZDD = 195.3 	, AT = {0,0,0,0} , MFT = { 0 , 130.2 , 260.4 } }
			}

LMT.L = {
		[ "models/SmallBridge/Elevators,Large/sblelevb.mdl" 	]	= { LT = "B"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,0,0,1} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevbe.mdl" 	]	= { LT = "BE"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevbedh.mdl" 	]	= { LT = "BEdh"	, ZUD = 195.3 	, ZDD =  65.1 	, AT = {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevbr.mdl" 	]	= { LT = "BR"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,0,0} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevbt.mdl" 	]	= { LT = "BT"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,1,0} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevbx.mdl" 	]	= { LT = "BX"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,1,1} } ,
		
		[ "models/SmallBridge/Elevators,Large/sblelevm.mdl" 	]	= { LT = "M"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,0,0,1} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevme.mdl" 	]	= { LT = "ME"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevmedh.mdl" 	]	= { LT = "MEdh"	, ZUD = 195.3 	, ZDD =  65.1 	, AT = {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevmr.mdl" 	]	= { LT = "MR"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,0,0} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevmt.mdl" 	]	= { LT = "MT"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,1,0} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevmx.mdl" 	]	= { LT = "MX"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,1,1} } ,
		
		[ "models/SmallBridge/Elevators,Large/sblelevt.mdl" 	]	= { LT = "T"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,0,0,1} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevte.mdl" 	]	= { LT = "TE"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevtedh.mdl" 	]	= { LT = "TEdh"	, ZUD = 195.3 	, ZDD =  65.1 	, AT = {0,1,0,1} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevtr.mdl" 	]	= { LT = "TR"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,0,0} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevtt.mdl" 	]	= { LT = "TT"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,1,0} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevtx.mdl" 	]	= { LT = "TX"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {1,1,1,1} } ,
		
		[ "models/SmallBridge/Elevators,Large/sblelevs.mdl" 	]	= { LT = "S"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,0,0,0} } ,
		[ "models/SmallBridge/Elevators,Large/sblelevs2.mdl" 	]	= { LT = "S2"	, ZUD =  65.1 	, ZDD =  65.1 	, AT = {0,0,0,0} }

			}

local PMT = {}
PMT.S = {
		"models/SmallBridge/Elevators,Small/sbselevp0.mdl"	,
		"models/SmallBridge/Elevators,Small/sbselevp1.mdl"	,
		"models/SmallBridge/Elevators,Small/sbselevp2e.mdl"	,
		"models/SmallBridge/Elevators,Small/sbselevp2r.mdl"	,
		"models/SmallBridge/Elevators,Small/sbselevp3.mdl"
			}

PMT.L = {
		"models/SmallBridge/Elevators,Large/sblelevp0.mdl"	,
		"models/SmallBridge/Elevators,Large/sblelevp1.mdl"	,
		"models/SmallBridge/Elevators,Large/sblelevp2e.mdl"	,
		"models/SmallBridge/Elevators,Large/sblelevp2r.mdl"	,
		"models/SmallBridge/Elevators,Large/sblelevp3.mdl"
			}

local function CheckSkin( ent , skin )
	if !skin || !ValidEntity( ent ) then return end
	if ent:SkinCount() > 5 then
		ent:SetSkin( skin * 2 )
	else
		ent:SetSkin( skin )
	end
end

function ENT:Initialize()

	self:SetModel( PMT[self.Size[1]][5] ) 

	self.PT = {} --Part Table
	self.ST = {} --System Table
	
	self.ST.PC = 0 --Part Count
	self.ST.FC = 0 --Floor Count
	self.Activated = false
	
	self.ST.MAT = {0,0,0,0} --Model Access Table
	--self.ST.MAT = table.Copy({0,0,0,0}) --Model Access Table
	
	self.ST.FN = 1 --Floor Number
	self.ST.CP = 1 --Current Part
	self.ST.CF = 1 --Current Floor
	
	self.CFT = {} --Call Floor Table (for queuing)
	self.IsHolding = false
	self.TAD = 0 -- Timer Delay
	self.TAST = CurTime() -- Timer Start Time
	self.THD = 0 -- Timer Delay
	self.THST = CurTime() -- Timer Start Time
	
	self.ST.Usable = self.Usable
	self.ST.Size   = self.Size
	self.ST.Skin   = self.Skin
	
	self.Index = tostring( self:EntIndex() )
	
	self.INC = -60.45 --Increment
	self.TO = -60.45 --Target Offset
	
	self.ST.AYO = 90 --Angle Yaw Offset
	
	self.ShadowParams = {}
		self.ShadowParams.maxangular = 5000 --What should be the maximal angular force applied
		self.ShadowParams.maxangulardamp = 10000 -- At which force/speed should it start damping the rotation
		self.ShadowParams.maxspeed = 1000000 -- Maximal linear force applied
		self.ShadowParams.maxspeeddamp = 10000-- Maximal linear force/speed before  damping
		self.ShadowParams.dampfactor = 0.8 -- The percentage it should damp the linear/angular force if it reachs it's max ammount
		self.ShadowParams.teleportdistance = 100 -- If it's further away than this it'll teleport (Set to 0 to not teleport)
		
	--self.ST.ShadowParams = self.ShadowParams

	CheckSkin( self.Entity , self.Skin )
	
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

function ENT:CreatePart( n )

	local NP = ents.Create( "sbep_elev_housing" )
	
	self.PT[ n ] = NP
	self.ST.PC = #self.PT
	self:SetNetworkedInt( "SBEP_LiftPartCount" , self.ST.PC )
	
	NP.Controller = self.Entity
	NP:Spawn()
	self.Entity:DeleteOnRemove( NP )
	
	return NP
end

function ENT:RefreshPart( PartNum )

	local n = tonumber( PartNum )
	local P = self.PT[ n ]

	P.PD.model = "models/SmallBridge/Elevators,"..self.Size[3].."/sb"..self.Size[2].."elev"..string.sub( P.PD.model , 43 )
	local DT = LMT[self.Size[1]][ P.PD.model ]
	
	P:SetModel( P.PD.model )
	
	CheckSkin( P , self.Skin )
	
	self.ST.PC = #self.PT
	
	P:UpdatePartData( DT , self , n )
	
	P:SetPos( self.StartPos + Vector(0,0, P.PD.HO ) )
	P:SetAngles( Angle( 0 , P.PD.Yaw , P.PD.Roll ) )

	for k,v in ipairs( self.PT ) do		
		if k > n then
			self:RefreshPart( k )
		end
	end
	
	return P

end

function ENT:AddArriveDelay( delay )

	self.TAST = CurTime() --Timer Arrive Start Time
	if delay > self.TAD then
		self.TAD = delay
	end

end

function ENT:AddHoldDelay( delay )

	self.THST = CurTime() --Timer Hold Start Time
	if delay > self.THD then
		self.THD = delay
	end
	self.IsHolding = true

end

function ENT:Think()

	if !self.Activated then 
		self.Entity:NextThink( CurTime() + 0.1 )
		return true
	end

	self.Entity:NextThink( CurTime() + 0.01 )
	
	--[[if !self.printcount then
		self.printcount = 0
	elseif self.printcount > 100 then
		PrintTable( self.CFT )
		print( tostring( self.ATL ).."\n".."------------" )
		self.printcount = 0
	end
	self.printcount = self.printcount + 1]]
	
	if self.CFT[1] then
		self.ST.FN = self.CFT[1]
		self.TO = self.ST.FT[self.CFT[1]]
	end

	self.ATL = ( math.Round(self.INC) == math.Round( self.TO ) )

	if self.ATL ~= self.OldATL then
		if self.ST.UseDoors then
			self:CheckDoorStatus()
		end
		if self.ATL then
			self:AddArriveDelay( 4 )
		elseif self.ST.UseDoors then	
			self:AddHoldDelay( 2 )
		end
	end
	self.OldATL = self.ATL
	
	if self.IsHolding ~= self.OIH && self.ST.UseDoors then
		self:CheckDoorStatus()
	end
	self.OIH = self.IsHolding
	
	if self.TAD > 0 && CurTime() > ( self.TAST + self.TAD ) && #self.CFT > 1 then
		table.remove( self.CFT , 1 ) 
		self.TAD = 0
	end
	
	if self.THD > 0 && CurTime() < ( self.THST + self.THD ) then
		WireLib.TriggerOutput( self , "Holding" , 1 )
		return true
	elseif self.THD > 0 && CurTime() > ( self.THST + self.THD ) then
		self.THD = 0
		if self.IsHolding then
			self:AddHoldDelay( 2 )
		end
		self.IsHolding = false
		WireLib.TriggerOutput( self , "Holding" , 0 )
	end

	if self.ATL then return true end
	
	self.INC = self.INC + math.Clamp( ( self.TO - self.INC) , -0.6 , 0.6 )
	
	local endloop = false
	for k,v in ipairs( self.ST.FT ) do
		if endloop || ( k == #self.ST.FT ) then break end
		if math.abs(self.INC) < math.abs( ( v + self.ST.FT[k + 1] ) / 2 ) then
			self.ST.CF = k
			endloop = true
		else
			self.ST.CF = k + 1
		end
	end
	
	if self.ST.CF ~= self.OldCF then
		WireLib.TriggerOutput( self , "Floor" , self.ST.CF )
	end
	self.OldCF = self.ST.CF
	
	if self.TO > self.INC then
		self.Direction = "UP"
	else
		self.Direction = "DOWN"
	end
	
	if self.ST.UseHatches then
		self:CheckHatchStatus()
	end
	
	return true
end

function ENT:PhysicsSimulate( phys, deltatime )

	if !self.Activated then return SIM_NOTHING end

	local Pos1 = self.PT[1]:GetPos()
	local Pos2 = self.PT[self.ST.PC]:GetPos()
	
	self.ShaftDirectionVector = Pos2 - Pos1
	self.ShaftDirectionVector:Normalize()
	
	self.CurrentElevPos = Pos1 + (self.ShaftDirectionVector * self.INC)
	self.CurrentElevAng = self.PT[1]:GetAngles()
	if self.PT[1].PD.Inv then
		self.CurrentElevAng = self.CurrentElevAng + Angle( 0 , 0 , 180 )
	end
	self.CurrentElevAng:RotateAroundAxis( self.ShaftDirectionVector , self.ST.AYO )

	phys:Wake()
	
	self.ShadowParams.secondstoarrive = 0.01
	self.ShadowParams.pos = self.CurrentElevPos
	self.ShadowParams.angle = self.CurrentElevAng
	self.ShadowParams.deltatime = deltatime
	
	return phys:ComputeShadowControl(self.ShadowParams)

end

function ENT:CheckHatchStatus()
	if 	!self.ST.UseHatches 		||
		!self.Activated 		||
		self.ATL 	||
		!self.HT then return end

	for k,v in ipairs( self.HT ) do
		if self.Direction == "UP" then
			if self.INC > ( v.HD.HO + 20 ) then
				v.OpenTrigger = false
			elseif self.INC > ( v.HD.HO - 110 ) then
				v.OpenTrigger = true
			end
		elseif self.Direction == "DOWN" then
			if self.INC < ( v.HD.HO - 80 ) then
				v.OpenTrigger = false
			elseif self.INC < ( v.HD.HO + 50 ) then
				v.OpenTrigger = true
			end
		end
	end
end

function ENT:CheckDoorStatus()
	if  !self.ST.UseDoors	||
		!self.Activated		||
		!self.FDT	then return end

	if self.ATL then
		for k,v in ipairs( self.FDT[ self.ST.FN ] ) do
			v.OpenTrigger = true
		end
	elseif !self.IsHolding then
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
	self.ST.PC = #self.PT
	
	local P1 = self.PT[ 1 ]
	
	if P1.PD.IsVisor then
		if P1.PD.Inv then
			P1.PD.model = ( "models/SmallBridge/Station Parts/sbbridgevisort.mdl" )
		else
			P1.PD.model = ( "models/SmallBridge/Station Parts/sbbridgevisorb.mdl" )
		end
	else
		if P1.PD.Inv then
			P1.PD.model = ( "models/SmallBridge/Elevators,"..self.Size[3].."/sb"..self.Size[2].."elevt"..string.sub( P1.PD.model , 44 ) )
		else
			P1.PD.model = ( "models/SmallBridge/Elevators,"..self.Size[3].."/sb"..self.Size[2].."elevb"..string.sub( P1.PD.model , 44 ) )
		end
	end
	self:RefreshPart( 1 )
	
	local P2 = self.PT[ self.ST.PC ]
	
	if P2.PD.IsVisor then
		if P2.PD.Inv then
			P2.PD.model = ( "models/SmallBridge/Station Parts/sbbridgevisorb.mdl" )
		else
			P2.PD.model = ( "models/SmallBridge/Station Parts/sbbridgevisort.mdl" )
		end
	else
		if P2.PD.Inv then
			P2.PD.model = ( "models/SmallBridge/Elevators,"..self.Size[3].."/sb"..self.Size[2].."elevb"..string.sub( P2.PD.model , 44 ) )
		else
			P2.PD.model = ( "models/SmallBridge/Elevators,"..self.Size[3].."/sb"..self.Size[2].."elevt"..string.sub( P2.PD.model , 44 ) )
		end
	end
	self:RefreshPart( self.ST.PC )

	for k,v in ipairs( self.PT ) do
		v:SetColor( 255 , 255 , 255 , 255 )
		self:CalcPanelModel( k )
		v:PhysicsInitialize()
	end
	self:PhysicsInitialize()
	
	CheckSkin( self.Entity , self.Skin )
	
	self:StartMotionController()
	
	self.ST.model = self:GetModel()
	
	self:WeldSystem()
	
	self.ST.FC = 0
	self.ST.FT = {}
	for k,v in ipairs( self.PT ) do
		if !v.PD.IsShaft then
			v:MakeWire()
			if v.PD.IsMultiFloor then
				v.PD.FN = {}
				for m,n in ipairs( v.PD.FO ) do
					self.ST.FC = self.ST.FC + 1
					self.ST.FT[self.ST.FC] = v.PD.HO - v.PD.ZDD + n + 4.65
					v.PD.FN[m] = self.ST.FC
				end
			else
				self.ST.FC = self.ST.FC + 1
				if v.PD.Inv then
					self.ST.FT[self.ST.FC] = v.PD.HO - v.PD.ZUD + 4.65
				else
					self.ST.FT[self.ST.FC] = v.PD.HO - v.PD.ZDD + 4.65
				end
				v.PD.FN = self.ST.FC
			end
		end
	end
	self.ST.FC = #self.ST.FT
	
	if self.ST.UseHatches then
		self:CreateHatches()
	elseif self.ST.UseDoors then
		self:CreateDoors()
	end
	
	self:MakeWire()
	
	self:AddCallFloorNum( 1 )
	
	self.Activated = true

end

function ENT:CreateHatches()
	
	self.HT = {}
	local HI = 0
	for k,v in ipairs(self.PT) do
		if !(k == #self.PT) then
			if not (v.PD.IsShaft && self.PT[k + 1].PD.IsShaft) then
				HI = HI + 1
				self.HT[HI] = ents.Create( "sbep_base_door" )
				local NH = self.HT[HI]
				NH:Spawn()
				NH.HD = {} --Hatch Data
				if self.Size[1] == "L" then
					NH:SetDoorType( "Door_ElevHatch_L" )
				else
					NH:SetDoorType( "Door_ElevHatch" )
				end
				NH:SetAngles( v:GetAngles() )
				
				local weldpart = 0
				if self.PT[k + 1].PD.IsShaft then
					if v.PD.Inv then
						NH.HD.PO = v.PD.ZDD - 4.65
					else
						NH.HD.PO = v.PD.ZUD - 4.65
					end
				else
					if v.PD.Inv then
						NH.HD.PO = v.PD.ZDD + 4.65
					else
						NH.HD.PO = v.PD.ZUD + 4.65
					end
					weldpart = 1
				end
				NH.HD.HO = v.PD.HO + NH.HD.PO
				NH:SetPos( self.StartPos + Vector(0,0,NH.HD.HO) )
				constraint.Weld( NH, self.PT[k + weldpart] , 0, 0, 0, true )
				
				if self.Skin then
					NH:SetSkin( self.Skin )
				end

				NH.OpenTrigger = false
				self:DeleteOnRemove(NH)
			end
		end
	end
	self.ST.HC = #self.HT
end

function ENT:CreateDoors()

	self.FDT = {}
	local FDI = 0
	for k,v in ipairs( self.PT ) do
		if !v.PD.IsShaft then
			FDI = FDI + 1
			self.FDT[ FDI ] = {}
			local inc = 0
			for m,n in ipairs( v.PD.AT ) do
				if n == 1 then
					inc = inc + 1
					self.FDT[ FDI ][ inc ] = ents.Create( "sbep_base_door" )
					local vec = Vector(-60.45,0,0)
					
					if self.Size[1] == "L" then
						if v.PD.IsDH then
							self.FDT[ FDI ][ inc ]:SetDoorType( "Door_DWDH" )
						else
							self.FDT[ FDI ][ inc ]:SetDoorType( "Door_DW" )
						end
						vec = Vector(-176.7,0,0)
					else
						if v.PD.IsDH then
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
	self.ST.FDC = #self.FDT
	self.DoorTrig = true

end

function ENT:WeldSystem() --Welds and nocollides the system once completed.
	
	if self.ST.PC > 1 then

		for k,v in ipairs( self.PT ) do
			if ValidEntity( v ) && ValidEntity(self.PT[k + 1]) then
				constraint.Weld( v , self.PT[k + 1] , 0 , 0 , 0 , true )
			end
			if ValidEntity( v ) && ValidEntity(self.PT[k + 2]) && (k/2 == math.floor(k/2)) then
				constraint.Weld( v , self.PT[k + 2] , 0 , 0 , 0 , true )
			end
			if ValidEntity( v ) && ValidEntity(self) then
				constraint.NoCollide( v , self , 0 , 0 )
			end
		end

		if ValidEntity(self.PT[1]) && ValidEntity(self.PT[self.ST.PC]) then
			constraint.Weld( self.PT[1] , self.PT[self.ST.PC] , 0 , 0 , 0 , true )
		end
	end
end

function ENT:CalcPanelModel( PartNum )

	local P = self.PT[ PartNum ]
	
	if P.PD.LTC == "R" && P.PD.Inv then
		P.PD.AT = table.Copy( {0,1,1,0} )
	end
	
	local function RotateAT( r )
		for i = 1 , r do
			table.insert( P.PD.AT , P.PD.AT[1] )
			table.remove( P.PD.AT , 1 )
		end
	end
	--Rotating the part access table.----------------
	if P.PD.LTC ~= "X" then
		RotateAT( P.PD.Yaw / 90 )
	end
	------------------------
	
	--Adds any new open access points to the model access table.------------------
	for k,v in ipairs( P.PD.AT ) do
		if v > self.ST.MAT[k] then
			self.ST.MAT[k] = v
		end
	end
	
	self.ST.MATSum = self.ST.MAT[1] + self.ST.MAT[2] + self.ST.MAT[3] + self.ST.MAT[4]
	
	DMT = PMT[self.Size[1]]
	
	--Using the model access table to work out the model and rotation of the elevator panel.-----------------
	if self.ST.MATSum == 4 then
		self:SetModel( DMT[1] )
		self.ST.AYO = 0
	elseif self.ST.MATSum == 1 then 
		self:SetModel( DMT[5] )
		self.ST.AYO = ((self.ST.MAT[4] * 90) + (self.ST.MAT[3] * 180) + (self.ST.MAT[2] * 270) )
	elseif self.ST.MATSum == 3 then 
		self:SetModel( DMT[2] )
		self.ST.AYO = (((self.ST.MAT[1] - 1) * -90) + ((self.ST.MAT[4] - 1) * -180) + ((self.ST.MAT[3] - 1) * -270))
	elseif self.ST.MATSum == 2 then 
		if self.ST.MAT[1] == self.ST.MAT[3] then
			self:SetModel( DMT[3] )
			self.ST.AYO = (self.ST.MAT[2] * 90)
		elseif self.ST.MAT[1] == self.ST.MAT[2] || self.ST.MAT[2] == self.ST.MAT[3] then
			self:SetModel( DMT[4] )
			if self.ST.MAT[1] == 1 then
				self.ST.AYO =  (self.ST.MAT[2] * -90) % 360
			elseif self.ST.MAT[3] == 1 then
				self.ST.AYO =  ((self.ST.MAT[4] * 90) + (self.ST.MAT[2] * 180)) % 360
			end
		end
	end
	------------------------------------------------

end

function ENT:MakeWire() --Adds the appropriate wire inputs.
	self.SBEP_WireInputsTable = {}
	self.SBEP_WireInputsTable[1] = "FloorNum"
	for k,v in ipairs( self.ST.FT ) do
		table.insert( self.SBEP_WireInputsTable , ( "Floor "..tostring(k) ) )
	end
	table.insert( self.SBEP_WireInputsTable , ( "Hold" ) )
	self.Inputs = Wire_CreateInputs(self.Entity, self.SBEP_WireInputsTable)
	
	self.Outputs = WireLib.CreateOutputs(self.Entity,{"Floor","Holding"})
end

function ENT:TriggerInput(k,v)

	if k == "FloorNum" then
		self:AddCallFloorNum( v )
	end
	
	for i = 1, self.ST.FC do
		if k == ("Floor "..tostring(i)) && v > 0 then
			self:AddCallFloorNum( i )
		end
	end
	
	if k == "Hold" && v > 0 then
		self:AddHoldDelay( 4 )
	end
end

function ENT:AddCallFloorNum( num )

	for k,v in ipairs( self.CFT ) do
		if v == num then return end
	end
	table.insert( self.CFT , num )

end

function ENT:PasteRefreshSystem()
	
	for n,P in ipairs( self.PT ) do
		local DT = LMT[self.Size[1]][ P.PD.model ]
		P:UpdatePartData( DT , self , n )
		P:MakeWire()
	end
	
	self:SetModel( self.ST.model )
	self:PhysicsInitialize()
	self:StartMotionController()
	self:MakeWire()
	self.Activated = true

end

function ENT:PreEntityCopy()
	local dupeInfo = {}

	dupeInfo.ST  = self.ST
	dupeInfo.INC = self.INC
	
	dupeInfo.DT = {}
	for k,v in pairs( self.PT ) do
		dupeInfo.DT[k] 		 = {}
		dupeInfo.DT[k].Index = v:EntIndex()
		dupeInfo.DT[k].PD 	 = v.PD
	end
	
	if self.ST.UseHatches then
		dupeInfo.HDT = {}
		for k,v in pairs( self.HT ) do
			dupeInfo.HDT[k]		  = {}
			dupeInfo.HDT[k].Index = v:EntIndex()
			dupeInfo.HDT[k].HD 	  = v.HD
		end
	end
	
	if self.ST.UseDoors then
		dupeInfo.FDDT = {}
		for k,v in pairs( self.FDT ) do
			dupeInfo.FDDT[k] = {}
			for m,n in pairs( v ) do
				dupeInfo.FDDT[k][m] = n:EntIndex()
			end
		end
	end
	
	if WireAddon then
		dupeInfo.WireData = WireLib.BuildDupeInfo( self.Entity )
	end
	
	duplicator.StoreEntityModifier(self, "SBEPLiftSysDupeInfo", dupeInfo)
end
duplicator.RegisterEntityModifier( "SBEPLiftSysDupeInfo" , function() end)

function ENT:PostEntityPaste(pl, Ent, CreatedEntities)

	self.ST			= Ent.EntityMods.SBEPLiftSysDupeInfo.ST
	
	self.Size		  = self.ST.Size
	self.Usable		  = self.ST.Usable
	
	self.PT			= {}
	for i = 1, self.ST.PC do
		self.PT[i] 				= CreatedEntities[Ent.EntityMods.SBEPLiftSysDupeInfo.DT[i].Index]
		self.PT[i].Controller 	= self.Entity
		self.PT[i].PD			= Ent.EntityMods.SBEPLiftSysDupeInfo.DT[i].PD
	end
	
	if self.ST.UseHatches then
		self.HT = {}
		for i = 1, self.ST.HC do
			self.HT[i] 				= CreatedEntities[Ent.EntityMods.SBEPLiftSysDupeInfo.HDT[i].Index]
			self.HT[i].HD			= Ent.EntityMods.SBEPLiftSysDupeInfo.HDT[i].HD
		end
	end
	
	if self.ST.UseDoors then
		self.FDT = {}
		for i = 1, self.ST.FDC do
			self.FDT[i] = {}
			for m,n in pairs( Ent.EntityMods.SBEPLiftSysDupeInfo.FDDT[i] ) do
				self.FDT[i][m] = CreatedEntities[ n ]
			end
		end
	end
	
	self:PasteRefreshSystem()
	self:AddCallFloorNum( self.ST.FN )
	
	if(Ent.EntityMods && Ent.EntityMods.SBEPLiftSysDupeInfo.WireData) then
		WireLib.ApplyDupeInfo( pl, Ent, Ent.EntityMods.SBEPLiftSysDupeInfo.WireData, function(id) return CreatedEntities[id] end)
	end

end