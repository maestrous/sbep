
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

	local w,t, C = self.Wide, self.Tall, self.Col
	if self:GetHL() then
		C = self.HCol
	end
	draw.RoundedBox( self.Rad , self.OrX - 0.5*w , self.OrY - 0.5*t , w, t, C )
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

function OBJ:MouseCheck( MX, MY )
	local x,y,w,t = self.OrX, self.OrY, self.Wide, self.Tall
	if MX >= x - 0.5 * w && MX <= x + 0.5 * w && MY >= y - 0.5*t && MY <= y + 0.5*t then
		return true
	end
	return false
end
 
function OBJ:MPos()
	if self:GetParent() then
		--print("Lets work with our parents.")
		return self:GetParent():MPos()
	elseif self:GetPanel() && self:GetPanel():IsValid() then
		--print("We have an assigned panel. Lets use that.")
		if self:GetPanel().MouseInfo then
			--print("We have mouse info.")
			return self:GetPanel():MouseInfo()
		end            
	end
	return 0,0
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