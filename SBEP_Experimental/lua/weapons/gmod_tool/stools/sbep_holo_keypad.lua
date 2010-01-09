if WireAddon then
	TOOL.Tab = "Wire"
	TOOL.Category = "Wire - I/O"
else
	TOOL.Category		= "SBEP"
end

TOOL.Name			= "#Holo Keypad" 
TOOL.Command 		= nil 
TOOL.ConfigName 	= ""

TOOL.ClientConVar[ "model" 		] = "models/Slyfo/util_tracker.mdl"
TOOL.ClientConVar[ "R"  		] = 200
TOOL.ClientConVar[ "G"  		] = 200
TOOL.ClientConVar[ "B"  		] = 230
TOOL.ClientConVar[ "bright" 	] = 255
TOOL.ClientConVar[ "pass"   	] = 1234
TOOL.ClientConVar[ "encrypt"	] = 0

local TName = "sbep_holo_keypad"

if CLIENT then
	language.Add( "Tool_"..TName.."_name"		, "SBEP Holo Keypad" 									)
	language.Add( "Tool_"..TName.."_desc"		, "Spawn Holo Keypads." 								)
	language.Add( "Tool_"..TName.."_0"			, "Left-click to spawn a keypad."						)
	language.Add( "undone_SBEP Holo Keypad"		, "Undone SBEP Holo Keypad"								)
	
	local function SetColors( um )
		local HK = um:ReadEntity()
			local r,g,b = um:ReadFloat(),um:ReadFloat(),um:ReadFloat()
			local cry = um:ReadBool()
			timer.Simple( 0.1, function()
									HK:SetColors( r,g,b )
									HK.Encrypt = cry
								end)
	end
	usermessage.Hook( "SBEPHoloKeypad_SetColors" , SetColors )
end

function TOOL:LeftClick( tr ) 
	if CLIENT then return end
	
	local ply = self:GetOwner()

	local model = self:GetClientInfo( "model" )
	local pos = tr.HitPos

	local HK = ents.Create( "HoloButton" )
		HK:Spawn()
		
		HK:SetModel( model )
		
		HK:SetPos( pos - tr.HitNormal * HK:OBBMins().z )
		HK:SetAngles( tr.HitNormal:Angle() )
		HK:SetAngles( HK:LocalToWorldAngles( Angle(0,90,90) ) )
		
		local B = self:GetClientNumber( "bright" )
		local r = self:GetClientNumber( "R" ) * B/255
		local g = self:GetClientNumber( "G" ) * B/255
		local b = self:GetClientNumber( "B" ) * B/255
		umsg.Start( "SBEPHoloKeypad_SetColors" , RecipientFilter():AddAllPlayers() )
			umsg.Entity( HK )
			umsg.Float( r )
			umsg.Float( g )
			umsg.Float( b )
			umsg.Bool( self:GetClientNumber( "encrypt" ) == 1 )
		umsg.End()
		
	undo.Create("SBEP Holo Keypad")
		undo.AddEntity( HK )
		undo.SetPlayer( ply )
	undo.Finish()
	
	return true
end 

function TOOL:RightClick( tr ) 
	
end

function TOOL:Reload( tr ) 
	
end

function TOOL.BuildCPanel( panel )
	
	panel:SetSpacing( 10 )
	panel:SetName( "SBEP Holo Keypad" )
	
	----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	local DCC = vgui.Create( "DColorCircle" )
		DCC:SetSize( 100 , 3.5*panel:GetWide() )
		DCC.TranslateValues = function( self, x, y )
									x = x - 0.5
									y = y - 0.5
									local angle = math.atan2( x, y )
									local length = math.sqrt( x*x + y*y )
										length = math.Clamp( length, 0, 0.5 )
									x = 0.5 + math.sin( angle ) * length
									y = 0.5 + math.cos( angle ) * length
										self:SetHue( math.Rad2Deg( angle ) + 270 )
										self:SetSaturation( length * 2 )
										self:SetRGB( HSVToColor( self:GetHue(), self:GetSaturation(), 1 ) )
									return x, y
								end
		DCC.OnMouseReleased = function( self )
									self:SetDragging( false )
									self:MouseCapture( false )
									
									RunConsoleCommand( TName.."_R" , self:GetRGB().r )
									RunConsoleCommand( TName.."_G" , self:GetRGB().g )
									RunConsoleCommand( TName.."_B" , self:GetRGB().b )
								end
	panel:AddItem( DCC )
	
	local BNS = vgui.Create( "DNumSlider" )
		BNS:SetText( "Brightness" )
		BNS:SetMin( 0 )
		BNS:SetMax( 255 )
		BNS:SetDecimals( 0 )
		BNS:SetConVar( TName.."_bright" )
	panel:AddItem( BNS )
	----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	local PS = vgui.Create( "DPropertySheet" )
		PS:SetSize( 50, 400 )
	panel:AddItem( PS )
	
	local KP = vgui.Create( "DPanelList" )
		KP:SetSpacing( 5 )
		KP:SetPadding( 5 )
	
	PS:AddSheet( "Keypad" , KP , "gui/silkicons/plugin"	, false , false , "Keypad" )
	
	local PassL = vgui.Create( "DLabel" )
		PassL:SetText( "Pass Key" )
	KP:AddItem( PassL )
	
	local Pass = vgui.Create( "DTextEntry" )
		Pass.OnEnter = function(self)
							RunConsoleCommand( TName.."_pass" , self:GetValue() )
						end
	KP:AddItem( Pass )
	
	local Cry = vgui.Create( "DCheckBoxLabel" )
		Cry:SetText( "Encrypt Display" )
		Cry:SetConVar( TName.."_encrypt" )
	KP:AddItem( Cry )
	
 end  