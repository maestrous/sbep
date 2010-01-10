include('shared.lua')
--include('holo_elements.lua')



local BMat = Material( "tripmine_laser" )
local SMat = Material( "sprites/light_glow02_add" )

ENT.RenderGroup = RENDERGROUP_BOTH

surface.CreateFont ("Trebuchet", 25, 500, true, false, "TrebuchetH" )

function ENT:Initialize()
	self.IncZ = 0
	self.Inc = 0
	self.Alpha = 0
	self.PulseTime = 0
	self.PulseLength = 0
	self.MX = 0
	self.MY = 0
	
	self.PermaA = true
	
	self.X = 20
	self.Y = 20
	self.Z = 15
	
	self:LoadInterface()
	
	--PrintTable(self.Elements)
	
	self.R,self.G,self.B = 200,200,210
	self:SetColors( 200, 200, 230 )
end

function ENT:LoadInterface()
	self.Elements = {}
	local Base = holo.Create("HRect")
	Base:SetPanel(self)
	Base:SetSize((self.X * 10) - 20,(self.Y * 10) - 20)
	Base:SetColor(Color(150,150,170,100))
	
	local Hov = holo.Create("HButton", Base)
	
	Hov:SetSize(20,20)
	Hov:SetColor(Color(180,180,200,100))
	Hov:SetHColor(Color(220,220,240,150))
	Hov:SetPos(0,0)
	Hov.sOutput = "TestValue1"
	Hov.Toggled = true
		
	local VSB = holo.Create("HSBar", Base)
	
	VSB:SetSize(10,100)
	VSB:SetColor(Color(180,180,200,100))
	VSB:SetHColor(Color(220,220,240,150))
	VSB:SetPos(55,0)
	VSB.Min = 60
	VSB.Max = -60
	VSB.Vert = true
	VSB.sOutput = "TestValue2"
	
	local HSB = holo.Create("HSBar", Base)
	
	HSB:SetSize(100,10)
	HSB:SetColor(Color(180,180,200,100))
	HSB:SetHColor(Color(220,220,240,150))
	HSB:SetPos(0,55)
	HSB.Min = 60
	HSB.Max = -60
	HSB.Vert = false
	HSB.sOutput = "TestValue3"
	
	table.insert(self.Elements, Base)
	table.insert(self.Elements, Hov)
	table.insert(self.Elements, VSB)
	table.insert(self.Elements, HSB)
end

function ENT:MouseInfo()
	return self.MX, self.MY
end

function ENT:GetAlpha()
	return self.Alpha
end

function ENT:SetColors( R, G, B )

	self.R = R
	self.G = G
	self.B = B
	
	self.BCol = Color( self.R, self.G, self.B , 140 )
	self.SCol = Color( self.R, self.G, self.B , 180 )

end

function ENT:ScaleColor( fSc )
	
	local r = math.Clamp( self.R*fSc, 0, 255)
	local g = math.Clamp( self.G*fSc, 0, 255)
	local b = math.Clamp( self.B*fSc, 0, 255)
	--print( r,g,b )
	return r,g,b
	
end

function ENT:Draw()
	self:DrawModel()
end

function ENT:DrawTranslucent()
		
	if self.IncZ > 0 then
		-------------------------------------			Square Definition					-------------------------------------
		local incZ = self.IncZ --Z increment for transition
		local inc = self.Inc --increment for transition
		local selfpos = self:GetPos()
		local up = self:GetUp()
		
		local Origin = selfpos + up * 3
		
		local Square = {
			self:LocalToWorld( Vector( (inc *  self.X * .5), (inc *  self.Y * .5), incZ * self.Z ) ),
			self:LocalToWorld( Vector( (inc * -self.X * .5), (inc *  self.Y * .5), incZ * self.Z ) ),
			self:LocalToWorld( Vector( (inc * -self.X * .5), (inc * -self.Y * .5), incZ * self.Z ) ),
			self:LocalToWorld( Vector( (inc *  self.X * .5), (inc * -self.Y * .5), incZ * self.Z ) ),
						}
		
		local BCol = self.BCol
		local SCol = self.SCol
		render.SetMaterial( SMat )	
		render.DrawSprite( Origin, 5, 5, SCol )
		for n, Pos in ipairs( Square ) do
			render.SetMaterial( SMat )	
				render.DrawSprite( Pos, 5, 5, SCol )
			render.SetMaterial( BMat )
				render.DrawBeam( Pos, Origin , 10, 0, 0, BCol )
				render.DrawBeam( Pos, Square[ math.fmod(n, 4) + 1 ], 10, 0, 0, BCol )
		end
		
		-------------------------------------			"Mouse" Position					-------------------------------------
		if inc >= 1 then
			--render.SetMaterial( QMat )
			--render.DrawQuad(Vec2,Vec1,Vec4,Vec3)
			local eyepos = LocalPlayer():GetShootPos()
			
			local W = eyepos - (selfpos + up * self.Z)
			local N = up
			local AVec = LocalPlayer():GetAimVector()
			local mx,my = gui.MousePos()
			if mx > 0 || my > 0 then
				AVec = gui.ScreenToVector( gui.MousePos() )
			end
			local U = AVec--LocalPlayer():GetAimVector()
			--(-(self:up.(playershootpos - self:pos)) / (self:up.player:aimvec))
			local Upper = N:DotProduct(W)
			local Lower = N:DotProduct(U)
			
			local RDist = -Upper / Lower
			
			local RPos = eyepos + U * RDist
			
			local R = self:WorldToLocal( RPos )
			self.MX, self.MY = R.x * 10, R.y * -10
			
			-------------------------------------			3D2D Start					-------------------------------------
			cam.Start3D2D( selfpos + up * (incZ * self.Z), self:GetAngles(), 0.1 )
				
				-------------------------------------			Colour Definition					-------------------------------------
				local R,G,B = self.R, self.G, self.B
				local r,g,b
				local Alpha = self.Alpha
			
				r,g,b = self:ScaleColor( 15/20 )
				--local Edge = 20
				--draw.RoundedBox( 6, (-self.X * 5 + Edge), (-self.Y * 5) + Edge, (self.X * 10) - (Edge * 2), (self.Y * 10) - (Edge * 2), Color( r , g , b , Alpha * 90) ) -- The basic square

				r,g,b = self:ScaleColor( 17/20 )
                local KCol = Color( r , g , b , Alpha * 150 )
                local KColH = Color( R , G , B , Alpha * 200 )

				local PTime = math.Clamp((CurTime() - self.PulseTime),0,1) / self.PulseLength
				
				local PCol = Color(Lerp(PTime,R,r),Lerp(PTime,G,g),Lerp(PTime,B,b),Lerp(PTime,KColH.a,KCol.a))
				
				--draw.DrawText( "^" , "TrebuchetH", 0, -185, Color(255,255,255, self.Alpha * 255), TEXT_ALIGN_RIGHT )
				
				for k,e in pairs( self.Elements ) do
					e:Draw()
				end
				
				
				/*
				if RX >= -85 && RX <= 85 && RY >= -85 && RY <= -50 then
					draw.RoundedBox( 6, -85, -85, 170, 35, KColH )
					draw.DrawText( Value , "TrebuchetH", 80, -81, Color(R,G,B, 255), TEXT_ALIGN_RIGHT )
					self.ManualInput = true
					self:SetHighlighted( 12 )
				else
					local PTime = math.Clamp((CurTime() - self.PulseTime),0,1) / self.PulseLength
					local PCol = Color(Lerp(PTime,KColH.r,KCol.r),Lerp(PTime,KColH.g,KCol.g),Lerp(PTime,KColH.b,KCol.b),Lerp(PTime,KColH.a,KCol.a))
					draw.RoundedBox( 6, -85, -85, 170, 35, PCol )
					draw.DrawText( self.CString , "TrebuchetH", 80, -74, Color(self.R,self.G,self.B, 255), TEXT_ALIGN_RIGHT )
					self.ManualInput = false
				end
				--draw.DrawText( Value , "TrebuchetH", 80, -81, Color(R,G,B, 255), TEXT_ALIGN_RIGHT )
				local Highlight = -1
				
				for y,Row in pairs( self.Boxes ) do
					for label,x in pairs( Row ) do
						if RX >= x-17.5 && RX <= x+17.5 && RY >= y-17.5 && RY <= y+17.5 then
							draw.RoundedBox( 12, x-17.5, y-17.5, 35, 35, KColH )
								local mc = math.Max( self.R, self.G, self.B)
								r,g,b = self:ScaleColor( 1/mc )
							draw.DrawText( label , "TrebuchetH", x, y-13, Color( r , g , b , 255), TEXT_ALIGN_CENTER )
							local val = label
							if label == "CL" then
								val = 10
							elseif label == "OK" then
								val = 11
							end
							self:SetHighlighted( val )
							Highlight = val
						else
							draw.RoundedBox( 6, x-17.5, y-17.5, 35, 35, KCol )
							draw.DrawText( label , "TrebuchetH", x, y-13, Color( R, G, B, 255), TEXT_ALIGN_CENTER )
						end
					end
					if Highlight == -1 then --This bit just stops it from clearing the highlighted button even while you're looking at it.
						self.HighClear = self.HighClear + 1
						if self.HighClear > 15 then
							self:SetHighlighted( -1 )
						end
					else
						self.HighClear = 0
					end
										
					if Highlight != self:GetHighlighted() && Highlight != -1 then
						self:SetHighlighted( Highlight )
					end
				end
				*/
			cam.End3D2D()
		end
	end
end

function ENT:Think()
	if !self.PermaA then
		local SDir = (self:GetPos() - LocalPlayer():GetShootPos()):Angle()
		local PDir = LocalPlayer():GetAimVector():Angle() -- Best to get rid of the roll on both angles, just to make sure they're compared fairly.
		--print(SDir,PDir)
		local PDif = math.abs(math.AngleDifference(SDir.p, PDir.p))
		local YDif = math.abs(math.AngleDifference(SDir.y, PDir.y))
		--print(PDif,YDif)
		local plypos = self:WorldToLocal( LocalPlayer():GetShootPos() )
		if plypos.x >= -100 && plypos.x <= 100 && plypos.y >= -100 && plypos.y <= 100 && plypos.z >= 0 && plypos.z <= 100 && YDif <= 30 && PDif <= 30 then
			--print("Here's looking at you, kid")
			self.LocalActive = true
		else
			self.LocalActive = false
		end
	end
	if self.LocalActive || self.PermaA then
		--print("Active")
		self.IncZ = math.Approach(self.IncZ, 1, .03)
		if self.IncZ >= 1 then
			self.Inc = math.Approach(self.Inc, 1, .02)
		end
		if self.Inc >= 1 then
			self.Alpha = math.Approach(self.Alpha, 1, .01)
		end
		
		
		
		
		
		
		
		
		if LocalPlayer():KeyPressed( IN_USE ) || (input.IsMouseDown(MOUSE_FIRST) && !self.MTog) then
			self.MTog = true
			local val = 0-- self:GetHighlighted()
			if val == 10 then
				--self:ClearValue()
				self.CString = ""
				self.Adding = false
			elseif val == 11 then
				--self:SendValue()
				RunConsoleCommand( "HoloPadSetVar" , self:EntIndex() , self.CString )
				--timer.Simple( 1, function()
				--					self:ClearValue()
				--					end)
				if !self.SecureMode then self.CVal = self.CString end
				if self.SecureMode then self.CString = "" end
				self.Adding = false
				self.PulseTime = CurTime()
			else
				--self:AddHValue( val )
				if val >= 0 && val <= 9 then
					if self.Adding then
						if string.len( self.CString ) <= 22 then -- 22 seems a reasonable length. Quite generous, in fact...
							self.CString = self.CString..tostring(val)
						end
					else
						self.CString = tostring(val)
						self.Adding = true
					end
				end
			end
		elseif !input.IsMouseDown(MOUSE_FIRST) then
			self.MTog = false
		end
	elseif self.IncZ > 0 then
		self.Alpha = math.Approach(self.Alpha, 0, .05)
		if self.Alpha <= 0 then
			self.Inc = math.Approach(self.Inc, 0, .02)
		end
		if self.Inc <= 0 then
			self.IncZ = math.Approach(self.IncZ, 0, .03)
		end
	else
		self.IncZ = 0
		self.Inc = 0
		self.Alpha = 0
	end
end
