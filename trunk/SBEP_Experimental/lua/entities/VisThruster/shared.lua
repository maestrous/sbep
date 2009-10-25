ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.PrintName		= "VisThruster"
ENT.Author			= "Paradukes"
ENT.Category		= "SBEP - Other"

ENT.Spawnable		= true
ENT.AdminSpawnable	= true


function ENT:SetActive( val )
	self.Entity:SetNetworkedBool("ClActive",val,true)
end

function ENT:GetActive()
	return self.Entity:GetNetworkedBool("ClActive")
end