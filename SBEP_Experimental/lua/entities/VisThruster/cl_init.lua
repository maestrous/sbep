include('shared.lua')
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
function ENT:Initialize()
	
 	// This is how long the spawn effect
 	// takes from start to finish.
 	self.Time = 15
 	self.ESTime = CurTime() + 3.5
 	self.EFTime = CurTime() + 14
 	self.LifeTime = CurTime() + self.Time
 	self.STime = CurTime()
 	self.CSpeed = 0
 	 
 	
 	--self:SetRenderBoundsWS( self.Vec1, self.Vec2 )
 	self:SetRenderBounds( Vector(1000,1000,1000), Vector(-1000,-1000,-1000) )--I need to fix this.
 	
 	--self.Entity:SetModel( "models/props_combine/portalball.mdl" )
 	--self.Entity:SetColor(250,160,255,255)
 	--self.Entity:SetMaterial("Models/effects/comball_sphere")
 	self.Heat = Material( "sprites/heatwave" )
 	
 	self.OPos = self.Entity:GetPos()
 	
end

function ENT:Draw()
	local Pos = self.Entity:GetPos()
	if self.Entity:GetActive() then
	
		if self.ExTime <= 0 then
			self.ExTime = CurTime()
			self.CSpeed = 0
		end
		
		local Col = Color( 150, 150, 240, 255 )
		local Time = CurTime() - self.ExTime
		local Width = (math.Clamp(Time,0,2) * 0.5) * 8
		if Width >= 8 then
			local Rate = 0
			if self.DSpeed > self.CSpeed then Rate = 1 else Rate = 5 end
			self.CSpeed = math.Approach(self.CSpeed,self.DSpeed,Rate)
		end
		local Speed = self.CSpeed * 0.1
		local ScSpeed = -20
		
		self.Entity:SetModelScale(Vector(Width * 0.05 + (Speed * 0.05),Width * 0.05 + (Speed * 0.05),Width * 0.05 + (Speed * 0.05)))
		self.Entity:SetModel( "models/props_combine/portalball.mdl" )
		self.Entity:SetColor(0,0,255,255)
		self.Entity:SetMaterial("")
		self.Entity:SetPos( Pos + self.Entity:GetForward() * 55 )
		self.Entity:DrawModel()
		
		self.Entity:SetModelScale(Vector(Speed * 1.5,Speed * 0.5 + 1,Speed * 0.5 + 1))
		self.Entity:SetColor(255,255,255,255)
		self.Entity:SetMaterial( "spacebuild/Fusion2" )
		self.Entity:SetModel( "models/dav0r/hoverball.mdl" )
		self.Entity:DrawModel()
		
		render.UpdateRefractTexture()
		--self.Heat:SetMaterialFloat( "$refractamount", 0.02 + math.sin(math.rad((CurTime() - self.STime) * 0.01 )) )
		self.Entity:SetModel( "models/Effects/combineball.mdl" )
		--self.Heat:SetMaterialFloat( "$bluramount", 10 ) 
		self.Entity:SetPos( Pos + self.Entity:GetForward() * ((Width * 14) + 55 ))
		self.Entity:SetMaterial("sprites/heatwave")
		self.Entity:SetModelScale(Vector(Width*0.3,Width,Width ))
		self.Entity:DrawModel()
		
		self.Entity:SetPos( Pos + self.Entity:GetForward() * ((Width * 7) + (Speed * 3) + 55 ))
		self.Entity:SetColor(250,160,255,255)
		self.Entity:SetModel( "models/Effects/intro_vortshield.mdl" )
		self.Entity:SetMaterial("")
		self.Entity:SetModelScale(Vector(Width * 0.2 + (Speed * 0.2),Width * 0.2 + (Speed * 0.2),Width * 0.2 + (Speed * 0.2)))
		self.Entity:DrawModel()
		
		render.UpdateRefractTexture()
		render.SetMaterial( self.Heat )
		render.DrawBeam( Pos, Pos + self.Entity:GetForward() * 1000, Speed * 15, Time * ScSpeed, 100 + (Time * ScSpeed), Col )
		
	else
		self.Entity:SetPos( Pos )
		self.ExTime = 0
		self.Entity:SetModel( "models/Items/AR2_Grenade.mdl" )
		self.Entity:SetMaterial("")
		self.Entity:SetModelScale(Vector(1,1,1))
		self.Entity:DrawModel()
	end
	self.Entity:SetPos( Pos )

end

function ENT:Think()

	self.OPos = self.OPos or self.Entity:GetPos()

	self.DSpeed = math.Clamp(self.Entity:GetPos():Distance(self.OPos),0,150)
	
	--if self.DSpeed > 0 then print(self.DSpeed) end
	
	self.OPos = self.Entity:GetPos()
	
	self.Entity:NextThink(CurTime() + 0.1)
	
	return true
end