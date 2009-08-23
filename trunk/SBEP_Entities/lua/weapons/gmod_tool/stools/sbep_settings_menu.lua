TOOL.Category		= "SBEP"
TOOL.Name			= "#Settings"
TOOL.Command		= nil
TOOL.ConfigName 	= ""

//TOOL.ClientConVar[ "red" ] = "255"
//TOOL.ClientConVar[ "green" ] = "255"
//TOOL.ClientConVar[ "blue" ] = "255"

if CLIENT then

	language.Add( "Tool_sbep_settings_menu_name", "SBEP Settings Menu" )
	language.Add( "Tool_sbep_settings_menu_desc", "Setup your settings." )
	language.Add( "Tool_sbep_settings_menu_0", "Open the Context Menu for this stool to edit SBEP settings!" )
	
end

function TOOL:LeftClick( trace )

end

function TOOL:RightClick( trace )

end

function TOOL:Reload( trace )

end

function TOOL.BuildCPanel(panel)

	panel:SetSpacing( 10 )
	panel:SetName( "SBEP Settings" )
	
	local DupeFixButton = vgui.Create("DButton")
		DupeFixButton:SetText( "Fix All Dupes" )
		DupeFixButton:SetSize( 100, 50 )

	DupeFixButton.DoClick = function ( btn )
							RunConsoleCommand( "SBEP_FixAllDupes" )
						end
	panel:AddItem( DupeFixButton )
	
	//panel:AddControl("Label", {Text = "Weapon Color"})
	//panel:AddControl("Color",{Label = "Weapon Color",Red = "sbep_settings_menu_red", Green = "sbep_settings_menu_green", Blue = "sbep_settings_menu_blue",ShowAlpha = "0",ShowHSV = "0",ShowRGB = "1",Multiplier = "255"})
	//panel:AddControl("Button", {Text = "Update Settings",Command = "sbep_update_settings"})
	
end 

/*
if (CLIENT) then
	function LetsGetOurColorNow()
			RunConsoleCommand("SBEP_Weapon_Color",GetConVar("sbep_settings_menu_red"):GetInt(),GetConVar("sbep_settings_menu_green"):GetInt(),GetConVar("sbep_settings_menu_blue"):GetInt())
	end
	concommand.Add("sbep_update_settings",LetsGetOurColorNow)
end 
*/