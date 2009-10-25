
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()

	self.Entity:SetModel( "models/Items/AR2_Grenade.mdl" )
	self.Entity:SetName("Thruster")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	--self.Entity:SetMaterial("models/props_combine/combinethumper002")
	self.Inputs = Wire_CreateInputs( self.Entity, { "Active"  } )
	
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableGravity(false)
		phys:EnableDrag(false)
		phys:EnableCollisions(false)
	end
	
    --self.Entity:SetKeyValue("rendercolor", "0 0 0")
	self.PhysObj = self.Entity:GetPhysicsObject()
	self.CAng = self.Entity:GetAngles()
	
	self.NFire = 0
	self.MCD = 0
	self.CSpeed = 0
end

function ENT:TriggerInput(iname, value)		
	
	if (iname == "Active") then
		if value > 0 then
			self.NBT = CurTime() + 1
			self.Entity:SetActive(true)
		else
			self.NBT = CurTime() + 1
			self.Entity:SetActive(false)
		end
	end	
end

function ENT:Think()
	
	--self.Entity:SetSpeed(math.Clamp(self.CSpeed,0,1000))

	if self:GetParent():IsValid() then
		self.Entity:SetLocalPos(Vector(0,0,0))
	end
	
	--self.Entity:NextThink(CurTime() + 0.01)
	
	--return true
end

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16 + Vector(0,0,50)
	
	local ent = ents.Create( "VisThruster" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Initialize()
	ent:Activate()
	ent.SPL = ply
	
	return ent
	
end

