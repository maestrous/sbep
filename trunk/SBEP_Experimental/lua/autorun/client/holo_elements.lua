
holo = {}

holo.Register = function( sName , tObject , sParent )
					holo.Classes = holo.Classes || {}
					if sParent then
						local P = holo.Classes.sParent
						if P then
							table.Inherit( tObject, P )
						end
					end
					holo.Classes.sName = tObject
					return true
				end

holo.Create = function( sName , tParent )
					if !holo.Classes || !holo.Classes.sName then return end
					
					local Obj = table.Copy( holo.Classes.sName )
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
	draw.RoundedBox( self.Rad , self.OrX - 0.5*w , self.OrY - 0.5*t , w, t, self.Col )
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

function OBJ:OnPressed()
end

function OBJ:OnReleased()
end

holo.Register( "HRect" , OBJ )