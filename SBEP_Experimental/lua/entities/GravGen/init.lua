
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()

	self.Entity:SetModel( "models/Slyfo_2/rocketpod_smallrockethalf.mdl" ) 
	self.Entity:SetName("Rotate")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Inputs = Wire_CreateInputs( self.Entity, { "Gravity","Radius" } )
	
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableGravity(false)
		phys:EnableDrag(false)
		phys:EnableCollisions(false)
		phys:SetMass( 1 )
	end
	
	self.Entity:StartMotionController()
	
	self.Entity:SetKeyValue("rendercolor", "255 255 255")
	self.PhysObj = self.Entity:GetPhysicsObject()
	
	self.Speed = 0
	self.OAng = Angle(0,0,0)
	self.Radius = 1000
	self.Strength = 10
	self.NextScan = 0
end

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	
	local ent = ents.Create( "GravGen" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	ent.SPL = ply
	
	return ent
	
end

function ENT:TriggerInput(iname, value)		
	if (iname == "Gravity") then
		self.Strength = value
	elseif (iname == "Radius") then
		self.Radius = value
	end
end

function ENT:PhysicsUpdate()

end

function ENT:Think()
	if CurTime() > self.NextScan then
		--print("Scanning...")
		self.Targets = {}
		local ScanResult = ents.FindInSphere(self:GetPos(), self.Radius)
		for k,e in pairs( ScanResult ) do
			if e != self then
				if e:IsPlayer() then
					if e.GravCon && e.GravCon:IsValid() then
						e.GravCon.GravMode = 2
						e.GravCon.GravGen = self
					else
						if !(e:GetVehicle() && e:GetVehicle():IsValid()) || e:GetMoveType() == 8 then
							local NGrav = ents.Create( "GravRotator" )
							NGrav:SetPos( e:GetPos() )
							NGrav:Spawn()
							NGrav:Activate()
							NGrav.CPL = e
							e.GravCon = NGrav
							NGrav.GravGen = self
							NGrav.GravMode = 2
						end
					end
				else
					table.insert(self.Targets,e)
				end
			end
		end
		self.NextScan = CurTime() + 1
	end
	
	for k,e in pairs (self.Targets) do
		if e && e:IsValid() then
			local Phys = e:GetPhysicsObject()
			if Phys && Phys:IsValid() then
				Phys:ApplyForceCenter((self:GetPos() - e:GetPos()):GetNormal() * self.Strength)
			end
		end
	end
	
	self.Entity:NextThink( CurTime() + 0.01 ) 
	return true
end

function ENT:PhysicsCollide( data, physobj )
	
end

function ENT:OnTakeDamage( dmginfo )
	
end

function ENT:Use( activator, caller )

end

function ENT:Touch( ent )

end

function ENT:BuildDupeInfo()
	local info = self.BaseClass.BuildDupeInfo(self) or {}
	if (self.Side) then
		info.Side = self.Side
	end
	if (self.Mounted) then
		info.Mounted = self.Mounted
	end
	if (self.Pod) and (self.Pod:IsValid()) then
		info.Pod = self.Pod:EntIndex()
	end
	if (self.Cont) and (self.Cont:IsValid()) then
		info.Cont = self.Cont:EntIndex()
	end
	return info
end

function ENT:ApplyDupeInfo(ply, ent, info, GetEntByID)
	self.BaseClass.ApplyDupeInfo(self, ply, ent, info, GetEntByID)
	if (info.Cont) then
		self.Cont = GetEntByID(info.Cont)
		if (!self.Cont) then
			self.Cont = ents.GetByIndex(info.Cont)
		end
	end
	if (info.Pod) then
		self.Pod = GetEntByID(info.Pod)
		if (!self.Pod) then
			self.Pod = ents.GetByIndex(info.Pod)
		end
	end
	if (info.Mounted) then
		self.Mounted = info.Mounted
	end
	if (info.Side) then
		self.Side = info.Side
	end
	self.SPL = ply
end