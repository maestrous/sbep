	
local PANEL = {}
  
/*---------------------------------------------------------
   Name: Init
---------------------------------------------------------*/
function PANEL:Init()

        self.List = vgui.Create( "DPanelList", self )
                self.List:EnableHorizontal( false )
				self.List:SetAutoSize( true )
                self.List:EnableVerticalScrollbar()
                self.List:SetSpacing( 10 )

		self.Controls   = {}
		self.Categories = {}

end
 
/*---------------------------------------------------------
   Name: AddMCategory
---------------------------------------------------------*/
function PANEL:AddMCategory( categoryname , listkey , modeltable , toolname )

	local Key = (#self.Categories + 1)
	
	self.Categories[Key] = {}

	local DCC = vgui.Create("DCollapsibleCategory")
			DCC:SetExpanded( false )
			DCC:SetLabel( categoryname )
		self.List:AddItem( DCC )
	self.Categories[Key][1] = DCC
	 
	local DPL = vgui.Create( "DPanelList" )
			DPL:SetAutoSize( true )
			DPL:SetSpacing( 5 )
			DPL:EnableHorizontal( false )
			DPL:EnableVerticalScrollbar( false )
		DCC:SetContents( DPL )
	self.Categories[Key][2] = DPL
	
	self.Categories[Key]["ModelConVar"] = (toolname.."_model_"..tostring(Key))

	local DPS = vgui.Create( "PropSelect" )
			DPS:SetConVar( self.Categories[Key]["ConVar"] )
			DPS.Label:SetText( "Model:" )
			for m,n in pairs( modeltable ) do
				if n[2] == listkey then
					DPS:AddModel( m , {} )
				end
			end
		DPL:AddItem( DPS )
	self.Categories[Key][3] = DPS

	self.Categories[Key][1].Header.OnMousePressed = function()
									for m,n in pairs( self.Categories ) do
										if n[1]:GetExpanded() then
											n[1]:Toggle()
										end
									end
									if !DCC:GetExpanded() then
										DCC:Toggle()
									end
									RunConsoleCommand( toolname.."_activecat", Key )
							end
end
 
/*---------------------------------------------------------
   Name: ControlValues
---------------------------------------------------------*/
 
/*---------------------------------------------------------
   Name: PerformLayout
---------------------------------------------------------*/
 
/*---------------------------------------------------------
   Name: SelectButton
---------------------------------------------------------*/
 
/*---------------------------------------------------------
   Name: TestForChanges
---------------------------------------------------------*/
 
vgui.Register( "SBEPMultiPropSelect", PANEL )