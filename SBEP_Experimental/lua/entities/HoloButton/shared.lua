ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.PrintName		= "Holo Input"
ENT.Author			= "Paradukes + SlyFo"
ENT.Category		= "SBEP-Other"

ENT.Spawnable		= true
ENT.AdminSpawnable	= true

function ENT:SetActive( val )
	self.Entity:SetNetworkedBool("ClActive",val,true)
end

function ENT:GetActive()
	return self.Entity:GetNetworkedBool("ClActive")
end

function ENT:SetController( val )
	self.Entity:SetNetworkedEntity("ClPilot",val,true)
end

function ENT:GetController()
	return self.Entity:GetNetworkedEntity("ClPilot")
end