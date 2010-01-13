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

local function ClampColor( cC )
	local r,g,b,a = math.Clamp( cC.r,0,255 ) , math.Clamp( cC.g,0,255 ) , math.Clamp( cC.b,0,255 ) , math.Clamp( cC.a,0,255 )
	return Color( r,g,b,a )
end

---------------------------------------------------------------------------------------------------
//	HRect										//
---------------------------------------------------------------------------------------------------
local OBJ = {}

AccessorFunc(  OBJ,  "bHL"		,  "HL"				,  FORCE_BOOL 		)
AccessorFunc(  OBJ,  "bCHL"		,  "CheckHL"		,  FORCE_BOOL 		)
AccessorFunc(  OBJ,  "bAFP"		,  "AlphaFromParent",  FORCE_BOOL 		)
AccessorFunc(  OBJ,  "bAFE"		,  "AlphaFromElement", FORCE_BOOL 		)
AccessorFunc(  OBJ,  "bHLFC"	,  "HLFromColor"	,  FORCE_BOOL 		)
AccessorFunc(  OBJ,  "nWide"	,  "Wide"			,  FORCE_NUMBER 	)
AccessorFunc(  OBJ,  "nTall"	,  "Tall"			,  FORCE_NUMBER 	)
AccessorFunc(  OBJ,  "nRad"		,  "Radius"			,  FORCE_NUMBER 	)
AccessorFunc(  OBJ,  "nVal"		,  "Value"			,  FORCE_NUMBER 	)
AccessorFunc(  OBJ,  "sOutput"	,  "Output"			,  FORCE_STRING 	)
AccessorFunc(  OBJ,  "tPos"		,  "Pos"	 		,  FORCE_TABLE	 	)
AccessorFunc(  OBJ,  "cCol"		,  "Color"	 		,  FORCE_COLOR	 	)
AccessorFunc(  OBJ,  "cHLCol"	,  "HLColor"		,  FORCE_COLOR	 	)
AccessorFunc(  OBJ,  "heParent"	,  "Parent"			,  FORCE_HELEMENT 	)
AccessorFunc(  OBJ,  "heElement",  "Element"		,  FORCE_HELEMENT 	)
AccessorFunc(  OBJ,  "ePanel"	,  "Panel"			,  FORCE_ENTITY 	)

function OBJ:Initialize()

	self:SetPos(0,0) 
	self:SetRadius( 6 )
	self:SetSize( 10, 10 )
	self:SetValue( 0 )
	self:SetOutput( "" )
	self:SetHLFromColor( true )
	self:SetColor( Color(255,255,255,255) )
	
end

function OBJ:Draw()
	self:Think()

	local w,t = self:GetSize()
	local P   = self:GetPos()
	local C
	if self:GetAlphaFromElement() or self:GetAlphaFromParent() then
		C = self:ModColorAlpha()
	else
		C = self:GetHL() and self:GetHLColor() or self:GetColor()
	end
	
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
	self.cCol = ClampColor( cC )

	if self:GetHLFromColor() then
		self:SetHLColor( cC )
		self:SetHLColorBright( math.fmod( self:GetHLColorBright() + 0.15, 255 ) )
	end
end

function OBJ:SetHLColor( cC )
	self.cHLCol = ClampColor( cC )
end

function OBJ:SetColorBright( iV )
	iV = math.Clamp( iV, 0, 1 )
	local C = self:GetColor()
	local h,s,v = ColorToHSV( C )
	local C2 = HSVToColor( h,s, iV )
	C2.a = C.a
	self:SetColor( C2 )
end

function OBJ:GetColorBright()
	local h,s, V = ColorToHSV( self:GetColor() )
	return V
end

function OBJ:SetHLColorBright( iV )
	iV = math.Clamp( iV, 0, 1 )
	local C = self:GetHLColor()
	local h,s,v = ColorToHSV( C )
	local C2 = HSVToColor( h,s, iV )
	C2.a = C.a	
	self:SetHLColor( C2 )
end

function OBJ:GetHLColorBright()
	local h,s, V = ColorToHSV( self:GetHLColor() )
	return V
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
			C = self:GetHLColor()
		end
	return Color(C.r, C.g, C.b, C.a * A)
end

function OBJ:MouseCheck( MX, MY )
	local w, t = self:GetSize()
	if w and t then
		if MX >= -0.5*w and MX <= 0.5*w and MY >= -0.5*t and MY <= 0.5*t then
			return true
		end
	end
	return false
end
 
function OBJ:MPos()
	local panel = self:GetPanel()
	if panel then
		local mx, my = panel:MouseInfo()
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
		E = self:GetElement()
		if E then
			return E:GetPanel()
		end
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
		H:SetAlphaFromElement( true )
	self.Shadow = H
	
	local H = holo.Create( "HRect" )
		H:SetElement( self )
		H:SetCheckHL( true )
		H:SetAlphaFromElement( true )
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
		S:SetColor( cC )
		S:SetColorBright( math.fmod( self:GetColorBright() - 0.7 , 1 ) )
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
	self:SetCheckHL( false )
	self:SetRadius( 2 )
	self:SetVertical( true )
	self:SetAllowJump( false )
	
	local H = holo.Create( "HRect" )
		H:SetElement( self )
		H:SetRadius( 2 )
		H:SetAlphaFromElement( true )
	self.Bar = H
	
	H = holo.Create( "HRect" )
		H:SetElement( self )
		H:SetRadius( 2 )
		H:SetAlphaFromElement( true )
		H:SetCheckHL( true )
	self.Slider = H
	
	self:SetSize( 14, 50 )
	self:SetValue( 0.5 )
	self:SetColor( Color(255,255,255,255) )
end

function OBJ:Draw()
	self:Think()
	
	self.Bar:Draw()
	self.Slider:Draw()
end

function OBJ:Think()
	local D = false
	if LocalPlayer():KeyDown( IN_USE ) or input.IsMouseDown(MOUSE_FIRST) then
		local M = false
		local x, y = self:MPos()
		if self:GetAllowJump() then
			M = self:MouseCheck( x,y )
		else
			M = self.Slider:MouseCheck( self.Slider:MPos() )
		end

		if M or self:GetDragging() then
			D = true
			
			local V, l = self:GetVertical(), self:GetLength()
			local m = V and y or x
			
			self:SetValue( Lerp( math.Clamp( 0.5 + m/l ,0,1 ) , self:GetMin(), self:GetMax() ) )
		end
	end
	self:SetDragging( D )
end

function OBJ:GetLength()
	return (self:GetVertical() and self:GetTall() or self:GetWide())
end

function OBJ:SetSize( x, y )
	local V = self:GetVertical()
	
	self:SetWide( x )
	self:SetTall( y )
	
	local B, S = self.Bar, self.Slider
	if B then B:SetSize( V and x-4 or x    , V and y-4  or y ) end
	if S then S:SetSize( V and x   or x/15 , V and y/15 or y ) end
end

function OBJ:SetColor( cC )
	local H = self:GetHL()
	
	self.cCol = cC
	local B, S = self.Bar, self.Slider
	if B then 
		B:SetColor( cC )
		B:SetColorBright( math.fmod( B:GetColorBright() - 0.75 , 0 , 1 ) )
	end
	if S then S:SetColor( cC ) end
end

function OBJ:SetValue( nVal )
	if type( nVal ) ~= "number" then return end

	self.nVal = nVal
	if self.Slider then
		local V, d = self:GetVertical(), self:GetLength()
		local f = math.abs( nVal / ( self:GetMax() - self:GetMin() ) )

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

AccessorFunc( OBJ, "bDrag"	, "Dragging"	, FORCE_BOOL )
AccessorFunc( OBJ, "bJump"	, "AllowJump"	, FORCE_BOOL )
AccessorFunc( OBJ, "nXVal"	, "XValue"		, FORCE_NUMBER )
AccessorFunc( OBJ, "nYVal"	, "YValue"		, FORCE_NUMBER )
AccessorFunc( OBJ, "nXMax"	, "XMax"		, FORCE_NUMBER )
AccessorFunc( OBJ, "nXMin"	, "XMin"		, FORCE_NUMBER )
AccessorFunc( OBJ, "nYMax"	, "YMax"		, FORCE_NUMBER )
AccessorFunc( OBJ, "nYMin"	, "YMin"		, FORCE_NUMBER )

function OBJ:Initialize()

	self.BaseClass.Initialize( self )

	self:SetXMin( 0 )
	self:SetXMax( 1 )
	self:SetYMin( 0 )
	self:SetYMax( 1 )
	self:SetRadius( 2 )
	self:SetAllowJump( false )
	
	local H = holo.Create( "HRect" )
		H:SetElement( self )
		H:SetRadius( 4 )
		H:SetAlphaFromElement( true )
	self.Sheet = H
	
	H = holo.Create( "HRect" )
		H:SetElement( self )
		H:SetRadius( 2 )
		H:SetAlphaFromElement( true )
	self.XBar = H
	
	H = holo.Create( "HRect" )
		H:SetElement( self )
		H:SetRadius( 2 )
		H:SetAlphaFromElement( true )
	self.YBar = H
	
	H = holo.Create( "HRect" )
		H:SetElement( self )
		H:SetRadius( 2 )
		H:SetAlphaFromElement( true )
		H:SetCheckHL( true )
	self.Slider = H
	
	self:SetSize( 50 , 50 )
	self:SetValue( 0.5, 0.5 )
	self:SetColor( Color(255,255,255,255) )
end

function OBJ:Draw()
	self:Think()
	
	self.Sheet:Draw()
	self.XBar:Draw()
	self.YBar:Draw()
	self.Slider:Draw()
end

function OBJ:Think()
	local D = false
	if LocalPlayer():KeyDown( IN_USE ) or input.IsMouseDown(MOUSE_FIRST) then
		local M = false
		local x, y = self:MPos()
		if self:GetAllowJump() then
			M = self:MouseCheck( x,y )
		else
			M = self.Slider:MouseCheck( self.Slider:MPos() )
		end

		if M or self:GetDragging() then
			D = true
			
			local X = Lerp( math.Clamp( 0.5 + x/self:GetWide() ,0,1 ) , self:GetXMin(), self:GetXMax() )
			local Y = Lerp( math.Clamp( 0.5 + y/self:GetTall() ,0,1 ) , self:GetYMin(), self:GetYMax() )
			print( X,Y )
			self:SetValue( X , Y )
			--self:SetXValue( X )
			--self:SetYValue( Y )
		end
	end
	self:SetDragging( D )
end

function OBJ:SetSize( x, y )
	self:SetWide( x )
	self:SetTall( y )
	
	local Sh, XB, YB, Sl = self.Sheet, self.XBar, self.YBar, self.Slider
	if Sh then Sh:SetSize( x , y ) end
	if XB then XB:SetSize(  x , y/10 - 4 ) end
	if YB then YB:SetSize( x/10 - 4 , y  ) end
	if Sl then Sl:SetSize(  x/10 , y/10  ) end
end

function OBJ:SetColor( cC )
	cC = ClampColor( cC )
	
	self.cCol = cC
	local Sh, XB, YB, Sl = self.Sheet, self.XBar, self.YBar, self.Slider
	if Sh then 
		local C2 = cC
		if C2.a < 255 then
			C2.a = math.Clamp( C2.a - 40 , 100 , 255 )
		end
		Sh:SetColor( C2 )
		Sh:SetColorBright( math.fmod( Sh:GetColorBright() - 0.5 , 0 , 1 ) )
	end
	if XB then 
		XB:SetColor( cC )
		XB:SetColorBright( math.fmod( XB:GetColorBright() - 0.75 , 0 , 1 ) )
	end
	if YB then 
		YB:SetColor( cC )
		YB:SetColorBright( math.fmod( YB:GetColorBright() - 0.75 , 0 , 1 ) )
	end
	if Sl then Sl:SetColor( cC ) end
end

function OBJ:SetValue( nXVal , nYVal )
	if type( nXVal ) ~= "number" or type( nYVal ) ~= "number" then return end

	self.nXVal = nXVal
	self.nYVal = nYVal
	local fx = ( nXVal - self:GetXMin() ) / ( self:GetXMax() - self:GetXMin() )
	local fy = ( nYVal - self:GetYMin() ) / ( self:GetYMax() - self:GetYMin() )
	
	local w, t = self:GetWide(), self:GetTall()
	local x = math.Clamp( w*(0.5 - fx) , -0.5*w + 1 , 0.5*w - 1 )
	local y = math.Clamp( t*(0.5 - fy) , -0.5*t + 1 , 0.5*t - 1 )
	
	local Sl = self.Slider
		if Sl then
			Sl:SetPos( x , y  )
		end
	local XB = self.XBar
		if XB then
			XB:SetPos( 0 , y  )
		end
	local YB = self.YBar
		if YB then
			YB:SetPos( x , 0  )
		end
	--self:Output( nVal )
end

function OBJ:GetValue()
	return self:GetXValue() , self:GetYValue()
end

function OBJ:SetXValue( nVal )
	if type( nVal ) ~= "number" then return end
		
	self.nXVal = nVal
	local f = ( nVal - self:GetXMin() ) / ( self:GetXMax() - self:GetXMin() )
	local w = self:GetWide()
	local x = math.Clamp( w*(0.5 - f) , -0.5*w + 1 , 0.5*w - 1 )
	
	local Sl = self.Slider
		if Sl then
			Sl:SetPos( x , Sl:GetPos().y  )
		end
	local YB = self.YBar
		if YB then
			YB:SetPos( x , 0  )
		end
	--self:Output( nVal )
end

function OBJ:SetYValue( nVal )
	if type( nVal ) ~= "number" then return end
		
	self.nYVal = nVal
	local f = ( nVal - self:GetYMin() ) / ( self:GetYMax() - self:GetYMin() )
	local t = self:GetTall()
	local y = math.Clamp( t*(0.5 - f) , -0.5*t + 1 , 0.5*t - 1 )
	
	local Sl = self.Slider
		if Sl then
			Sl:SetPos( Sl:GetPos().x , y  )
		end
	local XB = self.XBar
		if XB then
			XB:SetPos( 0 , y )
		end
	--self:Output( nVal )
end

holo.Register( "HDSBar" , OBJ , "HRect" )