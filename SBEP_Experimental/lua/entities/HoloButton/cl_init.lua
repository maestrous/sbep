include('shared.lua')

local BMat = Material( "tripmine_laser" )
local SMat = Material( "sprites/light_glow02_add" )
local QMat = Material( "spacebuild/Hazard2" )

function ENT:Initialize()
	self.ZSize = 0
	self.Size = 0
	self.Alpha = 0
end

function ENT:Draw()
	
	self:DrawModel()
	
	if self:GetActive() then
		local Size = self.Size
		local ZSize = self.ZSize
		local Vec0 = self:GetPos() + (self:GetUp() * 3)
		local Vec1 = self:GetPos() + (self:GetUp() * ZSize) + (self:GetForward() * Size) + (self:GetRight() * Size)
		local Vec2 = self:GetPos() + (self:GetUp() * ZSize) + (self:GetForward() * Size) + (self:GetRight() * -Size)
		local Vec3 = self:GetPos() + (self:GetUp() * ZSize) + (self:GetForward() * -Size) + (self:GetRight() * -Size)
		local Vec4 = self:GetPos() + (self:GetUp() * ZSize) + (self:GetForward() * -Size) + (self:GetRight() * Size)
		local BCol = Color(200,200,210,140)
		local SCol = Color(200,200,210,170)
		
				
		render.SetMaterial( SMat )	
		render.DrawSprite( Vec0, 5, 5, SCol )
		
		render.SetMaterial( SMat )	
		render.DrawSprite( Vec1, 5, 5, SCol )
		
		render.SetMaterial( SMat )	
		render.DrawSprite( Vec2, 5, 5, SCol )
		
		render.SetMaterial( SMat )	
		render.DrawSprite( Vec3, 5, 5, SCol )
		
		render.SetMaterial( SMat )	
		render.DrawSprite( Vec4, 5, 5, SCol )
		
		render.SetMaterial( BMat )
		render.DrawBeam( Vec1, Vec2, 10, 0, 0, BCol )
		
		render.SetMaterial( BMat )
		render.DrawBeam( Vec2, Vec3, 10, 0, 0, BCol )
		
		render.SetMaterial( BMat )
		render.DrawBeam( Vec3, Vec4, 10, 0, 0, BCol )
		
		render.SetMaterial( BMat )
		render.DrawBeam( Vec4, Vec1, 10, 0, 0, BCol )
		
		render.SetMaterial( BMat )
		render.DrawBeam( Vec1, Vec0, 10, 0, 0, BCol )
		
		render.SetMaterial( BMat )
		render.DrawBeam( Vec2, Vec0, 10, 0, 0, BCol )
		
		render.SetMaterial( BMat )
		render.DrawBeam( Vec3, Vec0, 10, 0, 0, BCol )
		
		render.SetMaterial( BMat )
		render.DrawBeam( Vec4, Vec0, 10, 0, 0, BCol )
		
		if self.Size >= 10 then
			--render.SetMaterial( QMat )
			--render.DrawQuad(Vec2,Vec1,Vec4,Vec3)
			local W = (LocalPlayer():GetShootPos() - (self:GetPos() + self:GetUp() * 15))
			local N = self:GetUp()
			local U = LocalPlayer():GetAimVector()
			--(-(self:up.(playershootpos - self:pos)) / (self:up.player:aimvec))
			local Upper = N:DotProduct(W)
			local Lower = N:DotProduct(U)
			
			local RDist = -Upper / Lower
			
			local RPos = LocalPlayer():GetShootPos() + U * RDist
			
			--render.SetMaterial( SMat )	
			--render.DrawSprite( RPos, 5, 5, Color(255,0,0,255) )
			
			local RX = self:GetForward():DotProduct( self:WorldToLocal(RPos) ) * 10
			local RY = self:GetUp():DotProduct( self:WorldToLocal(RPos) ) * 10
			
			print(RX,RY)
			
			--local RPos = math.Clamp(LocalPlayer():GetAimVector():DotProduct( Vec - Pos ) * 2,-self.SpeedClamp,self.SpeedClamp)
			
			cam.Start3D2D( self:GetPos() + self:GetUp() * (ZSize + 0.1), self:GetAngles(), .1 )
                                
                draw.RoundedBox( 6, -90, -90, 180, 180, Color(170,170,180,self.Alpha * 90) )
                
                local KCol = Color( 200, 200, 210, self.Alpha * 140 )
                local KColH = Color( 210, 210, 220, self.Alpha * 255 )
                
                local Boxes = {}
                
                Boxes[0] = {50, 5, 35, 35}
                Boxes[1] = {-85, -40, 35, 35}
                Boxes[2] = {-40, -40, 35, 35}
                Boxes[3] = {5, -40, 35, 35}
                Boxes[4] = {-85, 5, 35, 35}
                Boxes[5] = {-40, 5, 35, 35}
                Boxes[6] = {5, 5, 35, 35}
                Boxes[7] = {-85, 50, 35, 35}
                Boxes[8] = {-40, 50, 35, 35}
                Boxes[9] = {5, 50, 35, 35}
                
                Boxes[10] = {50, -40, 35, 35} --Ok
                Boxes[11] = {50, 50, 35, 35} --Cancel
                Boxes[12] = {-85, -85, 170, 35} --Display
                
                local CurrentBox = -1
                
                for i = 0,12 do
                	local LCol = KCol
                	if HoloBColTest(RX,RY,Boxes[i][1],Boxes[i][2],Boxes[i][3],Boxes[i][4], LCol) then
                		LCol = KColH
                		CurrentBox = i
                	end
					draw.RoundedBox( 6, Boxes[i][1], Boxes[i][2], Boxes[i][3], Boxes[i][4], LCol )
                end
                                
                --draw.RoundedBox( 6, -85, -85, 170, 35, KCol ) --Display
                                
                --draw.RoundedBox( 6, -85, -40, 35, 35, KCol ) --1
                
                --draw.RoundedBox( 6, -40, -40, 35, 35, KCol ) --2
                
                --draw.RoundedBox( 6, 5, -40, 35, 35, KCol ) --3
                
                --draw.RoundedBox( 6, 50, -40, 35, 35, KCol ) --Ok
                
                --draw.RoundedBox( 6, -85, 5, 35, 35, KCol ) --4
                
                --draw.RoundedBox( 6, -40, 5, 35, 35, KCol ) --5
                
                --draw.RoundedBox( 6, 5, 5, 35, 35, KCol ) --6
                
                --draw.RoundedBox( 6, 50, 5, 35, 35, KCol ) --0
                
                --draw.RoundedBox( 6, -85, 50, 35, 35, KCol ) --7
                
                --draw.RoundedBox( 6, -40, 50, 35, 35, KCol ) --8
                
                --draw.RoundedBox( 6, 5, 50, 35, 35, KCol ) --9
                
                --draw.RoundedBox( 6, 50, 50, 35, 35, KCol ) --Cancel
                
                draw.DrawText("1", "ScoreboardText", -67.5, -32.5, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
                
                draw.DrawText("2", "ScoreboardText", -22.5, -32.5, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
                
                draw.DrawText("3", "ScoreboardText", 22.5, -32.5, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
                
                draw.DrawText("OK", "ScoreboardText", 67.5, -32.5, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
                
                draw.DrawText("4", "ScoreboardText", -67.5, 15, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
                
                draw.DrawText("5", "ScoreboardText", -22.5, 15, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
                
                draw.DrawText("6", "ScoreboardText", 22.5, 15, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
                
                draw.DrawText("0", "ScoreboardText", 67.5, 15, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
                
                draw.DrawText("7", "ScoreboardText", -67.5, 57.5, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
                
                draw.DrawText("8", "ScoreboardText", -22.5, 57.5, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
                
                draw.DrawText("9", "ScoreboardText", 22.5, 57.5, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
                
                draw.DrawText("Cncl", "ScoreboardText", 67.5, 57.5, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
                
				--draw.RoundedBox( 6, 100, 50, 100, 23, Color( 255, 255, 255, 150 ) )
                
                
                
        	cam.End3D2D()
		end
	end
end

function HoloBColTest(MX,MY,BX,BY,BW,BH)
	if MX >= BX && MX <= BX + BW && MY >= BY && MY <= BY + BH then
		return true
	end
	return false
end

function ENT:Think()
	if self:GetActive() then
		self.ZSize = math.Approach(self.ZSize, 15, .3)
		if self.ZSize >= 15 then
			self.Size = math.Approach(self.Size, 10, .2)
		end
		if self.Size >= 10 then
			self.Alpha = math.Approach(self.Alpha, 1, .05)
		end
	else
		self.ZSize = 0
		self.Size = 0
		self.Alpha = 0
	end
end