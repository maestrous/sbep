TOOL.Category		= "SBEP"
TOOL.Name			= "#SmallBridge Skin Selector" 
TOOL.Command 		= nil 
TOOL.ConfigName 	= ""

TOOL.ClientConVar[ "skin"  	] = 0
TOOL.ClientConVar[ "glass"  ] = 0

if ( CLIENT ) then
	language.Add( "Tool_sbep_smb_skin_selector_name" , "SBEP SmallBridge Skin Selector Tool" 				)
	language.Add( "Tool_sbep_smb_skin_selector_desc" , "Easily change skins of SmallBridge props." 			)
	language.Add( "Tool_sbep_smb_skin_selector_0"	 , "Left click a prop to switch to the selected skin." 	)
end


function TOOL:LeftClick( trace ) 
	if trace.Entity:IsValid() then
		if string.find( string.lower( trace.Entity:GetModel() ), "smallbridge" ) then
			if trace.Entity:SkinCount() == 10 then
				SkinInt = 1
			else
				SkinInt = 0
			end
			
			SkinNumber  = self:GetClientNumber( "skin" )
			GlassNumber = self:GetClientNumber( "glass" )
			
			if SkinInt == 1 then
				Skin = 2 * SkinNumber + GlassNumber
			elseif SkinInt == 0 then
				Skin = SkinNumber
			end
			
			trace.Entity:SetSkin(Skin)
			
			return true
		
		end	
	end
end 


function TOOL:RightClick( trace ) 

end  

function TOOL.BuildCPanel( panel )
	
	panel:SetSpacing( 10 )
	panel:SetName( "SBEP SmallBridge Skin Selector" )

	local SkinMenu = vgui.Create("DButton")
	SkinMenu:SetText( "Skin" )
	SkinMenu:SetSize( 100, 50 )

	local SkinTable = {
			"Scrappers"  ,
			"Advanced"   ,
			"SlyBridge"  ,
			"MedBridge2" ,
			"Jaanus"
				}

	SkinMenu.DoClick = function ( btn )
			local SkinMenuOptions = DermaMenu()
			for i = 1, #SkinTable do
				SkinMenuOptions:AddOption( SkinTable[i] , function() RunConsoleCommand( "sbep_smb_skin_selector_skin", (i - 1) ) end )
			end
			SkinMenuOptions:Open()
						end
	panel:AddItem( SkinMenu )
	
	local UseCheckBox = vgui.Create( "DCheckBoxLabel" )
		UseCheckBox:SetText( "Glass" )
		UseCheckBox:SetConVar( "sbep_smb_skin_selector_glass" )
		UseCheckBox:SetValue( 0 )
		UseCheckBox:SizeToContents()
	panel:AddItem( UseCheckBox )
	
 end  