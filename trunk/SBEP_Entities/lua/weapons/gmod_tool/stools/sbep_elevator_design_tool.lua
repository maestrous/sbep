TOOL.Category		= "SBEP"
TOOL.Name			= "#SBEP Elevator Designer"
TOOL.Command		= nil
TOOL.ConfigName 	= ""

ElevatorModelTable = {}
	ElevatorModelTable[1] = {}
		ElevatorModelTable[1][1]		= { "B"			, "models/SmallBridge/Elevators,Small/sbselevb.mdl" 		, 65.1 	, {0,1,0,0} 	}
		ElevatorModelTable[1][2]		= { "BE"		, "models/SmallBridge/Elevators,Small/sbselevbe.mdl" 		, 65.1 	, {0,1,0,1} 	}
		ElevatorModelTable[1][3] 		= { "BEdh"		, "models/SmallBridge/Elevators,Small/sbselevbedh.mdl" 		, 195.3 , {0,1,0,1} 	}
		ElevatorModelTable[1][4] 		= { "BEdw"		, "models/SmallBridge/Elevators,Small/sbselevbedw.mdl" 		, 65.1	, {0,1,0,1} 	}
		ElevatorModelTable[1][5]		= { "BR"		, "models/SmallBridge/Elevators,Small/sbselevbr.mdl" 		, 65.1	, {1,1,0,0} 	}
		ElevatorModelTable[1][6]		= { "BT"		, "models/SmallBridge/Elevators,Small/sbselevbt.mdl" 		, 65.1	, {1,1,1,0} 	}
		ElevatorModelTable[1][7]		= { "BX"		, "models/SmallBridge/Elevators,Small/sbselevbx.mdl" 		, 65.1	, {1,1,1,1} 	}
	ElevatorModelTable[2] = {}
		ElevatorModelTable[2][1]		= { "M"			, "models/SmallBridge/Elevators,Small/sbselevm.mdl" 		, 65.1	, {0,1,0,0} 	}
		ElevatorModelTable[2][2]		= { "ME"		, "models/SmallBridge/Elevators,Small/sbselevme.mdl" 		, 65.1	, {0,1,0,1} 	}
		ElevatorModelTable[2][3]	 	= { "MEdh"		, "models/SmallBridge/Elevators,Small/sbselevmedh.mdl" 		, 195.3 , {0,1,0,1} 	}
		ElevatorModelTable[2][4]		= { "MEdw"		, "models/SmallBridge/Elevators,Small/sbselevmedw.mdl" 		, 65.1 	, {0,1,0,1} 	}
		ElevatorModelTable[2][5]		= { "MR"		, "models/SmallBridge/Elevators,Small/sbselevmr.mdl" 		, 65.1 	, {1,1,0,0} 	}
		ElevatorModelTable[2][6]		= { "MT"		, "models/SmallBridge/Elevators,Small/sbselevmt.mdl" 		, 65.1 	, {1,1,1,0} 	}
		ElevatorModelTable[2][7]		= { "MX"		, "models/SmallBridge/Elevators,Small/sbselevmx.mdl" 		, 65.1 	, {1,1,1,1} 	}
	ElevatorModelTable[3] = {}
		ElevatorModelTable[3][1]		= { "T"			, "models/SmallBridge/Elevators,Small/sbselevt.mdl" 		, 65.1 	, {0,1,0,0} 	}
		ElevatorModelTable[3][2]		= { "TE"		, "models/SmallBridge/Elevators,Small/sbselevte.mdl" 		, 65.1	, {0,1,0,1} 	}
		ElevatorModelTable[3][3]		= { "TEdh"		, "models/SmallBridge/Elevators,Small/sbselevtedh.mdl" 		, 195.3 , {0,1,0,1} 	}
		ElevatorModelTable[3][4]	 	= { "TEdw"		, "models/SmallBridge/Elevators,Small/sbselevtedw.mdl" 		, 65.1	, {0,1,0,1} 	}
		ElevatorModelTable[3][5]		= { "TR"		, "models/SmallBridge/Elevators,Small/sbselevtr.mdl" 		, 65.1	, {1,1,0,0} 	}
		ElevatorModelTable[3][6]		= { "TT"		, "models/SmallBridge/Elevators,Small/sbselevtt.mdl" 		, 65.1	, {1,1,1,0} 	}
		ElevatorModelTable[3][7]		= { "TX"		, "models/SmallBridge/Elevators,Small/sbselevtx.mdl" 		, 65.1	, {1,1,1,1} 	}
	ElevatorModelTable[4] = {}
		ElevatorModelTable[4][1]		= { "S"			, "models/SmallBridge/Elevators,Small/sbselevs.mdl" 		, 65.1	, {0,0,0,0} 	}
		ElevatorModelTable[4][2]		= { "S2"		, "models/SmallBridge/Elevators,Small/sbselevs2.mdl" 		, 65.1	, {0,0,0,0} 	}
	ElevatorModelTable[5] = {}
		ElevatorModelTable[5][1] 		= { "P0"		, "models/SmallBridge/Elevators,Small/sbselevp0.mdl"		, 0		, {1,1,1,1} 	}
		ElevatorModelTable[5][2] 		= { "P1"		, "models/SmallBridge/Elevators,Small/sbselevp1.mdl"		, 0		, {1,0,1,1} 	}
		ElevatorModelTable[5][3] 		= { "P2E"		, "models/SmallBridge/Elevators,Small/sbselevp2e.mdl"		, 0		, {1,0,1,0} 	}
		ElevatorModelTable[5][4] 		= { "P2R"		, "models/SmallBridge/Elevators,Small/sbselevp2r.mdl"		, 0		, {1,0,0,1} 	}
		ElevatorModelTable[5][5] 		= { "P3"		, "models/SmallBridge/Elevators,Small/sbselevp3.mdl"		, 0		, {1,0,0,0} 	}

if CLIENT then
	language.Add( "Tool_sbep_elevator_design_tool_name", "SBEP Elevator Design Tool" )
	language.Add( "Tool_sbep_elevator_design_tool_desc", "Create an elevator system." )
	language.Add( "Tool_sbep_elevator_design_tool_0", "Left click somewhere, or on an existing elevator housing, to begin." )
end

CreateClientConVar( "sbep_elevator_design_tool_editing", 0, false, false ) 

if CLIENT then
	
	print( "\nInitialising SBEP Elevator Design Menu.\n" )

	SBEPElevPartCount = 0
	
	SBEPElevMenuPanel = vgui.Create( "DFrame" )
		SBEPElevMenuPanel:SetPos( 30,30 )
		SBEPElevMenuPanel:SetSize( 325, 548 )
		SBEPElevMenuPanel:SetTitle( "SBEP Elevator System Designer" )
		SBEPElevMenuPanel:SetVisible( MenuVisible )
		SBEPElevMenuPanel:SetDraggable( true )
		SBEPElevMenuPanel:ShowCloseButton( false )
		SBEPElevMenuPanel:MakePopup()
		
	SBEPElevMenuCloseButton = vgui.Create("DSysButton", SBEPElevMenuPanel )
		SBEPElevMenuCloseButton:SetPos( 285 , 4 )   
		SBEPElevMenuCloseButton:SetSize( 35 , 13 )   
		SBEPElevMenuCloseButton:SetType( "close" )
		SBEPElevMenuCloseButton.DoClick = function()
												SBEPElevMenuPanelVisible = false
												SBEPElevMenuPanel:SetVisible( SBEPElevMenuPanelVisible )
												if ValidEntity(GhostEnt) then
													GhostEnt:Remove()
												end
												RunConsoleCommand("SBEP_CancelElevDesignMenu_ser")
										end

	SBEPElevMenuPartButton = {}
	for i = 1,8 do
		SBEPElevMenuPartButton[i] = vgui.Create("DImageButton", SBEPElevMenuPanel )
			SBEPElevMenuPartButton[i]:SetImage( "sbep_icons/SBSelev"..ElevatorModelTable[ 2 + 2 * math.floor(i / 8) ][i - 7 * math.floor(i / 8)][1]..".vmt" )
			SBEPElevMenuPartButton[i]:SetPos( 5 + 80 * ((i - 1)%4) , 28 + 80 * math.floor((i - 1)/ 4))
			SBEPElevMenuPartButton[i]:SetSize( 75 , 75 )
			SBEPElevMenuPartButton[i].DoClick = function()
													CL.CurrentModelNumber = i - 7 * math.floor(i / 8)
													CL.CurrentRowBaseNumber = 1 + 3 * math.floor(i / 8) //+ 2 * CL.Inverted * ((math.floor(i / 8) + 1) % 2)
													CL.CurrentRowMidNumber = 2 + 2 * math.floor(i / 8)
													UpdateGhostEntModel()
													if i == 8 then
														CL.ShaftConstant = 1
													else
														CL.ShaftConstant = 0
													end
												end
	end
	
	SBEPElevMenuFinishButton = vgui.Create("DButton", SBEPElevMenuPanel )
		SBEPElevMenuFinishButton:SetPos( 5 , 508 )
		SBEPElevMenuFinishButton:SetSize( 315 , 35 )
		SBEPElevMenuFinishButton:SetText( "Finish" )
		SBEPElevMenuFinishButton.DoClick = function()
											SBEP_FinishElevDesignMenu()
										end
	
	SBEPElevMenuConstructButton = vgui.Create("DButton", SBEPElevMenuPanel )
		SBEPElevMenuConstructButton:SetPos( 5 , 273 )
		SBEPElevMenuConstructButton:SetSize( 155 , 190 )
		SBEPElevMenuConstructButton:SetText( "Construct" )
		SBEPElevMenuConstructButton.DoClick = function()
												RunConsoleCommand("SBEP_ConstructPart_ser", 
																				GhostEnt:GetModel() , 
																				tostring(CL.GhostPos.x) , 
																				tostring(CL.GhostPos.y) , 
																				tostring(CL.GhostPos.z) , 
																				tostring(CL.CurrentModelRow[3]) ,
																				tostring(CL.StartAngleYaw) ,
																				tostring(CL.StartAngleTwist) ,
																				tostring(CL.Inverted) ,
																				tostring(CL.CurrentModelNumber) ,
																				tostring(CL.CurrentModelRow[4][1]) ,
																				tostring(CL.CurrentModelRow[4][2]) ,
																				tostring(CL.CurrentModelRow[4][3]) ,
																				tostring(CL.CurrentModelRow[4][4]) ,
																				CL.CurrentModelRow[1] ,
																				tostring(CL.ShaftConstant)
																	)
												timer.Simple(0.01, function()
																		UpdateClientPartTable()
																		UpdateGhostEntPos()
																	end)
										end
	
	SBEPElevMenuUpPosButton = vgui.Create("DImageButton", SBEPElevMenuPanel )
		SBEPElevMenuUpPosButton:SetPos( 45 , 233 )   
		SBEPElevMenuUpPosButton:SetSize( 75 , 35 )   
		SBEPElevMenuUpPosButton:SetImage( "sbep_icons/ArrowUp.vmt" )
		SBEPElevMenuUpPosButton.DoClick = function()
										end
	
	SBEPElevMenuDownPosButton = vgui.Create("DImageButton", SBEPElevMenuPanel )
		SBEPElevMenuDownPosButton:SetPos( 45 , 468 )   
		SBEPElevMenuDownPosButton:SetSize( 75 , 35 )   
		SBEPElevMenuDownPosButton:SetImage( "sbep_icons/ArrowDown.vmt" )
		SBEPElevMenuDownPosButton.DoClick = function()
										end
	
	SBEPElevMenuCamUpButton = vgui.Create("DImageButton", SBEPElevMenuPanel )
		SBEPElevMenuCamUpButton:SetPos( 205 , 348 )   
		SBEPElevMenuCamUpButton:SetSize( 75 , 35 )   
		SBEPElevMenuCamUpButton:SetImage( "sbep_icons/ArrowUp.vmt" )
		SBEPElevMenuCamUpButton.DoClick = function()
											CL.ModViewPitch = CL.ModViewPitch + 2
											ReCalcViewAngles()
										end
	
	SBEPElevMenuCamDownButton = vgui.Create("DImageButton", SBEPElevMenuPanel )
		SBEPElevMenuCamDownButton:SetPos( 205 , 468 )   
		SBEPElevMenuCamDownButton:SetSize( 75 , 35 )   
		SBEPElevMenuCamDownButton:SetImage( "sbep_icons/ArrowDown.vmt" )
		SBEPElevMenuCamDownButton.DoClick = function()
												CL.ModViewPitch = CL.ModViewPitch - 2
												ReCalcViewAngles()
										end
	
	SBEPElevMenuCamLeftButton = vgui.Create("DImageButton", SBEPElevMenuPanel )
		SBEPElevMenuCamLeftButton:SetPos( 165 , 388 )   
		SBEPElevMenuCamLeftButton:SetSize( 35 , 75 )
		SBEPElevMenuCamLeftButton:SetImage( "sbep_icons/ArrowLeft.vmt" )
		SBEPElevMenuCamLeftButton.DoClick = function()
												CL.ModViewYaw = CL.ModViewYaw - 2
												ReCalcViewAngles()
										end
	
	SBEPElevMenuCamRightButton = vgui.Create("DImageButton", SBEPElevMenuPanel )
		SBEPElevMenuCamRightButton:SetPos( 285 , 388 )   
		SBEPElevMenuCamRightButton:SetSize( 35 , 75 )
		SBEPElevMenuCamRightButton:SetImage( "sbep_icons/ArrowRight.vmt" )
		SBEPElevMenuCamRightButton.DoClick = function()
												CL.ModViewYaw = CL.ModViewYaw + 2
												ReCalcViewAngles()
										end

	SBEPElevMenuCamIcon = vgui.Create("DImageButton", SBEPElevMenuPanel )
		SBEPElevMenuCamIcon:SetPos( 205 , 388 )   
		SBEPElevMenuCamIcon:SetSize( 75 , 75 ) 
		SBEPElevMenuCamIcon:SetImage( "sbep_icons/Camera.vmt" )		
		SBEPElevMenuCamIcon.DoClick = function()
											DefaultViewAngles()
										end
	
	SBEPElevMenuCamZoomInButton = vgui.Create("DImageButton", SBEPElevMenuPanel )
		SBEPElevMenuCamZoomInButton:SetPos( 285 , 348 )   
		SBEPElevMenuCamZoomInButton:SetSize( 35 , 35 )
		SBEPElevMenuCamZoomInButton:SetImage( "sbep_icons/ZoomIn.vmt" )
		SBEPElevMenuCamZoomInButton.DoClick = function()
												CL.ModViewRange = CL.ModViewRange - 10
												ReCalcViewAngles()
										end
	
	SBEPElevMenuCamZoomOutButton = vgui.Create("DImageButton", SBEPElevMenuPanel )
		SBEPElevMenuCamZoomOutButton:SetPos( 165 , 348 )   
		SBEPElevMenuCamZoomOutButton:SetSize( 35 , 35 )
		SBEPElevMenuCamZoomOutButton:SetImage( "sbep_icons/ZoomOut.vmt" )
		SBEPElevMenuCamZoomOutButton.DoClick = function()
												CL.ModViewRange = CL.ModViewRange + 10
												ReCalcViewAngles()
										end
	
	SBEPElevMenuRotCamCButton = vgui.Create("DImageButton", SBEPElevMenuPanel )
		SBEPElevMenuRotCamCButton:SetPos( 165 , 468 )   
		SBEPElevMenuRotCamCButton:SetSize( 35 , 35 )
		SBEPElevMenuRotCamCButton:SetImage( "sbep_icons/RotC.vmt" )
		SBEPElevMenuRotCamCButton.DoClick = function()
												CL.ModViewYaw = CL.ModViewYaw - 90
												ReCalcViewAngles()
											end
	
	SBEPElevMenuRotCamACButton = vgui.Create("DImageButton", SBEPElevMenuPanel )
		SBEPElevMenuRotCamACButton:SetPos( 285 , 468 )   
		SBEPElevMenuRotCamACButton:SetSize( 35 , 35 )
		SBEPElevMenuRotCamACButton:SetImage( "sbep_icons/RotAC.vmt" )
		SBEPElevMenuRotCamACButton.DoClick = function()
												CL.ModViewYaw = CL.ModViewYaw + 90
												ReCalcViewAngles()
											end

	SBEPElevMenuInvertPartButton = vgui.Create("DImageButton", SBEPElevMenuPanel )
		SBEPElevMenuInvertPartButton:SetPos( 45 , 188 )   
		SBEPElevMenuInvertPartButton:SetSize( 75 , 35 )   
		SBEPElevMenuInvertPartButton:SetImage( "sbep_icons/Invert.vmt" )
		SBEPElevMenuInvertPartButton.DoClick = function()
													CL.Inverted = (CL.Inverted + 1) % 2
													CL.StartAngleTwist = (CL.StartAngleTwist + 180) % 360
													UpdateGhostEntPos()
												end

	SBEPElevMenuRotPartCButton = vgui.Create("DImageButton", SBEPElevMenuPanel )
		SBEPElevMenuRotPartCButton:SetPos( 5 , 188 )   
		SBEPElevMenuRotPartCButton:SetSize( 35 , 35 )
		SBEPElevMenuRotPartCButton:SetImage( "sbep_icons/RotC.vmt" )
		SBEPElevMenuRotPartCButton.DoClick = function()
												CL.StartAngleYaw = (CL.StartAngleYaw - 90) % 360
												//print(tostring(CL.StartAngleYaw))
												UpdateGhostEntPos()
											end
	
	SBEPElevMenuRotPartACButton = vgui.Create("DImageButton", SBEPElevMenuPanel )
		SBEPElevMenuRotPartACButton:SetPos( 125 , 188 )   
		SBEPElevMenuRotPartACButton:SetSize( 35 , 35 )
		SBEPElevMenuRotPartACButton:SetImage( "sbep_icons/RotAC.vmt" )
		SBEPElevMenuRotPartACButton.DoClick = function()
												CL.StartAngleYaw = (CL.StartAngleYaw + 90) % 360
												//print(tostring(CL.StartAngleYaw))
												UpdateGhostEntPos()
											end

	
	
	function SBEP_OpenElevDesignMenu()

		CL.StartOffset = Vector(0,0,65.1)
		CL.StartAngleYaw = 0
		CL.StartAngleTwist = 0
		CL.StartAngleOffset = Angle(0,CL.StartAngleYaw,CL.StartAngleTwist)
		CL.Inverted = 0
		CLickPos = CL:GetNetworkedVector( "SBEP_Elev_StartPos" )
		
		CL.CurrentModelNumber = 1
		CL.CurrentRowBaseNumber = 1
		CL.CurrentRowMidNumber = 2
		CL.ShaftConstant = 0
		CL.CurrentModelRow = ElevatorModelTable[1][1]

		DefaultViewAngles()
		ReCalcViewAngles()

		ElevSystemEnt = CL:GetNetworkedEntity( "SBEP_ElevSystem" )
		ElevSystemEnt.Editable = true
		
		CL.PartCount = ElevSystemEnt:GetNetworkedFloat( "SBEP_PartCount" )
		CL.PartTable = {}
		
		GhostEnt = ElevSystemEnt:GhostEntity()
			GhostEnt:SetModel( CL.CurrentModelRow[2] )

		UpdateGhostEntPos()
		
		SBEPElevMenuPanelVisible = true
		SBEPElevMenuPanel:SetVisible( SBEPElevMenuPanelVisible )

	end
	
	concommand.Add("SBEP_OpenElevDesignMenu_cl",SBEP_OpenElevDesignMenu)
	
	function UpdateGhostEntPos()
	
		if !GhostEnt or !GhostEnt:IsValid() then
			GhostEnt = ElevSystemEnt:GhostEntity()
				GhostEnt:SetModel( CL.CurrentModelRow[2] )
		end
		
		CL.GhostPos = ElevSystemEnt:GetNetworkedVector( "SBEP_GhostVecPos" )
		
		if !CL.GhostPos then CL.GhostPos = Vector(0,0,65.1) end
		
		if CL.Inverted == 1 and CL.CurrentModelNumber == 3 then 
			CL.GhostPos = CL.GhostPos + Vector(0,0,130.2)
		end
		
		GhostEnt:SetPos( CL.GhostPos )

		CL.StartAngleOffset = Angle(0,CL.StartAngleYaw,CL.StartAngleTwist)
		GhostEnt:SetAngles(CL.StartAngleOffset)

		UpdateGhostEntModel()
		
	end
	
	function UpdateGhostEntModel()
		if CL.PartCount == 0 then
			CL.CurrentModelRow = ElevatorModelTable[CL.CurrentRowBaseNumber + 2 * CL.Inverted][CL.CurrentModelNumber]
		else
			CL.CurrentModelRow = ElevatorModelTable[CL.CurrentRowMidNumber][CL.CurrentModelNumber]
		end
		GhostEnt:SetModel( CL.CurrentModelRow[2] )
	end

	function UpdateClientPartTable()
	
		CL.PartCount = ElevSystemEnt:GetNetworkedFloat( "SBEP_PartCount" )
		
		if CL.PartCount > 0 then
				CL.PartTable = {}
				for i = 1, CL.PartCount do
					CL.PartTable[i] = ElevSystemEnt:GetNetworkedEntity( "SBEP_Part_"..tostring(i) )
				end
		end
	
	end
	
	function DefaultViewAngles()
			CL.ModBaseVector = Vector(-1,0,0)
			CL.ModViewYaw = -135
			CL.ModViewPitch = 30
			CL.ModViewRange = 500

			ReCalcViewAngles()
	end

	function ReCalcViewAngles()
		CL.ModBaseVector = Vector(-1,0,0)
		CL.ModRotAngle = Angle( CL.ModViewPitch , CL.ModViewYaw , 0 )
		CL.ModBaseVector:Rotate( CL.ModRotAngle )
		CL.ModViewOffset = CL.ModViewRange * CL.ModBaseVector
	end
	
	function SBEP_FinishElevDesignMenu()
	
		SBEPElevMenuPanelVisible = false
		SBEPElevMenuPanel:SetVisible( SBEPElevMenuPanelVisible )
		
		if CL.PartCount > 1 and CL.CurrentRowMidNumber == 2 then
			RunConsoleCommand( "SBEP_InitSystem_ser" , tostring( ElevatorModelTable[3][CL.CurrentModelNumber][2] ) )
		end

		RunConsoleCommand( "SBEP_WeldSystem_ser" )

		GhostEnt:Remove()
		
		RunConsoleCommand( "sbep_elevator_design_tool_editing", 0 )

	end
	
	hook.Add("InitPostEntity", "GetSBEPLocalPlayer", function()
		CL = LocalPlayer()
	end)

	function SBEP_ElevCalcView( ply, origin, angles, fov )
 
		if SBEPElevMenuPanelVisible then
			local view = {}
					view.origin = CL.GhostPos + CL.ModViewOffset
					view.angles = CL.ModRotAngle

			return view
		else
			return GAMEMODE:CalcView(ply,origin,angles,fov)
		end
 
	end
 
	hook.Add("CalcView", "SBEP_ElevCalcView", SBEP_ElevCalcView)

end

if SERVER then

	function SBEP_ConstructPart( ply , cmd , args )

		ElevSystem:ConstructPart( args )

	end

	concommand.Add("SBEP_ConstructPart_ser",SBEP_ConstructPart)
	
	function SBEP_WeldSystem()
	
		ElevSystem:WeldSystem()
	
	end
	
	concommand.Add("SBEP_WeldSystem_ser",SBEP_WeldSystem)
	
	function SBEP_InitSystem( ply, cmd, args )
	
		ElevSystem:InitSystem( ply , args )
	
	end
	
	concommand.Add("SBEP_InitSystem_ser",SBEP_InitSystem)
	
	function SBEP_CancelElevDesignMenu()
	
		if ValidEntity(ElevSystem) then
			ElevSystem:Remove()
		end

		RunConsoleCommand( "sbep_elevator_design_tool_editing", 0 )

	end
	
	concommand.Add("SBEP_CancelElevDesignMenu_ser",SBEP_CancelElevDesignMenu)

end

function TOOL:LeftClick( trace )

	/*-----------------
	if trace.Entity:IsValid() then

		TraceEntModel = trace.Entity:GetModel()
		TraceEntPos = trace.Entity:GetPos()
		UseTraceEntStart = false
		
		for k,v in ipairs( ElevatorModelTable[1] ) do
			//for q,r in ipairs( v ) do
				print( tostring( TraceEntModel ) )
				print( tostring( v ) )
				if v == TraceEntModel then
					UseTraceEntStart = true
					print( "Elevator Housing Match." )
				end
			//end
		end		
	end
	--------------*/
	local Editing = GetConVarNumber( "sbep_elevator_design_tool_editing" )
	
	if Editing == 0 then
	
		local startpos = trace.HitPos
		local spawnoffset = Vector(0,0,4.65)
	
		ElevSystem = ents.Create( "sbep_elev_system" )
			ElevSystem:SetPos( startpos + spawnoffset)
			ElevSystem:SetAngles( Angle(0,-90,0) )
			ElevSystem:Spawn()
			//ElevSystem:SetColor(255,255,255,180)
			ElevSystem.Editable = true
			ElevSystem:SetNetworkedVector( "SBEP_GhostVecPos" , startpos + Vector(0,0, 65.1 ))

		self:GetOwner():SetNetworkedEntity( "SBEP_ElevSystem" , ElevSystem )
		self:GetOwner():SetNetworkedVector( "SBEP_Elev_StartPos" , startpos )

		timer.Simple(0.01, function()
								RunConsoleCommand( "SBEP_OpenElevDesignMenu_cl" )
							end)
	
		RunConsoleCommand( "sbep_elevator_design_tool_editing", 1 )
	
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
	
end