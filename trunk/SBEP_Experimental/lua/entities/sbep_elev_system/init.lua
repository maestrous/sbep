AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" ) 

ENT.WireDebugName = "SBEP Elevator System"

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

function ENT:Initialize()

	self:SetModel( PMT[self.Size[1]][5] ) 

	self.PT  = {} --Part Table
	self.ST  = {} --System Table
	self.FT  = {} --Floor Table
	self.HT  = {} --Hatch Table
	self.FDT = {} --Door Table

	self.Activated = false
	
	self.ST.MAT = {0,0,0,0} --Model Access Table

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

	self:CheckSkin()
	
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

function ENT:CreatePart()
	local NP = ents.Create( "sbep_elev_housing" )
		NP.Cont = self.Entity
		NP:Spawn()
		self.Entity:DeleteOnRemove( NP )
	return NP
end

function ENT:AddPartToTable( part , pos )
	self.PT[ pos ] = part
	part.PD.PN = pos
	self:SetNWInt( "SBEP_LiftPartCount" , self:GetPartCount() )
end

function ENT:RemovePartFromTable( pos )
	self.PT[ pos ]:Remove()
	table.remove( self.PT , pos )
	self:SetNWInt( "SBEP_LiftPartCount" , self:GetPartCount() )
end

function ENT:RefreshParts( N ) --Refreshes parts from the nth position upwards.
	for n,P in ipairs( self.PT ) do		
		if n >= N then
			P.PD.PN = n
			P:UpdateHeightOffsets()
			P:RefreshAng()
		end
	end
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

function ENT:GetPartCount()
	return #self.PT
end

function ENT:GetFloorCount()
	return #self.FT
end

function ENT:GetDoorCount()
	if self.FDT then
		return #self.FDT
	end
end

function ENT:GetHatchCount()
	if self.HT then
		return #self.HT
	end
end

function ENT:SetSystemSize( size )
	if size == 2 then
		self.Size = { "L" , "l" , "Large" , 1 }
	else
		self.Size = { "S" , "s" , "Small" , 0 }
	end
end

function ENT:CheckSkin()
	if self:SkinCount() > 5 then
		self:SetSkin( self.Skin * 2 )
	else
		self:SetSkin( self.Skin )
	end
end

function ENT:Think()

	if !self.Activated then	
		self.Entity:NextThink( CurTime() + 0.05 )
		return true
	end
	self.Entity:NextThink( CurTime() + 0.01 )
	
	if self.CFT[1] then
		self.TO = self.FT[self:GetFloorNum()]
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
	
	if --[[self.IsHolding ~= self.OIH &&]] self.ST.UseDoors then
		self:CheckDoorStatus()
	end
	--self.OIH = self.IsHolding
	
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
	for k,v in ipairs( self.FT ) do
		if endloop || ( k == #self.FT ) then break end
		if math.abs(self.INC) < math.abs( ( v + self.FT[k + 1] ) / 2 ) then
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
	local Pos2 = self.PT[self:GetPartCount()]:GetPos()
	
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
	if 	!self.ST.UseHatches 	||
		!self.Activated 		||
		self.ATL 				||
		!self.HT then return end

	for k,V in ipairs( self.HT ) do
		if self.Direction == "UP" then
			if self.INC > ( V.HD.HO + 20 ) then
				V.OpenTrigger = false
			elseif self.INC > ( V.HD.HO - 110 ) then
				V.OpenTrigger = true
			end
		elseif self.Direction == "DOWN" then
			if self.INC < ( V.HD.HO - 80 ) then
				V.OpenTrigger = false
			elseif self.INC < ( V.HD.HO + 50 ) then
				V.OpenTrigger = true
			end
		end
	end
end

function ENT:CheckDoorStatus()
	if  !self.ST.UseDoors	||
		!self.Activated		||
		!self.FDT	then return end

	if self.ATL then
		for k,V in ipairs( self.PT[ self:FloorToPartNum( self:GetFloorNum() ) ].PD.FDT ) do
			V.OpenTrigger = true
		end
	elseif !self.IsHolding then
		for k,V in ipairs( self.PT ) do
			for m,D in ipairs( V.PD.FDT ) do
				D.OpenTrigger = false
			end
		end
	end
end

function ENT:FinishSystem()

	self:RefreshParts( 1 ) --Refreshes all parts
	self:RemovePartFromTable( self:GetPartCount() ) --Removes the top ghost entity
	local C = self:GetPartCount()

	local P2 = self.PT[ C ] --Switches the top and bottom parts to have floors/ceilings
		if P2.PD.Inv then
			P2:SetPartClass( "B" )
		else
			P2:SetPartClass( "T" )
		end	
	local P1 = self.PT[ 1 ]
		if P1.PD.Inv then
			P1:SetPartClass( "T" )
		else
			P1:SetPartClass( "B" )
		end
	self:RefreshParts( 1 ) --Refreshes all parts

	for n,P in ipairs( self.PT ) do
		P:SetColor( 255 , 255 , 255 , 255 ) --Makes sure everything is opaque again
		self:CalcPanelModel( n ) --Works out what model the lift panel should be
		P:PhysicsInitialize() --Calls physics for all the parts, which have all had models changed
	end
	self:PhysicsInitialize() --Calls physics for self
	
	self:CheckSkin() --Sets skin of self
	
	self:StartMotionController()
	
	self.ST.model = self:GetModel()
	
	self:WeldSystem() --Welds and Nocollides the parts appropriately
	
	for n,P in ipairs( self.PT ) do --Setting up the floors 
		if !P.PD.SD.IsShaft then
			P:MakeWire()
			local C3 = math.Clamp( P.PD.Roll , 0 , 1 )
			local C4 = math.abs( C3 - 1 )
			if P.PD.SD.MFT then
				P.PD.FO = {}
				P.PD.FN = {}
				for m,n in ipairs( P.PD.SD.MFT ) do
					P.PD.FO[m] = P.PD.HO - C3*P.PD.ZUD - C4*P.PD.ZDD + 4.65 + n
					table.insert( self.FT , P.PD.FO[m] )
					P.PD.FN[m] = self:GetFloorCount()
				end
			else
				P.PD.FO = P.PD.HO - C3*P.PD.ZUD - C4*P.PD.ZDD + 4.65 --Calculates floor offset, depending on part roll offset
				table.insert( self.FT , P.PD.FO )
				P.PD.FN = self:GetFloorCount()
			end
		end
	end
	
	if self.ST.UseHatches then
		self:CreateHatches()
	elseif self.ST.UseDoors then
		self:CreateDoors()
	end
	
	self:MakeWire()
	
	self:AddCallFloorNum( 1 )
	
	self.Activated = true

end

function ENT:CreateHatches()		--Creating Hatches. Each Hatch is paired with the part below it, so the top part has no hatch associated.
	for k,V in ipairs(self.PT) do
		local V1 = self.PT[k + 1]
		if !(k == self:GetPartCount()) && !(V.PD.SD.IsShaft && V1.PD.SD.IsShaft) then
			local NH = ents.Create( "sbep_base_door" )
			NH:Spawn()
			NH.HD = {} 	--Hatch Data
			NH:SetDoorType( "Door_ElevHatch_"..self.Size[1] )
			NH:SetAngles( V:GetAngles() )
			
			local C3 = math.Clamp( V.PD.Roll , 0 , 1 )
			local C4 = math.abs( C3 - 1 )
				local S = 1
				if V1.PD.SD.IsShaft then S = -1 end
			NH.HD.PO = C3*V.PD.ZDD + C4*V.PD.ZUD + S*4.65	--Offset from paired part
			NH.HD.HO = V.PD.HO + NH.HD.PO					--Offset from system origin
			NH:SetPos( V:LocalToWorld( Vector(0,0,NH.HD.PO) ) )
			constraint.Weld( NH, self.PT[k + math.Clamp( S,0,1 )] , 0, 0, 0, true )
			NH:SetSkin( self.Skin )

			NH.OpenTrigger = false
			self:DeleteOnRemove(NH)
			table.insert( self.HT , NH )
		end
	end
end

local DoorTypes = {
	S = { "Door_Anim3"	, "Door_Anim3dh"	} ,
	L = { "Door_DW"		, "Door_DWDH"		}
				}

function ENT:CreateDoors()
	for k,V in ipairs( self.PT ) do
		V.PD.FDT = {}
		if !V.PD.SD.IsShaft then
			for m,n in ipairs( V.PD.AT ) do
				if n == 1 then
					local ND = ents.Create( "sbep_base_door" )
					ND:Spawn()
						local vec = Vector(-60.45 - self.Size[4]*116.25,0,0)
							vec:Rotate( Angle(0, (-90) * m ,0) )
						local d = 1
						if V.PD.SD.IsDH then d = 2 end
						ND:SetDoorType( DoorTypes[ self.Size[1] ][ d ] )
						ND:SetPos( V:GetPos() + vec )
						ND:SetAngles( Angle( 0 , 90 * m , 0 ) )
						self:DeleteOnRemove( ND )
						V:DeleteOnRemove( ND )
						ND:SetSkin( self.Skin )
						constraint.Weld( ND , V , 0 , 0 , 0 , true )
						ND:GetPhysicsObject():EnableMotion( true )
					table.insert( V.PD.FDT , ND )
				end
			end
		end
	end
end

function ENT:WeldSystem() --Welds and nocollides the system once completed.
	local C = self:GetPartCount()
	if C > 1 then
		for k,V in ipairs( self.PT ) do
			if ValidEntity( V ) && ValidEntity(self.PT[k + 1]) then
				constraint.Weld( V , self.PT[k + 1] , 0 , 0 , 0 , true )
			end
			if ValidEntity( V ) && ValidEntity(self.PT[k + 2]) && (k/2 == math.floor(k/2)) then
				constraint.Weld( V , self.PT[k + 2] , 0 , 0 , 0 , true )
			end
			if ValidEntity( V ) && ValidEntity(self) then
				constraint.NoCollide( V , self , 0 , 0 )
			end
		end
		if ValidEntity(self.PT[1]) && ValidEntity(self.PT[ C ]) then
			constraint.Weld( self.PT[1] , self.PT[ C ] , 0 , 0 , 0 , true )
		end
	end
end

function ENT:CalcPanelModel( PartNum )

	local P = self.PT[ PartNum ]
	
	if P.PD.TC == "R" && P.PD.Inv then
		P.PD.AT = {0,1,1,0}
	end
	
	local function RotateAT( r )
		for i = 1 , r do
			table.insert( P.PD.AT , P.PD.AT[1] )
			table.remove( P.PD.AT , 1 )
		end
	end
	--Rotating the part access table.----------------
	if P.PD.TC ~= "X" then
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
	local function SetLiftModel( n )
		self:SetModel( DMT[ n ] )
	end
	local S = self.ST.MATSum
	local T = self.ST.MAT
	
	--Using the model access table to work out the model and rotation of the elevator panel.-----------------
	if S == 4 then
		SetLiftModel( 1 )
		self.ST.AYO = 0
	elseif S == 1 then 
		SetLiftModel( 5 )
		self.ST.AYO = ((T[4] * 90) + (T[3] * 180) + (T[2] * 270) )
	elseif S == 3 then 
		SetLiftModel( 2 )
		self.ST.AYO = (((T[1] - 1) * -90) + ((T[4] - 1) * -180) + ((T[3] - 1) * -270))
	elseif S == 2 then 
		if T[1] == T[3] then
			SetLiftModel( 3 )
			self.ST.AYO = (T[2] * 90)
		elseif T[1] == T[2] || T[2] == T[3] then
			SetLiftModel( 4 )
			if T[1] == 1 then
				self.ST.AYO =  (T[2] * -90) % 360
			elseif T[3] == 1 then
				self.ST.AYO =  ((T[4] * 90) + (T[2] * 180)) % 360
			end
		end
	end
	------------------------------------------------

end

function ENT:MakeWire() --Adds the appropriate wire inputs.
	self.SBEP_WireInputsTable = {}
	self.SBEP_WireInputsTable[1] = "FloorNum"
	for k,v in ipairs( self.FT ) do
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
	
	for i = 1, self:GetFloorCount() do
		if k == ("Floor "..tostring(i)) && v > 0 then
			self:AddCallFloorNum( i )
		end
	end
	
	if k == "Hold" && v > 0 then
		self:AddHoldDelay( 4 )
	end
end

function ENT:AddCallFloorNum( FN )
	for k,v in ipairs( self.CFT ) do
		if v == FN then return end
	end
	table.insert( self.CFT , FN )
end

function ENT:FloorToPartNum( fn )
	for n,P in ipairs( self.PT ) do
		if P.PD.SD.MFT then
			for k,F in ipairs( P.PD.FN ) do
				if F == fn then return P.PD.PN end
			end
		else
			if P.PD.FN == fn then return P.PD.PN end
		end
	end
	return nil
end

function ENT:PartToFloorNum( pn )
	return self.PT[ pn ].FN
end

function ENT:GetFloorNum()
	return self.CFT[1]
end

function ENT:PasteRefreshSystem()
	
	for n,P in ipairs( self.PT ) do
		P:SetPartType( P.PD.T , self.Size[1] , self.Entity )
		P:UpdateHeightOffsets( self.Entity , n )
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
	
	dupeInfo.PT = {}
	for k,v in pairs( self.PT ) do
		dupeInfo.PT[k] = v:EntIndex()
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
	
	duplicator.StoreEntityModifier(self, "SBEPLS", dupeInfo)
end
duplicator.RegisterEntityModifier( "SBEPLS" , function() end)

function ENT:PostEntityPaste(pl, Ent, CreatedEntities)

	self.ST			= Ent.EntityMods.SBEPLS.ST
	
	self.Size		  = self.ST.Size
	self.Usable		  = self.ST.Usable
	
	self.PT			= {}
	for i = 1, self:GetPartCount() do
		self.PT[i] 				= CreatedEntities[Ent.EntityMods.SBEPLS.DT[i].Index]
	end
	
	if self.ST.UseHatches then
		self.HT = {}
		for i = 1, self.ST.HC do
			self.HT[i] 				= CreatedEntities[Ent.EntityMods.SBEPLS.HDT[i].Index]
			self.HT[i].HD			= Ent.EntityMods.SBEPLS.HDT[i].HD
		end
	end
	
	if self.ST.UseDoors then
		self.FDT = {}
		for i = 1, self.ST.FDC do
			self.FDT[i] = {}
			for m,n in pairs( Ent.EntityMods.SBEPLS.FDDT[i] ) do
				self.FDT[i][m] = CreatedEntities[ n ]
			end
		end
	end
	
	self:PasteRefreshSystem()
	self:AddCallFloorNum( 1 )
	
	if(Ent.EntityMods && Ent.EntityMods.SBEPLS.WireData) then
		WireLib.ApplyDupeInfo( pl, Ent, Ent.EntityMods.SBEPLS.WireData, function(id) return CreatedEntities[id] end)
	end

end