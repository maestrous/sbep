TOOL.Category		= "SBEP"
TOOL.Name			= "#Lift System Designer"
TOOL.Command		= nil
TOOL.ConfigName 	= ""

local BMT = {
	{ "models/SmallBridge/Elevators,Small/sbselevm.mdl" 	, "M"		 } ,
	{ "models/SmallBridge/Elevators,Small/sbselevme.mdl" 	, "ME"		 } ,
	{ "models/SmallBridge/Elevators,Small/sbselevmedh.mdl" 	, "MEdh"	 } ,
	{ "models/SmallBridge/Elevators,Small/sbselevmedw.mdl" 	, "MEdw"	 } ,
	{ "models/SmallBridge/Elevators,Small/sbselevmr.mdl" 	, "MR"		 } ,
	{ "models/SmallBridge/Elevators,Small/sbselevmt.mdl" 	, "MT"		 } ,
	{ "models/SmallBridge/Elevators,Small/sbselevmx.mdl" 	, "MX"		 } ,
	{ "models/SmallBridge/Elevators,Small/sbselevs.mdl" 	, "S"		 }
			}

local SMT = {
	{ "models/SmallBridge/Station Parts/sbbridgevisorm.mdl" , "VM"		 } ,
	{ "models/SmallBridge/Station Parts/sbhuble.mdl" 		, "H"		 }
			}

if CLIENT then
	language.Add( "Tool_sbep_lift_designer_name", "SBEP Lift System Designer" 		)
	language.Add( "Tool_sbep_lift_designer_desc", "Create a lift system." 			)
	language.Add( "Tool_sbep_lift_designer_0"	, "Left click somewhere to begin." 	)
	language.Add( "undone_SBEP Lift System"		, "Undone SBEP Lift System"			)
end

local ConVars = {
		editing 		= 0,
		model			= "models/SmallBridge/Elevators,Small/sbselevm.mdl",
		yaw				= 0,
		roll			= 0,
		activepart		= 1,
		skin			= 0,
		enableuse		= 0,
		doors			= 0,
		size			= 1
				}
for k,v in pairs(ConVars) do
	TOOL.ClientConVar[k] = v
end

local function RCC( com , args)
	
	RunConsoleCommand( com , unpack( args ) )
	
end

if CLIENT then

	SBEPLiftDesignerMenuTable = {}

	function CreateSBEPLiftDesignerMenu()
	
		local LDT = SBEPLiftDesignerMenuTable
	
		LDT.Frame = vgui.Create( "DFrame" )
			LDT.Frame:SetPos( 30,30 )
			LDT.Frame:SetSize( 325, 548 )
			LDT.Frame:SetTitle( "SBEP Lift System Designer" )
			LDT.Frame:SetVisible( false )
			LDT.Frame:SetDraggable( false )
			LDT.Frame:ShowCloseButton( false )
			LDT.Frame:MakePopup()
		
		LDT.SFrame = vgui.Create( "DFrame" )
			LDT.SFrame:SetPos( 360,193 )
			LDT.SFrame:SetSize( 165,85 )
			LDT.SFrame:SetTitle( " " )
			LDT.SFrame:SetBackgroundBlur( true )
			LDT.SFrame:SetVisible( false )
			LDT.SFrame:SetDraggable( false )
			LDT.SFrame:ShowCloseButton( false )
			LDT.SFrame:MakePopup()
		
		---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		//					MENU CONTROLS
		---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		
		LDT.SButtons = {}
		
		LDT.SButtons.Close = vgui.Create("DSysButton", LDT.Frame )
			LDT.SButtons.Close:SetPos( 285 , 4 )   
			LDT.SButtons.Close:SetSize( 35 , 13 )   
			LDT.SButtons.Close:SetType( "close" )
			LDT.SButtons.Close.DoClick = function()
												RunConsoleCommand( "SBEP_LiftCancelMenu_ser" )
												LDT.Frame:Remove()
											end
		
		LDT.SButtons.finish = vgui.Create("DImageButton", LDT.Frame )
			LDT.SButtons.finish:SetPos( 5 , 508 )
			LDT.SButtons.finish:SetSize( 315 , 35 )
			LDT.SButtons.finish:SetImage( "sbep_icons/Finish.vmt" )
			LDT.SButtons.finish.DoClick = function()
												RunConsoleCommand( "SBEP_LiftFinishSystem_ser" )
												LDT.Frame:Remove()
											end
		
		---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		//					MODEL CONTROLS
		---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

		LDT.PButtons = {}
		
		for k,v in ipairs(BMT) do
			LDT.PButtons[k] = vgui.Create("DImageButton", LDT.Frame )
				LDT.PButtons[k]:SetImage( "sbep_icons/SBSelev"..v[2]..".vmt" )
				LDT.PButtons[k]:SetPos( 5 + 80 * ((k - 1)%4) , 28 + 80 * math.floor((k - 1)/ 4))
				LDT.PButtons[k]:SetSize( 75 , 75 )
				LDT.PButtons[k].DoClick = function()
														RunConsoleCommand( "SBEP_LiftSys_SetLiftPartModel_ser" , GetConVarNumber( "sbep_lift_designer_activepart" ) , v[1] )
													end
		end
		
		LDT.PButtons.Special = {}
		
		LDT.PButtons.Special.B = vgui.Create("DImageButton", LDT.Frame )
			LDT.PButtons.Special.B:SetPos( 165 , 188 )   
			LDT.PButtons.Special.B:SetSize( 155 , 35 )
			LDT.PButtons.Special.B:SetImage( "sbep_icons/Special.vmt" )
			LDT.PButtons.Special.B.DoClick = function()
													LDT.SFrame.visible = !LDT.SFrame.visible
													LDT.SFrame:SetVisible( LDT.SFrame.visible )
												end
		
		LDT.PButtons.Special[1] = vgui.Create("DImageButton", LDT.SFrame )
			LDT.PButtons.Special[1]:SetImage( "sbep_icons/SBSelevVM.vmt" )
			LDT.PButtons.Special[1]:SetPos( 5 , 5 )
			LDT.PButtons.Special[1]:SetSize( 75 , 75 )
			LDT.PButtons.Special[1].DoClick = function()
													LDT.SFrame.visible = false
													LDT.SFrame:SetVisible( LDT.SFrame.visible )
													RunConsoleCommand( "SBEP_LiftSys_SetLiftPartModel_ser" , GetConVarNumber( "sbep_lift_designer_activepart" ) , SMT[1][1] )
												end

		LDT.PButtons.Special[2] = vgui.Create("DImageButton", LDT.SFrame )
			LDT.PButtons.Special[2]:SetImage( "sbep_icons/SBSelevH.vmt" )
			LDT.PButtons.Special[2]:SetPos( 85 , 5 )
			LDT.PButtons.Special[2]:SetSize( 75 , 75 )
			LDT.PButtons.Special[2].DoClick = function()
													LDT.SFrame.visible = false
													LDT.SFrame:SetVisible( LDT.SFrame.visible )
													RunConsoleCommand( "SBEP_LiftSys_SetLiftPartModel_ser" , GetConVarNumber( "sbep_lift_designer_activepart" ) , SMT[2][1] )
												end
		
		function SBEPDisableButtons( ply , cmd , args )
			local size = tonumber( GetConVarNumber( "sbep_lift_designer_size" ) )
			if size == 2 then
				LDT.PButtons[4]:SetDisabled( true )
				LDT.PButtons.Special.B:SetDisabled( true )
			else
				LDT.PButtons[4]:SetDisabled( false )
				LDT.PButtons.Special.B:SetDisabled( false )
			end
		end
		concommand.Add( "SBEPDisableButtons_cl" , SBEPDisableButtons )

		
		---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		//					CONSTRUCTION CONTROLS
		---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		
		LDT.BButtons = {}
		
		LDT.BButtons.Construct = vgui.Create("DImageButton", LDT.Frame )
			LDT.BButtons.Construct:SetPos( 5 , 268 )
			LDT.BButtons.Construct:SetSize( 155 , 195 )
			LDT.BButtons.Construct:SetImage( "sbep_icons/Construct.vmt" )
			LDT.BButtons.Construct.DoClick = function()
													local pos = tonumber( GetConVarNumber( "sbep_lift_designer_activepart" ) )
													pos = pos + 1
													RunConsoleCommand( "SBEP_LiftConstructPart_ser" , pos )
											end
		
		LDT.BButtons.up = vgui.Create("DImageButton", LDT.Frame )
			LDT.BButtons.up:SetPos( 45 , 228 )   
			LDT.BButtons.up:SetSize( 75 , 35 )   
			LDT.BButtons.up:SetImage( "sbep_icons/ArrowUp.vmt" )
			LDT.BButtons.up.DoClick = function()
													local pos = tonumber( GetConVarNumber( "sbep_lift_designer_activepart" ) )
													pos = math.Clamp( pos + 1 , 1 , CL.LiftSystem:GetNetworkedInt( "SBEP_LiftPartCount" ) )
													RunConsoleCommand( "sbep_lift_designer_activepart" , pos )
													RunConsoleCommand( "SBEP_LiftGetCamHeight_ser" )
											end
		
		LDT.BButtons.down = vgui.Create("DImageButton", LDT.Frame )
			LDT.BButtons.down:SetPos( 45 , 468 )   
			LDT.BButtons.down:SetSize( 75 , 35 )   
			LDT.BButtons.down:SetImage( "sbep_icons/ArrowDown.vmt" )
			LDT.BButtons.down.DoClick = function()
													local pos = tonumber( GetConVarNumber( "sbep_lift_designer_activepart" ) )
													pos = math.Clamp( pos - 1 , 1 , CL.LiftSystem:GetNetworkedInt( "SBEP_LiftPartCount" ) )
													RunConsoleCommand( "sbep_lift_designer_activepart" , pos )
													RunConsoleCommand( "SBEP_LiftGetCamHeight_ser" )
											end
		
		LDT.BButtons.inv = vgui.Create("DImageButton", LDT.Frame )
			LDT.BButtons.inv:SetPos( 45 , 188 )   
			LDT.BButtons.inv:SetSize( 75 , 35 )   
			LDT.BButtons.inv:SetImage( "sbep_icons/Invert.vmt" )
			LDT.BButtons.inv.DoClick = function()
														RunConsoleCommand( "SBEP_LiftSys_SetLiftPartRoll_ser" , GetConVarNumber( "sbep_lift_designer_activepart" ) , 180 )
														RunConsoleCommand( "SBEP_LiftGetCamHeight_ser" )
													end

		LDT.BButtons.RotC = vgui.Create("DImageButton", LDT.Frame )
			LDT.BButtons.RotC:SetPos( 5 , 188 )   
			LDT.BButtons.RotC:SetSize( 35 , 35 )
			LDT.BButtons.RotC:SetImage( "sbep_icons/RotC.vmt" )
			LDT.BButtons.RotC.DoClick = function()
													RunConsoleCommand( "SBEP_LiftSys_SetLiftPartYaw_ser" , GetConVarNumber( "sbep_lift_designer_activepart" ) , 270 )
												end
		
		LDT.BButtons.RotAC = vgui.Create("DImageButton", LDT.Frame )
			LDT.BButtons.RotAC:SetPos( 125 , 188 )   
			LDT.BButtons.RotAC:SetSize( 35 , 35 )
			LDT.BButtons.RotAC:SetImage( "sbep_icons/RotAC.vmt" )
			LDT.BButtons.RotAC.DoClick = function()
													RunConsoleCommand( "SBEP_LiftSys_SetLiftPartYaw_ser" , GetConVarNumber( "sbep_lift_designer_activepart" ) , 90 )
												end
		
		LDT.BButtons.Delete = vgui.Create("DImageButton", LDT.Frame )
			LDT.BButtons.Delete:SetPos( 125 , 228 )   
			LDT.BButtons.Delete:SetSize( 35 , 35 )
			LDT.BButtons.Delete:SetImage( "sbep_icons/Delete.vmt" )
			LDT.BButtons.Delete.DoClick = function()
													RunConsoleCommand( "SBEP_LiftDeletePart_ser" )	
												end
		
		---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		//					CAMERA CONTROLS
		---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		
		LDT.CButtons = {}
		
		LDT.CButtons.up = vgui.Create("DImageButton", LDT.Frame )
			LDT.CButtons.up:SetPos( 205 , 348 )   
			LDT.CButtons.up:SetSize( 75 , 35 )   
			LDT.CButtons.up:SetImage( "sbep_icons/ArrowUp.vmt" )
			LDT.CButtons.up.DoClick = function()
												CL.MVPitch = CL.MVPitch + 2
												ReCalcViewAngles()
											end
		
		LDT.CButtons.down = vgui.Create("DImageButton", LDT.Frame )
			LDT.CButtons.down:SetPos( 205 , 468 )   
			LDT.CButtons.down:SetSize( 75 , 35 )   
			LDT.CButtons.down:SetImage( "sbep_icons/ArrowDown.vmt" )
			LDT.CButtons.down.DoClick = function()
													CL.MVPitch = CL.MVPitch - 2
													ReCalcViewAngles()
											end
		
		LDT.CButtons.left = vgui.Create("DImageButton", LDT.Frame )
			LDT.CButtons.left:SetPos( 165 , 388 )   
			LDT.CButtons.left:SetSize( 35 , 75 )
			LDT.CButtons.left:SetImage( "sbep_icons/ArrowLeft.vmt" )
			LDT.CButtons.left.DoClick = function()
													CL.MVYaw = CL.MVYaw - 2
													ReCalcViewAngles()
											end
		
		LDT.CButtons.right = vgui.Create("DImageButton", LDT.Frame )
			LDT.CButtons.right:SetPos( 285 , 388 )   
			LDT.CButtons.right:SetSize( 35 , 75 )
			LDT.CButtons.right:SetImage( "sbep_icons/ArrowRight.vmt" )
			LDT.CButtons.right.DoClick = function()
													CL.MVYaw = CL.MVYaw + 2
													ReCalcViewAngles()
											end

		LDT.CButtons.default = vgui.Create("DImageButton", LDT.Frame )
			LDT.CButtons.default:SetPos( 205 , 388 )   
			LDT.CButtons.default:SetSize( 75 , 75 ) 
			LDT.CButtons.default:SetImage( "sbep_icons/Camera.vmt" )		
			LDT.CButtons.default.DoClick = function()
												SetBaseViewAngles()
											end
		
		LDT.CButtons.Zplus = vgui.Create("DImageButton", LDT.Frame )
			LDT.CButtons.Zplus:SetPos( 285 , 348 )   
			LDT.CButtons.Zplus:SetSize( 35 , 35 )
			LDT.CButtons.Zplus:SetImage( "sbep_icons/ZoomIn.vmt" )
			LDT.CButtons.Zplus.DoClick = function()
													CL.MVRange = CL.MVRange - 0.1
													ReCalcViewAngles()
											end
		
		LDT.CButtons.Zminus = vgui.Create("DImageButton", LDT.Frame )
			LDT.CButtons.Zminus:SetPos( 165 , 348 )   
			LDT.CButtons.Zminus:SetSize( 35 , 35 )
			LDT.CButtons.Zminus:SetImage( "sbep_icons/ZoomOut.vmt" )
			LDT.CButtons.Zminus.DoClick = function()
													CL.MVRange = CL.MVRange + 0.1
													ReCalcViewAngles()
											end
		
		LDT.CButtons.RotC = vgui.Create("DImageButton", LDT.Frame )
			LDT.CButtons.RotC:SetPos( 165 , 468 )   
			LDT.CButtons.RotC:SetSize( 35 , 35 )
			LDT.CButtons.RotC:SetImage( "sbep_icons/RotC.vmt" )
			LDT.CButtons.RotC.DoClick = function()
													CL.MVYaw = CL.MVYaw - 90
													ReCalcViewAngles()
												end
		
		LDT.CButtons.RotAC = vgui.Create("DImageButton", LDT.Frame )
			LDT.CButtons.RotAC:SetPos( 285 , 468 )   
			LDT.CButtons.RotAC:SetSize( 35 , 35 )
			LDT.CButtons.RotAC:SetImage( "sbep_icons/RotAC.vmt" )
			LDT.CButtons.RotAC.DoClick = function()
													CL.MVYaw = CL.MVYaw + 90
													ReCalcViewAngles()
												end
	
	end
		
		---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		//					CLIENT FUNCTIONS
		---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		
		function SBEP_OpenLiftDesignMenu( um )
			CreateSBEPLiftDesignerMenu()
			
			SBEPLiftDesignerMenuTable.Frame.visible = true
			SBEPLiftDesignerMenuTable.Frame:SetVisible( true )

			CL.StartPos 	= um:ReadVector() 
			CL.LiftSystem 	= um:ReadEntity()
			CL.CVOffset 	= Vector(  246 ,  235 ,  143 )
			CL.CHOffset		= 0
		
			SetBaseViewAngles()
		end
		usermessage.Hook("SBEP_OpenLiftDesignMenu_cl", SBEP_OpenLiftDesignMenu)
		
		function SBEP_CloseLiftDesignMenu( um )
			SBEPLiftDesignerMenuTable.Frame:Remove()
		end
		usermessage.Hook("SBEP_CloseLiftDesignMenu_cl", SBEP_CloseLiftDesignMenu)
		
		function SetBaseViewAngles()
				CL.MVYaw = 0
				CL.MVPitch = 0
				CL.MVRange = 2.2

				ReCalcViewAngles()
		end

		function ReCalcViewAngles( um )
			if um then
				CL.MBVec = um:ReadVector()
			else
				CL.MBVec = CL.MBVec or Vector(  246 ,  235 ,  143 )
			end
			CL.MRVec = Vector( CL.MBVec.x , CL.MBVec.y , CL.MBVec.z )
			CL.MRAng = Angle( -1 * CL.MVPitch , CL.MVYaw , CL.MVPitch )
			CL.MRVec:Rotate( CL.MRAng )
			CL.MVOffset = CL.MVRange * CL.MRVec
		end
		usermessage.Hook("SBEP_ReCalcViewAngles_LiftDesignMenu_cl", ReCalcViewAngles)
		
		hook.Add("InitPostEntity", "GetSBEPLocalPlayer", function()
			CL = LocalPlayer()
		end)

		function SBEPSetStartPos( um )
			CL.StartPos = um:ReadVector()
		end
		usermessage.Hook("SBEP_SetStartPosLiftDesignMenu_cl", SBEPSetStartPos)

		function SBEPSetPHOffset( um )
			CL.PHOffset = um:ReadFloat()
		end
		usermessage.Hook("SBEP_SetPHOffsetLiftDesignMenu_cl", SBEPSetPHOffset)
		
		function SBEP_LiftCalcView( ply, origin, angles, fov )
	 
			if SBEPLiftDesignerMenuTable.Frame and SBEPLiftDesignerMenuTable.Frame.visible then
				local view = {}
					CL.CVOffset.x = CL.CVOffset.x + math.Clamp( CL.MVOffset.x - CL.CVOffset.x , -0.02 * CL.MVOffset.x , 0.02 * CL.MVOffset.x )
					CL.CVOffset.y = CL.CVOffset.y + math.Clamp( CL.MVOffset.y - CL.CVOffset.y , -0.02 * CL.MVOffset.y , 0.02 * CL.MVOffset.y )
					CL.CVOffset.z = CL.CVOffset.z + math.Clamp( CL.MVOffset.z - CL.CVOffset.z , -0.02 * CL.MVOffset.z , 0.02 * CL.MVOffset.z )
					
					CL.CHOffset = CL.CHOffset + math.Clamp( CL.PHOffset - CL.CHOffset , -2 , 2 )

					view.origin = CL.StartPos + CL.CVOffset + Vector( 0 , 0 , CL.CHOffset )
					view.angles = (-1 * CL.CVOffset):Angle()

				return view
			else
				return GAMEMODE:CalcView(ply,origin,angles,fov)
			end
	 
		end
	 
		hook.Add("CalcView", "SBEP_LiftDesignerCalcView", SBEP_LiftCalcView)

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
		
		LiftSystem_SER.PT[n].PD.model = args[2]
		RunConsoleCommand( "sbep_lift_designer_model" , LiftSystem_SER.PT[n].PD.model )
		LiftSystem_SER:RefreshPart( n )
		RunConsoleCommand( "SBEP_LiftGetCamHeight_ser" )
	end
	concommand.Add( "SBEP_LiftSys_SetLiftPartModel_ser" , SBEP_SetLiftPartModel )
	
	function SBEP_SetLiftPartRoll( ply , cmd , args )
		n = tonumber( args[1] )
		if !LiftSystem_SER.PT[n] then return end
		
		LiftSystem_SER.PT[n].PD.Roll   = ( LiftSystem_SER.PT[n].PD.Roll + tonumber(args[2]) ) % 360
		RunConsoleCommand( "sbep_lift_designer_roll" , LiftSystem_SER.PT[n].PD.Roll )
		LiftSystem_SER:RefreshPart( n )
	end
	concommand.Add( "SBEP_LiftSys_SetLiftPartRoll_ser" , SBEP_SetLiftPartRoll )	

	function SBEP_SetLiftPartYaw( ply , cmd , args )
		n = tonumber( args[1] )
		if !LiftSystem_SER.PT[n] then return end
		
		LiftSystem_SER.PT[n].PD.Yaw   = ( LiftSystem_SER.PT[n].PD.Yaw + tonumber(args[2]) ) % 360
		RunConsoleCommand( "sbep_lift_designer_yaw" , LiftSystem_SER.PT[n].PD.Yaw )
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

		umsg.Start("SBEP_SetPHOffsetLiftDesignMenu_cl", RecipientFilter():AddPlayer( ply ) )
			umsg.Float( LiftSystem_SER.PT[ n ].PD.HO )
		umsg.End()
		for k,v in ipairs( LiftSystem_SER.PT ) do
			v:SetColor( 255 , 255 , 255 , 255 )
		end
		if n == LiftSystem_SER.ST.PC then
			LiftSystem_SER.PT[ n ]:SetColor( 255 , 255 , 255 , 180 )
		else
			LiftSystem_SER.PT[ n ]:SetColor( 64 , 128 , 255 , 180 )
			LiftSystem_SER.PT[ LiftSystem_SER.ST.PC ]:SetColor( 255 , 255 , 255 , 100 )
		end
		umsg.Start("SBEP_ReCalcViewAngles_LiftDesignMenu_cl", RecipientFilter():AddPlayer( ply ) )
			umsg.Vector( LiftSystem_SER.PT[ n ]:OBBMaxs() )
		umsg.End()
	end
	concommand.Add( "SBEP_LiftGetCamHeight_ser" , SBEP_LiftGetCamHeight )	
	
	function SBEP_LiftConstructPart( ply , cmd , args )
		if tonumber(GetConVarNumber( "sbep_lift_designer_activepart" )) != LiftSystem_SER.ST.PC then return false end
		
		n = tonumber( args[1] )
		if n == 1 then return end
		
		RunConsoleCommand( "sbep_lift_designer_activepart" , n )

		LiftSystem_SER:CreatePart( n )
		local NP = LiftSystem_SER.PT[ n ]

		NP.PD.Yaw 	= GetConVarNumber( "sbep_lift_designer_yaw" )
		NP.PD.Roll 	= GetConVarNumber( "sbep_lift_designer_roll" )
		NP.PD.model = GetConVarString( "sbep_lift_designer_model" )
		LiftSystem_SER:RefreshPart( n )
		
		RunConsoleCommand( "SBEP_LiftGetCamHeight_ser" )
	end
	concommand.Add( "SBEP_LiftConstructPart_ser" , SBEP_LiftConstructPart )
	
	function SBEP_LiftFinishSystem( ply , cmd , args )
		if LiftSystem_SER.ST.PC == 1 then return end
		if LiftSystem_SER.PT[ LiftSystem_SER.ST.PC - 1 ].PD.IsShaft or LiftSystem_SER.PT[ LiftSystem_SER.ST.PC - 1 ].PD.IsHub then return end
		
		umsg.Start("SBEP_CloseLiftDesignMenu_cl", RecipientFilter():AddPlayer( ply ) )
		umsg.End()
		
		LiftSystem_SER:FinishSystem()
		RunConsoleCommand( "sbep_lift_designer_editing" , 0 )
	end
	concommand.Add( "SBEP_LiftFinishSystem_ser" , SBEP_LiftFinishSystem )
	
	function SBEP_LiftDeletePart( ply , cmd , args )
		local n = tonumber(GetConVarNumber( "sbep_lift_designer_activepart" ))
		if n == 1 then return end
		
		LiftSystem_SER.PT[n]:Remove()
		table.remove( LiftSystem_SER.PT , n )
		
		for k,v in ipairs( LiftSystem_SER.PT ) do
			LiftSystem_SER:RefreshPart( k )
		end
		
		if n > LiftSystem_SER.ST.PC then
			RunConsoleCommand( "sbep_lift_designer_activepart" , LiftSystem_SER.ST.PC )
		end
		RunConsoleCommand( "SBEP_LiftGetCamHeight_ser" )
	end
	concommand.Add( "SBEP_LiftDeletePart_ser" , SBEP_LiftDeletePart )
	
	for k,v in ipairs( ConVars ) do
	RunConsoleCommand( "sbep_lift_designer_"..k , v )
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
			
		LiftSystem_SER.Usable =  tonumber(self:GetClientNumber( "enableuse" )) == 1
		LiftSystem_SER.Large = tonumber(self:GetClientNumber( "size" )) == 2
		
		LiftSystem_SER:Spawn()
		LiftSystem_SER.StartPos = startpos + Vector(0,0,65.1)

		umsg.Start("SBEP_SetStartPosLiftDesignMenu_cl", RecipientFilter():AddPlayer( self:GetOwner() ) )
			umsg.Vector( LiftSystem_SER.StartPos )
		umsg.End()
		
		local hatchconvar = tonumber(self:GetClientNumber( "doors" ))
		LiftSystem_SER.ST.UseHatches = hatchconvar == 2
		LiftSystem_SER.ST.UseDoors   = hatchconvar == 3	
		
		undo.Create( "SBEP Lift System" )
			undo.AddEntity( LiftSystem_SER )
			undo.SetPlayer( self:GetOwner() )
		undo.Finish()
		
		LiftSystem_SER:CreatePart( 1 )
			LiftSystem_SER.PT[1].PD.Yaw   = 0
			LiftSystem_SER.PT[1].PD.Roll  = 0		
			LiftSystem_SER.PT[1].PD.model = "models/SmallBridge/Elevators,Small/sbselevm.mdl"		
		LiftSystem_SER:RefreshPart( 1 )
		
		RunConsoleCommand( "SBEPDisableButtons_cl" )
		
		RunConsoleCommand( "sbep_lift_designer_model" , "models/SmallBridge/Elevators,Small/sbselevm.mdl" )
		RunConsoleCommand( "sbep_lift_designer_activepart" , 1 )
	
		umsg.Start("SBEP_OpenLiftDesignMenu_cl", RecipientFilter():AddPlayer( self:GetOwner() ) )
			umsg.Vector( LiftSystem_SER.StartPos )
			umsg.Entity( LiftSystem_SER )
		umsg.End()
		
		RunConsoleCommand( "SBEP_LiftGetCamHeight_ser" )
	
		RunConsoleCommand( "sbep_lift_designer_editing" , 1 )
	
		return true
	end
end

function TOOL:RightClick( trace )

end

function TOOL:Reload( trace )

end

function TOOL.BuildCPanel(panel)
	
	panel:SetSpacing( 10 )
	panel:SetName( "SBEP Lift System Designer" )
	
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	local SkinMenu = vgui.Create("DButton")
	SkinMenu:SetText( "Skin" )
	SkinMenu:SetSize( 100, 40 )

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
	DoorMenu:SetSize( 100, 40 )

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
	SizeMenu:SetSize( 100, 40 )

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