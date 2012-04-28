
include('shared.lua')
--killicon.AddFont("seeker_missile", "CSKillIcons", "C", Color(255,80,0,255))
ENT.RenderGroup = RENDERGROUP_BOTH


function ENT:Initialize()
	self.CRo = 0
	self.LDT = CurTime()
	self.LPos = self:GetPos()
end

function ENT:Think()
	if !self.WM || !self.WM:IsValid() then
		self.WM = ClientsideModel("models/Slyfo/rover_snowtire.mdl", RENDERGROUP_BOTH)
		self.WM:SetPos(self:GetPos())
		self.WM:SetAngles(self:GetAngles())
		self.WM:SetParent(self)
	end
	/*
	if !self.Sprue || !self.WM:IsValid() then
		self.Sprue = ClientsideModel("models/Slyfo_2/mortarsys_launchtube.mdl", RENDERGROUP_BOTH)
		self.Sprue:SetPos(self:GetPos())
		self.Sprue:SetAngles(self:GetAngles())	
		self.Sprue:SetParent(self:GetParent())
		
		if self:GetLocalPos().y > 0 then
			self.Sprue:SetLocalPos(Vector(0,-10,0))
		else
			self.Sprue:SetLocalPos(Vector(0,10,0))
		end
	end
	*/
	
	local Delta = CurTime() - self.LDT
	--print(Delta)
	--self.Entity:DrawModel()
	
	local RVec = Vector(0,0,0)
	if Delta > 0 then
		RVec = (self:GetPos() - self.LPos) * (1 / Delta)
		--print((self:GetPos() - self.LPos),(1 / Delta))
		RVec:Rotate(self:GetAngles() * -1)
		--print(RVec)
		
		self.CRo = self.CRo + (RVec.x / 138.2)
	end
	
	
	--local BVec = Vector(0,0,0)
	--BVec = self:GetForward() * RVec.x * -FBr * phys:GetMass()
		
	if self.WM then
		self.WM:SetLocalAngles(Angle(self.CRo,0,0))
	end
	/*
	if self.Sprue then
		local End = self:GetLocalPos().x
		local Side = self:GetLocalPos().y
		
		local Y = 0
		local Mul = 1
		if End > 0 then
			Y = 90
		elseif End < 0 then
			Y = 70
		end
		
		if Side > 0 then
			Mul = -1
		end	
		
		self.Sprue:SetModelScale(Vector(0.2,0.2,0.6))
		
		self.Sprue:SetLocalAngles(Angle(90,Y*Mul,0))
		
	end
	*/
	
	self.LDT = CurTime()
	self.LPos = self:GetPos()
	
	self.Entity:NextThink( CurTime() + 0.01 ) 
	return true	
end

function ENT:Draw()
	
end

function ENT:DrawTranslucent()

	local CrossBeam = Material( "models/alyx/emptool_glow.vmt" )
	
	local End = self:GetLocalPos().x
	local Side = self:GetLocalPos().y
	
	local Pos = Vector(0,0,0)
	local Mul = 1
	if Side < 0 then
		Mul = -1
	end	
	if End > 0 then
		Pos = Vector(70,20 * Mul,-16)
	elseif End < 0 then
		Pos = Vector(-75,12 * Mul,10)
	end
	
	
	
	local V1 = self:GetPos() + self:GetRight() * 7 * Mul
	local V2 = self:GetParent():LocalToWorld(Pos)
 
	render.SetMaterial( CrossBeam )
	render.DrawBeam( V1, V2, 5, 1, 1, Color( 255, 255, 255, 255 ) ) 
	
end

function ENT:OnRemove()
	if self.WM then
		self.WM:Remove()
	end
	
	if self.Sprue then
		self.Sprue:Remove()
	end
end