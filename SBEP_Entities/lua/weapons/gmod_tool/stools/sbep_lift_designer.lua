TOOL.Category		= "SBEP"
TOOL.Name			= "#Lift System Designer"
TOOL.Command		= nil
TOOL.ConfigName 	= ""

LiftModelTable = {}
	LiftModelTable[1] = {}
		LiftModelTable[1][1]		= { "B"			, "models/SmallBridge/Elevators,Small/sbselevb.mdl" 		, 65.1 	, {0,1,0,0} 	}
		LiftModelTable[1][2]		= { "BE"		, "models/SmallBridge/Elevators,Small/sbselevbe.mdl" 		, 65.1 	, {0,1,0,1} 	}
		LiftModelTable[1][3] 		= { "BEdh"		, "models/SmallBridge/Elevators,Small/sbselevbedh.mdl" 		, 195.3 , {0,1,0,1} 	}
		LiftModelTable[1][4] 		= { "BEdw"		, "models/SmallBridge/Elevators,Small/sbselevbedw.mdl" 		, 65.1	, {0,1,0,1} 	}
		LiftModelTable[1][5]		= { "BR"		, "models/SmallBridge/Elevators,Small/sbselevbr.mdl" 		, 65.1	, {1,1,0,0} 	}
		LiftModelTable[1][6]		= { "BT"		, "models/SmallBridge/Elevators,Small/sbselevbt.mdl" 		, 65.1	, {1,1,1,0} 	}
		LiftModelTable[1][7]		= { "BX"		, "models/SmallBridge/Elevators,Small/sbselevbx.mdl" 		, 65.1	, {1,1,1,1} 	}
	LiftModelTable[2] = {}
		LiftModelTable[2][1]		= { "M"			, "models/SmallBridge/Elevators,Small/sbselevm.mdl" 		, 65.1	, {0,1,0,0} 	}
		LiftModelTable[2][2]		= { "ME"		, "models/SmallBridge/Elevators,Small/sbselevme.mdl" 		, 65.1	, {0,1,0,1} 	}
		LiftModelTable[2][3]	 	= { "MEdh"		, "models/SmallBridge/Elevators,Small/sbselevmedh.mdl" 		, 195.3 , {0,1,0,1} 	}
		LiftModelTable[2][4]		= { "MEdw"		, "models/SmallBridge/Elevators,Small/sbselevmedw.mdl" 		, 65.1 	, {0,1,0,1} 	}
		LiftModelTable[2][5]		= { "MR"		, "models/SmallBridge/Elevators,Small/sbselevmr.mdl" 		, 65.1 	, {1,1,0,0} 	}
		LiftModelTable[2][6]		= { "MT"		, "models/SmallBridge/Elevators,Small/sbselevmt.mdl" 		, 65.1 	, {1,1,1,0} 	}
		LiftModelTable[2][7]		= { "MX"		, "models/SmallBridge/Elevators,Small/sbselevmx.mdl" 		, 65.1 	, {1,1,1,1} 	}
	LiftModelTable[3] = {}
		LiftModelTable[3][1]		= { "T"			, "models/SmallBridge/Elevators,Small/sbselevt.mdl" 		, 65.1 	, {0,1,0,0} 	}
		LiftModelTable[3][2]		= { "TE"		, "models/SmallBridge/Elevators,Small/sbselevte.mdl" 		, 65.1	, {0,1,0,1} 	}
		LiftModelTable[3][3]		= { "TEdh"		, "models/SmallBridge/Elevators,Small/sbselevtedh.mdl" 		, 195.3 , {0,1,0,1} 	}
		LiftModelTable[3][4]	 	= { "TEdw"		, "models/SmallBridge/Elevators,Small/sbselevtedw.mdl" 		, 65.1	, {0,1,0,1} 	}
		LiftModelTable[3][5]		= { "TR"		, "models/SmallBridge/Elevators,Small/sbselevtr.mdl" 		, 65.1	, {1,1,0,0} 	}
		LiftModelTable[3][6]		= { "TT"		, "models/SmallBridge/Elevators,Small/sbselevtt.mdl" 		, 65.1	, {1,1,1,0} 	}
		LiftModelTable[3][7]		= { "TX"		, "models/SmallBridge/Elevators,Small/sbselevtx.mdl" 		, 65.1	, {1,1,1,1} 	}
	LiftModelTable[4] = {}
		LiftModelTable[4][1]		= { "S"			, "models/SmallBridge/Elevators,Small/sbselevs.mdl" 		, 65.1	, {0,0,0,0} 	}
		LiftModelTable[4][2]		= { "S2"		, "models/SmallBridge/Elevators,Small/sbselevs2.mdl" 		, 65.1	, {0,0,0,0} 	}
	LiftModelTable[5] = {}
		LiftModelTable[5][1] 		= { "P0"		, "models/SmallBridge/Elevators,Small/sbselevp0.mdl"		, 0		, {1,1,1,1} 	}
		LiftModelTable[5][2] 		= { "P1"		, "models/SmallBridge/Elevators,Small/sbselevp1.mdl"		, 0		, {1,0,1,1} 	}
		LiftModelTable[5][3] 		= { "P2E"		, "models/SmallBridge/Elevators,Small/sbselevp2e.mdl"		, 0		, {1,0,1,0} 	}
		LiftModelTable[5][4] 		= { "P2R"		, "models/SmallBridge/Elevators,Small/sbselevp2r.mdl"		, 0		, {1,0,0,1} 	}
		LiftModelTable[5][5] 		= { "P3"		, "models/SmallBridge/Elevators,Small/sbselevp3.mdl"		, 0		, {1,0,0,0} 	}

if CLIENT then
	language.Add( "Tool_sbep_lift_designer_name", "SBEP Lift System Designer" )
	language.Add( "Tool_sbep_lift_designer_desc", "Create a lift system." )
	language.Add( "Tool_sbep_lift_designer_0", "Left click somewhere, or on an existing lift housing, to begin." )
	language.Add( "undone_SBEP Lift System"	, "Undone SBEP Lift System"			)
end

CreateClientConVar( "sbep_lift_designer_editing", 0, false, false ) 

if CLIENT then

	SBEPLiftPartCount = 0
	
	SBEPLiftMenuPanel = vgui.Create( "DFrame" )
		SBEPLiftMenuPanel:SetPos( 30,30 )
		SBEPLiftMenuPanel:SetSize( 325, 548 )
		SBEPLiftMenuPanel:SetTitle( "SBEP Lift System Designer" )
		SBEPLiftMenuPanel:SetVisible( MenuVisible )
		SBEPLiftMenuPanel:SetDraggable( true )
		SBEPLiftMenuPanel:ShowCloseButton( false )
		SBEPLiftMenuPanel:MakePopup()
		
	SBEPLiftMenuCloseButton = vgui.Create("DSysButton", SBEPLiftMenuPanel )
		SBEPLiftMenuCloseButton:SetPos( 285 , 4 )   
		SBEPLiftMenuCloseButton:SetSize( 35 , 13 )   
		SBEPLiftMenuCloseButton:SetType( "close" )
		SBEPLiftMenuCloseButton.DoClick = function()
												SBEPLiftMenuPanelVisible = false
												SBEPLiftMenuPanel:SetVisible( SBEPLiftMenuPanelVisible )
												if ValidEntity(GhostEnt) then
													GhostEnt:Remove()
												end
												RunConsoleCommand("SBEP_CancelLiftDesignMenu_ser")
										end

	SBEPLiftMenuPartButton = {}
	for i = 1,8 do
		SBEPLiftMenuPartButton[i] = vgui.Create("DImageButton", SBEPLiftMenuPanel )
			SBEPLiftMenuPartButton[i]:SetImage( "sbep_icons/SBSelev"..LiftModelTable[ 2 + 2 * math.floor(i / 8) ][i - 7 * math.floor(i / 8)][1]..".vmt" )
			SBEPLiftMenuPartButton[i]:SetPos( 5 + 80 * ((i - 1)%4) , 28 + 80 * math.floor((i - 1)/ 4))
			SBEPLiftMenuPartButton[i]:SetSize( 75 , 75 )
			SBEPLiftMenuPartButton[i].DoClick = function()
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
	
	SBEPLiftMenuFinishButton = vgui.Create("DButton", SBEPLiftMenuPanel )
		SBEPLiftMenuFinishButton:SetPos( 5 , 508 )
		SBEPLiftMenuFinishButton:SetSize( 315 , 35 )
		SBEPLiftMenuFinishButton:SetText( "Finish" )
		SBEPLiftMenuFinishButton.DoClick = function()
											SBEP_FinishLiftDesignMenu()
										end
	
	SBEPLiftMenuConstructButton = vgui.Create("DButton", SBEPLiftMenuPanel )
		SBEPLiftMenuConstructButton:SetPos( 5 , 273 )
		SBEPLiftMenuConstructButton:SetSize( 155 , 190 )
		SBEPLiftMenuConstructButton:SetText( "Construct" )
		SBEPLiftMenuConstructButton.DoClick = function()
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
	
	SBEPLiftMenuUpPosButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuUpPosButton:SetPos( 45 , 233 )   
		SBEPLiftMenuUpPosButton:SetSize( 75 , 35 )   
		SBEPLiftMenuUpPosButton:SetImage( "sbep_icons/ArrowUp.vmt" )
		SBEPLiftMenuUpPosButton.DoClick = function()
										end
	
	SBEPLiftMenuDownPosButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuDownPosButton:SetPos( 45 , 468 )   
		SBEPLiftMenuDownPosButton:SetSize( 75 , 35 )   
		SBEPLiftMenuDownPosButton:SetImage( "sbep_icons/ArrowDown.vmt" )
		SBEPLiftMenuDownPosButton.DoClick = function()
										end
	
	SBEPLiftMenuCamUpButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuCamUpButton:SetPos( 205 , 348 )   
		SBEPLiftMenuCamUpButton:SetSize( 75 , 35 )   
		SBEPLiftMenuCamUpButton:SetImage( "sbep_icons/ArrowUp.vmt" )
		SBEPLiftMenuCamUpButton.DoClick = function()
											CL.ModViewPitch = CL.ModViewPitch + 2
											ReCalcViewAngles()
										end
	
	SBEPLiftMenuCamDownButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuCamDownButton:SetPos( 205 , 468 )   
		SBEPLiftMenuCamDownButton:SetSize( 75 , 35 )   
		SBEPLiftMenuCamDownButton:SetImage( "sbep_icons/ArrowDown.vmt" )
		SBEPLiftMenuCamDownButton.DoClick = function()
												CL.ModViewPitch = CL.ModViewPitch - 2
												ReCalcViewAngles()
										end
	
	SBEPLiftMenuCamLeftButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuCamLeftButton:SetPos( 165 , 388 )   
		SBEPLiftMenuCamLeftButton:SetSize( 35 , 75 )
		SBEPLiftMenuCamLeftButton:SetImage( "sbep_icons/ArrowLeft.vmt" )
		SBEPLiftMenuCamLeftButton.DoClick = function()
												CL.ModViewYaw = CL.ModViewYaw - 2
												ReCalcViewAngles()
										end
	
	SBEPLiftMenuCamRightButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuCamRightButton:SetPos( 285 , 388 )   
		SBEPLiftMenuCamRightButton:SetSize( 35 , 75 )
		SBEPLiftMenuCamRightButton:SetImage( "sbep_icons/ArrowRight.vmt" )
		SBEPLiftMenuCamRightButton.DoClick = function()
												CL.ModViewYaw = CL.ModViewYaw + 2
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
												CL.ModViewRange = CL.ModViewRange - 10
												ReCalcViewAngles()
										end
	
	SBEPLiftMenuCamZoomOutButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuCamZoomOutButton:SetPos( 165 , 348 )   
		SBEPLiftMenuCamZoomOutButton:SetSize( 35 , 35 )
		SBEPLiftMenuCamZoomOutButton:SetImage( "sbep_icons/ZoomOut.vmt" )
		SBEPLiftMenuCamZoomOutButton.DoClick = function()
												CL.ModViewRange = CL.ModViewRange + 10
												ReCalcViewAngles()
										end
	
	SBEPLiftMenuRotCamCButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuRotCamCButton:SetPos( 165 , 468 )   
		SBEPLiftMenuRotCamCButton:SetSize( 35 , 35 )
		SBEPLiftMenuRotCamCButton:SetImage( "sbep_icons/RotC.vmt" )
		SBEPLiftMenuRotCamCButton.DoClick = function()
												CL.ModViewYaw = CL.ModViewYaw - 90
												ReCalcViewAngles()
											end
	
	SBEPLiftMenuRotCamACButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuRotCamACButton:SetPos( 285 , 468 )   
		SBEPLiftMenuRotCamACButton:SetSize( 35 , 35 )
		SBEPLiftMenuRotCamACButton:SetImage( "sbep_icons/RotAC.vmt" )
		SBEPLiftMenuRotCamACButton.DoClick = function()
												CL.ModViewYaw = CL.ModViewYaw + 90
												ReCalcViewAngles()
											end

	SBEPLiftMenuInvertPartButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuInvertPartButton:SetPos( 45 , 188 )   
		SBEPLiftMenuInvertPartButton:SetSize( 75 , 35 )   
		SBEPLiftMenuInvertPartButton:SetImage( "sbep_icons/Invert.vmt" )
		SBEPLiftMenuInvertPartButton.DoClick = function()
													CL.Inverted = (CL.Inverted + 1) % 2
													CL.StartAngleTwist = (CL.StartAngleTwist + 180) % 360
													UpdateGhostEntPos()
												end

	SBEPLiftMenuRotPartCButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuRotPartCButton:SetPos( 5 , 188 )   
		SBEPLiftMenuRotPartCButton:SetSize( 35 , 35 )
		SBEPLiftMenuRotPartCButton:SetImage( "sbep_icons/RotC.vmt" )
		SBEPLiftMenuRotPartCButton.DoClick = function()
												CL.StartAngleYaw = (CL.StartAngleYaw - 90) % 360
												//print(tostring(CL.StartAngleYaw))
												UpdateGhostEntPos()
											end
	
	SBEPLiftMenuRotPartACButton = vgui.Create("DImageButton", SBEPLiftMenuPanel )
		SBEPLiftMenuRotPartACButton:SetPos( 125 , 188 )   
		SBEPLiftMenuRotPartACButton:SetSize( 35 , 35 )
		SBEPLiftMenuRotPartACButton:SetImage( "sbep_icons/RotAC.vmt" )
		SBEPLiftMenuRotPartACButton.DoClick = function()
												CL.StartAngleYaw = (CL.StartAngleYaw + 90) % 360
												//print(tostring(CL.StartAngleYaw))
												UpdateGhostEntPos()
											end

	
	
	function SBEP_OpenLiftDesignMenu()

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
		CL.CurrentModelRow = LiftModelTable[1][1]

		DefaultViewAngles()
		ReCalcViewAngles()

		LiftSystemEnt = CL:GetNetworkedEntity( "SBEP_ElevSystem" )
		LiftSystemEnt.Editable = true
		
		CL.PartCount = LiftSystemEnt:GetNetworkedFloat( "SBEP_PartCount" )
		CL.PartTable = {}
		
		GhostEnt = LiftSystemEnt:GhostEntity()
			GhostEnt:SetModel( CL.CurrentModelRow[2] )

		UpdateGhostEntPos()
		
		SBEPLiftMenuPanelVisible = true
		SBEPLiftMenuPanel:SetVisible( SBEPLiftMenuPanelVisible )

	end
	
	concommand.Add("SBEP_OpenLiftDesignMenu_cl",SBEP_OpenLiftDesignMenu)
	
	function UpdateGhostEntPos()
	
		if !GhostEnt or !GhostEnt:IsValid() then
			GhostEnt = LiftSystemEnt:GhostEntity()
				GhostEnt:SetModel( CL.CurrentModelRow[2] )
		end
		
		CL.GhostPos = LiftSystemEnt:GetNetworkedVector( "SBEP_GhostVecPos" )
		
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
			CL.CurrentModelRow = LiftModelTable[CL.CurrentRowBaseNumber + 2 * CL.Inverted][CL.CurrentModelNumber]
		else
			CL.CurrentModelRow = LiftModelTable[CL.CurrentRowMidNumber][CL.CurrentModelNumber]
		end
		GhostEnt:SetModel( CL.CurrentModelRow[2] )
	end

	function UpdateClientPartTable()
	
		CL.PartCount = LiftSystemEnt:GetNetworkedFloat( "SBEP_PartCount" )
		
		if CL.PartCount > 0 then
				CL.PartTable = {}
				for i = 1, CL.PartCount do
					CL.PartTable[i] = LiftSystemEnt:GetNetworkedEntity( "SBEP_Part_"..tostring(i) )
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
	
	function SBEP_FinishLiftDesignMenu()
	
		SBEPLiftMenuPanelVisible = false
		SBEPLiftMenuPanel:SetVisible( SBEPLiftMenuPanelVisible )
		
		if CL.PartCount > 1 and CL.CurrentRowMidNumber == 2 then
			RunConsoleCommand( "SBEP_InitSystem_ser" , tostring( LiftModelTable[3][CL.CurrentModelNumber][2] ) )
		end

		RunConsoleCommand( "SBEP_WeldSystem_ser" )

		GhostEnt:Remove()
		
		RunConsoleCommand( "sbep_lift_designer_editing", 0 )
		
		RunConsoleCommand( "SBEP_AddSystemUndo_ser" )

	end
	
	hook.Add("InitPostEntity", "GetSBEPLocalPlayer", function()
		CL = LocalPlayer()
	end)

	function SBEP_LiftCalcView( ply, origin, angles, fov )
 
		if SBEPLiftMenuPanelVisible then
			local view = {}
					view.origin = CL.GhostPos + CL.ModViewOffset
					view.angles = CL.ModRotAngle

			return view
		else
			return GAMEMODE:CalcView(ply,origin,angles,fov)
		end
 
	end
 
	hook.Add("CalcView", "SBEP_LiftCalcView", SBEP_LiftCalcView)

end

if SERVER then

	function SBEP_ConstructPart( ply , cmd , args )

		LiftSystem:ConstructPart( args )

	end

	concommand.Add("SBEP_ConstructPart_ser",SBEP_ConstructPart)
	
	function SBEP_WeldSystem()
	
		LiftSystem:WeldSystem()
	
	end
	
	concommand.Add("SBEP_WeldSystem_ser",SBEP_WeldSystem)
	
	function SBEP_InitSystem( ply, cmd, args )
	
		LiftSystem:InitSystem( ply , args )
	
	end
	
	concommand.Add("SBEP_InitSystem_ser",SBEP_InitSystem)
	
	function SBEP_CancelLiftDesignMenu()
	
		if ValidEntity(LiftSystem) then
			LiftSystem:Remove()
		end

		RunConsoleCommand( "sbep_lift_designer_editing", 0 )

	end
	
	concommand.Add("SBEP_CancelLiftDesignMenu_ser",SBEP_CancelLiftDesignMenu)
	
	function SBEP_AddSystemUndo( ply , cmd , args )
	
		undo.Create("SBEP Lift System")
			undo.AddEntity( LiftSystem )
			undo.SetPlayer( ply )
		undo.Finish()
	
	end
	
	concommand.Add("SBEP_AddSystemUndo_ser",SBEP_AddSystemUndo)

end

function TOOL:LeftClick( trace )

	/*-----------------
	if trace.Entity:IsValid() then

		TraceEntModel = trace.Entity:GetModel()
		TraceEntPos = trace.Entity:GetPos()
		UseTraceEntStart = false
		
		for k,v in ipairs( LiftModelTable[1] ) do
			//for q,r in ipairs( v ) do
				print( tostring( TraceEntModel ) )
				print( tostring( v ) )
				if v == TraceEntModel then
					UseTraceEntStart = true
					print( "Lift Housing Match." )
				end
			//end
		end		
	end
	--------------*/
	local Editing = GetConVarNumber( "sbep_lift_designer_editing" )
	
	if Editing == 0 then
	
		local startpos = trace.HitPos
		local spawnoffset = Vector(0,0,4.65)
	
		LiftSystem = ents.Create( "sbep_elev_system" )
			LiftSystem:SetPos( startpos + spawnoffset)
			LiftSystem:SetAngles( Angle(0,-90,0) )
			LiftSystem:Spawn()
			//LiftSystem:SetColor(255,255,255,180)
			LiftSystem.Editable = true
			LiftSystem:SetNetworkedVector( "SBEP_GhostVecPos" , startpos + Vector(0,0, 65.1 ))

		self:GetOwner():SetNetworkedEntity( "SBEP_ElevSystem" , LiftSystem )
		self:GetOwner():SetNetworkedVector( "SBEP_Elev_StartPos" , startpos )

		timer.Simple(0.05, function()
								RunConsoleCommand( "SBEP_OpenLiftDesignMenu_cl" )
							end)
	
		RunConsoleCommand( "sbep_lift_designer_editing", 1 )
	
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
	
end