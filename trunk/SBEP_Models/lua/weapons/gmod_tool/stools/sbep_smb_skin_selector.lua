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
			local SkinInt = 0
			if trace.Entity:SkinCount() == 10 then
				SkinInt = 1
			else
				SkinInt = 0
			end
			
			local SkinNumber  = self:GetClientNumber( "skin" )
			local GlassNumber = self:GetClientNumber( "glass" )
			
			local Skin = 1
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
	
	ModelDisp = vgui.Create( "DModelPanel" )
		ModelDisp:SetSize( 100,200 )
		ModelDisp:SetModel( "models/SmallBridge/Hulls,SW/sbhulle1.mdl" )
		ModelDisp:SetCamPos( Vector(  246 ,  235 ,  143 ) )
		ModelDisp:SetLookAt( Vector( -246 , -235 , -143 ) )
	panel:AddItem( ModelDisp )
	
	local function SBEP_SMBSkinTool_Skin( skin, glass )
		local var = type(glass)
		if var == "number" then
			glass = glass == 1
		end
		
		skin = 2 * skin
		if glass then
			skin = skin + 1
		end
		ModelDisp.Entity:SetSkin( skin )
	end

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
				SkinMenuOptions:AddOption( SkinTable[i] , function() 
															RunConsoleCommand( "sbep_smb_skin_selector_skin", (i - 1) )
															SBEP_SMBSkinTool_Skin( (i - 1) , GetConVarNumber( "sbep_smb_skin_selector_glass" ) )
														end )
			end
			SkinMenuOptions:Open()
						end
	panel:AddItem( SkinMenu )
	
	local GlassButton = vgui.Create("DButton")
	GlassButton:SetText( "Glass" )
	GlassButton:SetSize( 100, 25 )

	local GlassTable = { "No Glass" , "Glass" }

	GlassButton.DoClick = function ( btn )
			local GlassButtonOptions = DermaMenu()
			for k,v in ipairs( GlassTable ) do
				GlassButtonOptions:AddOption( v , function() 
													RunConsoleCommand( "sbep_smb_skin_selector_glass", (k - 1) )
													SBEP_SMBSkinTool_Skin( GetConVarNumber( "sbep_smb_skin_selector_skin" ) , (k - 1) )
												end )
			end
			GlassButtonOptions:Open()
						end
	panel:AddItem( GlassButton )
	
 end  