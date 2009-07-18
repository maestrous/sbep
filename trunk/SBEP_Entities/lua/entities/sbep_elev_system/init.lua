AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" ) 

ENT.WireDebugName = "SBEP Elevator System"

local ElevatorModelsTable = {}
		ElevatorModelsTable[1] 		= "models/SmallBridge/Elevators,Small/sbselevp0.mdl"
		ElevatorModelsTable[2] 		= "models/SmallBridge/Elevators,Small/sbselevp1.mdl"
		ElevatorModelsTable[3] 		= "models/SmallBridge/Elevators,Small/sbselevp2e.mdl"
		ElevatorModelsTable[4] 		= "models/SmallBridge/Elevators,Small/sbselevp2r.mdl"
		ElevatorModelsTable[5] 		= "models/SmallBridge/Elevators,Small/sbselevp3.mdl"

function ENT:Initialize()
	
	self:SetModel( "models/SmallBridge/Elevators,Small/sbselevp3.mdl" ) 
	
	self.Editable = false
	self.PT = {}
	self.PartCount = 0
	self.FloorCount = 0
	self.ModelAccessTable = {0,0,0,0}
	self.Activated = false
	self.CurrentFloorNumber = 1
	self.Increment = -65.1
	self.ShadowParams = {}
		self.ShadowParams.maxangular = 5000 //What should be the maximal angular force applied
		self.ShadowParams.maxangulardamp = 10000 // At which force/speed should it start damping the rotation
		self.ShadowParams.maxspeed = 1000000 // Maximal linear force applied
		self.ShadowParams.maxspeeddamp = 10000// Maximal linear force/speed before  damping
		self.ShadowParams.dampfactor = 0.8 // The percentage it should damp the linear/angular force if it reachs it's max ammount
		self.ShadowParams.teleportdistance = 0 // If it's further away than this it'll teleport (Set to 0 to not teleport)

	self:SetNetworkedVector( "SBEP_GhostVecPos" , Vector(0,0,65.1))
	self:SetNetworkedFloat( "SBEP_PartCount" , self.PartCount)
	
	self:StartMotionController()
	
	self:PhysicsInitialize()
	
	self:MakeWire()

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

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16 + Vector(0,0,65.1)
	local RotAng   = Angle(0 , 0 , 0)
	
	local ent = ents.Create( "sbep_elev_system" )
	ent:SetPos( SpawnPos )
	ent:SetAngles( RotAng )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:Think()

	if !self.Activated then return end
	
	self.Increment = self.Increment + math.Clamp( ( self.TargetOffset - self.Increment) , -0.5 , 0.5 )
	if math.Round(self.Increment) == math.Round(self.OldIncrement) then
		self.AtTargetLocation = true
	else
		self.AtTargetLocation = false
	end
	self.OldIncrement = self.Increment
	
	if self.TargetOffset > self.Increment then
		self.Direction = "UP"
	else
		self.Direction = "DOWN"
	end

	self:CheckHatchStatus()
	
	self.Entity:NextThink( CurTime() + 0.01 )

	return true
end

function ENT:PhysicsSimulate( phys, deltatime )

	if !self.Activated then return SIM_NOTHING end
	
	if ValidEntity(self.PT[1]) then
		self.PT[1].CurrentPos = self.PT[1]:GetPos()
		self.PT[1].CurrentAng = self.PT[1]:GetAngles()
	end
	
	if ValidEntity(self.PT[self.PartCount]) then
		self.PT[self.PartCount].Pos = self.PT[self.PartCount]:GetPos()
	end
		
	self.ShaftDirectionVector = self.PT[self.PartCount].Pos - self.PT[1].CurrentPos
	self.ShaftDirectionVector:Normalize()
	
	self.CurrentElevPos = self.PT[1].CurrentPos + (self.ShaftDirectionVector * self.Increment)
	self.CurrentElevAng = self.PT[1].CurrentAng
	self.CurrentElevAng:RotateAroundAxis( self.ShaftDirectionVector , self.AngleOffset.y )

	
	phys:Wake()
	
	self.ShadowParams.secondstoarrive = 0.005
	self.ShadowParams.pos = self.CurrentElevPos
	self.ShadowParams.angle = self.CurrentElevAng
	self.ShadowParams.deltatime = deltatime

	return phys:ComputeShadowControl(self.ShadowParams)

end

function ENT:CheckHatchStatus()
	if !self.Activated then return end
	if self.AtTargetLocation then return end

	for k,v in ipairs( self.PT.Hatches ) do
		if self.Direction == "UP" then
			if self.Increment > ( v.Offset + 20 ) then
				v.OpenTrigger = false
			elseif self.Increment > ( v.Offset - 110 ) then
				v.OpenTrigger = true
			end
		elseif self.Direction == "DOWN" then
			if self.Increment < ( v.Offset - 80 ) then
				v.OpenTrigger = false
			elseif self.Increment < ( v.Offset + 50 ) then
				v.OpenTrigger = true
			end
		end
	end
end

function ENT:ConstructPart( args )

	self.GhostEntModel 			= args[1]
	self.GhostPos = {}
		self.GhostPos.x 		= tonumber(args[2])
		self.GhostPos.y 		= tonumber(args[3])
		self.GhostPos.z 		= tonumber(args[4])
	self.ModelHeightOffset	 	= tonumber(args[5])
	self.StartAngleYaw			= tonumber(args[6])
	self.StartAngleTwist 		= tonumber(args[7]) 				
	if tonumber(args[8])  == 1 then self.Inverted 	= true else self.Inverted 	= false end
	self.CurrentModelNumber		= tonumber(args[9])
	if tonumber(args[9])  == 3 then self.IsDH 		= true else self.IsDH 		= false end
	self.PartXPosAccess		 	= tonumber(args[10])
	self.PartYNegAccess		 	= tonumber(args[11])
	self.PartXNegAccess		 	= tonumber(args[12])
	self.PartYPosAccess		 	= tonumber(args[13])
	self.ModelSuffix			= args[14]
	if tonumber(args[15]) == 1 then self.IsShaft	= true else self.IsShaft	= false end
	
	if self.IsShaft and self.PartCount == 0 then return end

	self.GhostVecPos = Vector( self.GhostPos.x , self.GhostPos.y , self.GhostPos.z )
	
	self.PartCount = self.PartCount + 1
	if !self.IsShaft then
		self.FloorCount = self.FloorCount + 1
	end
	
	self.PT[self.PartCount] = ents.Create( "sbep_elev_housing" )
		self.PT[self.PartCount]:SetModel( self.GhostEntModel )
		self.PT[self.PartCount]:SetPos( self.GhostVecPos )
		self.PT[self.PartCount]:SetAngles( Angle(0,self.StartAngleYaw,self.StartAngleTwist) )
		
		self.PT[self.PartCount].Controller = self.Entity
		self.PT[self.PartCount].PartType = string.Left( self.ModelSuffix , 1 )
		self.PT[self.PartCount].IsDH = self.IsDH
		self:DeleteOnRemove(self.PT[self.PartCount])
		
		if !self.IsShaft then
			self.PT[self.PartCount].FloorNum = self.FloorCount
			self.PT[self.PartCount].IsShaft	= false
		else
			self.PT[self.PartCount].FloorNum = nil
			self.PT[self.PartCount].IsShaft	= true
		end
		
		if !self.IsShaft then
			self.PT[self.PartCount]:MakeWire()
		end
	
		self.PT[self.PartCount]:Initialize()
		
		self.PT[self.PartCount].ModelNumber = self.CurrentModelNumber
		self.PT[self.PartCount].HeightOffset = self.ModelHeightOffset
		self.PT[self.PartCount].PartPos = self.GhostVecPos
		
		local phys = self.PT[self.PartCount]:GetPhysicsObject()
			if ValidEntity(phys) then
				phys:EnableMotion(false)
			end

	self.NewGhostPos = self.GhostVecPos + Vector(0,0, self.ModelHeightOffset + 65.1)
	if self.Inverted == "1" and self.CurrentModelNumber == "3" then
		self.NewGhostPos = self.NewGhostPos - Vector(0,0, 130.2)
	end
	
	self.PT[self.PartCount].AccessTable = { self.PartXPosAccess , self.PartYNegAccess , self.PartXNegAccess , self.PartYPosAccess }
	
	//Rotating the part access table.----------------
	if self.StartAngleYaw == 90 then
		self.PT[self.PartCount].AccessTable[5] = self.PT[self.PartCount].AccessTable[1]
		
		self.PT[self.PartCount].AccessTable[1] = self.PT[self.PartCount].AccessTable[2]
		self.PT[self.PartCount].AccessTable[2] = self.PT[self.PartCount].AccessTable[3]
		self.PT[self.PartCount].AccessTable[3] = self.PT[self.PartCount].AccessTable[4]
		self.PT[self.PartCount].AccessTable[4] = self.PT[self.PartCount].AccessTable[5]
		
		self.PT[self.PartCount].AccessTable[5] = nil
	elseif self.StartAngleYaw == 180 then
		self.PT[self.PartCount].AccessTable[5] = self.PT[self.PartCount].AccessTable[1]
		self.PT[self.PartCount].AccessTable[6] = self.PT[self.PartCount].AccessTable[2]
		
		self.PT[self.PartCount].AccessTable[1] = self.PT[self.PartCount].AccessTable[3]
		self.PT[self.PartCount].AccessTable[2] = self.PT[self.PartCount].AccessTable[4]
		self.PT[self.PartCount].AccessTable[3] = self.PT[self.PartCount].AccessTable[5]
		self.PT[self.PartCount].AccessTable[4] = self.PT[self.PartCount].AccessTable[6]
		
		self.PT[self.PartCount].AccessTable[5] = nil
		self.PT[self.PartCount].AccessTable[6] = nil
	elseif self.StartAngleYaw == 270 then
		self.PT[self.PartCount].AccessTable[5] = self.PT[self.PartCount].AccessTable[4]
		
		self.PT[self.PartCount].AccessTable[4] = self.PT[self.PartCount].AccessTable[3]
		self.PT[self.PartCount].AccessTable[3] = self.PT[self.PartCount].AccessTable[2]
		self.PT[self.PartCount].AccessTable[2] = self.PT[self.PartCount].AccessTable[1]
		self.PT[self.PartCount].AccessTable[1] = self.PT[self.PartCount].AccessTable[5]
		
		self.PT[self.PartCount].AccessTable[5] = nil
	end
	//----------------------
	
	//Adds any new open access points to the model access table.------------------
	if self.PT[self.PartCount].AccessTable[1] > self.ModelAccessTable[1] then
		self.ModelAccessTable[1] = self.PT[self.PartCount].AccessTable[1]
	end
	if self.PT[self.PartCount].AccessTable[2] > self.ModelAccessTable[2] then
		self.ModelAccessTable[2] = self.PT[self.PartCount].AccessTable[2]
	end
	if self.PT[self.PartCount].AccessTable[3] > self.ModelAccessTable[3] then
		self.ModelAccessTable[3] = self.PT[self.PartCount].AccessTable[3]
	end
	if self.PT[self.PartCount].AccessTable[4] > self.ModelAccessTable[4] then
		self.ModelAccessTable[4] = self.PT[self.PartCount].AccessTable[4]
	end
	
	self.ModelAccessTableSum = self.ModelAccessTable[1] + self.ModelAccessTable[2] + self.ModelAccessTable[3] + self.ModelAccessTable[4]
	
	//Using the model access table to work out the model and rotation of the elevator panel.-----------------
	if self.ModelAccessTableSum == 4 then
		self:SetModel( ElevatorModelsTable[1] )
		self.AngleOffset =  Angle( 0, -90 , 0)
	elseif self.ModelAccessTableSum == 1 then 
		self:SetModel( ElevatorModelsTable[5] )
		self.AngleOffset =  Angle( 0, ((self.ModelAccessTable[4] * 90) + (self.ModelAccessTable[3] * 180) + (self.ModelAccessTable[2] * 270) ) , 0)
	elseif self.ModelAccessTableSum == 3 then 
		self:SetModel( ElevatorModelsTable[2] )
		self.AngleOffset =  Angle( 0, (((self.ModelAccessTable[1] - 1) * -90) + ((self.ModelAccessTable[4] - 1) * -180) + ((self.ModelAccessTable[3] - 1) * -270)) , 0)
	elseif self.ModelAccessTableSum == 2 then 
		if self.ModelAccessTable[1] == self.ModelAccessTable[3] then
			self:SetModel( ElevatorModelsTable[3] )
			self.AngleOffset =  Angle( 0, (self.ModelAccessTable[2] * 90) , 0)
		elseif self.ModelAccessTable[1] == self.ModelAccessTable[2] or self.ModelAccessTable[2] == self.ModelAccessTable[3] then
			self:SetModel( ElevatorModelsTable[4] )
			if self.ModelAccessTable[1] == 1 then
				self.AngleOffset =  Angle( 0, (self.ModelAccessTable[2] * -90) % 360 , 0)
			elseif self.ModelAccessTable[3] == 1 then
				self.AngleOffset =  Angle( 0, ((self.ModelAccessTable[4] * 90) + (self.ModelAccessTable[2] * 180)) % 360 , 0)
			end
		end
	end
	self:SetAngles( self.AngleOffset )
	//----------------------------------------------
	
	self:PhysicsInitialize()

	local phys = self:GetPhysicsObject()
		if ValidEntity(phys) then
			phys:EnableMotion(false)
		end

	self:SetNetworkedVector( "SBEP_GhostVecPos" , self.NewGhostPos)
	self:SetNetworkedEntity( "SBEP_Part_"..tostring(self.PartCount) , self.PT[self.PartCount] )
	self:SetNetworkedFloat( "SBEP_PartCount" , self.PartCount)

end

function ENT:WeldSystem() //Welds and nocollides the system once completed.
	
	if self.PartCount > 1 then

		for i = 1, self.PartCount do
			if ValidEntity(self.PT[i]) and ValidEntity(self.PT[i + 1]) then
				constraint.Weld( self.PT[i] , self.PT[i + 1] , 0 , 0 , 0 , true )
			end
			if ValidEntity(self.PT[i]) and ValidEntity(self.PT[i + 2]) and (i/2 == math.floor(i/2)) then
				constraint.Weld( self.PT[i] , self.PT[i + 2] , 0 , 0 , 0 , true )
			end
			if ValidEntity(self.PT[i]) and ValidEntity(self) then
				constraint.NoCollide( self.PT[i] , self , 0 , 0 )
			end
		end

		if ValidEntity(self.PT[1]) and ValidEntity(self.PT[self.PartCount]) then
			constraint.Weld( self.PT[1] , self.PT[self.PartCount] , 0 , 0 , 0 , true )
		end

	end
	
end

function ENT:InitSystem( ply, args ) //Sets up the system for use.

	self.PT[self.PartCount]:SetModel( args[1] )
	self.PT[self.PartCount]:Initialize()

	self.ElevFloorDist = {}
	for i = 1, self.PartCount do
		if !self.PT[i].IsShaft then
			self.ElevFloorDist[self.PT[i].FloorNum] = (self.PT[i].PartPos - self.PT[1].PartPos - Vector(0,0,65.1 - 4.65)).z
		end
	end

	local phys = self:GetPhysicsObject()
		if ValidEntity(phys) then
			phys:EnableMotion(true)
			phys:Wake()
		end

	self.TargetOffset = self.ElevFloorDist[self.CurrentFloorNumber]
	
	self.PT.Hatches = {}
	
	local HatchInc = 0
	self.HatchOffsetVal = 0
	for k,v in ipairs(self.PT) do
			if !(k == self.PartCount) then
				if !(k == 1) then
					self.HatchOffsetVal = self.HatchOffsetVal + 130.2
					if v.IsDH then
						self.HatchOffsetVal = self.HatchOffsetVal + 130.2
					end
				end
				if not (v.IsShaft and self.PT[k + 1].IsShaft) then
					HatchInc = HatchInc + 1
					self.PT.Hatches[HatchInc] = ents.Create( "sbep_base_door" )
					self.PT.Hatches[HatchInc]:Spawn()
					self.PT.Hatches[HatchInc]:SetDoorType( "Door_ElevHatch" )
					self.PT.Hatches[HatchInc]:SetAngles( v:GetAngles() )
					
					if self.PT[k + 1].IsShaft then
						HatchOff = 60.45
						if v.IsDH then
							HatchOff = HatchOff + 130.2
						end
						self.PT.Hatches[HatchInc]:SetPos( v:GetPos() + Vector(0,0,HatchOff) )
						constraint.Weld( self.PT.Hatches[HatchInc], v , 0, 0, 0, true )
					else
						HatchOff = 69.75
						if v.IsDH then
							HatchOff = HatchOff + 130.2
						end
						self.PT.Hatches[HatchInc]:SetPos( v:GetPos() + Vector(0,0,HatchOff) )
						constraint.Weld( self.PT.Hatches[HatchInc], self.PT[k + 1] , 0, 0, 0, true )
					end
					self.PT.Hatches[HatchInc].Offset = self.HatchOffsetVal + HatchOff
					self.PT.Hatches[HatchInc]:Close()
					self:DeleteOnRemove(self.PT.Hatches[HatchInc])
				end
			end
	end
	self.HatchCount = HatchInc

	self:StartMotionController()

	self:MakeWire()

	undo.Create("Elevator System") 
		undo.SetPlayer(ply) 
		undo.AddEntity(self.Entity) 
	undo.Finish()

	self.Activated = true

end

function ENT:MakeWire() //Adds the appropriate wire inputs.
	self.SBEP_WireInputsTable = {}
	self.SBEP_WireInputsTable[1] = "FloorNum"
	for i = 1, self.FloorCount do
		self.SBEP_WireInputsTable[i + 1] = "Floor "..tostring(i)
	end
	self.Inputs = Wire_CreateInputs(self.Entity, self.SBEP_WireInputsTable)
	//self.Outputs = WireLib.CreateOutputs(self.Entity,{""})
end

function ENT:TriggerInput(k,v)

	if k == "FloorNum" then
		self.CurrentFloorNumber = v
		self.TargetOffset = self.ElevFloorDist[self.CurrentFloorNumber]
	end
	
	for i = 1, self.FloorCount do
		if k == ("Floor "..tostring(i)) and v == 1 then
			self.CurrentFloorNumber = i
			self.TargetOffset = self.ElevFloorDist[self.CurrentFloorNumber]
		end
	end
end

function ENT:SetCallFloorNum( num )

	self.CurrentFloorNumber = num
	self.TargetOffset = self.ElevFloorDist[self.CurrentFloorNumber]

end