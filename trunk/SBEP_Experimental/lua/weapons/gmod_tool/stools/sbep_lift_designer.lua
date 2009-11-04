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

local LHMT = list.Get( "SBEP_LiftHousingModels" )

local BEM = { S = true , S2 = true , H = true }
			
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

local LiftSystem_SER

if CLIENT then

	function CreateSBEPLiftDesignerMenu()
	
		local LDT = {}
	
		LDT.Frame = vgui.Create( "DFrame" )
			LDT.Frame:SetPos( 30,30 )
			LDT.Frame:SetSize( 325, 548 )
			LDT.Frame:SetTitle( "SBEP Lift System Designer" )
			LDT.Frame:SetVisible( false )
			LDT.Frame:SetDraggable( false )
			LDT.Frame:SetMouseInputEnabled( true )
			LDT.Frame:ShowCloseButton( false )
			LDT.Frame:MakePopup()
		
		LDT.SFrame = vgui.Create( "DFrame" )
			LDT.SFrame:SetPos( 360,193 )
			LDT.SFrame:SetSize( 165,85 )
			LDT.SFrame:SetTitle( " " )
			LDT.SFrame:SetBackgroundBlur( true )
			LDT.SFrame:SetVisible( false )
			LDT.SFrame:SetDraggable( false )
			LDT.SFrame:SetMouseInputEnabled( true )
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
												CL.LiftDes.SBEPLDDM = nil
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
													CL.LiftDes.DIR = "UP"
													pos = math.Clamp( pos + 1 , 1 , CL.LiftDes.LiftSystem:GetNWInt( "SBEP_LiftPartCount" ) )
													RCC( "sbep_lift_designer_activepart" , pos )
													RCC( "SBEP_LiftGetCamHeight_ser" )
											end
		
		LDT.BButtons.down = vgui.Create("DImageButton", LDT.Frame )
			LDT.BButtons.down:SetPos( 45 , 468 )   
			LDT.BButtons.down:SetSize( 75 , 35 )   
			LDT.BButtons.down:SetImage( "sbep_icons/ArrowDown.vmt" )
			LDT.BButtons.down.DoClick = function()
													local pos = GetConVarNumber( "sbep_lift_designer_activepart" )
													if pos == 1 then 
														CL.LiftDes.DIR = "DOWN"
														RCC( "SBEP_LiftConstructPart_ser" , 1 , "DOWN" )
													end
													pos = math.Clamp( pos - 1 , 1 , CL.LiftDes.LiftSystem:GetNWInt( "SBEP_LiftPartCount" ) )
													RCC( "sbep_lift_designer_activepart" , pos )
													RCC( "SBEP_LiftGetCamHeight_ser" )
											end
		
		LDT.BButtons.inv = vgui.Create("DImageButton", LDT.Frame )
			LDT.BButtons.inv:SetPos( 45 , 188 )   
			LDT.BButtons.inv:SetSize( 75 , 35 )   
			LDT.BButtons.inv:SetImage( "sbep_icons/Invert.vmt" )
			LDT.BButtons.inv.DoClick = function()
														RCC( "SBEP_LiftSys_InvertLiftPart_ser" )
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
												CL.LiftDes.MVPitch = math.Clamp( CL.LiftDes.MVPitch + 0.1 , -89 , 89 )
												CL.LiftDes.CVPitch = CL.LiftDes.MVPitch
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
													CL.LiftDes.MVPitch = math.Clamp( CL.LiftDes.MVPitch - 0.1 , -89 , 89 )
													CL.LiftDes.CVPitch = CL.LiftDes.MVPitch
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
													CL.LiftDes.MVYaw = CL.LiftDes.MVYaw - 0.1
													CL.LiftDes.CVYaw = CL.LiftDes.MVYaw
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
													CL.LiftDes.MVYaw = CL.LiftDes.MVYaw + 0.1
													CL.LiftDes.CVYaw = CL.LiftDes.MVYaw
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
													CL.LiftDes.MVRange = CL.LiftDes.MVRange - 0.007
													CL.LiftDes.CVRange = CL.LiftDes.MVRange
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
													CL.LiftDes.MVRange = CL.LiftDes.MVRange + 0.007
													CL.LiftDes.CVRange = CL.LiftDes.MVRange
													ReCalcViewAngles()
											end
		
		LDT.CButtons.RotC = vgui.Create("DImageButton", LDT.Frame )
			LDT.CButtons.RotC:SetPos( 165 , 468 )   
			LDT.CButtons.RotC:SetSize( 35 , 35 )
			LDT.CButtons.RotC:SetImage( "sbep_icons/RotC.vmt" )
			LDT.CButtons.RotC.DoClick = function()
													CL.LiftDes.MVYaw = CL.LiftDes.MVYaw - 90
													ReCalcViewAngles()
												end
		
		LDT.CButtons.RotAC = vgui.Create("DImageButton", LDT.Frame )
			LDT.CButtons.RotAC:SetPos( 285 , 468 )   
			LDT.CButtons.RotAC:SetSize( 35 , 35 )
			LDT.CButtons.RotAC:SetImage( "sbep_icons/RotAC.vmt" )
			LDT.CButtons.RotAC.DoClick = function()
													CL.LiftDes.MVYaw = CL.LiftDes.MVYaw + 90
													ReCalcViewAngles()
												end
	
		return LDT
	
	end

		---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		//					CLIENT FUNCTIONS
		---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		
		function SBEP_OpenLiftDesignMenu( um )
			CL.LiftDes.SBEPLDDM = CreateSBEPLiftDesignerMenu()
			CL.LiftDes = CL.LiftDes or {}
			CL.LiftDes.DIR = "UP"
			
			CL.LiftDes.SBEPLDDM.Frame.visible = true
			CL.LiftDes.SBEPLDDM.Frame:SetVisible( true )

			CL.LiftDes.LiftSystem 	= um:ReadEntity()
			if CL.LiftSystem then
				CL.LiftDes.StartPos 	= (CL.LiftDes.LiftSystem:GetPos() + 60.45*CL.LiftDes.LiftSystem:GetUp()) || Vector(0,0,0)
			else
				CL.LiftDes.StartPos 	= Vector(0,0,0)
			end
			SetBaseViewAngles()
			CL.LiftDes.CVYaw   		= CL.LiftDes.MVYaw
			CL.LiftDes.CVPitch 		= CL.LiftDes.MVPitch
			CL.LiftDes.CVRange 		= CL.LiftDes.MVRange
			CL.LiftDes.CBRange 		= 168.15
			CL.LiftDes.MBRange 		= 168.15
			CL.LiftDes.CHOffset		= 0
			CL.LiftDes.PHOffset		= 0
			
			CL.LiftDes.PC = CL.LiftDes.LiftSystem:GetNWInt( "SBEP_LiftPartCount" )
		
			SetBaseViewAngles()
		end
		usermessage.Hook("SBEP_OpenLiftDesignMenu_cl", SBEP_OpenLiftDesignMenu)
		
		function SBEP_CloseLiftDesignMenu( um )
			CL.LiftDes.SBEPLDDM.SFrame:Remove()
			CL.LiftDes.SBEPLDDM.Frame:Remove()
			CL.LiftDes.SBEPLDDM = nil
		end
		usermessage.Hook("SBEP_CloseLiftDesignMenu_cl", SBEP_CloseLiftDesignMenu)
		
		function SBEPDisableButtons( um )
			local size	= GetConVarNumber( "sbep_lift_designer_size" )
			local pos	= um:ReadShort()
			CL.LiftDes.PC		= um:ReadShort()
			local CanDown = um:ReadBool()
			local type1 = um:ReadString()
			local type2 = um:ReadString()
			local typeC = um:ReadString()

			CL.LiftDes.SBEPLDDM.PButtons.Part[4]:SetDisabled( size == 2 )
			CL.LiftDes.SBEPLDDM.PButtons.Special.B:SetDisabled( size == 2 )
			CL.LiftDes.SBEPLDDM.PButtons.Part[8]:SetDisabled( pos == 1 )
			CL.LiftDes.SBEPLDDM.PButtons.Special.Part[2]:SetDisabled( pos == 1 )
			CL.LiftDes.SBEPLDDM.BButtons.Delete:SetDisabled( CL.LiftDes.PC == 1 || (pos == 1 && BEM[type2]) )
			CL.LiftDes.SBEPLDDM.BButtons.down:SetDisabled( pos == 1 && (!CanDown) )
			CL.LiftDes.SBEPLDDM.BButtons.up:SetDisabled( pos == CL.LiftDes.PC )
			CL.LiftDes.SBEPLDDM.BButtons.Construct:SetDisabled( pos ~= CL.LiftDes.PC )
			CL.LiftDes.SBEPLDDM.SButtons.finish:SetDisabled( (CL.LiftDes.PC < 3) || BEM[type1] || BEM[typeC] )
		end
		usermessage.Hook("SBEPDisableButtons_cl", SBEPDisableButtons)
		
		function SetBaseViewAngles()
			CL.LiftDes.MVYaw = 45
			CL.LiftDes.MVPitch = 20
			CL.LiftDes.MVRange = 2.35
			ReCalcViewAngles()
		end

		function ReCalcViewAngles( um )
			if um then
				CL.LiftDes.MBRange = um:ReadFloat()
			end
			if CL.LiftSystem then
				CL.LiftDes.StartPos 	= (CL.LiftDes.LiftSystem:GetPos() + 60.45*CL.LiftDes.LiftSystem:GetUp()) || Vector(0,0,0)
			else
				CL.LiftDes.StartPos 	= Vector(0,0,0)
			end
		end
		usermessage.Hook("SBEP_ReCalcViewAngles_LiftDesignMenu_cl", ReCalcViewAngles)
		
		hook.Add("InitPostEntity", "GetSBEPLocalPlayer", function()
			CL = LocalPlayer()
			CL.LiftDes = {}
		end)

		function SBEPSetPHOffset( um )
			CL.LiftDes.PHOffset = um:ReadFloat()
		end
		usermessage.Hook("SBEP_SetPHOffsetLiftDesignMenu_cl", SBEPSetPHOffset)
		
		function SBEP_LiftCalcView( ply, origin, angles, fov )
			if CL.LiftDes.SBEPLDDM && CL.LiftDes.SBEPLDDM.Frame && CL.LiftDes.SBEPLDDM.Frame.visible then
				local view = {}
					CL.LiftDes.CVYaw   	= CL.LiftDes.CVYaw   	+ math.Clamp( CL.LiftDes.MVYaw   	- CL.LiftDes.CVYaw   	, -0.1  , 0.1  	)
					CL.LiftDes.CVPitch 	= CL.LiftDes.CVPitch 	+ math.Clamp( CL.LiftDes.MVPitch 	- CL.LiftDes.CVPitch 	, -0.1  , 0.1  	)
					CL.LiftDes.CVRange 	= CL.LiftDes.CVRange 	+ math.Clamp( CL.LiftDes.MVRange 	- CL.LiftDes.CVRange 	, -0.007, 0.007 )
					CL.LiftDes.CBRange 	= CL.LiftDes.CBRange 	+ math.Clamp( CL.LiftDes.MBRange 	- CL.LiftDes.CBRange 	, -0.5  , 0.5 	)
					CL.LiftDes.CHOffset = CL.LiftDes.CHOffset 	+ math.Clamp( CL.LiftDes.PHOffset 	- CL.LiftDes.CHOffset 	, -1 	, 1 	)
					
					CL.LiftDes.CRVec = Vector( 1 , 0 , 0 )
						CL.LiftDes.CRAng = Angle( -1 * CL.LiftDes.CVPitch , CL.LiftDes.CVYaw , CL.LiftDes.CVPitch )
						CL.LiftDes.CRVec:Rotate( CL.LiftDes.CRAng )
					CL.LiftDes.MVOffset = CL.LiftDes.CVRange * CL.LiftDes.CRVec * CL.LiftDes.CBRange
					
					if CL.LiftDes.LiftSystem then
						view.origin = CL.LiftDes.StartPos + CL.LiftDes.MVOffset + CL.LiftDes.LiftSystem:GetUp()*CL.LiftDes.CHOffset
					else
						view.origin = CL.LiftDes.StartPos + CL.LiftDes.MVOffset + Vector(0,0,1)*CL.LiftDes.CHOffset
					end
					view.angles = (-1 * CL.LiftDes.MVOffset):Angle()
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
		if CL.LiftDes.SBEPLDDM then
			for n,B in pairs( CL.LiftDes.SBEPLDDM.CButtons ) do
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
	
	function SBEP_InvertLiftPart( ply , cmd , args )
		local n = GetConVarNumber( "sbep_lift_designer_activepart" )
			if !LiftSystem_SER.PT[n] then return end
		LiftSystem_SER.PT[n]:Invert()
		RCC( "SBEP_LiftGetCamHeight_ser" )
	end
	concommand.Add( "SBEP_LiftSys_InvertLiftPart_ser" , SBEP_InvertLiftPart )	

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
			LiftSystem_SER.PT[ C ]:SetColor( 255 , 255 , 255 ,  0  )
		end
		umsg.Start("SBEP_ReCalcViewAngles_LiftDesignMenu_cl", RecipientFilter():AddPlayer( ply ) )
			umsg.Float( LiftSystem_SER.PT[ n ]:OBBMaxs():Length() )
		umsg.End()
		LiftSystem_SER.CanDown = false
		if n == 1 && LiftSystem_SER.MDB then
			local tracedata = {}
				tracedata.start = LiftSystem_SER.PT[1]:GetPos()
				if LiftSystem_SER.PT[1].PD.Inv then
					tracedata.endpos = tracedata.start + 200*LiftSystem_SER.PT[1]:GetUp()
				else
					tracedata.endpos = tracedata.start - 200*LiftSystem_SER.PT[1]:GetUp()
				end
				tracedata.filter = { LiftSystem_SER , LiftSystem_SER.PT[1] }
			local trace = util.TraceHull(tracedata)
			if !trace.Hit then LiftSystem_SER.CanDown = true end
		end
		umsg.Start("SBEPDisableButtons_cl", RecipientFilter():AddPlayer( ply ) )
			umsg.Short( n )
			umsg.Short( C )
			umsg.Bool( LiftSystem_SER.CanDown )
			umsg.String( LiftSystem_SER.PT[1]:GetPartType() )
			if C > 1 then umsg.String( LiftSystem_SER.PT[2]:GetPartType() ) end
			if C > 2 then umsg.String( LiftSystem_SER.PT[C-1]:GetPartType() ) end
		umsg.End()
	end
	concommand.Add( "SBEP_LiftGetCamHeight_ser" , SBEP_LiftGetCamHeight )	
	
	function SBEP_LiftConstructPart( ply , cmd , args )
		local type = GetConVarString( "sbep_lift_designer_type" )
		local n = tonumber( args[1] )
		local D = args[2]
		--[[if n == 1 && D == "DOWN" then
			local NP = LiftSystem_SER:CreatePart()
		end]]
		
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
		if n == 1 && BEM[LiftSystem_SER.PT[2]:GetPartType()] then return end

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

	if CLIENT then return end
	local Editing = GetConVarNumber( "sbep_lift_designer_editing" )
	
	if Editing == 0 then
	
		local startpos = trace.HitPos
		local ply = self:GetOwner()
	
		LiftSystem_SER = ents.Create( "sbep_elev_system" )
			LiftSystem_SER:SetPos( startpos + Vector(0,0,4.65))
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
		
		PrintTable( LiftSystem_Ser:GetTable() )
	
		umsg.Start("SBEP_OpenLiftDesignMenu_cl", RecipientFilter():AddPlayer( ply ) )
			umsg.Entity( LiftSystem_SER )
		umsg.End()
		
		RCC( "SBEP_LiftGetCamHeight_ser" )
	
		RCC( "sbep_lift_designer_editing" , 1 )
	
		return true
	end
end

function TOOL:RightClick( trace )

	if CLIENT then return end

	local Editing = GetConVarNumber( "sbep_lift_designer_editing" )
	
	if Editing == 0 then
		local startent = trace.Entity
			if !startent || !(startent:IsValid()) then return end
		local ply = self:GetOwner()
		local model = startent:GetModel()
			if !LHMT[ model ] then return end
		local type = LHMT[model][1]
		local size = LHMT[model][2]
		local pos  = startent:GetPos()
		local ang  = startent:GetAngles()
		local skin = startent:GetSkin()
		if startent:SkinCount() > 5 then
			if math.fmod( skin / 2 ) ~= 0 then skin = skin - 1 end
			skin = skin / 2
		end
	
		LiftSystem_SER = ents.Create( "sbep_elev_system" )
			LiftSystem_SER:SetPos( pos - Vector(0,0,60.45))
			LiftSystem_SER:SetAngles( ang )
			LiftSystem_SER:SetModel( "models/SmallBridge/Elevators,Small/sbselevp3.mdl" )
			LiftSystem_SER.Skin = skin
			LiftSystem_SER.MDB  = true --Allow building downward
			LiftSystem_SER.Usable = GetConVarNumber( "sbep_lift_designer_enableuse" ) == 1
			LiftSystem_SER:SetSystemSize( size )
		LiftSystem_SER:Spawn()
		
		local hatchconvar = GetConVarNumber( "sbep_lift_designer_doors" )
		LiftSystem_SER.ST.UseHatches = hatchconvar == 2
		LiftSystem_SER.ST.UseDoors   = hatchconvar == 3	
		
		undo.Create( "SBEP Lift System" )
			undo.AddEntity( LiftSystem_SER )
			undo.SetPlayer( ply )
		undo.Finish()
		
		startent:Remove()
		
		local NP = LiftSystem_SER:CreatePart()
			LiftSystem_SER:AddPartToTable( NP , 1 )
			NP:SetPartType( type )
		LiftSystem_SER:RefreshParts( 1 )

		RCC( "sbep_lift_designer_activepart" , 1 )
		RCC( "sbep_lift_designer_type" , type )
		RCC( "SBEP_LiftConstructPart_ser" , 2 )
	
		umsg.Start("SBEP_OpenLiftDesignMenu_cl", RecipientFilter():AddPlayer( ply ) )
			umsg.Entity( LiftSystem_SER )
		umsg.End()
		
		RCC( "SBEP_LiftGetCamHeight_ser" )
	
		RCC( "sbep_lift_designer_editing" , 1 )
	
		return true
	end
end

function TOOL:Reload( trace )

end

function TOOL.BuildCPanel(panel)
	
	panel:SetSpacing( 10 )
	panel:SetName( "SBEP Lift System Designer" )
	
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	local SkinTable = {
			"Scrappers"  ,
			"Advanced"   ,
			"SlyBridge"  ,
			"MedBridge2" ,
			"Jaanus"
				}
	
	local SLV = vgui.Create("DListView")
		SLV:SetSize(100, 101)
		SLV:SetMultiSelect(false)
		SLV:AddColumn("Skin")
		SLV.OnClickLine = function(parent, line, isselected)
												parent:ClearSelection()
												line:SetSelected( true )
												RCC( "sbep_lift_designer_skin", line:GetID() - 1 )
										end
		 
		for k,v in ipairs( SkinTable ) do
			SLV:AddLine(v)
		end
	panel:AddItem( SLV )
	
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	local DoorTable = {
			"None"  			,
			"Shaft Hatches"   	,
			"Floor Doors"  		
				}

	local DLV = vgui.Create("DListView")
		DLV:SetSize(100, 67)
		DLV:SetMultiSelect(false)
		DLV:AddColumn("Doors and Hatches")
		DLV.OnClickLine = function(parent, line, isselected)
												parent:ClearSelection()
												line:SetSelected( true )
												RCC( "sbep_lift_designer_doors", line:GetID() )
										end
		 
		for k,v in ipairs( DoorTable ) do
			DLV:AddLine(v)
		end
	panel:AddItem( DLV )
	
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	local SizeTable = {
				"Small"  	,
				"Large"   		
				}

	local SiLV = vgui.Create("DListView")
		SiLV:SetSize(100, 50)
		SiLV:SetMultiSelect(false)
		SiLV:AddColumn("Size")
		SiLV.OnClickLine = function(parent, line, isselected)
												parent:ClearSelection()
												line:SetSelected( true )
												RCC( "sbep_lift_designer_size", line:GetID() )
										end
		 
		for k,v in ipairs( SizeTable ) do
			SiLV:AddLine(v)
		end
	panel:AddItem( SiLV )
	
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