include('shared.lua')

local BMat = Material( "tripmine_laser" )
local SMat = Material( "sprites/light_glow02_add" )

ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:Initialize()
	self.IncZ = 0
	self.Inc = 0
	self.Alpha = 0
	self.CString = ""
	self.CVal = ""
end

function ENT:DrawTranslucent()
	
	self:DrawModel()
	
	if self.IncZ > 0 then
		local incZ = self.IncZ --Z increment for transition
		local inc = self.Inc --increment for transition
		local selfpos = self:GetPos()
		
		local Origin = selfpos + self:GetUp() * 3
		
		local Square = {
			self:LocalToWorld( Vector( inc * incZ /  15 , inc * incZ /  15 , incZ ) ),
			self:LocalToWorld( Vector( inc * incZ / -15 , inc * incZ /  15 , incZ ) ),
			self:LocalToWorld( Vector( inc * incZ / -15 , inc * incZ / -15 , incZ ) ),
			self:LocalToWorld( Vector( inc * incZ /  15 , inc * incZ / -15 , incZ ) )
						}
		
		local BCol = Color(200,200,210,140)
		local SCol = Color(200,200,210,170)
		render.SetMaterial( SMat )	
		render.DrawSprite( Origin, 5, 5, SCol )
		for n, Pos in ipairs( Square ) do
			render.SetMaterial( SMat )	
				render.DrawSprite( Pos, 5, 5, SCol )
			render.SetMaterial( BMat )
				render.DrawBeam( Pos, Origin , 10, 0, 0, BCol )
				render.DrawBeam( Pos, Square[ math.fmod(n, 4) + 1 ], 10, 0, 0, BCol )
		end
				
		if inc >= 10 then
			--render.SetMaterial( QMat )
			--render.DrawQuad(Vec2,Vec1,Vec4,Vec3)
			local W = LocalPlayer():GetShootPos() - (self:GetPos() + self:GetUp() * 15)
			local N = self:GetUp()
			local U = LocalPlayer():GetAimVector()
			--(-(self:up.(playershootpos - self:pos)) / (self:up.player:aimvec))
			local Upper = N:DotProduct(W)
			local Lower = N:DotProduct(U)
			
			local RDist = -Upper / Lower
			
			local RPos = LocalPlayer():GetShootPos() + U * RDist
			
			local R = self:WorldToLocal( RPos )
			local RX, RY = R.x * 10, R.y * -10

			cam.Start3D2D( self:GetPos() + self:GetUp() * (incZ + 0.1), self:GetAngles(), 0.1 )
                                
                draw.RoundedBox( 6, -90, -90, 180, 180, Color(150,150,180,self.Alpha * 90) )
                
                local KCol = Color( 180, 180, 210, self.Alpha * 150 )
                local KColH = Color( 210, 210, 235, self.Alpha * 200 )
                
                local Boxes = {
							[-22.5] = {
								[1] = -67.5,
								[2] = -22.5,
								[3] =  22.5,
								 OK =  67.5
									},
							[22.5] = {
								[4] = -67.5,
								[5] = -22.5,
								[6] =  22.5,
								[0] =  67.5
									},
							[67.5] = {
								[7] = -67.5,
								[8] = -22.5,
								[9] =  22.5,
						 [" Clear"] =  67.5
									}
							}

			draw.RoundedBox( 6, -85, -85, 170, 35, KCol )
			self:SetHighlighted( 12 )
			for y,Row in pairs( Boxes ) do
				for label,x in pairs( Row ) do
					if RX >= x-17.5 && RX <= x+17.5 && RY >= y-17.5 && RY <= y+17.5 then
						draw.RoundedBox( 12, x-17.5, y-17.5, 35, 35, KColH )
						draw.DrawText( label , "DefaultLarge", x, y-9, Color(30, 30, 55, 255), TEXT_ALIGN_CENTER )
						local val = label
						if label == " Clear" then
							val = 10
						elseif label == "OK" then
							val = 11
						end
						self:SetHighlighted( val )
					else
						draw.RoundedBox( 6, x-17.5, y-17.5, 35, 35, KCol )
						draw.DrawText( label , "DefaultLarge", x, y-9, Color(230, 230, 255, 255), TEXT_ALIGN_CENTER )
					end
					
				end
			end
			
			draw.DrawText( self.CString , "DefaultLarge", 80, -74, Color(230, 230, 255, 255), TEXT_ALIGN_RIGHT )
			
			cam.End3D2D()
		end
	end
end

function ENT:Think()
	local Dist = math.abs(self:GetPos().x - LocalPlayer():GetShootPos().x) + math.abs(self:GetPos().y - LocalPlayer():GetShootPos().y) + math.abs(self:GetPos().y - LocalPlayer():GetShootPos().y) -- relatively cheap and crappy way of calculating distance
	local Vec = LocalPlayer():GetAimVector():DotProduct((self:GetPos() - LocalPlayer():GetShootPos()):Normalize())
	--print(Dist, Vec)
	if Dist <= 300 && Vec > 0.85 then
		--print("Here's looking at you, kid")
		self.LocalActive = true
	else
		self.LocalActive = false
	end
	if self.LocalActive then
		--print("Active")
		self.IncZ = math.Approach(self.IncZ, 15, .3)
		if self.IncZ >= 15 then
			self.Inc = math.Approach(self.Inc, 10, .2)
		end
		if self.Inc >= 10 then
			self.Alpha = math.Approach(self.Alpha, 1, .05)
		end
		if self.Alpha >= 1 then
			if !self.PreActive then
				self.CString = self.CVal
				self.PreActive = true
				self.Adding = false
			end
		else
			self.PreActive = false
		end
		
		if LocalPlayer():KeyPressed( IN_USE ) then
			local val = self:GetHighlighted()
			if val == 10 then
				--self:ClearValue()
				self.CString = ""
				self.Adding = false
			elseif val == 11 then
				--self:SendValue()
				LocalPlayer():ConCommand("HoloPadSetVar "..self:EntIndex().." "..self.CString)
				--timer.Simple( 1, function()
				--					self:ClearValue()
				--					end)
				self.CVal = self.CString
				self.Adding = false
			else
				--self:AddHValue( val )
				if val >= 0 && val <= 9 then
					if self.Adding then
						self.CString = self.CString..tostring(val)
					else
						self.CString = tostring(val)
						self.Adding = true
					end
				end
			end
		end
	elseif self.IncZ > 0 then
		self.Alpha = math.Approach(self.Alpha, 0, .05)
		if self.Alpha <= 0 then
			self.Inc = math.Approach(self.Inc, 0, .2)
		end
		if self.Inc <= 0 then
			self.IncZ = math.Approach(self.IncZ, 0, .3)
		end
	else
		self.IncZ = 0
		self.Inc = 0
		self.Alpha = 0
	end
end