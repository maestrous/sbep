
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()

	self.Entity:SetModel( "models/Items/AR2_Grenade.mdl" )
	self.Entity:SetName("Artillery Shell")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableGravity(false)
		phys:EnableDrag(false)
		phys:EnableCollisions(true)
	end
	
	self.cbt = {}
	self.cbt.health = 5000
	self.cbt.armor = 500
	self.cbt.maxhealth = 5000
		
    --self.Entity:SetKeyValue("rendercolor", "0 0 0")
	self.PhysObj = self.Entity:GetPhysicsObject()
	self.CAng = self.Entity:GetAngles()
	util.SpriteTrail( self.Entity, 0, Color(50,50,50,50), false, 10, 0, 1, 1, "trails/smoke.vmt" ) --"trails/smoke.vmt"

	self.Drunk = self.Drunk or 1
	self.CSAng = math.random(0,360)
	self.CSSpeed = math.random(-100 * self.Drunk,100 * self.Drunk)
	self.CSXSp = math.random(0,10 * self.Drunk)
	self.CSYSp = math.random(0,10 * self.Drunk)
	self.STime = CurTime()
end

function ENT:PhysicsUpdate(phys)
	
	if(self.Exploded) then
		self.Entity:Remove()
		return
	end

end

function ENT:Think()

	local LTime = CurTime() - self.STime
	
	if LTime > 10 then
		self:GoBang()
	end

	self.CSAng = math.fmod(self.CSAng + self.CSSpeed,360)
	--print(self.CSAng)
	local XShift = math.sin(math.rad( self.CSAng )) * self.CSXSp
	local YShift = math.cos(math.rad( self.CSAng )) * self.CSYSp

	self.Entity:GetPhysicsObject():SetVelocity((self.Entity:GetForward() * (1000 + (LTime * 100))) + (self.Entity:GetRight() * XShift)+ (self.Entity:GetUp() * YShift))
	
	local trace = {}
	trace.start = self.Entity:GetPos()
	trace.endpos = self.Entity:GetPos() + (self.Entity:GetVelocity())
	trace.filter = self.Entity
	local tr = util.TraceLine( trace )
	if tr.Hit and tr.HitSky then
		self.Entity:Remove()
	end
	
	self:NextThink(CurTime() + 0.1)
	return true
end

function ENT:PhysicsCollide( data, physobj )
	if(!self.Exploded) then
		self.Entity:GoBang()
	end
end

function ENT:OnTakeDamage( dmginfo )
	if(!self.Exploded) then
		--self.Entity:GoBang()
	end
end

function ENT:Use( activator, caller )

end

function ENT:GoBang()
	self.Exploded = true
	util.BlastDamage(self.Entity, self.Entity, self.Entity:GetPos(), 200, 75)
	gcombat.hcgexplode( self.Entity:GetPos(), 200, math.Rand(50, 100), 7)

	self.Entity:EmitSound("explode_4")
	
	local effectdata = EffectData()
	effectdata:SetOrigin(self.Entity:GetPos())
	effectdata:SetStart(self.Entity:GetPos())
	effectdata:SetAngle(self.Entity:GetAngles())
	util.Effect( "TinyWhomphSplode", effectdata )
end