/*if not rawtype then 
    rawtype = type
    function type(obj)
        local mt = getmetatable(obj)
        if mt then
            local mtype = mt.__type
            if mtype then
                return mtype
            end
        end
        return rawtype(obj)
    end
end*/

holo = {}

holo.Register = function( sName , heObject , sParent )
					holo.Classes = holo.Classes || {}
					if sParent then
						local P = holo.Classes[sParent]
						if P then
							table.Inherit( heObject, P )
						end
					end
					heObject.Class = sName
					heObject.IsHElement = function(self) return true end
					holo.Classes[sName] = heObject
					return true
				end

holo.Create = function( sName , heParent )
					if !holo.Classes || !holo.Classes[sName] then ErrorNoHalt"Holo Class does not exist." return end
					
					local Obj = table.Copy( holo.Classes[sName] )
						Obj:Initialize()
						if heParent then
							Obj:SetParent( heParent )
						end
					return Obj
				end

holo.Render = function( heObject ) --or eHoloPanel
					heObject:Draw()
					if heObject.Children then
						for n,HE in ipairs( heObject.Children ) do
							holo.Render( HE )
						end
					end
				end

local FORCE_TABLE, FORCE_COLOR, FORCE_ENTITY, FORCE_HELEMENT	= 4, 5, 6, 7

local AccessorFunc = function ( tOBJ , sVar , sMethod , enFT )

						tOBJ[ "Get"..sMethod ] = function( self ) return self[ sVar ] end

						if enFT == FORCE_BOOL then
							tOBJ[ "Set"..sMethod ] = function( self, B ) self[ sVar ] = tobool( B ) end
						return end
						if enFT == FORCE_NUMBER then
							tOBJ[ "Set"..sMethod ] = function( self, N ) self[ sVar ] = tonumber( N ) or self[ sVar ] end
						return end
						if enFT == FORCE_STRING then
							tOBJ[ "Set"..sMethod ] = function( self, S ) self[ sVar ] = tostring( S ) or self[ sVar ] end
						return end
						if enFT == FORCE_TABLE then
							tOBJ[ "Set"..sMethod ] = function( self, T ) if type( T ) == "table" then self[ sVar ] = T end end
						return end
						if enFT == FORCE_COLOR then
							tOBJ[ "Set"..sMethod ] = function( self, C )
														if type( C ) == "table" and C.r and C.g and C.b and C.a then self[ sVar ] = C end end
						return end
						if enFT == FORCE_ENTITY then
							tOBJ[ "Set"..sMethod ] = function( self, E )
														if E and E:IsValid() then self[ sVar ] = E end end
						return end
						if enFT == FORCE_HELEMENT then
							tOBJ[ "Set"..sMethod ] = function( self, HE )
														if HE and HE:IsHElement() then self[ sVar ] = HE end end
						return end
					   
						tOBJ[ "Set"..sMethod ] = function( self, var ) self[ sVar ] = var end
					end
				
---------------------------------------------------------------------------------------------------
//	HRect										//
---------------------------------------------------------------------------------------------------
local OBJ = {}

AccessorFunc(  OBJ,  "bHL"		,  "HL"				,  FORCE_BOOL 		)
AccessorFunc(  OBJ,  "bCHL"		,  "CheckHL"		,  FORCE_BOOL 		)
AccessorFunc(  OBJ,  "bAFP"		,  "AlphaFromParent",  FORCE_BOOL 		)
AccessorFunc(  OBJ,  "nWide"	,  "Wide"			,  FORCE_NUMBER 	)
AccessorFunc(  OBJ,  "nTall"	,  "Tall"			,  FORCE_NUMBER 	)
AccessorFunc(  OBJ,  "nRad"		,  "Radius"			,  FORCE_NUMBER 	)
AccessorFunc(  OBJ,  "nVal"		,  "Value"			,  FORCE_NUMBER 	)
AccessorFunc(  OBJ,  "sOutput"	,  "Output"			,  FORCE_STRING 	)
AccessorFunc(  OBJ,  "tPos"		,  "Pos"	 		,  FORCE_TABLE	 	)
AccessorFunc(  OBJ,  "cCol"		,  "Color"	 		,  FORCE_COLOR	 	)
AccessorFunc(  OBJ,  "cHCol"	,  "HColor"			,  FORCE_COLOR	 	)
AccessorFunc(  OBJ,  "heParent"	,  "Parent"			,  FORCE_HELEMENT 	)
AccessorFunc(  OBJ,  "heElement",  "Element"		,  FORCE_HELEMENT 	)
AccessorFunc(  OBJ,  "ePanel"	,  "Panel"			,  FORCE_ENTITY 	)

function OBJ:Initialize()

	self:SetPos(0,0) 
	self:SetRadius( 6 )
	self:SetSize( 10, 10 )
	self:SetValue( 0 )
	self:SetOutput( "" )
	self:SetColor( Color(255,255,255,255) )--math.fmod( self.Col.r + 128, 255 )
	self:SetHColor( Color(255,255,255,255) )
	
end

function OBJ:Draw()
	self:Think()

	local w,t = self:GetSize()
	local P   = self:GetPos()
	local C   = self:GetAlphaFromParent() and self:ModColorAlpha() or self:GetColor()
	
	draw.RoundedBox( self:GetRadius() , P.x - 0.5*w , P.y - 0.5*t , w, t, C )
end

function OBJ:Think()
	if self:GetCheckHL() then
		self:SetHL( self:MouseCheck( self:MPos() ) )
	end
end

function OBJ:SetPos( x , y )
	local X, Y = tonumber(x) or 0, tonumber(y) or 0
	if !self.tPos or type( self.tPos ) ~= "table" then self.tPos = { x = 0, y = 0 } end
	
	local HE = self:GetElement() or self:GetParent()
	if HE then
		local Ph = HE:GetPos()
			X = X + Ph.x
			Y = Y + Ph.y
	end
	self.tPos.x = X
	self.tPos.y = Y
	
	if self.Components then
		for n,E in ipairs( self.Components ) do
			E:SetPos( E:GetPos() )
		end
	end
end

function OBJ:SetSize( x , y )
	if type(x) == "number" and x > 0 then
		self:SetWide( x )
	end
	if type(y) == "number" and y > 0 then
		self:SetTall( y )
	end
end

function OBJ:GetSize()
	return self:GetWide(), self:GetTall()
end

function OBJ:SetColor( cC )
	local r,g,b,a = math.Clamp( cC.r,0,255 ) , math.Clamp( cC.g,0,255 ) , math.Clamp( cC.b,0,255 ) , math.Clamp( cC.a,0,255 )
	self.cCol = Color( r,g,b,a )

	r,g,b = math.Clamp( r + 40,0,255 ) , math.Clamp( g + 40,0,255 ) , math.Clamp( b + 40,0,255 )
	self:SetHColor( Color( r,g,b,a ) )
end

function OBJ:CheckPAlpha()
	local P = self:GetPanel()
		if P then
			return P:GetAlpha() || 1
		end
	return 1
end

function OBJ:ModColorAlpha()
	local A, C = self:CheckPAlpha(), self:GetColor()
		if self:GetHL() then
			C = self:GetHColor()
		end
	return Color(C.r, C.g, C.b, C.a * A)
end

function OBJ:MouseCheck( MX, MY )
	local w, t = self:GetSize()
	if MX >= -0.5*w and MX <= 0.5*w and MY >= -0.5*t and MY <= 0.5*t then
		return true
	end
	return false
end
 
function OBJ:MPos()
	if self:GetPanel() then
		local mx, my = self:GetPanel():MouseInfo()
		local P = self:GetPos()		
		return P.x - mx, P.y - my
	end
	return 0,0
end

function OBJ:Output(Output)
	local P = self:GetPanel()
	if !P then return end
	local OPType, sO = type(Output), self:GetOutput()
	--Check that the output is different to whatever was outputted last, so we don't keep sending the same value.
	if Output ~= self.LOutput and sO and sO ~= "" then
		if OPType == "number" then
			RunConsoleCommand( "HoloEleOut" , P:EntIndex() , sO, OPType , tostring(Output) )
		elseif OPType == "Vector" then
			RunConsoleCommand( "HoloEleOut" , P:EntIndex() , sO, OPType , Output.x, Output.y, Output.z )
		end
		self.LOutput = Output
	end
end

function OBJ:Input( nInput )
	if type(nInput) == "number" then
		self:SetValue( nInput )
	end
end

function OBJ:SetPanel( ePanel )
	if ePanel and ePanel:IsValid() then
		self.ePanel = ePanel
		if self.Components then
			for n,E in ipairs( self.Components ) do
				E:SetPanel( ePanel )
			end
		end
	end
end

function OBJ:GetPanel()
	local P = self.ePanel
	if P && P:IsValid() then
		return P
	else
		P = self:GetParent()
		if P then
			return P:GetPanel()
		end
	end
end

function OBJ:SetParent( heParent )
	self.heParent = heParent
	
	heParent.Children = heParent.Children || {}
		table.insert( heParent.Children, self )
end

function OBJ:SetElement( heElement )
	if !heElement or !heElement:IsHElement() then return end
	
	self.heElement = heElement
		heElement:AddComponent( self )
end

function OBJ:AddComponent( heComp )
	if !heComp or !heComp:IsHElement() then return end
	if !self.Components then self.Components = {} end
	
	table.insert( self.Components, heComp)
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

AccessorFunc(  OBJ,  "sText"	,  "Text"		, FORCE_STRING	)
AccessorFunc(  OBJ,  "sFont"	,  "Font"		, FORCE_STRING	)
AccessorFunc(  OBJ,  "enAlign"	,  "Align"		)
AccessorFunc(  OBJ,  "nFSize"	,  "FontSize"	, FORCE_NUMBER	)
AccessorFunc(  OBJ,  "nFWeight"	,  "FontWeight"	, FORCE_NUMBER	)

function OBJ:Initialize()
	
	self:SetText( "Label" )
	self:SetFont( "TargetID" )
	self:SetFontSize( 30 )
	self:SetFontWeight( 400 )
	self:SetAlign( TEXT_ALIGN_CENTER )

end

function OBJ:Draw()
	self:Think()
	
	local P = self:GetPos()
	draw.DrawText( self:GetText() , self:GetFont(), P.x, P.y-13, self:GetColor() , self:GetAlign() )
end

function OBJ:SetAlign( enA )
	local en = {
		TEXT_ALIGN_LEFT,
		TEXT_ALIGN_CENTER,
		TEXT_ALIGN_RIGHT,
		TEXT_ALIGN_TOP,
		TEXT_ALIGN_BOTTOM
				}
	
	for n, EN in ipairs( en ) do
		if enA == n - 1 || enA == EN then
			self.enAlign = EN
		end
	end
end

holo.Register( "HLabel" , OBJ , "HRect" )

---------------------------------------------------------------------------------------------------
//	HButton										//
---------------------------------------------------------------------------------------------------

local OBJ = {}

AccessorFunc( OBJ , "bOn"		, "Pressed"		, FORCE_BOOL	)
AccessorFunc( OBJ , "bToggle"	, "Toggle"		, FORCE_BOOL	)
AccessorFunc( OBJ , "nMax"		, "OnValue"		, FORCE_NUMBER	)
AccessorFunc( OBJ , "nMin"		, "OffValue"	, FORCE_NUMBER	)

function OBJ:Initialize()
	
	self.BaseClass.Initialize( self )
	
	self:SetOnValue(1)
	self:SetOffValue(0)
		
	H = holo.Create( "HRect" )
		H:SetElement( self )
		H:SetSize( self:GetWide() + 1 , self:GetTall() + 1 )
	self.Shadow = H
	
	local H = holo.Create( "HRect" )
		H:SetElement( self )
		H:SetCheckHL( true )
	self.Rect = H
	
	self:SetPressed( false )
	self:SetColor( self:GetColor() )

end

function OBJ:Think()	
	if self:GetToggle() then
		if (LocalPlayer():KeyPressed( IN_USE ) or (input.IsMouseDown(MOUSE_FIRST) && !self.MTog)) and self:MouseCheck( self:MPos() ) then
			self:Toggle()
			self.MTog = true
		elseif !input.IsMouseDown(MOUSE_FIRST) then
			self.MTog = false
		end
	elseif (LocalPlayer():KeyDown( IN_USE ) or (input.IsMouseDown(MOUSE_FIRST))) and  self:MouseCheck( self:MPos() ) then
		self:SetPressed( true )
	else
		self:SetPressed( false )
	end
end

function OBJ:SetColor( cC )
	self.BaseClass.SetColor( self, cC )
	
	local R = self.Rect
	if R then
		R:SetColor( cC )
	end
	local S = self.Shadow
	if S then
		S:SetColor( Color( math.fmod(cC.r - 200,255) , math.fmod(cC.g - 200,255) , math.fmod(cC.b - 200,255) , cC.a ) )
	end
end

function OBJ:SetSize( x , y )
	self:SetWide( x )
	self:SetTall( y )
	
	local R, S = self.Rect, self.Shadow
	if R then
		R:SetSize( x, y )
	end
	if S then
		S:SetSize( x+1, y+1 )
	end
end

function OBJ:SetPressed( bPress )
	if type(bPress) ~= "boolean" then return end
	if !self.bOn then self.bOn = !bPress end
	if self.bOn ~= bPress then
		self.bOn = bPress
		self:Output( bPress and self:GetOnValue() or self:GetOffValue() )
		local o = bPress and 0 or -1
		
		self.Rect:SetPos( o , o )
		self.Shadow:SetPos( 0 , 0 )

	end
end

function OBJ:Toggle()
	self:SetPressed( !self:GetPressed() )
end

function OBJ:Draw()
	self:Think()
	
	self.Shadow:Draw()
	self.Rect:Draw()
end

holo.Register( "HButton" , OBJ , "HRect" )

---------------------------------------------------------------------------------------------------
//	HSBar										//
---------------------------------------------------------------------------------------------------
local OBJ = {}

AccessorFunc( OBJ, "bVert"	, "Vertical"	, FORCE_BOOL )
AccessorFunc( OBJ, "bDrag"	, "Dragging"	, FORCE_BOOL )
AccessorFunc( OBJ, "bJump"	, "AllowJump"	, FORCE_BOOL )
AccessorFunc( OBJ, "nVal"	, "Value"		, FORCE_NUMBER )
AccessorFunc( OBJ, "nMax"	, "Max"			, FORCE_NUMBER )
AccessorFunc( OBJ, "nMin"	, "Min"			, FORCE_NUMBER )

function OBJ:Initialize()

	self.BaseClass.Initialize( self )

	self:SetMin( 0 )
	self:SetMax( 1 )
	self:SetValue( 0 )
	self:SetRadius( 2 )
	self.BoxP = 0 --The position
	self.BoxD = 10 -- The other demension
	self:SetVertical( true )
	self:SetAllowJump( false )
	
	local H = holo.Create( "HRect" )
		H:SetElement( self )
		H:SetRadius( 2 )
	self.Bar = H
	
	H = holo.Create( "HRect" )
		H:SetElement( self )
		H:SetRadius( 2 )
		H:SetCheckHL( true )
	self.Slider = H
	
	self:SetSize( 14, 50 )
	self:SetColor( Color(255,255,255,255) )
end

function OBJ:Draw()
	self:Think()
	
	self.Bar:Draw()
	self.Slider:Draw()
end

function OBJ:Think()
	local x,y = self:MPos()
	
	local M = self:GetAllowJump() and self:MouseCheck( x,y ) or self.Slider:MouseCheck( x,y )
	if (LocalPlayer():KeyDown( IN_USE ) or input.IsMouseDown(MOUSE_FIRST)) and M then
		self:SetDragging( true )
	end
	
	-- We want it to start dragging when both conditions are true, but we only want it to end when the key is up.
	if !LocalPlayer():KeyDown( IN_USE ) and !input.IsMouseDown(MOUSE_FIRST) then
		self:SetDragging( false )
	end

	if self:GetDragging() then
		local V, d = self:GetVertical(), self:GetLength()
		local m = V and y or x
		
		self:SetValue( Lerp( math.Clamp( 0.5+m/d,0,1 ) , self:GetMin(), self:GetMax() ) )
	end
	
end

function OBJ:GetLength()
	return self:GetVertical() and self:GetTall() or self:GetWide()
end

function OBJ:SetSize( x, y )
	local V = self:GetVertical()
	
	self:SetWide( x )
	self:SetTall( y )
	
	local B, S = self.Bar, self.Slider
	if B then B:SetSize( V and x-4 or x    , V and y-4  or y ) end
	if S then S:SetSize( V and x   or x/20 , V and y/20 or y ) end
end

function OBJ:SetColor( tCol )
	local H = self:GetHL()
	
	self.Col = tCol
	local B, S = self.Bar, self.Slider
	if B then B:SetColor( Color( math.Clamp( tCol.r - 200,0,255),math.Clamp( tCol.r - 200,0,255),math.Clamp( tCol.r - 200,0,255),math.Clamp( tCol.a - 50,50,255) ) ) end
	if S then S:SetColor( tCol ) end
end

function OBJ:SetValue( nVal )
	if type( nVal ) ~= "number" then return end
		self.nVal = nVal
		print( nVal )
		if self.Slider then
			local V, d = self:GetVertical(), self:GetLength()
			local f = nVal / ( self:GetMax() - self:GetMin() )

			if V then
				self.Slider:SetPos( 0 , math.Clamp( d*(0.5 - f) , -0.5*d+1 , 0.5*d-1 )  )
			else
				self.Slider:SetPos( math.Clamp( d*(0.5 - f) , -0.5*d+1 , 0.5*d-1 ) , 0  )
			end
		end
	self:Output( nVal )
end

holo.Register( "HSBar" , OBJ , "HRect" )

---------------------------------------------------------------------------------------------------
//	HDSBar										//
---------------------------------------------------------------------------------------------------
local OBJ = {}

function OBJ:Initialize()

	self.sOutput = ""	
	self.XMin  = 0
	self.XMax  = 1
	self.YMin  = 0
	self.YMax  = 1
	self.XVal = 0
	self.YVal = 0
	self.Rad  = 4
	self.BoxX = 0
	self.BoxY = 0
	self.BoxW = 10
	self.BoxT = 10
	self.OrX  = 0
	self.OrY  = 0
	self.Wide = 50
	self.Tall = 50
	self.Col  = Color(255,255,255,255)
	self.HCol = Color(255,255,255,255)
	self.HL   = false
	
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
		--local MAx,OAx,Scl,Mul,Add = self.Vert and y or x,self.Vert and self.OrY or self.OrX, self.Vert and self.Tall or self.Wide, self.Vert and 1 or -1, self.Vert and 0 or 1
		local XPos = (math.Clamp((((x - self.OrX) / (self.Wide * 0.5 - 10)) * -0.5) + 0.5,0,1) - 1) * -1
		self.XVal = self.XMin + (XPos * (self.XMax - self.XMin))
		
		local YPos = math.Clamp((((y - self.OrY) / (self.Tall * 0.5 - 10)) * -0.5) + 0.5,0,1)
		self.YVal = self.YMin + (YPos * (self.YMax - self.YMin))
		
	end
	local PVec = Vector(self.XVal,self.YVal,0)
	self:Output(PVec)
end

function OBJ:Draw()
	self:Think()
	
	local w,w2,w3,t,t2,t3,C,A = self.Wide,self.BoxW,self.BoxW + 5, self.Tall, self.BoxT,self.BoxT + 5, self.Col, self:CheckAlpha()
	if self:GetHL() then
		C = self.HCol
	end
	
	local XVal = 0
	if self.XMax-self.XMin != 0 then
		XVal = math.Clamp((self.XVal-self.XMin)/(self.XMax-self.XMin),0,1) * 2 - 1
	end
	--local axis, scale,mul = self.Vert and self.OrY or self.OrX, self.Vert and t or w, self.Vert and 1 or -1
	local ax = self.OrX - (XVal * (w * 0.5 - 10)) * -1
	
	local YVal = 0
	if self.YMax-self.YMin != 0 then
		YVal = math.Clamp((self.YVal-self.YMin)/(self.YMax-self.YMin),0,1) * 2 - 1
	end
	local ay = self.OrY - (YVal * (t * 0.5 - 10))
		
	local Col = Color(C.r, C.g, C.b, C.a * A)
	local ColD = Color(math.Clamp(C.r - 200,0,255),math.Clamp(C.r - 200,0,255),math.Clamp(C.r - 200,0,255),math.Clamp((C.a * A) - 50,50,255))
	
	draw.RoundedBox( self.Rad , (self.OrX - 0.5*w), (self.OrY - 0.5*t), w, t, ColD )
	draw.RoundedBox( self.Rad , (ax - 0.5*w2), (self.OrY - 0.5*t), w2, t, ColD ) -- Vertical Bar
	draw.RoundedBox( self.Rad , (self.OrX - 0.5*w), (ay - 0.5*t2), w, t2, ColD ) -- Horizontal Bar
	draw.RoundedBox( self.Rad , (ax - 0.5*w3), (ay - 0.5*t3) , w3, t3, Col )
end

function OBJ:MouseCheck( MX, MY )
	local XVal = 0
	if self.XMax-self.XMin != 0 then
		XVal = math.Clamp((self.XVal-self.XMin)/(self.XMax-self.XMin),0,1) * 2 - 1
	end
	--local axis, scale, mul = self.Vert and self.OrY or self.OrX, self.Vert and self.Tall or self.Wide, self.Vert and 1 or -1
	local x = self.OrX - (XVal * (self.Wide * 0.5 - 10)) * -1
	
	local YVal = 0
	if self.YMax-self.YMin != 0 then
		YVal = math.Clamp((self.YVal-self.YMin)/(self.YMax-self.YMin),0,1) * 2 - 1
	end
	--local axis, scale, mul = self.Vert and self.OrY or self.OrX, self.Vert and self.Tall or self.Wide, self.Vert and 1 or -1
	local y = self.OrY - (YVal * (self.Tall * 0.5 - 10))
	
	local w,t = self.BoxW, self.BoxT
	if MX >= x - 0.5 * w && MX <= x + 0.5 * w && MY >= y - 0.5*t && MY <= y + 0.5*t then
		return true
	end
	return false
end

holo.Register( "HDSBar" , OBJ , "HRect" )