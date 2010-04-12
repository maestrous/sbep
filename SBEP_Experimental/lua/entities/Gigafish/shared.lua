ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.PrintName		= "Gigafish"
ENT.Author			= "Paradukes"
ENT.Category		= "SBEP - Weapons"

ENT.Spawnable		= false
ENT.AdminSpawnable	= true
ENT.TogC			= 0

ENT.HPType			= "Small"
ENT.APPos			= Vector(10,0,0)


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