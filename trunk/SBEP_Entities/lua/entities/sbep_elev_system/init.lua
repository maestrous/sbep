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
	self.PartTable = {}
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

	if self.Activated then
		self.Increment = self.Increment + math.Clamp( ( self.TargetOffset - self.Increment) , -0.5 , 0.5 )

		self.Entity:NextThink( CurTime() + 0.01 )

		return true
	end
end

function ENT:PhysicsSimulate( phys, deltatime )

	if !self.Activated then return SIM_NOTHING end
	
	if ValidEntity(self.PartTable[1]) then
		self.PartTable[1].CurrentPos = self.PartTable[1]:GetPos()
		self.PartTable[1].CurrentAng = self.PartTable[1]:GetAngles()
	end
	
	if ValidEntity(self.PartTable[self.PartCount]) then
		self.PartTable[self.PartCount].Pos = self.PartTable[self.PartCount]:GetPos()
	end
		
	self.ShaftDirectionVector = self.PartTable[self.PartCount].Pos - self.PartTable[1].CurrentPos
	self.ShaftDirectionVector:Normalize()
	
	self.CurrentElevPos = self.PartTable[1].CurrentPos + (self.ShaftDirectionVector * self.Increment)
	self.CurrentElevAng = self.PartTable[1].CurrentAng
	self.CurrentElevAng:RotateAroundAxis( self.ShaftDirectionVector , self.AngleOffset.y )

	
	phys:Wake()
	
	self.ShadowParams.secondstoarrive = 0.005
	self.ShadowParams.pos = self.CurrentElevPos
	self.ShadowParams.angle = self.CurrentElevAng
	self.ShadowParams.deltatime = deltatime

	return phys:ComputeShadowControl(self.ShadowParams)

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
	self.Inverted 				= tonumber(args[8])
	self.CurrentModelNumber		= tonumber(args[9])
	self.PartXPosAccess		 	= tonumber(args[10])
	self.PartYNegAccess		 	= tonumber(args[11])
	self.PartXNegAccess		 	= tonumber(args[12])
	self.PartYPosAccess		 	= tonumber(args[13])
	self.ModelSuffix			= args[14]
	self.Shaft					= tonumber(args[15])

	self.GhostVecPos = Vector( self.GhostPos.x , self.GhostPos.y , self.GhostPos.z )
	
	self.PartCount = self.PartCount + 1
	if self.Shaft == 0 then
		self.FloorCount = self.FloorCount + 1
	end
	
	self.PartTable[self.PartCount] = ents.Create( "sbep_elev_housing" )
		self.PartTable[self.PartCount]:SetModel( self.GhostEntModel )
		self.PartTable[self.PartCount]:SetPos( self.GhostVecPos )
		self.PartTable[self.PartCount]:SetAngles( Angle(0,self.StartAngleYaw,self.StartAngleTwist) )
		
		self.PartTable[self.PartCount].Controller = self.Entity
		self:DeleteOnRemove(self.PartTable[self.PartCount])
		
		if self.Shaft == 0 then
			self.PartTable[self.PartCount].FloorNum = self.FloorCount
			self.PartTable[self.PartCount].Shaft	= 0
		else
			self.PartTable[self.PartCount].FloorNum = nil
			self.PartTable[self.PartCount].Shaft	= 1
		end
		
		self.PartTable[self.PartCount]:Initialize()
		
		self.PartTable[self.PartCount].ModelNumber = self.CurrentModelNumber
		self.PartTable[self.PartCount].HeightOffset = self.ModelHeightOffset
		self.PartTable[self.PartCount].PartPos = self.GhostVecPos
		
		local phys = self.PartTable[self.PartCount]:GetPhysicsObject()
			if ValidEntity(phys) then
				phys:EnableMotion(false)
			end

	self.NewGhostPos = self.GhostVecPos + Vector(0,0, self.ModelHeightOffset + 65.1)
	if self.Inverted == "1" and self.CurrentModelNumber == "3" then
		self.NewGhostPos = self.NewGhostPos - Vector(0,0, 130.2)
	end
	
	self.PartTable[self.PartCount].AccessTable = { self.PartXPosAccess , self.PartYNegAccess , self.PartXNegAccess , self.PartYPosAccess }
	
	//Rotating the part access table.----------------
	if self.StartAngleYaw == 90 then
		self.PartTable[self.PartCount].AccessTable[5] = self.PartTable[self.PartCount].AccessTable[1]
		
		self.PartTable[self.PartCount].AccessTable[1] = self.PartTable[self.PartCount].AccessTable[2]
		self.PartTable[self.PartCount].AccessTable[2] = self.PartTable[self.PartCount].AccessTable[3]
		self.PartTable[self.PartCount].AccessTable[3] = self.PartTable[self.PartCount].AccessTable[4]
		self.PartTable[self.PartCount].AccessTable[4] = self.PartTable[self.PartCount].AccessTable[5]
		
		self.PartTable[self.PartCount].AccessTable[5] = nil
	elseif self.StartAngleYaw == 180 then
		self.PartTable[self.PartCount].AccessTable[5] = self.PartTable[self.PartCount].AccessTable[1]
		self.PartTable[self.PartCount].AccessTable[6] = self.PartTable[self.PartCount].AccessTable[2]
		
		self.PartTable[self.PartCount].AccessTable[1] = self.PartTable[self.PartCount].AccessTable[3]
		self.PartTable[self.PartCount].AccessTable[2] = self.PartTable[self.PartCount].AccessTable[4]
		self.PartTable[self.PartCount].AccessTable[3] = self.PartTable[self.PartCount].AccessTable[5]
		self.PartTable[self.PartCount].AccessTable[4] = self.PartTable[self.PartCount].AccessTable[6]
		
		self.PartTable[self.PartCount].AccessTable[5] = nil
		self.PartTable[self.PartCount].AccessTable[6] = nil
	elseif self.StartAngleYaw == 270 then
		self.PartTable[self.PartCount].AccessTable[5] = self.PartTable[self.PartCount].AccessTable[4]
		
		self.PartTable[self.PartCount].AccessTable[4] = self.PartTable[self.PartCount].AccessTable[3]
		self.PartTable[self.PartCount].AccessTable[3] = self.PartTable[self.PartCount].AccessTable[2]
		self.PartTable[self.PartCount].AccessTable[2] = self.PartTable[self.PartCount].AccessTable[1]
		self.PartTable[self.PartCount].AccessTable[1] = self.PartTable[self.PartCount].AccessTable[5]
		
		self.PartTable[self.PartCount].AccessTable[5] = nil
	end
	//----------------------
	
	//Adds any new open access points to the model access table.------------------
	if self.PartTable[self.PartCount].AccessTable[1] > self.ModelAccessTable[1] then
		self.ModelAccessTable[1] = self.PartTable[self.PartCount].AccessTable[1]
	end
	if self.PartTable[self.PartCount].AccessTable[2] > self.ModelAccessTable[2] then
		self.ModelAccessTable[2] = self.PartTable[self.PartCount].AccessTable[2]
	end
	if self.PartTable[self.PartCount].AccessTable[3] > self.ModelAccessTable[3] then
		self.ModelAccessTable[3] = self.PartTable[self.PartCount].AccessTable[3]
	end
	if self.PartTable[self.PartCount].AccessTable[4] > self.ModelAccessTable[4] then
		self.ModelAccessTable[4] = self.PartTable[self.PartCount].AccessTable[4]
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
	self:SetNetworkedEntity( "SBEP_Part_"..tostring(self.PartCount) , self.PartTable[self.PartCount] )
	self:SetNetworkedFloat( "SBEP_PartCount" , self.PartCount)

end

function ENT:WeldSystem() //Welds and nocollides the system once completed.
	
	if self.PartCount > 0 then

		for i = 1, self.PartCount do
			if ValidEntity(self.PartTable[i]) and ValidEntity(self.PartTable[i + 1]) then
				constraint.Weld( self.PartTable[i] , self.PartTable[i + 1] , 0 , 0 , 0 , true )
			end
			if ValidEntity(self.PartTable[i]) and ValidEntity(self.PartTable[i + 2]) and (i/2 == math.floor(i/2)) then
				constraint.Weld( self.PartTable[i] , self.PartTable[i + 2] , 0 , 0 , 0 , true )
			end
			if ValidEntity(self.PartTable[i]) and ValidEntity(self) then
				constraint.NoCollide( self.PartTable[i] , self , 0 , 0 )
			end
		end

		if ValidEntity(self.PartTable[1]) and ValidEntity(self.PartTable[self.PartCount]) then
			constraint.Weld( self.PartTable[1] , self.PartTable[self.PartCount] , 0 , 0 , 0 , true )
		end

	end
	
end

function ENT:InitSystem( ply, args ) //Sets up the system for use.

		self.PartTable[self.PartCount]:SetModel( args[1] )
		self.PartTable[self.PartCount]:Initialize()

		self.ElevFloorDist = {}
		for i = 1, self.PartCount do
			if self.PartTable[i].Shaft == 0 then
				self.ElevFloorDist[self.PartTable[i].FloorNum] = (self.PartTable[i].PartPos - self.PartTable[1].PartPos - Vector(0,0,65.1 - 4.65)).z
			end
		end
		
		//*---------------
		local phys = self:GetPhysicsObject()
			if ValidEntity(phys) then
				phys:EnableMotion(true)
				phys:Wake()
			end
		--------------*/

		self.TargetOffset = self.ElevFloorDist[self.CurrentFloorNumber]
		
		/*----------
		for k,v in pairs(self.PartTable) do
			if ValidEntity(v) then
				self:DeleteOnRemove(v)
			end
		end
		--------*/

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

	if k == "Floor" then
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