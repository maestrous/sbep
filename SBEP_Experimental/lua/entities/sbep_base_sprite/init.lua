AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()

	self.Entity:SetModel( "models/Combine_Helicopter/helicopter_bomb01.mdl" )
	
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:DrawShadow( false )
	
	self:SetNWString( "SBEPSpriteType" , "SWSH" )

	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableGravity(false)
		phys:EnableDrag(false)
		phys:EnableCollisions(false)
	end
	
	self.TD = 0
	self.TS = CurTime()
	self.set = false
	
end

function ENT:Think()

	if self.TD > 0 && CurTime() > self.TS + self.TD then self:Remove() return end

	if !self.SEO || !self.SEO:IsValid() then
		if !self.set then 
			self.TS = CurTime() 
			self.set = true
		end
		self.TD = 10
		return
	else
		self.TD = 0
	end
	
	if !self.Offset || !self.Dir then 
		self.Following = false 
	end

	if self.Following then
		self:SetPos( self.SEO:LocalToWorld( self.Offset ) )
		self:SetAngles( self.SEO:LocalToWorldAngles( self.Dir ) )
	end
	
	self:NextThink( CurTime() + 0.02 )
	return true
end

function ENT:SetSpriteType( type )

	self:SetNWString( "SBEPSpriteType" , type )

end

function ENT:GetSpriteType()

	return self:GetNWString( "SBEPSpriteType" )

end