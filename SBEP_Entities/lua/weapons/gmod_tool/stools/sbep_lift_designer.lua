TOOL.Category		= "SBEP"
TOOL.Name			= "#Lift System Designer"
TOOL.Command		= nil
TOOL.ConfigName 	= ""

local ButtonModelTable = {
			[ 1 ] = { "models/SmallBridge/Elevators,Small/sbselevm.mdl" 	, "M"		 } ,
			[ 2 ] = { "models/SmallBridge/Elevators,Small/sbselevme.mdl" 	, "ME"		 } ,
			[ 3 ] = { "models/SmallBridge/Elevators,Small/sbselevmedh.mdl" 	, "MEdh"	 } ,
			[ 4 ] = { "models/SmallBridge/Elevators,Small/sbselevmedw.mdl" 	, "MEdw"	 } ,
			[ 5 ] = { "models/SmallBridge/Elevators,Small/sbselevmr.mdl" 	, "MR"		 } ,
			[ 6 ] = { "models/SmallBridge/Elevators,Small/sbselevmt.mdl" 	, "MT"		 } ,
			[ 7 ] = { "models/SmallBridge/Elevators,Small/sbselevmx.mdl" 	, "MX"		 } ,
			[ 8 ] = { "models/SmallBridge/Elevators,Small/sbselevs.mdl" 	, "S"		 }
						}

local SpecialModelTable = {
			[ 1 ] = { "models/SmallBridge/Station Parts/sbbridgevisorm.mdl" , "VM"		 } ,
			[ 2 ] = { "models/SmallBridge/Station Parts/sbhuble.mdl" 		, "H"		 }
						}

if CLIENT then
	language.Add( "Tool_sbep_lift_designer_name", "SBEP Lift System Designer" )
	language.Add( "Tool_sbep_lift_designer_desc", "Create a lift system." )
	language.Add( "Tool_sbep_lift_designer_0", "Left click somewhere to begin." )
	language.Add( "undone_SBEP Lift System"	, "Undone SBEP Lift System"			)
end

local ConVars = {
		{ "editing" 		, 						0							} ,
		{ "model"			, "models/SmallBridge/Elevators,Small/sbselevm.mdl" } ,
		{ "yaw"				, 						0							} ,
		{ "roll"			, 						0							} ,
		{ "activepart"		,						1							} ,
		{ "skin"			,						0							} ,
		{ "enableuse"		,						0							} ,
		{ "doors"			,						0							} ,
		{ "size"			,						1							}
			}
for k,v in pairs(ConVars) do
	TOOL.ClientConVar[ v[1] ] = v[2]
end

if CLIENT then
	
	SBEPLiftMenuPanel = vgui.Create( "DFrame" )
		SBEPLiftMenuPanel:SetPos( 30,30 )
		SBEPLiftMenuPanel:SetSize( 325, 548 )
		SBEPLiftMenuPanel:SetTitle( "SBEP Lift System Designer" )
		SBEPLiftMenuPanel:SetVisible( false )
		SBEPLiftMenuPanel:SetDraggable( false )
		SBEPLiftMenuPanel:ShowCloseButton( false )
		SBEPLiftMenuPanel:MakePopup()
	
	SBEPLiftSpecialMenuPanel = vgui.Create( "DFrame" )
		SBEPLiftSpecialMenuPanel:SetPos( 360,193 )
		SBEPLiftSpecialMenuPanel:SetSize( 165,85 )
		SBEPLiftSpecialMenuPanel:SetTitle( " " )
		SBEPLiftSpecialMenuPanel:SetBackgroundBlur( true )
		SBEPLiftSpecialMenuPanel:SetVisible( false )
		SBEPLiftSpecialMenuPanel:SetDraggable( false )
		SBEPLiftSpecialMenuPanel:ShowCloseButton( false )
		SBEPLiftSpecialMenuPanel:MakePopup()
	
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//					MENU CONTROLS
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		
	SBEPLiftMenuCloseButton = vgui.Create("DSysButton", SBEPLiftMenuPanel )
		SBEPLiftMenuCloseButton:SetPos( 285 , 4 )   
		SBEPLiftMenuCloseButton:SetSize( 35 , 13 )   
		SBEPLiftMenuCloseButton:SetType( "close" )
		SBEPLiftMenuCloseButton.DoClick = function()
												SBEPLiftMenuPanelVisible = false
												SBEPLiftMenuPanel:SetVisible( SBEPLiftMenuPanelVisible )
												RunConsoleCommand( "SBEP_LiftCancelMenu_ser" )
										end
	
	SBEPLiftMenuFinishButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuFinishButton:SetPos( 5 , 508 )
		SBEPLiftMenuFinishButton:SetSize( 315 , 35 )
		SBEPLiftMenuFinishButton:SetImage( "sbep_icons/Finish.vmt" )
		SBEPLiftMenuFinishButton.DoClick = function()
												RunConsoleCommand( "SBEP_LiftFinishSystem_ser" )
										end
	
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//					MODEL CONTROLS
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	SBEPLiftMenuPartButton = {}
	for k,v in ipairs(ButtonModelTable) do
		SBEPLiftMenuPartButton[k] = vgui.Create("DImageButton", SBEPLiftMenuPanel )
			SBEPLiftMenuPartButton[k]:SetImage( "sbep_icons/SBSelev"..v[2]..".vmt" )
			SBEPLiftMenuPartButton[k]:SetPos( 5 + 80 * ((k - 1)%4) , 28 + 80 * math.floor((k - 1)/ 4))
			SBEPLiftMenuPartButton[k]:SetSize( 75 , 75 )
			SBEPLiftMenuPartButton[k].DoClick = function()
													RunConsoleCommand( "SBEP_LiftSys_SetLiftPartModel_ser" , GetConVarNumber( "sbep_lift_designer_activepart" ) , v[1] )
												end
	end
	
	SBEPLiftMenuSpecialButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuSpecialButton:SetPos( 165 , 188 )   
		SBEPLiftMenuSpecialButton:SetSize( 155 , 35 )
		SBEPLiftMenuSpecialButton:SetImage( "sbep_icons/Special.vmt" )
		SBEPLiftMenuSpecialButton.DoClick = function()
												SBEPLiftSpecialVisible = !SBEPLiftSpecialVisible
												SBEPLiftSpecialMenuPanel:SetVisible( SBEPLiftSpecialVisible )
											end
	
	SBEPLiftMenuSpecial1 = vgui.Create("DImageButton", SBEPLiftSpecialMenuPanel )
		SBEPLiftMenuSpecial1:SetImage( "sbep_icons/SBSelevVM.vmt" )
		SBEPLiftMenuSpecial1:SetPos( 5 , 5 )
		SBEPLiftMenuSpecial1:SetSize( 75 , 75 )
		SBEPLiftMenuSpecial1.DoClick = function()
												SBEPLiftSpecialVisible = false
												SBEPLiftSpecialMenuPanel:SetVisible( SBEPLiftSpecialVisible )
												RunConsoleCommand( "SBEP_LiftSys_SetLiftPartModel_ser" , GetConVarNumber( "sbep_lift_designer_activepart" ) , SpecialModelTable[1][1] )
											end

	SBEPLiftMenuSpecial2 = vgui.Create("DImageButton", SBEPLiftSpecialMenuPanel )
		SBEPLiftMenuSpecial2:SetImage( "sbep_icons/SBSelevH.vmt" )
		SBEPLiftMenuSpecial2:SetPos( 85 , 5 )
		SBEPLiftMenuSpecial2:SetSize( 75 , 75 )
		SBEPLiftMenuSpecial2.DoClick = function()
												SBEPLiftSpecialVisible = false
												SBEPLiftSpecialMenuPanel:SetVisible( SBEPLiftSpecialVisible )
												RunConsoleCommand( "SBEP_LiftSys_SetLiftPartModel_ser" , GetConVarNumber( "sbep_lift_designer_activepart" ) , SpecialModelTable[2][1] )
											end
	
	function SBEPDisableButtons( ply , cmd , args )
		local size = tonumber( GetConVarNumber( "sbep_lift_designer_size" ) )
		if size == 2 then
			SBEPLiftMenuPartButton[4]:SetDisabled( true )
			SBEPLiftMenuSpecialButton:SetDisabled( true )
		else
			SBEPLiftMenuPartButton[4]:SetDisabled( false )
			SBEPLiftMenuSpecialButton:SetDisabled( false )
		end
	end
	concommand.Add( "SBEPDisableButtons_cl" , SBEPDisableButtons )

	
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//					CONSTRUCTION CONTROLS
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	SBEPLiftMenuConstructButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuConstructButton:SetPos( 5 , 268 )
		SBEPLiftMenuConstructButton:SetSize( 155 , 195 )
		SBEPLiftMenuConstructButton:SetImage( "sbep_icons/Construct.vmt" )
		SBEPLiftMenuConstructButton.DoClick = function()
												local pos = tonumber( GetConVarNumber( "sbep_lift_designer_activepart" ) )
												pos = pos + 1
												RunConsoleCommand( "SBEP_LiftConstructPart_ser" , pos )
										end
	
	SBEPLiftMenuUpPosButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuUpPosButton:SetPos( 45 , 228 )   
		SBEPLiftMenuUpPosButton:SetSize( 75 , 35 )   
		SBEPLiftMenuUpPosButton:SetImage( "sbep_icons/ArrowUp.vmt" )
		SBEPLiftMenuUpPosButton.DoClick = function()
												local pos = tonumber( GetConVarNumber( "sbep_lift_designer_activepart" ) )
												pos = math.Clamp( pos + 1 , 1 , CL.LiftSystem:GetNetworkedInt( "SBEP_LiftPartCount" ) )
												RunConsoleCommand( "sbep_lift_designer_activepart" , pos )
												RunConsoleCommand( "SBEP_LiftGetCamHeight_ser" )
										end
	
	SBEPLiftMenuDownPosButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuDownPosButton:SetPos( 45 , 468 )   
		SBEPLiftMenuDownPosButton:SetSize( 75 , 35 )   
		SBEPLiftMenuDownPosButton:SetImage( "sbep_icons/ArrowDown.vmt" )
		SBEPLiftMenuDownPosButton.DoClick = function()
												local pos = tonumber( GetConVarNumber( "sbep_lift_designer_activepart" ) )
												pos = math.Clamp( pos - 1 , 1 , CL.LiftSystem:GetNetworkedInt( "SBEP_LiftPartCount" ) )
												RunConsoleCommand( "sbep_lift_designer_activepart" , pos )
												RunConsoleCommand( "SBEP_LiftGetCamHeight_ser" )
										end
	
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//					PART CONTROLS
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	SBEPLiftMenuInvertPartButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuInvertPartButton:SetPos( 45 , 188 )   
		SBEPLiftMenuInvertPartButton:SetSize( 75 , 35 )   
		SBEPLiftMenuInvertPartButton:SetImage( "sbep_icons/Invert.vmt" )
		SBEPLiftMenuInvertPartButton.DoClick = function()
													RunConsoleCommand( "SBEP_LiftSys_SetLiftPartRoll_ser" , GetConVarNumber( "sbep_lift_designer_activepart" ) , 180 )
													RunConsoleCommand( "SBEP_LiftGetCamHeight_ser" )
												end

	SBEPLiftMenuRotPartCButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuRotPartCButton:SetPos( 5 , 188 )   
		SBEPLiftMenuRotPartCButton:SetSize( 35 , 35 )
		SBEPLiftMenuRotPartCButton:SetImage( "sbep_icons/RotC.vmt" )
		SBEPLiftMenuRotPartCButton.DoClick = function()
												RunConsoleCommand( "SBEP_LiftSys_SetLiftPartYaw_ser" , GetConVarNumber( "sbep_lift_designer_activepart" ) , 270 )
											end
	
	SBEPLiftMenuRotPartACButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuRotPartACButton:SetPos( 125 , 188 )   
		SBEPLiftMenuRotPartACButton:SetSize( 35 , 35 )
		SBEPLiftMenuRotPartACButton:SetImage( "sbep_icons/RotAC.vmt" )
		SBEPLiftMenuRotPartACButton.DoClick = function()
												RunConsoleCommand( "SBEP_LiftSys_SetLiftPartYaw_ser" , GetConVarNumber( "sbep_lift_designer_activepart" ) , 90 )
											end
	
	SBEPLiftMenuDeletePartButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuDeletePartButton:SetPos( 125 , 228 )   
		SBEPLiftMenuDeletePartButton:SetSize( 35 , 35 )
		SBEPLiftMenuDeletePartButton:SetImage( "sbep_icons/Delete.vmt" )
		SBEPLiftMenuDeletePartButton.DoClick = function()
												RunConsoleCommand( "SBEP_LiftDeletePart_ser" )	
											end
	
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//					CAMERA CONTROLS
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	SBEPLiftMenuCamUpButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuCamUpButton:SetPos( 205 , 348 )   
		SBEPLiftMenuCamUpButton:SetSize( 75 , 35 )   
		SBEPLiftMenuCamUpButton:SetImage( "sbep_icons/ArrowUp.vmt" )
		SBEPLiftMenuCamUpButton.DoClick = function()
											CL.MVPitch = CL.MVPitch + 2
											ReCalcViewAngles()
										end
	
	SBEPLiftMenuCamDownButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuCamDownButton:SetPos( 205 , 468 )   
		SBEPLiftMenuCamDownButton:SetSize( 75 , 35 )   
		SBEPLiftMenuCamDownButton:SetImage( "sbep_icons/ArrowDown.vmt" )
		SBEPLiftMenuCamDownButton.DoClick = function()
												CL.MVPitch = CL.MVPitch - 2
												ReCalcViewAngles()
										end
	
	SBEPLiftMenuCamLeftButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuCamLeftButton:SetPos( 165 , 388 )   
		SBEPLiftMenuCamLeftButton:SetSize( 35 , 75 )
		SBEPLiftMenuCamLeftButton:SetImage( "sbep_icons/ArrowLeft.vmt" )
		SBEPLiftMenuCamLeftButton.DoClick = function()
												CL.MVYaw = CL.MVYaw - 2
												ReCalcViewAngles()
										end
	
	SBEPLiftMenuCamRightButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuCamRightButton:SetPos( 285 , 388 )   
		SBEPLiftMenuCamRightButton:SetSize( 35 , 75 )
		SBEPLiftMenuCamRightButton:SetImage( "sbep_icons/ArrowRight.vmt" )
		SBEPLiftMenuCamRightButton.DoClick = function()
												CL.MVYaw = CL.MVYaw + 2
												ReCalcViewAngles()
										end

	SBEPLiftMenuCamIcon = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuCamIcon:SetPos( 205 , 388 )   
		SBEPLiftMenuCamIcon:SetSize( 75 , 75 ) 
		SBEPLiftMenuCamIcon:SetImage( "sbep_icons/Camera.vmt" )		
		SBEPLiftMenuCamIcon.DoClick = function()
											DefaultViewAngles()
										end
	
	SBEPLiftMenuCamZoomInButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuCamZoomInButton:SetPos( 285 , 348 )   
		SBEPLiftMenuCamZoomInButton:SetSize( 35 , 35 )
		SBEPLiftMenuCamZoomInButton:SetImage( "sbep_icons/ZoomIn.vmt" )
		SBEPLiftMenuCamZoomInButton.DoClick = function()
												CL.MVRange = CL.MVRange - 10
												ReCalcViewAngles()
										end
	
	SBEPLiftMenuCamZoomOutButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuCamZoomOutButton:SetPos( 165 , 348 )   
		SBEPLiftMenuCamZoomOutButton:SetSize( 35 , 35 )
		SBEPLiftMenuCamZoomOutButton:SetImage( "sbep_icons/ZoomOut.vmt" )
		SBEPLiftMenuCamZoomOutButton.DoClick = function()
												CL.MVRange = CL.MVRange + 10
												ReCalcViewAngles()
										end
	
	SBEPLiftMenuRotCamCButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuRotCamCButton:SetPos( 165 , 468 )   
		SBEPLiftMenuRotCamCButton:SetSize( 35 , 35 )
		SBEPLiftMenuRotCamCButton:SetImage( "sbep_icons/RotC.vmt" )
		SBEPLiftMenuRotCamCButton.DoClick = function()
												CL.MVYaw = CL.MVYaw - 90
												ReCalcViewAngles()
											end
	
	SBEPLiftMenuRotCamACButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuRotCamACButton:SetPos( 285 , 468 )   
		SBEPLiftMenuRotCamACButton:SetSize( 35 , 35 )
		SBEPLiftMenuRotCamACButton:SetImage( "sbep_icons/RotAC.vmt" )
		SBEPLiftMenuRotCamACButton.DoClick = function()
												CL.MVYaw = CL.MVYaw + 90
												ReCalcViewAngles()
											end
	
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//					CLIENT FUNCTIONS
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	function SBEP_OpenLiftDesignMenu()

		CL.StartPos = CL:GetNetworkedVector( "SBEP_LiftStartPos" )
		CL.LiftSystem = CL:GetNetworkedEntity( "SBEP_LiftSystem" )
	
		DefaultViewAngles()
		ReCalcViewAngles()
		
		SBEPLiftMenuPanelVisible = true
		SBEPLiftMenuPanel:SetVisible( SBEPLiftMenuPanelVisible )

	end
	
	concommand.Add("SBEP_OpenLiftDesignMenu_cl",SBEP_OpenLiftDesignMenu)
	
	function SBEP_CloseLiftDesignMenu()

		SBEPLiftMenuPanelVisible = false
		SBEPLiftMenuPanel:SetVisible( SBEPLiftMenuPanelVisible )

	end
	
	concommand.Add("SBEP_CloseLiftDesignMenu_cl",SBEP_CloseLiftDesignMenu)
	
	function DefaultViewAngles()
			CL.MBVec = Vector(-1,0,0)
			CL.MVYaw = -135
			CL.MVPitch = 30
			CL.MVRange = 500

			ReCalcViewAngles()
	end

	function ReCalcViewAngles()
		CL.MBVec = Vector(-1,0,0)
		CL.MRAng = Angle( CL.MVPitch , CL.MVYaw , 0 )
		CL.MBVec:Rotate( CL.MRAng )
		CL.MVOffset = CL.MVRange * CL.MBVec
	end
	
	hook.Add("InitPostEntity", "GetSBEPLocalPlayer", function()
		CL = LocalPlayer()
	end)

	function SBEP_LiftCalcView( ply, origin, angles, fov )
 
		if SBEPLiftMenuPanelVisible then
			local view = {}
				CL.StartPos = CL:GetNetworkedVector( "SBEP_LiftStartPos" )
				CL.PHOffset = CL.LiftSystem:GetNetworkedFloat( "SBEP_LiftCamHeight" )
				if CL.PHOffset then
					view.origin = CL.StartPos + CL.MVOffset + Vector( 0 , 0 , CL.PHOffset )
				else
					view.origin = CL.StartPos + CL.MVOffset
				end
				view.angles = CL.MRAng

			return view
		else
			return GAMEMODE:CalcView(ply,origin,angles,fov)
		end
 
	end
 
	hook.Add("CalcView", "SBEP_LiftCalcView", SBEP_LiftCalcView)

end

	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//					SERVER FUNCTIONS
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

if SERVER then

	function SBEP_SetLiftPartModel( ply , cmd , args )
		n = tonumber( args[1] )
		if n == 1 and ( args[2] == "models/SmallBridge/Elevators,Small/sbselevs.mdl" or 
						args[2] == "models/SmallBridge/Station Parts/sbhuble.mdl" )	 then return end
		if !LiftSystem_SER.PT[n] then return end
		
		LiftSystem_SER.PT[n].model = args[2]
		RunConsoleCommand( "sbep_lift_designer_model" , LiftSystem_SER.PT[n].model )
		LiftSystem_SER:RefreshPart( n )
		RunConsoleCommand( "SBEP_LiftGetCamHeight_ser" )
	end
	concommand.Add( "SBEP_LiftSys_SetLiftPartModel_ser" , SBEP_SetLiftPartModel )
	
	function SBEP_SetLiftPartRoll( ply , cmd , args )
		n = tonumber( args[1] )
		if !LiftSystem_SER.PT[n] then return end
		
		LiftSystem_SER.PT[n].Roll   = ( LiftSystem_SER.PT[n].Roll + tonumber(args[2]) ) % 360
		RunConsoleCommand( "sbep_lift_designer_roll" , LiftSystem_SER.PT[n].Roll )
		LiftSystem_SER:RefreshPart( n )
	end
	concommand.Add( "SBEP_LiftSys_SetLiftPartRoll_ser" , SBEP_SetLiftPartRoll )	

	function SBEP_SetLiftPartYaw( ply , cmd , args )
		n = tonumber( args[1] )
		if !LiftSystem_SER.PT[n] then return end
		
		LiftSystem_SER.PT[n].Yaw   = ( LiftSystem_SER.PT[n].Yaw + tonumber(args[2]) ) % 360
		RunConsoleCommand( "sbep_lift_designer_yaw" , LiftSystem_SER.PT[n].Yaw )
		LiftSystem_SER:RefreshPart( n )
	end
	concommand.Add( "SBEP_LiftSys_SetLiftPartYaw_ser" , SBEP_SetLiftPartYaw )	
	
	function SBEP_LiftCancelMenu( ply , cmd , args )
		LiftSystem_SER:Remove()
		RunConsoleCommand( "sbep_lift_designer_editing" , 0 )
	end
	concommand.Add( "SBEP_LiftCancelMenu_ser" , SBEP_LiftCancelMenu )	
	
	function SBEP_LiftGetCamHeight( ply , cmd , args )
		local n = tonumber(GetConVarNumber( "sbep_lift_designer_activepart" ))
	
		LiftSystem_SER:SetNetworkedFloat( "SBEP_LiftCamHeight" , LiftSystem_SER.PT[ n ].HO )
		for k,v in ipairs( LiftSystem_SER.PT ) do
			v:SetColor( 255 , 255 , 255 , 255 )
		end
		if n == LiftSystem_SER.PC then
			LiftSystem_SER.PT[ n ]:SetColor( 255 , 255 , 255 , 180 )
		else
			LiftSystem_SER.PT[ n ]:SetColor( 64 , 128 , 255 , 180 )
			LiftSystem_SER.PT[ LiftSystem_SER.PC ]:SetColor( 255 , 255 , 255 , 100 )
		end
	end
	concommand.Add( "SBEP_LiftGetCamHeight_ser" , SBEP_LiftGetCamHeight )	
	
	function SBEP_LiftConstructPart( ply , cmd , args )
		if tonumber(GetConVarNumber( "sbep_lift_designer_activepart" )) != LiftSystem_SER.PC then return false end
		
		n = tonumber( args[1] )
		if n == 1 then return end
		
		RunConsoleCommand( "sbep_lift_designer_activepart" , n )

		LiftSystem_SER:CreatePart( n )
		local NP = LiftSystem_SER.PT[ n ]

		NP.Yaw = GetConVarNumber( "sbep_lift_designer_yaw" )
		NP.Roll = GetConVarNumber( "sbep_lift_designer_roll" )
		NP.model = GetConVarString( "sbep_lift_designer_model" )
		LiftSystem_SER:RefreshPart( n )
		
		RunConsoleCommand( "SBEP_LiftGetCamHeight_ser" )
	end
	concommand.Add( "SBEP_LiftConstructPart_ser" , SBEP_LiftConstructPart )
	
	function SBEP_LiftFinishSystem( ply , cmd , args )
		if LiftSystem_SER.PC == 1 then return end
		if LiftSystem_SER.PT[ LiftSystem_SER.PC - 1 ].IsShaft or LiftSystem_SER.PT[ LiftSystem_SER.PC - 1 ].IsHub then return end
		RunConsoleCommand( "SBEP_CloseLiftDesignMenu_cl" )
		LiftSystem_SER:FinishSystem()
		RunConsoleCommand( "sbep_lift_designer_editing" , 0 )
	end
	concommand.Add( "SBEP_LiftFinishSystem_ser" , SBEP_LiftFinishSystem )
	
	function SBEP_LiftDeletePart( ply , cmd , args )
		local n = tonumber(GetConVarNumber( "sbep_lift_designer_activepart" ))
		if n == 1 then return end
		
		LiftSystem_SER.PT[ n ]:Remove()
		table.remove( LiftSystem_SER.PT , n )
		
		for k,v in ipairs( LiftSystem_SER.PT ) do
			LiftSystem_SER:RefreshPart( k )
		end
		
		if n > LiftSystem_SER.PC then
			RunConsoleCommand( "sbep_lift_designer_activepart" , LiftSystem_SER.PC )
		end
		RunConsoleCommand( "SBEP_LiftGetCamHeight_ser" )
	end
	concommand.Add( "SBEP_LiftDeletePart_ser" , SBEP_LiftDeletePart )
	
	for k,v in ipairs( ConVars ) do
	RunConsoleCommand( "sbep_lift_designer_"..v[1] , v[2] )
	end
end

function TOOL:LeftClick( trace )

	local Editing = self:GetClientNumber( "editing" )
	
	if Editing == 0 then
	
		local startpos = trace.HitPos
		local spawnoffset = Vector(0,0,4.65)
		
		local skin = self:GetClientNumber( "skin" )
	
		LiftSystem_SER = ents.Create( "sbep_elev_system" )
			LiftSystem_SER:SetPos( startpos + spawnoffset)
			LiftSystem_SER:SetAngles( Angle(0,-90,0) )
			LiftSystem_SER:SetModel( "models/SmallBridge/Elevators,Small/sbselevp3.mdl" )
			LiftSystem_SER.Skin = tonumber( skin )
			
		if tonumber(self:GetClientNumber( "enableuse" )) == 1 then
			LiftSystem_SER.Usable = true
		else
			LiftSystem_SER.Usable = false
		end
		
		if tonumber(self:GetClientNumber( "size" )) == 2 then
			LiftSystem_SER.Large = true
		else
			LiftSystem_SER.Large = false
		end
		
		LiftSystem_SER:Spawn()
		LiftSystem_SER.StartPos = startpos + Vector(0,0,65.1)

		self:GetOwner():SetNetworkedEntity( "SBEP_LiftSystem" , LiftSystem_SER )
		self:GetOwner():SetNetworkedVector( "SBEP_LiftStartPos" , startpos + Vector(0,0,65.1) )
		
		local hatchconvar = tonumber(self:GetClientNumber( "doors" ))
		if hatchconvar == 2 then
			LiftSystem_SER.UseHatches = true
		elseif hatchconvar == 3 then
			LiftSystem_SER.UseDoors = true
		end		
		
		undo.Create( "SBEP Lift System" )
			undo.AddEntity( LiftSystem_SER )
			undo.SetPlayer( self:GetOwner() )
		undo.Finish()
		
		LiftSystem_SER:CreatePart( 1 )
			LiftSystem_SER.PT[1].Yaw   = 0
			LiftSystem_SER.PT[1].Roll  = 0		
			LiftSystem_SER.PT[1].model = "models/SmallBridge/Elevators,Small/sbselevm.mdl"		
		LiftSystem_SER:RefreshPart( 1 )
		
		RunConsoleCommand( "SBEPDisableButtons_cl" )
		
		RunConsoleCommand( "sbep_lift_designer_model" , "models/SmallBridge/Elevators,Small/sbselevm.mdl" )
	
		RunConsoleCommand( "sbep_lift_designer_activepart" , 1 )
	
		RunConsoleCommand( "SBEP_LiftGetCamHeight_ser" )
	
		RunConsoleCommand( "SBEP_OpenLiftDesignMenu_cl" )
	
		RunConsoleCommand( "sbep_lift_designer_editing" , 1 )
	
		return true
	end
	
end

function TOOL:RightClick( trace )

	return true
end

function TOOL:Reload( trace )
	
	return true
end

function TOOL.BuildCPanel(panel)
	
	panel:SetSpacing( 10 )
	panel:SetName( "SBEP Lift System Designer" )
	
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	local SkinMenu = vgui.Create("DButton")
	SkinMenu:SetText( "Skin" )
	SkinMenu:SetSize( 100, 20 )

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
				SkinMenuOptions:AddOption( SkinTable[i] , function() RunConsoleCommand( "sbep_lift_designer_skin", (i - 1) ) end )
			end
			SkinMenuOptions:Open()
						end
	panel:AddItem( SkinMenu )
	
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	local DoorMenu = vgui.Create("DButton")
	DoorMenu:SetText( "Doors" )
	DoorMenu:SetSize( 100, 20 )

	local DoorTable = {
			"None"  			,
			"Shaft Hatches"   	,
			"Floor Doors"  		
				}

	DoorMenu.DoClick = function ( btn )
			local DoorMenuOptions = DermaMenu()
			for i = 1, #DoorTable do
				DoorMenuOptions:AddOption( DoorTable[i] , function() RunConsoleCommand( "sbep_lift_designer_doors", i ) end )
			end
			DoorMenuOptions:Open()
						end
	panel:AddItem( DoorMenu )
	
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	local SizeMenu = vgui.Create("DButton")
	SizeMenu:SetText( "Size" )
	SizeMenu:SetSize( 100, 20 )

	local SizeTable = {
				"Small"  	,
				"Large"   		
				}

	SizeMenu.DoClick = function ( btn )
			local SizeMenuOptions = DermaMenu()
			for i = 1, #SizeTable do
				SizeMenuOptions:AddOption( SizeTable[i] , function() RunConsoleCommand( "sbep_lift_designer_size", i ) end )
			end
			SizeMenuOptions:Open()
						end
	panel:AddItem( SizeMenu )
	
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	local UseCheckBox = vgui.Create( "DCheckBoxLabel" )
		UseCheckBox:SetText( "Enable Use Key on Housings" )
		UseCheckBox:SetConVar( "sbep_lift_designer_enableuse" )
		UseCheckBox:SetValue( 0 )
		UseCheckBox:SizeToContents()
	panel:AddItem( UseCheckBox )
	
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	local ResetLabel= vgui.Create("DLabel")
		ResetLabel:SetText("This tool is still a prototype. If the tool bugs,\nyou may need to reset it with this button.")
		ResetLabel:SizeToContents()
	panel:AddItem( ResetLabel )
		
	local ResetButton = vgui.Create( "DButton")
		ResetButton:SetSize( 100, 20 )
		ResetButton:SetText( "Reset" )
		ResetButton.DoClick = function()
							RunConsoleCommand( "sbep_lift_designer_editing" , 0 )
						end
	panel:AddItem( ResetButton )
	
	
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
end