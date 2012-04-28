
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()

	self.Entity:SetModel( "models/props_junk/PopCan01a.mdl" ) 
	self.Entity:SetName("ProtoRover")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( 0 )
	
	if WireAddon then
		local V,N,A,E = "VECTOR","NORMAL","ANGLE","ENTITY"
		self.Outputs = WireLib.CreateSpecialOutputs( self, 
			{ "CPos", "Pos", "Vel", "Ang" },
			{V,V,V,A})
	end
	
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableGravity(false)
		phys:EnableDrag(false)
		phys:EnableCollisions(false)
		phys:SetMass(1)
	end
	self.Entity:SetKeyValue("rendercolor", "255 255 255")
	self.PhysObj = self.Entity:GetPhysicsObject()
	
	self.CFSpeed = 0
	
	
	self.EMount = true
	self.HasHardpoints = true
	self.Cont = self.Entity
		
	self.HPC			= 4
	self.HP				= {}
	self.HP[1]			= {}
	self.HP[1]["Ent"]	= nil
	self.HP[1]["Type"]	= "Tiny"
	self.HP[1]["Pos"]	= Vector(70,20,-6)
	self.HP[1]["Angle"] = Angle(0,0,0)
	self.HP[2]			= {}
	self.HP[2]["Ent"]	= nil
	self.HP[2]["Type"]	= "Tiny"
	self.HP[2]["Pos"]	= Vector(70,-20,-6)
	self.HP[2]["Angle"] = Angle(0,0,0)
	self.HP[3]			= {}
	self.HP[3]["Ent"]	= nil
	self.HP[3]["Type"]	= { "Tiny", "Small" }
	self.HP[3]["Pos"]	= Vector(-15,30,5)
	self.HP[3]["Angle"] = Angle(0,0,-90)
	self.HP[4]			= {}
	self.HP[4]["Ent"]	= nil
	self.HP[4]["Type"]	= { "Tiny", "Small" }
	self.HP[4]["Pos"]	= Vector(-15,-30,5)
	self.HP[4]["Angle"] = Angle(0,0,90)
	
	local SpawnPos = self:GetPos()
	
	local Body = ents.Create( "prop_vehicle_prisoner_pod" )
	Body:SetModel( "models/Slyfo_2/protorover.mdl" ) 
	Body:SetPos( self:GetPos() + Vector(0,0,50) )
	--self:SetPos(Body:GetPos())
	Body:Spawn()
	Body:Activate()
	Body:SetKeyValue("vehiclescript", "scripts/vehicles/prisoner_pod.txt")
	Body:SetKeyValue("limitview", 0)
	local TB = Body:GetTable()
	TB.HandleAnimation = function (vec, ply)
		return ply:SelectWeightedSequence( drive_jeep ) 
	end 
	--Body:SetParent(self)
	self.Body = Body
	Body.ContEnt = self
	Body.Cont = self
	Body:SetNetworkedInt( "HPC", self.HPC )
	Body.HasHardpoints = true
	--local Weld = constraint.Weld(self,Body)
	self:SetParent(Body)
	
	--self:SetLocalPos(Vector(0,0,0))
	
	
	local phys = Body:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableGravity(true)
		phys:EnableDrag(true)
		phys:EnableCollisions(true)
		phys:SetMass( 1000 )
	end
	--gcombat.registerent( Body, 150, 800 )
	
	
	
	local Rear = ents.Create( "prop_physics" )
	Rear:SetModel( "models/Slyfo_2/power_unit.mdl" ) 
	Rear:SetPos( SpawnPos )
	Rear:Spawn()
	Rear:Activate()
	Rear:SetParent(Body)
	Rear:SetLocalPos(Vector(-70,0,10))
	Rear:SetLocalAngles(Angle(90,0,0))
	self.Rear = Rear
	--local Weld = constraint.Weld(ent,Tail)
	
	
	--self.Body:SetNetworkedEntity("ViewEnt",self.Rear,true)
	self.Body:SetNetworkedInt("OffsetOut",160,true)
	self.Body:SetNetworkedInt("OffsetUp",40,true)
	
	
	local phys = Rear:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableGravity(false)
		phys:EnableDrag(true)
		phys:EnableCollisions(true)
		phys:SetMass( 1 )
	end
	--gcombat.registerent( Rear, 100, 7000 )
	
	self:SetNetworkedEntity("Pod",Body,true)
	self:SetNetworkedEntity("Rear",Rear,true)
	
	
	
	
	
	self.RotorSpeed = 0
	self.RotorAng = 0
	
	self:SetLocalPos(Vector(0,0,0))
	self.Entity:SetColor( 0, 0, 0, 0 )
	
	local WRight = 50
	local WForward = 90
	local WUp = 0
	
	self.CSnd = 0
		

	self.WPs = { 	LF = { Pos = Vector( WForward,-WRight,WUp) },
					RF = { Pos = Vector( WForward, WRight,WUp) },
					LB = { Pos = Vector(-WForward,-WRight,WUp) },
					RB = { Pos = Vector(-WForward, WRight,WUp) }
				}
	
end

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16 + Vector(0,0,350)
	
	local ent = ents.Create( "ProtoRover" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	ent.SPL = ply
				
	return ent
end

function ENT:OnRemove()
	if self.Body && self.Body:IsValid() then
		self.Body:Remove()
	end
end

function ENT:PhysicsUpdate()

end

function ENT:Think()
	
	local Phys = nil
	if self.Body && self.Body:IsValid() then
		Phys = self.Body:GetPhysicsObject()
		self.CPL = self.Body:GetPassenger()
		
		local WRight = 50
		local WForward = 90
		
		for k,e in pairs(self.WPs) do
			--print("Thinking...")
			local w = e.Ent
			if !w || !w:IsValid() then
				--print("We have no wheel; making a new one.")
				local WE = ents.Create( "ProtoRoverWheel" )
				--WE:SetModel( "models/Slyfo/rover_snowtire.mdl" ) 
				
				WE:SetPos( self:LocalToWorld(e.Pos) )
				WE:SetAngles( self:GetAngles() )
				WE:Spawn()
				
				WE:Activate()
				WE:SetParent(self.Body)
				WE:SetLocalPos(e.Pos)
				WE:SetLocalAngles(Angle(0,0,0))
				WE.OffPos = e.Pos
				WE.Pod = self.Body
				WE.Drv = self
				
				local p = WE:GetPhysicsObject()
				if (p:IsValid()) then
					p:Wake()
					p:EnableGravity(true)
					p:EnableDrag(true)
					p:EnableCollisions(true)
					--p:SetMass( 1 )
				end
				local cs = constraint.Weld(WE, self.Body, 0, 0, 0, true)
				e.Ent = WE
			end
		
		end
		--self:EmitSound("ProtoRover/EngineRev.mp3", 400, math.Clamp(self.RotorSpeed * 3,30,200))
		
		
		if self.CPL && self.CPL:IsValid() then
			if !self.CSnd then
				self:EmitSound("JNK_engine_start")
				self.CSnd = 1
			end
			
			
			if (self.CPL:KeyDown( IN_FORWARD )) then
				if self.CSnd != 2 then
					self:StopSound( "JNK_engine_start" )
					self:StopSound( "JNK_engine_idle" )
					self:StopSound("JNK_throttleoff_slowspeed")
					self:EmitSound("JNK_fourthgear")
					self.CSnd = 2
				end
				DFSpeed = 16000
			elseif (self.CPL:KeyDown( IN_BACK )) then
				DFSpeed = -4000
			else
				if self.CSnd > 1 then
					--print(self.CSnd)
					self:StopSound( "JNK_fourthgear" )
					self:StopSound( "JNK_engine_start" )
					self:StopSound( "JNK_engine_idle" )
					--self:StopSound( "JNK_engine_idle" )
					self:EmitSound("JNK_throttleoff_slowspeed")
					self.CSnd = 1
				elseif self.CSnd != 1 then
					self:StopSound( "JNK_fourthgear" )
					self:EmitSound("JNK_engine_idle")
					self.CSnd = 1
				end
				DFSpeed = 0
			end
			
			self.CFSpeed = math.Approach(self.CFSpeed,DFSpeed,900)
			
			
			--print(self.CFSpeed)
			
			for i = 1,self.HPC do
				if self.HP[i]["Ent"] && self.HP[i]["Ent"]:IsValid() then
					local Phys = self.HP[i]["Ent"]:GetPhysicsObject()
					if Phys && Phys:IsValid() then
						Phys:EnableGravity(false)
						Phys:EnableDrag(false)
						Phys:EnableCollisions(false)
						Phys:SetMass( 1 )
					end
				end
			end
			
			---------------------------------------- Primary Attack ----------------------------------------
			if ( self.CPL:KeyDown( IN_ATTACK ) ) then
				if self.HPC && self.HPC > 0 then
					for i = 1, self.HPC do
						local HPC = self.CPL:GetInfo( "SBHP_"..i )
						--print(HPC)
						--print(string.byte(HPC))
						if self.HP[i]["Ent"] && self.HP[i]["Ent"]:IsValid() && (tonumber(HPC) > 0) then
							if self.HP[i]["Ent"].Cont && self.HP[i]["Ent"].Cont:IsValid() then
								self.HP[i]["Ent"].Cont:HPFire()
							else
								self.HP[i]["Ent"].Entity:HPFire()
							end
						end
					end
				end
			end
			
			
			---------------------------------------- Secondary Attack ----------------------------------------
			if ( self.CPL:KeyDown( IN_ATTACK2 ) ) then
				if self.HPC && self.HPC > 0 then
					for i = 1, self.HPC do
						local HPC = self.CPL:GetInfo( "SBHP_"..i.."a" )
						if self.HP[i]["Ent"] && self.HP[i]["Ent"]:IsValid() && (tonumber(HPC) > 0) then
							if self.HP[i]["Ent"].Cont && self.HP[i]["Ent"].Cont:IsValid() then
								self.HP[i]["Ent"].Cont:HPFire()
							else
								self.HP[i]["Ent"].Entity:HPFire()
							end
						end
					end
				end
			end	
			
			
			
			
			if self.CPL.SBEPYaw == 0 && self.CPL.SBEPPitch == 0 then
				if self.OPAng then
					self.CPL:SetEyeAngles(self:WorldToLocalAngles(self.OPAng):Forward():Angle())
				else
					self.OPAng = self.CPL:EyeAngles()
				end
			else
				self.OPAng = nil
			end
			
		else
			self.CFSpeed = 0
			if self.CSnd then
				self:EmitSound( "JNK_engine_stop" )
				self.CSnd = nil
			end
			self:StopSound( "JNK_engine_start" )
			self:StopSound( "JNK_engine_idle" )
			self:StopSound("JNK_throttleoff_slowspeed")
			
		end
	else
		
		self:Remove()
	end
		
	
	
	if Phys:IsValid() then
		if self.Active then
			--if Phys && Phys:IsValid() then
				--Phys:EnableGravity(false)
			--end
			--Phys:SetVelocity(Phys:GetVelocity() * .96)
			--if self.Fwd > -90 then
			--	local Lift = math.Clamp(self:GetForward():DotProduct( Phys:GetVelocity() ) , 0 , 500 ) * 0.02
				--print(self:GetForward():DotProduct( Phys:GetVelocity() ))
				--if self.RWingE && self.RWingE:IsValid() && self.LWingE && self.LWingE:IsValid() then
			--		Phys:ApplyForceCenter(self:GetUp() * (Lift * Phys:GetMass()) )
					--Phys:ApplyForceOffset(self.RWing:GetForward() * (self.Thrust * Phys:GetMass()), self:GetPos() + self:GetForward() * 86 + self:GetRight() * 50 )
					--Phys:SetVelocity(self.RWing:GetForward() * self.Thrust)
				--end
			--else
				
			--end
		--	Phys:ApplyForceCenter(self:GetUp() * (self.Thrust * Phys:GetMass()) )
		else
			if Phys && Phys:IsValid() then
				--Phys:EnableGravity(true)
			end
		end
	end
	
	
	self.Entity:NextThink( CurTime() + 0.01 ) 
	return true	
end

function ENT:PhysicsCollide( data, physobj )
	if data.Speed > 200 then
		local P = data.HitObject:GetMass()
		if data.HitEntity:IsWorld() then
			P = 1000
		end
		--gcombat.hcghit( self, data.Speed * 1, P, self:GetPos(), self:GetPos())
	end
end

function ENT:OnTakeDamage( dmginfo )
	
end

function ENT:Use( activator, caller )

end

function ENT:Touch( ent )
	if ent:IsVehicle() then
		self.Pod = ent
	end
end