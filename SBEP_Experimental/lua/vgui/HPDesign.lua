/*------------------------------------------------------------------------------------------------------------------

	Control: HPDTablet

------------------------------------------------------------------------------------------------------------------*/
local PANEL = {}
  
/*---------------------------------------------------------
   Name: Init
---------------------------------------------------------*/
function PANEL:Init()

	self.Elements = {}

end

/*---------------------------------------------------------
   Name: AddItem
---------------------------------------------------------*/
function PANEL:AddItem()
	local F = vgui.Create( "HPDItem" , self )
		F:SetPos( 20, 50 )
		local N = #self.Elements
		F.TIndex = N + 1
		F.Tablet = self
	self.Elements[ N + 1 ] = F
	return F
end

/*---------------------------------------------------------
   Name: SetSelected
---------------------------------------------------------*/
function PANEL:SetSelected( nS )
	nS = tonumber( nS ) or 1
	self.nSel = nS
	
	if !self.Elements then self.Elements = {} return end

	for n,HE in ipairs( self.Elements ) do
		if n == nS then
			HE:SetSelected( true )
		else
			HE:SetSelected( false )
		end
	end
end

/*---------------------------------------------------------
   Name: GetSelected
---------------------------------------------------------*/
function PANEL:GetSelected()
	local E = self.Elements
	if E then
		return E[ self.nSel ]
	end
end

derma.DefineControl( "HPDTablet", "A design tablet for the HoloPanel design menu.", PANEL, "DPanel" )

/*------------------------------------------------------------------------------------------------------------------

	Control: HPDItem

------------------------------------------------------------------------------------------------------------------*/
local PANEL = {}

AccessorFunc( PANEL, "bSel" , "Selected" , FORCE_BOOL )
  
/*---------------------------------------------------------
   Name: Init
---------------------------------------------------------*/
function PANEL:Init()

	self:SetVisible( true )
	self:ShowCloseButton( false )
	self:SetTitle( "" )
	self:SetSize( 60, 80 )
	--self:SetBGColor( 64,64,64, 255 )
	
	/*local P = vgui.Create( "DPanel" , self )
		P:SetPos(0,22)
		/*P.Paint = function()
						surface.SetDrawColor( 50, 50, 50, 255 )
						surface.DrawRect( 0, 0, P:GetWide(), P:GetTall() )
					end*
		P:SetBGColor( 64,64,64, 255 )
	self.P = P	*/

end

/*---------------------------------------------------------
   Name: PaintOver
---------------------------------------------------------*/
function PANEL:PaintOver()
	if self:GetSelected() then
		surface.SetDrawColor( 255, 255, 255, 255 )
		self:DrawOutlinedRect()
	end
end

/*---------------------------------------------------------
   Name: OnMouseReleased
---------------------------------------------------------*/
function PANEL:OnMouseReleased()
	self.Dragging = nil
	self.Sizing = nil
	self:MouseCapture( false )
	
	local P = self:GetParent()
	if P then
		P:SetSelected( self.TIndex )
	end
end

/*---------------------------------------------------------
   Name: Think
---------------------------------------------------------*/
function PANEL:Think()
	if self.Dragging then
	
		local x = gui.MouseX() - self.Dragging[1]
		local y = gui.MouseY() - self.Dragging[2]
		
		if self:GetScreenLock() then
			local pw, pt = self:GetParent():GetSize()
			x = math.Clamp( x, 0, pw - self:GetWide() )
			y = math.Clamp( y, 0, pt - self:GetTall() )
		end
	   
		self:SetPos( x, y )
	end
	
	if ( self.Sizing ) then

		local x = gui.MouseX() - self.Sizing[1]
		local y = gui.MouseY() - self.Sizing[2]

		self:SetSize( x, y )
		self:SetCursor( "sizenwse" )
		return

	end
   
	if ( self.Hovered &&
		self.m_bSizable &&
			gui.MouseX() > (self.x + self:GetWide() - 20) &&
			gui.MouseY() > (self.y + self:GetTall() - 20) ) then      

		self:SetCursor( "sizenwse" )
		return
	end
   
	if ( self.Hovered && self:GetDraggable() ) then
			self:SetCursor( "sizeall" )
	end
end

derma.DefineControl( "HPDItem", "An item for the HoloPanel design menu.", PANEL, "DFrame" )