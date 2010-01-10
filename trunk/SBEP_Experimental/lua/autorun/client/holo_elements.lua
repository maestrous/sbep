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

holo.Create = function( sName )
					if !holo.Classes || !holo.Classes.sName then return end
					
					local Obj = table.Copy( holo.Classes.sName )
						Obj:Initialize()
					return Obj
				end

---------------------------------------------------------------------------------------------------
//	HRect										//
---------------------------------------------------------------------------------------------------
local OBJ = {}

function OBJ:Initialize()
	
	self.Rad = 6
	self.OrX  = 0
	self.OrY  = 0
	self.Wide = 10
	self.Tall = 10
	self.Col  = Color(255,255,255,255)
	
end

function OBJ:Draw()
	local w,t = self.Wide, self.Tall
	draw.RoundedBox( self.Rad , self.OrX - 0.5*w , self.OrY - 0.5*t , w, t, self.Col )
end

function OBJ:Think()
	
end

function OBJ:Think()
	
end

function OBJ:SetSize( x , y )
	if type(x) == "number" && x > 0 then
		self.Wide = x
	end
	if type(y) == "number" && y > 0 then
		self.Tall = y
	end
end

function OBJ:SetPos( x , y )
	if type(x) == "number" then
		self.OrX = x
	end
	if type(y) == "number" then
		self.OrY = y
	end
end

function OBJ:SetColor( cCol )
	if type( cCol ) == "table" && cCol.r && cCol.g && cCol.b && cCol.a then
		self.Col = cCol
	end
end

function OBJ:OnPressed()
end

function OBJ:OnReleased()
end

holo.Register( "HRect" , OBJ )

---------------------------------------------------------------------------------------------------