TOOL.Category		= "SBEP"
TOOL.Name			= "#Lift System Designer"
TOOL.Command		= nil
TOOL.ConfigName 	= ""

local BMT = {
	{ type = "M"		} ,
	{ type = "ME"		} ,
	{ type = "MEdh"	 	} ,
	{ type = "MEdw"	 	} ,
	{ type = "MR"		} ,
	{ type = "MT"		} ,
	{ type = "MX"		} ,
	{ type = "S"		}
			}

local SMT = {
	{ type = "MV"		} ,
	{ type = "H"		}
			}

if CLIENT then
	language.Add( "Tool_sbep_lift_designer_name", "SBEP Lift System Designer" 		)
	language.Add( "Tool_sbep_lift_designer_desc", "Create a lift system." 			)
	language.Add( "Tool_sbep_lift_designer_0"	, "Left click somewhere to begin, or right click an existing lift shaft to start from there." 	)
	language.Add( "undone_SBEP Lift System"		, "Undone SBEP Lift System"			)
end

local ConVars = {
		editing 		= 0,
		activepart		= 1,
		skin			= 0,
		enableuse		= 0,
		doors			= 0,
		size			= 1,
		type			= "M"
				}
for k,v in pairs(ConVars) do
	TOOL.ClientConVar[k] = v
end

local function RCC( com , arg )
	RunConsoleCommand( com , arg )
end

local LiftSystem_SER = nil

if CLIENT then

	function CreateSBEPLiftDesignerMenu()
	
		local LDT = {}
	
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
												RCC( "SBEP_LiftCancelMenu_ser" )
												CL.SBEPLDDM = nil
												LDT.Frame:Remove()
												LDT.SFrame:Remove()
											end
		
		LDT.SButtons.finish = vgui.Create("DImageButton", LDT.Frame )
			LDT.SButtons.finish:SetPos( 5 , 508 )
			LDT.SButtons.finish:SetSize( 315 , 35 )
			LDT.SButtons.finish:SetImage( "sbep_icons/Finish.vmt" )
			LDT.SButtons.finish.DoClick = function()
												RCC( "SBEP_LiftFinishSystem_ser" )
												LDT.Frame:Remove()
												LDT.SFrame:Remove()
											end
		
		---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		//					MODEL CONTROLS
		---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

		LDT.PButtons = {}
		LDT.PButtons.Part = {}
		
		for k,v in ipairs(BMT) do
			LDT.PButtons.Part[k] = vgui.Create("DImageButton", LDT.Frame )
				LDT.PButtons.Part[k]:SetImage( "sbep_icons/"..v.type..".vmt" )
				LDT.PButtons.Part[k]:SetPos( 5 + 80 * ((k - 1)%4) , 28 + 80 * math.floor((k - 1)/ 4))
				LDT.PButtons.Part[k]:SetSize( 75 , 75 )
				LDT.PButtons.Part[k].DoClick = function()
														RCC( "SBEP_LiftSys_SetLiftPartType_ser" , v.type )
													end
		end
		
		LDT.PButtons.Special = {}
		LDT.PButtons.Special.Part = {}
		
		LDT.PButtons.Special.B = vgui.Create("DImageButton", LDT.Frame )
			LDT.PButtons.Special.B:SetPos( 165 , 188 )   
			LDT.PButtons.Special.B:SetSize( 155 , 35 )
			LDT.PButtons.Special.B:SetImage( "sbep_icons/Special.vmt" )
			LDT.PButtons.Special.B.DoClick = function()
													LDT.SFrame.visible = !LDT.SFrame.visible
													LDT.SFrame:SetVisible( LDT.SFrame.visible )
												end
		
		LDT.PButtons.Special.Part[1] = vgui.Create("DImageButton", LDT.SFrame )
			LDT.PButtons.Special.Part[1]:SetImage( "sbep_icons/MV.vmt" )
			LDT.PButtons.Special.Part[1]:SetPos( 5 , 5 )
			LDT.PButtons.Special.Part[1]:SetSize( 75 , 75 )
			LDT.PButtons.Special.Part[1].DoClick = function()
													LDT.SFrame.visible = false
													LDT.SFrame:SetVisible( LDT.SFrame.visible )
													RCC( "SBEP_LiftSys_SetLiftPartType_ser" , SMT[1].type )
												end

		LDT.PButtons.Special.Part[2] = vgui.Create("DImageButton", LDT.SFrame )
			LDT.PButtons.Special.Part[2]:SetImage( "sbep_icons/H.vmt" )
			LDT.PButtons.Special.Part[2]:SetPos( 85 , 5 )
			LDT.PButtons.Special.Part[2]:SetSize( 75 , 75 )
			LDT.PButtons.Special.Part[2].DoClick = function()
													LDT.SFrame.visible = false
													LDT.SFrame:SetVisible( LDT.SFrame.visible )
													RCC( "SBEP_LiftSys_SetLiftPartType_ser" , SMT[2].type )
												end

		---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		//					CONSTRUCTION CONTROLS
		---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		
		LDT.BButtons = {}
		
		LDT.BButtons.Construct = vgui.Create("DImageButton", LDT.Frame )
			LDT.BButtons.Construct:SetPos( 5 , 268 )
			LDT.BButtons.Construct:SetSize( 155 , 195 )
			LDT.BButtons.Construct:SetImage( "sbep_icons/Construct.vmt" )
			LDT.BButtons.Construct.DoClick = function()
													local pos = GetConVarNumber( "sbep_lift_designer_activepart" )
													pos = pos + 1
													RCC( "SBEP_LiftConstructPart_ser" , pos )
											end
		
		LDT.BButtons.up = vgui.Create("DImageButton", LDT.Frame )
			LDT.BButtons.up:SetPos( 45 , 228 )   
			LDT.BButtons.up:SetSize( 75 , 35 )   
			LDT.BButtons.up:SetImage( "sbep_icons/ArrowUp.vmt" )
			LDT.BButtons.up.DoClick = function()
													local pos = GetConVarNumber( "sbep_lift_designer_activepart" )
													pos = math.Clamp( pos + 1 , 1 , CL.LiftSystem:GetNWInt( "SBEP_LiftPartCount" ) )
													RCC( "sbep_lift_designer_activepart" , pos )
													RCC( "SBEP_LiftGetCamHeight_ser" )
											end
		
		LDT.BButtons.down = vgui.Create("DImageButton", LDT.Frame )
			LDT.BButtons.down:SetPos( 45 , 468 )   
			LDT.BButtons.down:SetSize( 75 , 35 )   
			LDT.BButtons.down:SetImage( "sbep_icons/ArrowDown.vmt" )
			LDT.BButtons.down.DoClick = function()
													local pos = GetConVarNumber( "sbep_lift_designer_activepart" )
													pos = math.Clamp( pos - 1 , 1 , CL.LiftSystem:GetNWInt( "SBEP_LiftPartCount" ) )
													RCC( "sbep_lift_designer_activepart" , pos )
													RCC( "SBEP_LiftGetCamHeight_ser" )
											end
		
		LDT.BButtons.inv = vgui.Create("DImageButton", LDT.Frame )
			LDT.BButtons.inv:SetPos( 45 , 188 )   
			LDT.BButtons.inv:SetSize( 75 , 35 )   
			LDT.BButtons.inv:SetImage( "sbep_icons/Invert.vmt" )
			LDT.BButtons.inv.DoClick = function()
														RCC( "SBEP_LiftSys_SetLiftPartRoll_ser" , 180 )
														RCC( "SBEP_LiftGetCamHeight_ser" )
													end

		LDT.BButtons.RotC = vgui.Create("DImageButton", LDT.Frame )
			LDT.BButtons.RotC:SetPos( 5 , 188 )   
			LDT.BButtons.RotC:SetSize( 35 , 35 )
			LDT.BButtons.RotC:SetImage( "sbep_icons/RotC.vmt" )
			LDT.BButtons.RotC.DoClick = function()
													RCC( "SBEP_LiftSys_SetLiftPartYaw_ser" , 270 )
												end
		
		LDT.BButtons.RotAC = vgui.Create("DImageButton", LDT.Frame )
			LDT.BButtons.RotAC:SetPos( 125 , 188 )   
			LDT.BButtons.RotAC:SetSize( 35 , 35 )
			LDT.BButtons.RotAC:SetImage( "sbep_icons/RotAC.vmt" )
			LDT.BButtons.RotAC.DoClick = function()
													RCC( "SBEP_LiftSys_SetLiftPartYaw_ser" , 90 )
												end
		
		LDT.BButtons.Delete = vgui.Create("DImageButton", LDT.Frame )
			LDT.BButtons.Delete:SetPos( 125 , 228 )   
			LDT.BButtons.Delete:SetSize( 35 , 35 )
			LDT.BButtons.Delete:SetImage( "sbep_icons/Delete.vmt" )
			LDT.BButtons.Delete.DoClick = function()
													RCC( "SBEP_LiftDeletePart_ser" )	
												end
		
		---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		//					CAMERA CONTROLS
		---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		
		LDT.CButtons = {}
		
		LDT.CButtons.up = vgui.Create("DImageButton", LDT.Frame )
			LDT.CButtons.up:SetPos( 205 , 348 )   
			LDT.CButtons.up:SetSize( 75 , 35 )   
			LDT.CButtons.up:SetImage( "sbep_icons/ArrowUp.vmt" )
			LDT.CButtons.up.Hold = true
			LDT.CButtons.up.OnMousePressed  = function() LDT.CButtons.up.Pressed = true  end
			LDT.CButtons.up.OnMouseReleased = function() LDT.CButtons.up.Pressed = false end
			LDT.CButtons.up.DoClick = function()
												CL.MVPitch = math.Clamp( CL.MVPitch + 0.1 , -89 , 89 )
												CL.CVPitch = CL.MVPitch
												ReCalcViewAngles()
											end
		
		LDT.CButtons.down = vgui.Create("DImageButton", LDT.Frame )
			LDT.CButtons.down:SetPos( 205 , 468 )   
			LDT.CButtons.down:SetSize( 75 , 35 )   
			LDT.CButtons.down:SetImage( "sbep_icons/ArrowDown.vmt" )
			LDT.CButtons.down.Hold = true
			LDT.CButtons.down.OnMousePressed  = function() LDT.CButtons.down.Pressed = true  end
			LDT.CButtons.down.OnMouseReleased = function() LDT.CButtons.down.Pressed = false end
			LDT.CButtons.down.DoClick = function()
													CL.MVPitch = math.Clamp( CL.MVPitch - 0.1 , -89 , 89 )
													CL.CVPitch = CL.MVPitch
													ReCalcViewAngles()
											end
		
		LDT.CButtons.left = vgui.Create("DImageButton", LDT.Frame )
			LDT.CButtons.left:SetPos( 165 , 388 )   
			LDT.CButtons.left:SetSize( 35 , 75 )
			LDT.CButtons.left:SetImage( "sbep_icons/ArrowLeft.vmt" )
			LDT.CButtons.left.Hold = true
			LDT.CButtons.left.OnMousePressed  = function() LDT.CButtons.left.Pressed = true  end
			LDT.CButtons.left.OnMouseReleased = function() LDT.CButtons.left.Pressed = false end
			LDT.CButtons.left.DoClick = function()
													CL.MVYaw = CL.MVYaw - 0.1
													CL.CVYaw = CL.MVYaw
													ReCalcViewAngles()
											end
		
		LDT.CButtons.right = vgui.Create("DImageButton", LDT.Frame )
			LDT.CButtons.right:SetPos( 285 , 388 )   
			LDT.CButtons.right:SetSize( 35 , 75 )
			LDT.CButtons.right:SetImage( "sbep_icons/ArrowRight.vmt" )
			LDT.CButtons.right.Hold = true
			LDT.CButtons.right.OnMousePressed  = function() LDT.CButtons.right.Pressed = true  end
			LDT.CButtons.right.OnMouseReleased = function() LDT.CButtons.right.Pressed = false end
			LDT.CButtons.right.DoClick = function()
													CL.MVYaw = CL.MVYaw + 0.1
													CL.CVYaw = CL.MVYaw
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
			LDT.CButtons.Zplus.Hold = true
			LDT.CButtons.Zplus.OnMousePressed  = function() LDT.CButtons.Zplus.Pressed = true  end
			LDT.CButtons.Zplus.OnMouseReleased = function() LDT.CButtons.Zplus.Pressed = false end
			LDT.CButtons.Zplus.DoClick = function()
													CL.MVRange = CL.MVRange - 0.007
													CL.CVRange = CL.MVRange
													ReCalcViewAngles()
											end
		
		LDT.CButtons.Zminus = vgui.Create("DImageButton", LDT.Frame )
			LDT.CButtons.Zminus:SetPos( 165 , 348 )   
			LDT.CButtons.Zminus:SetSize( 35 , 35 )
			LDT.CButtons.Zminus:SetImage( "sbep_icons/ZoomOut.vmt" )
			LDT.CButtons.Zminus.Hold = true
			LDT.CButtons.Zminus.OnMousePressed  = function() LDT.CButtons.Zminus.Pressed = true  end
			LDT.CButtons.Zminus.OnMouseReleased = function() LDT.CButtons.Zminus.Pressed = false end
			LDT.CButtons.Zminus.DoClick = function()
													CL.MVRange = CL.MVRange + 0.007
													CL.CVRange = CL.MVRange
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
	
		return LDT
	
	end

		---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		//					CLIENT FUNCTIONS
		---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		
		function SBEP_OpenLiftDesignMenu( um )
			CL.SBEPLDDM = CreateSBEPLiftDesignerMenu()
			
			CL.SBEPLDDM.Frame.visible = true
			CL.SBEPLDDM.Frame:SetVisible( true )

			CL.LiftSystem 	= um:ReadEntity()
			CL.StartPos 	= CL.LiftSystem:GetNWVector( "SBEPLiftDesigner_StartPos" )
			SetBaseViewAngles()
			CL.CVYaw   		= CL.MVYaw
			CL.CVPitch 		= CL.MVPitch
			CL.CVRange 		= CL.MVRange
			CL.CBRange 		= 168.15
			CL.MBRange 		= 168.15
			CL.CHOffset		= 0
			CL.PHOffset		= 0
			
			CL.PC = CL.LiftSystem:GetNWInt( "SBEP_LiftPartCount" )
		
			SetBaseViewAngles()
		end
		usermessage.Hook("SBEP_OpenLiftDesignMenu_cl", SBEP_OpenLiftDesignMenu)
		
		function SBEP_CloseLiftDesignMenu( um )
			CL.SBEPLDDM.SFrame:Remove()
			CL.SBEPLDDM.Frame:Remove()
			CL.SBEPLDDM = nil
		end
		usermessage.Hook("SBEP_CloseLiftDesignMenu_cl", SBEP_CloseLiftDesignMenu)
		
		function SBEPDisableButtons( um )
			local size	= GetConVarNumber( "sbep_lift_designer_size" )
			local pos	= um:ReadShort()
			CL.PC	= um:ReadShort()
			
			CL.SBEPLDDM.PButtons.Part[4]:SetDisabled( size == 2 )
			CL.SBEPLDDM.PButtons.Special.B:SetDisabled( size == 2 )
			CL.SBEPLDDM.PButtons.Part[8]:SetDisabled( pos == 1 )
			CL.SBEPLDDM.PButtons.Special.Part[2]:SetDisabled( pos == 1 )
			CL.SBEPLDDM.BButtons.Delete:SetDisabled( CL.PC == 1 )
			CL.SBEPLDDM.BButtons.down:SetDisabled( pos == 1 )
			CL.SBEPLDDM.BButtons.up:SetDisabled( pos == CL.PC )
			CL.SBEPLDDM.BButtons.Construct:SetDisabled( pos ~= CL.PC )
			CL.SBEPLDDM.SButtons.finish:SetDisabled( (pos ~= CL.PC) || (CL.PC < 3))
		end
		usermessage.Hook("SBEPDisableButtons_cl", SBEPDisableButtons)
		
		function SetBaseViewAngles()
			CL.MVYaw = 45
			CL.MVPitch = 20
			CL.MVRange = 2.35
			ReCalcViewAngles()
		end

		function ReCalcViewAngles( um )
			if um then
				CL.MBRange = um:ReadFloat()
			end
			CL.StartPos = CL.LiftSystem:GetNWVector( "SBEPLiftDesigner_StartPos" )
		end
		usermessage.Hook("SBEP_ReCalcViewAngles_LiftDesignMenu_cl", ReCalcViewAngles)
		
		hook.Add("InitPostEntity", "GetSBEPLocalPlayer", function()
			CL = LocalPlayer()
		end)

		function SBEPSetPHOffset( um )
			CL.PHOffset = um:ReadFloat()
		end
		usermessage.Hook("SBEP_SetPHOffsetLiftDesignMenu_cl", SBEPSetPHOffset)
		
		function SBEP_LiftCalcView( ply, origin, angles, fov )
			if CL.SBEPLDDM && CL.SBEPLDDM.Frame && CL.SBEPLDDM.Frame.visible then
				local view = {}
					CL.CVYaw   	= CL.CVYaw   	+ math.Clamp( CL.MVYaw   	- CL.CVYaw   	, -0.1  , 0.1  	)
					CL.CVPitch 	= CL.CVPitch 	+ math.Clamp( CL.MVPitch 	- CL.CVPitch 	, -0.1  , 0.1  	)
					CL.CVRange 	= CL.CVRange 	+ math.Clamp( CL.MVRange 	- CL.CVRange 	, -0.007, 0.007 )
					CL.CBRange 	= CL.CBRange 	+ math.Clamp( CL.MBRange 	- CL.CBRange 	, -0.5  , 0.5 	)
					CL.CHOffset = CL.CHOffset 	+ math.Clamp( CL.PHOffset 	- CL.CHOffset 	, -1 	, 1 	)
					
					CL.CRVec = Vector( 1 , 0 , 0 )
						CL.CRAng = Angle( -1 * CL.CVPitch , CL.CVYaw , CL.CVPitch )
						CL.CRVec:Rotate( CL.CRAng )
					CL.MVOffset = CL.CVRange * CL.CRVec * CL.CBRange

					view.origin = CL.StartPos + CL.MVOffset + Vector( 0 , 0 , CL.CHOffset )
					view.angles = (-1 * CL.MVOffset):Angle()
				return view
			else
				return GAMEMODE:CalcView(ply,origin,angles,fov)
			end
		end
		hook.Add("CalcView", "SBEP_LiftDesigner_CalcView", SBEP_LiftCalcView)

		function TOOL:GetViewModelPosition( pos , ang )
			if GetConVarNumber( "sbep_lift_designer_editing" ) == 1 then
				return Vector(0, 0, -1000), ang
			else
				return pos, ang
			end
		end
		
end

function TOOL:Think()
	if CLIENT then
		if CL.SBEPLDDM then
			for n,B in pairs( CL.SBEPLDDM.CButtons ) do
				if B.Hold && B.Pressed then
					B:DoClick()
				end
			end
			--self:NextThink( CurTime() + 0.05 )
		else
			--self:NextThink( CurTime() + 0.2 )
		end
		--return true
	end	
end

	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//					SERVER FUNCTIONS
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

if SERVER then

	function SBEP_SetLiftPartType( ply , cmd , args )
		local n = GetConVarNumber( "sbep_lift_designer_activepart" )
		local type = tostring( args[1] )
		if !LiftSystem_SER.PT[n] then return end
		
		RCC( "sbep_lift_designer_type" , type )
		LiftSystem_SER.PT[n]:SetPartType( type )
		LiftSystem_SER:RefreshParts( n )
		
		RCC( "SBEP_LiftGetCamHeight_ser" )
	end
	concommand.Add( "SBEP_LiftSys_SetLiftPartType_ser" , SBEP_SetLiftPartType )
	
	function SBEP_SetLiftPartRoll( ply , cmd , args )
		local n = GetConVarNumber( "sbep_lift_designer_activepart" )
			if !LiftSystem_SER.PT[n] then return end
		LiftSystem_SER.PT[n]:RotatePartRoll( tonumber( args[1] ) )
		RCC( "SBEP_LiftGetCamHeight_ser" )
	end
	concommand.Add( "SBEP_LiftSys_SetLiftPartRoll_ser" , SBEP_SetLiftPartRoll )	

	function SBEP_SetLiftPartYaw( ply , cmd , args )
		local n = GetConVarNumber( "sbep_lift_designer_activepart" )
			if !LiftSystem_SER.PT[n] then return end
		LiftSystem_SER.PT[n]:RotatePartYaw( tonumber( args[1] ) )
	end
	concommand.Add( "SBEP_LiftSys_SetLiftPartYaw_ser" , SBEP_SetLiftPartYaw )	
	
	function SBEP_LiftCancelMenu( ply , cmd , args )
		LiftSystem_SER:Remove()
		RCC( "sbep_lift_designer_editing" , 0 )
	end
	concommand.Add( "SBEP_LiftCancelMenu_ser" , SBEP_LiftCancelMenu )	
	
	function SBEP_LiftGetCamHeight( ply , cmd , args )
		local n = GetConVarNumber( "sbep_lift_designer_activepart" )
		local C = LiftSystem_SER:GetPartCount()
		umsg.Start("SBEP_SetPHOffsetLiftDesignMenu_cl", RecipientFilter():AddPlayer( ply ) )
			umsg.Float( LiftSystem_SER.PT[ n ].PD.HO )
		umsg.End()
		for k,v in ipairs( LiftSystem_SER.PT ) do
			v:SetColor( 255 , 255 , 255 , 255 )
		end
		if n == C then
			LiftSystem_SER.PT[ n ]:SetColor( 255 , 255 , 255 , 180 )
		else
			LiftSystem_SER.PT[ n ]:SetColor( 64  , 128 , 255 , 180 )
			LiftSystem_SER.PT[ C ]:SetColor( 255 , 255 , 255 , 100 )
		end
		umsg.Start("SBEP_ReCalcViewAngles_LiftDesignMenu_cl", RecipientFilter():AddPlayer( ply ) )
			umsg.Float( LiftSystem_SER.PT[ n ]:OBBMaxs():Length() )
		umsg.End()
		umsg.Start("SBEPDisableButtons_cl", RecipientFilter():AddPlayer( ply ) )
			umsg.Short( n )
			umsg.Short( C )
		umsg.End()
	end
	concommand.Add( "SBEP_LiftGetCamHeight_ser" , SBEP_LiftGetCamHeight )	
	
	function SBEP_LiftConstructPart( ply , cmd , args )
		local type = GetConVarString( "sbep_lift_designer_type" )
		local n = tonumber( args[1] )
		if n == 1 then return end
		
		RCC( "sbep_lift_designer_activepart" , n )

		local NP = LiftSystem_SER:CreatePart()
		LiftSystem_SER:AddPartToTable( NP , n )
		NP:SetPartType( type )

		LiftSystem_SER:RefreshParts( n )
		
		RCC( "SBEP_LiftGetCamHeight_ser" )
	end
	concommand.Add( "SBEP_LiftConstructPart_ser" , SBEP_LiftConstructPart )
	
	function SBEP_LiftFinishSystem( ply , cmd , args )		
		umsg.Start("SBEP_CloseLiftDesignMenu_cl", RecipientFilter():AddPlayer( ply ) )
			umsg.End()
		LiftSystem_SER:FinishSystem()
		RCC( "sbep_lift_designer_editing" , 0 )
	end
	concommand.Add( "SBEP_LiftFinishSystem_ser" , SBEP_LiftFinishSystem )
	
	function SBEP_LiftDeletePart( ply , cmd , args )
		local n = GetConVarNumber( "sbep_lift_designer_activepart" )
		if n == 1 then return end

		LiftSystem_SER:RemovePartFromTable( n )
		LiftSystem_SER:RefreshParts( 1 )
		
		local C = LiftSystem_SER:GetPartCount()
		if n > C then
			RCC( "sbep_lift_designer_activepart" , C )
		end
		RCC( "SBEP_LiftGetCamHeight_ser" )
	end
	concommand.Add( "SBEP_LiftDeletePart_ser" , SBEP_LiftDeletePart )
	
	--reset convars to defaults on load
	for k,v in pairs( ConVars ) do
	RCC( "sbep_lift_designer_"..k , v )
	end
end

function TOOL:LeftClick( trace )

	local Editing = GetConVarNumber( "sbep_lift_designer_editing" )
	
	if Editing == 0 then
	
		local startpos = trace.HitPos
		local ply = self:GetOwner()
	
		LiftSystem_SER = ents.Create( "sbep_elev_system" )
			LiftSystem_SER:SetPos( startpos + Vector(0,0,4.65))
			LiftSystem_SER:SetNWVector( "SBEPLiftDesigner_StartPos" , startpos + Vector(0,0,65.1) )
			LiftSystem_SER:SetAngles( Angle(0,-90,0) )
			LiftSystem_SER:SetModel( "models/SmallBridge/Elevators,Small/sbselevp3.mdl" )
			LiftSystem_SER.Skin = GetConVarNumber( "sbep_lift_designer_skin" )
			
		LiftSystem_SER.Usable = GetConVarNumber( "sbep_lift_designer_enableuse" ) == 1
		LiftSystem_SER:SetSystemSize( GetConVarNumber( "sbep_lift_designer_size" ) )
		
		LiftSystem_SER:Spawn()
		
		local hatchconvar = GetConVarNumber( "sbep_lift_designer_doors" )
		LiftSystem_SER.ST.UseHatches = hatchconvar == 2
		LiftSystem_SER.ST.UseDoors   = hatchconvar == 3	
		
		undo.Create( "SBEP Lift System" )
			undo.AddEntity( LiftSystem_SER )
			undo.SetPlayer( ply )
		undo.Finish()
		
		local NP = LiftSystem_SER:CreatePart()
			LiftSystem_SER:AddPartToTable( NP , 1 )
			NP:SetPartType( "M" )
		LiftSystem_SER:RefreshParts( 1 )

		RCC( "sbep_lift_designer_activepart" , 1 )
	
		umsg.Start("SBEP_OpenLiftDesignMenu_cl", RecipientFilter():AddPlayer( ply ) )
			umsg.Entity( LiftSystem_SER )
		umsg.End()
		
		RCC( "SBEP_LiftGetCamHeight_ser" )
	
		RCC( "sbep_lift_designer_editing" , 1 )
	
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
				SkinMenuOptions:AddOption( SkinTable[i] , function() RCC( "sbep_lift_designer_skin", (i - 1) ) end )
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
				DoorMenuOptions:AddOption( DoorTable[i] , function() RCC( "sbep_lift_designer_doors", i ) end )
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
				SizeMenuOptions:AddOption( SizeTable[i] , function() RCC( "sbep_lift_designer_size", i ) end )
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
							RCC( "sbep_lift_designer_editing" , 0 )
						end
	panel:AddItem( ResetButton )
	
	
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
end