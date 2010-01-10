
holo = {}

holo.Register = function( sName , tObject , sParent )
					holo.Classes = holo.Classes || {}
					if sParent then
						local P = holo.Classes[sParent]
						if P then
							table.Inherit( tObject, P )
						end
					end
					holo.Classes[sName] = tObject
					return true
				end

holo.Create = function( sName , tParent )
					if !holo.Classes || !holo.Classes[sName] then ErrorNoHalt"Holo class does not exist." return end
					
					local Obj = table.Copy( holo.Classes[sName] )
						/*local BC = Obj.BaseClass
						while BC do
							if BC.Initialize then
								BC.Initialize( Obj )
							end
							BC = BC.BaseClass
						end*/
						Obj:Initialize()
						if tParent then
							Obj:SetParent( tParent )
						end
					return Obj
				end

---------------------------------------------------------------------------------------------------
//	HRect										//
---------------------------------------------------------------------------------------------------
local OBJ = {}

AccessorFunc(  OBJ,  "HL"		,  "HL"		,  FORCE_BOOL 	)
AccessorFunc(  OBJ,  "Wide"		,  "Wide"	,  FORCE_NUMBER )
AccessorFunc(  OBJ,  "Tall"		,  "Tall"	,  FORCE_NUMBER )
AccessorFunc(  OBJ,  "Rad"		,  "Radius"	,  FORCE_NUMBER )
AccessorFunc(  OBJ,  "Col"		,  "Color"	 )
AccessorFunc(  OBJ,  "HCol"		,  "HColor"	 )
AccessorFunc(  OBJ,  "Parent"	,  "Parent"	 )
AccessorFunc(  OBJ,  "Panel"	,  "Panel"	 )

function OBJ:Initialize()

	self.sOutput = ""	
	self.Rad  = 6
	self.OrX  = 0
	self.OrY  = 0
	self.Wide = 10
	self.Tall = 10
	self.Col  = Color(255,255,255,255)
	self.HCol = Color(255,255,255,255)
	self.HL   = false
	
end

function OBJ:Draw()
	self:Think()

	local w,t,C,A = self.Wide, self.Tall, self.Col, self:CheckAlpha()
	if self:GetHL() then
		C = self.HCol
	end
	local Col = Color(C.r, C.g, C.b, C.a * A)
	draw.RoundedBox( self.Rad , self.OrX - 0.5*w , self.OrY - 0.5*t , w, t, Col )
end

function OBJ:Think()
end

function OBJ:SetPos( x , y )
	if type(x) == "number" then
		self.OrX = x
	end
	if type(y) == "number" then
		self.OrY = y
	end
end

function OBJ:GetPos()
	return { x = self.OrX , y = self.OrY }
end

function OBJ:SetSize( x , y )
	if type(x) == "number" && x > 0 then
		self.Wide = x
	end
	if type(y) == "number" && y > 0 then
		self.Tall = y
	end
end

function OBJ:GetSize()
	return self.Wide, self.Tall
end

function OBJ:CheckAlpha()
	if self:GetPanel() then
		if self:GetPanel().GetAlpha then
			return self:GetPanel():GetAlpha()
		end
	end
	return 1
end

function OBJ:MouseCheck( MX, MY )
	local x,y,w,t = self.OrX, self.OrY, self.Wide, self.Tall
	if MX >= x - 0.5 * w && MX <= x + 0.5 * w && MY >= y - 0.5*t && MY <= y + 0.5*t then
		return true
	end
	return false
end
 
function OBJ:MPos()
	if self:GetPanel() then
		return self:GetPanel():MouseInfo()
	end
	return 0,0
end

function OBJ:Output(Output)
	--Check that the output is different to whatever was outputted last, so we don't keep sending the same value.
	if Output != self.LOutput && self:GetPanel() && self.sOutput && self.sOutput != "" then
		RunConsoleCommand( "HoloEleOut" , self:GetPanel():EntIndex() , self.sOutput , tostring(Output) )
		self.LOutput = Output
	end
end

function OBJ:GetPanel()
	if self.Panel && self.Panel:IsValid() then
		--print("We have an assigned panel. Lets use that.")
		return self.Panel
	elseif self:GetParent() then
		--print("Lets work with our parents.")
		return self:GetParent():GetPanel()
	end
end

function OBJ:MouseHoverHL()
	self:SetHL( self:MouseCheck( self:MPos() ) )
end

function OBJ:SetAlpha( iA )
	self.Col.a = iA
end

function OBJ:GetAlpha()
	return self.Col.a
end

function OBJ:SetHAlpha( iA )
	self.HCol.a = iA
end

function OBJ:GetHAlpha()
	return self.HCol.a
end

function OBJ:OnPressed()
end

function OBJ:OnReleased()
end

holo.Register( "HRect" , OBJ )

---------------------------------------------------------------------------------------------------
//	HLabel										//
---------------------------------------------------------------------------------------------------
local OBJ = {}

AccessorFunc(  OBJ,  "Text"		,  "Text"	,  FORCE_STRING	)
AccessorFunc(  OBJ,  "Font"		,  "Font"	,  FORCE_STRING	)
AccessorFunc(  OBJ,  "Align"	,  "Align"	)

function OBJ:Initialize()
	
	self.Text 	= "Label"
	self.Font 	= "TargetID"
	self.Align	= TEXT_ALIGN_CENTER

end

function OBJ:Draw()
	local XY = self:GetPos()
	draw.DrawText( self.Text , self.Font, XY.x, XY.y-13, self:GetColor() , self.Align )
end

function OBJ:SetAlign( enA )
	if enA == 0 || enA == TEXT_ALIGN_LEFT then
		self.Align = TEXT_ALIGN_LEFT
	elseif enA == 1 || enA == TEXT_ALIGN_CENTER then
		self.Align = TEXT_ALIGN_CENTER
	elseif enA == 2 || enA == TEXT_ALIGN_RIGHT then
		self.Align = TEXT_ALIGN_RIGHT
	elseif enA == 3 || enA == TEXT_ALIGN_TOP then
		self.Align = TEXT_ALIGN_TOP
	elseif enA == 4 || enA == TEXT_ALIGN_BOTTOM then
		self.Align = TEXT_ALIGN_BOTTOM
	end
end

holo.Register( "HLabel" , OBJ )

---------------------------------------------------------------------------------------------------
//	HButton										//
---------------------------------------------------------------------------------------------------

local OBJ = {}

function OBJ:Think()
	self:MouseHoverHL()
	
	if self.Toggled then
		if self:MouseCheck( self:MPos() ) && (LocalPlayer():KeyPressed( IN_USE ) || (input.IsMouseDown(MOUSE_FIRST) && !self.MTog)) then
			self.Value = !self.Value
			self.MTog = true
		elseif !input.IsMouseDown(MOUSE_FIRST) then
			self.MTog = false
		end
	else
		if self:MouseCheck( self:MPos() ) && (LocalPlayer():KeyDown( IN_USE ) || (input.IsMouseDown(MOUSE_FIRST))) then
			self.Value = true
		else
			self.Value = false
		end
	end
	
	--print(self.Value)
	if self.Value then
		self:Output(1)
	else
		self:Output(0)
	end
end

function OBJ:Draw()
	self:Think()

	local w,t,C,A = self.Wide, self.Tall, self.Col, self:CheckAlpha()
	if self:GetHL() then
		C = self.HCol
	end
	local o = 1
	if self.Value then o = 0 end
	local Col = Color(C.r, C.g, C.b, C.a * A)
	local ColD = Color(math.Clamp(C.r - 200,0,255),math.Clamp(C.r - 200,0,255),math.Clamp(C.r - 200,0,255),C.a * A)
	draw.RoundedBox( self.Rad , (self.OrX - 0.5*w) + 1 , (self.OrY - 0.5*t) + 1 , w + 1, t + 1, ColD )
	draw.RoundedBox( self.Rad , (self.OrX - 0.5*w) - o , (self.OrY - 0.5*t) - o , w, t, Col )
end

--PrintTable(OBJ)
holo.Register( "HButton" , OBJ , "HRect" )


---------------------------------------------------------------------------------------------------
//	HSBar										//
---------------------------------------------------------------------------------------------------


local OBJ = {}

function OBJ:Initialize()

	self.sOutput = ""	
	self.Min  = 0
	self.Max  = 1
	self.Val  = 0
	self.Rad  = 4
	self.BoxP = 0 --The position
	self.BoxD = 10 -- The other demension
	self.OrX  = 0
	self.OrY  = 0
	self.Wide = 50
	self.Tall = 50
	self.Col  = Color(255,255,255,255)
	self.HCol = Color(255,255,255,255)
	self.HL   = false
	self.Vert = false
	
end

function OBJ:Think()
	self:MouseHoverHL()
	local x,y = self:MPos()
	
	if self:MouseCheck( x,y ) && (LocalPlayer():KeyDown( IN_USE ) || (input.IsMouseDown(MOUSE_FIRST))) then
		self.Dragging = true
	end
	
	if !(LocalPlayer():KeyDown( IN_USE ) || (input.IsMouseDown(MOUSE_FIRST))) then -- We want it to start dragging when both conditions are true, but we only want it to end when the key is up.
		self.Dragging = false
	end
	
	if self.Dragging then
		local MAx,OAx,Scl,Mul,Add = self.Vert and y or x,self.Vert and self.OrY or self.OrX, self.Vert and self.Tall or self.Wide, self.Vert and 1 or -1, self.Vert and 0 or 1
		local APos = (math.Clamp((((MAx - OAx) / (Scl * 0.5 - 10)) * -0.5) + 0.5,0,1) - Add) * Mul
		self.Val = self.Min + (APos * (self.Max - self.Min))
	end
	
	self:Output(self.Val)
end

function OBJ:Draw()
	self:Think()
	
	local w,w2,t,t2,C,A = self.Wide,self.Vert and self.Wide + 4 or self.BoxD, self.Tall, self.Vert and self.BoxD or self.Tall + 4, self.Col, self:CheckAlpha()
	if self:GetHL() then
		C = self.HCol
	end
	local AVal = 0
	if self.Max-self.Min != 0 then
		AVal = math.Clamp((self.Val-self.Min)/(self.Max-self.Min),0,1) * 2 - 1
	end
	local axis, scale,mul = self.Vert and self.OrY or self.OrX, self.Vert and t or w, self.Vert and 1 or -1
	local o = axis - (AVal * (scale * 0.5 - 10)) * mul
	local bx = self.Vert and self.OrX or o
	local by = self.Vert and o or self.OrY
	
	local Col = Color(C.r, C.g, C.b, C.a * A)
	local ColD = Color(math.Clamp(C.r - 200,0,255),math.Clamp(C.r - 200,0,255),math.Clamp(C.r - 200,0,255),math.Clamp((C.a * A) - 50,50,255))
	
	draw.RoundedBox( self.Rad , (self.OrX - 0.5*w), (self.OrY - 0.5*t), w, t, ColD )
	draw.RoundedBox( self.Rad , (bx - 0.5*w2), (by - 0.5*t2) , w2, t2, Col )
end

function OBJ:MouseCheck( MX, MY )
	local AVal = 0
	if self.Max-self.Min != 0 then
		AVal = math.Clamp((self.Val-self.Min)/(self.Max-self.Min),0,1) * 2 - 1
	end
	local axis, scale, mul = self.Vert and self.OrY or self.OrX, self.Vert and self.Tall or self.Wide, self.Vert and 1 or -1
	local o = axis - (AVal * (scale * 0.5 - 10)) * mul
	
	local x,y,w,t = self.Vert and self.OrX or o, self.Vert and o or self.OrY, self.Vert and self.Wide + 4 or self.BoxD, self.Vert and self.BoxD or self.Tall + 4
	if MX >= x - 0.5 * w && MX <= x + 0.5 * w && MY >= y - 0.5*t && MY <= y + 0.5*t then
		return true
	end
	return false
end

--PrintTable(OBJ)
holo.Register( "HSBar" , OBJ , "HRect" )