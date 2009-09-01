RTSSelectionMaterial = Material( "sprites/light_glow02_add" )

function RTSViewTrace()

	local AVec = gui.ScreenToVector( gui.MousePos() )
	AVec:Rotate( LocalPlayer():EyeAngles() * -1 )
	AVec:Rotate( Angle(0,90,0) )
	local trace = {}
	trace.start = LocalPlayer():GetShootPos() + LocalPlayer().BComp.CVVec
	trace.endpos = (LocalPlayer():GetShootPos() + LocalPlayer().BComp.CVVec) + (AVec * 65535)
	--trace.filter = self.FTab
	local tr = util.TraceLine( trace )

	return tr.HitPos
end

function SBEPRTS() --It stands for Spacebuild Enhancement Project - Real Time Strategy, in case you couldn't guess
	local ply = LocalPlayer()
	local PLVec = ply:GetVehicle()
	if PLVec && PLVec:IsValid() then
		local BComp = PLVec:GetNetworkedEntity( "BattleComputer" ) or nil
		local BCR = BComp:GetNetworkedBool( "BattleComputerActive" ) or false
		if BComp && BComp:IsValid() && BComp:GetNetworkedEntity( "BattleComputerPod" ) == PLVec then
			if BCR then
			
				--print(ply:EyeAngles())
				------------------------------------Preperation------------------------------------
				if !BComp.Prepped then
					BComp.CVVec = Vector(0,0,1000)
					BComp.Prepped = true
					ply.BComp = BComp
				end
				ply.BCMode = true
				
				
				------------------------------------HUD Initialization------------------------------------
				if !ply.BCOrderBox then
					local OBWidth = 400
					local OBHeight = 100
					ply.BCOrderBox = vgui.Create( "DFrame" )
				    ply.BCOrderBox:SetSize( OBWidth, OBHeight )
				    ply.BCOrderBox:SetPos( (ScrW() / 2) - (OBWidth / 2), ScrH() - OBHeight )
				    ply.BCOrderBox:SetVisible( true )
				    ply.BCOrderBox:ShowCloseButton( false )
				    ply.BCOrderBox:SetDraggable( false )
				    ply.BCOrderBox:SetTitle( "Set Stance:" )
				   	
				    local Button = vgui.Create( "Button", ply.BCOrderBox ) --Create a button that is attached to Frame 
				    Button:SetText( "Offence" ) --Set the button's text to "Click me!" 
				    Button:SetPos( 20, 35 ) --Set the button's position relative to it's parent(Frame) 
				    Button:SetWide( 80 ) --Sets the width of the button you're making 
					function Button:DoClick( ) --This is called when the button is clicked 
				    	--self:SetText( "Clicked" ) --Set the text to "Clicked"
				    	SBEPRTS_SetStance( 3, BComp )
					end
					local Button2 = vgui.Create( "Button", ply.BCOrderBox ) --Create a button that is attached to Frame 
				    Button2:SetText( "Defence" ) --Set the button's text to "Click me!" 
				    Button2:SetPos( 110, 35 ) --Set the button's position relative to it's parent(Frame) 
				    Button2:SetWide( 80 ) --Sets the width of the button you're making 
					function Button2:DoClick( ) --This is called when the button is clicked 
				    	SBEPRTS_SetStance( 2, BComp )
					end
					local Button3 = vgui.Create( "Button", ply.BCOrderBox ) --Create a button that is attached to Frame 
				    Button3:SetText( "Hold Fire" ) --Set the button's text to "Click me!" 
				    Button3:SetPos( 200, 35 ) --Set the button's position relative to it's parent(Frame) 
				    Button3:SetWide( 80 ) --Sets the width of the button you're making 
					function Button3:DoClick( ) --This is called when the button is clicked 
				    	SBEPRTS_SetStance( 1, BComp )
					end
					local Button4 = vgui.Create( "Button", ply.BCOrderBox ) --Create a button that is attached to Frame 
				    Button4:SetText( "Deactivate" ) --Set the button's text to "Click me!" 
				    Button4:SetPos( 290, 35 ) --Set the button's position relative to it's parent(Frame) 
				    Button4:SetWide( 80 ) --Sets the width of the button you're making 
					function Button4:DoClick( ) --This is called when the button is clicked 
				    	SBEPRTS_SetStance( 0, BComp )
					end
				end
				
				
				------------------------------------Display the HUD------------------------------------
				if ply.BCOrderBox then
					ply.BCOrderBox:SetVisible( true )
					gui.EnableScreenClicker( true )
				end
				
				
				------------------------------------Selection------------------------------------
				if input.IsMouseDown(MOUSE_FIRST) && !BComp.COrder then
					if !BComp.RTS_Selecting then
						--print("Mouse Start")
						if (gui.MouseY() < (ScrH() - 100)) then -- Note to self: Create a constant for the height/width of the various panels.

							BComp.RTS_Selecting = true
							BComp.RTS_SelStartP = RTSViewTrace() + Vector(0,0,20)
							
							--print(tr.HitPos)
						end
					else
						BComp.RTS_SelCurP = RTSViewTrace() + Vector(0,0,20)
						
						local effectdata = EffectData() 
						effectdata:SetOrigin( BComp.RTS_SelStartP ) 
						effectdata:SetStart( Vector(BComp.RTS_SelStartP.x,BComp.RTS_SelCurP.y,BComp.RTS_SelStartP.z) ) 
						util.Effect( "RTSSelection", effectdata )
						
						local effectdata = EffectData() 
						effectdata:SetOrigin( Vector(BComp.RTS_SelCurP.x,BComp.RTS_SelCurP.y,BComp.RTS_SelStartP.z) ) 
						effectdata:SetStart( Vector(BComp.RTS_SelStartP.x,BComp.RTS_SelCurP.y,BComp.RTS_SelStartP.z) ) 
						util.Effect( "RTSSelection", effectdata )
						
						local effectdata = EffectData() 
						effectdata:SetOrigin( Vector(BComp.RTS_SelCurP.x,BComp.RTS_SelCurP.y,BComp.RTS_SelStartP.z) ) 
						effectdata:SetStart( Vector(BComp.RTS_SelCurP.x,BComp.RTS_SelStartP.y,BComp.RTS_SelStartP.z) ) 
						util.Effect( "RTSSelection", effectdata )
						
						local effectdata = EffectData() 
						effectdata:SetOrigin( Vector(BComp.RTS_SelCurP.x,BComp.RTS_SelStartP.y,BComp.RTS_SelStartP.z) ) 
						effectdata:SetStart( BComp.RTS_SelStartP ) 
						util.Effect( "RTSSelection", effectdata )
						
						--This stuff is only here for debugging purposes
						/*
						if BComp.Sec1 then BComp.Sec1:Remove() end
						BComp.Sec1 = ClientsideModel("models/props_junk/PopCan01a.mdl", RENDERGROUP_OPAQUE)
						BComp.Sec1:SetPos(BComp.RTS_SelStartP)
						BComp.Sec1:SetMaterial("models/alyx/emptool_glow")
						BComp.Sec1:SetModelScale(Vector(10,10,10))
						
						if BComp.Sec2 then BComp.Sec2:Remove() end
						BComp.Sec2 = ClientsideModel("models/props_junk/PopCan01a.mdl", RENDERGROUP_OPAQUE)
						BComp.Sec2:SetPos(Vector(BComp.RTS_SelCurP.x,BComp.RTS_SelCurP.y,BComp.RTS_SelStartP.z))
						BComp.Sec2:SetMaterial("models/alyx/emptool_glow")
						BComp.Sec2:SetModelScale(Vector(10,10,10))
						
						if BComp.Sec3 then BComp.Sec3:Remove() end
						BComp.Sec3 = ClientsideModel("models/props_junk/PopCan01a.mdl", RENDERGROUP_OPAQUE)
						BComp.Sec3:SetPos(Vector(BComp.RTS_SelStartP.x,BComp.RTS_SelCurP.y,BComp.RTS_SelStartP.z))
						BComp.Sec3:SetMaterial("models/alyx/emptool_glow")
						BComp.Sec3:SetModelScale(Vector(10,10,10))
						
						if BComp.Sec4 then BComp.Sec4:Remove() end
						BComp.Sec4 = ClientsideModel("models/props_junk/PopCan01a.mdl", RENDERGROUP_OPAQUE)
						BComp.Sec4:SetPos(Vector(BComp.RTS_SelCurP.x,BComp.RTS_SelStartP.y,BComp.RTS_SelStartP.z))
						BComp.Sec4:SetMaterial("models/alyx/emptool_glow")
						BComp.Sec4:SetModelScale(Vector(10,10,10))
						*/
						
					end
				else
					
					if BComp.RTS_Selecting then
						BComp.UnitsSelected = {}
						local FEnts = ents.FindInBox( BComp.RTS_SelStartP - Vector(0,0,10000), BComp.RTS_SelCurP + Vector(0,0,10000) ) 
						for _,i in ipairs(FEnts) do
							print(i:GetClass())
							local Com = i.BCCommandable
							print(Com)
							--if table.HasValue( CommandableUnits, i:GetClass() ) then
							if Com then
								table.insert( BComp.UnitsSelected, i )
							end
							--LocalPlayer():ConCommand("RTSSelection "..BComp.RTS_SelStartP.x.." "..BComp.RTS_SelStartP.y.." "..BComp.RTS_SelStartP.z.." "..BComp.RTS_SelCurP.x.." "..BComp.RTS_SelCurP.y.." "..BComp.RTS_SelCurP.z)
							PrintTable(BComp.UnitsSelected)
						end
						 
					end
					
					BComp.RTS_Selecting = false
					
				end
				
				
				
				if input.IsMouseDown(MOUSE_FIRST) && BComp.COrder then
					
				end
				
				
				if input.IsMouseDown(MOUSE_RIGHT) then
					BComp.AltC = true
				else
					if BComp.AltC then
						local trace = RTSViewTrace()
						--LocalPlayer():ConCommand("IssueRTSOrder "..trace.x.." "..trace.y.." "..trace.z)
						SBEPRTS_IssueOrder( trace + Vector(0,0,500), BComp, 1 )
						local effectdata = EffectData() 
						effectdata:SetOrigin( trace )
						util.Effect( "RTSOrder", effectdata )
						BComp.AltC = false
					end
				end
				
				------------------------------------Scrolling------------------------------------
				local Y,X = gui.MousePos()
				if X < 50 then
					BComp.CVVec.x = BComp.CVVec.x + ( ( ( 50 - X ) * 0.5 ) * 5 )
					if BComp.CVVec.x > 6000 then
						BComp.CVVec.x = 6000
					end
				elseif X > ( ScrH() - 20 ) then
					BComp.CVVec.x = BComp.CVVec.x - ( ( ( X - ( ScrH() - 20 ) ) * 0.5 ) * 5 )
					if BComp.CVVec.x < -6000 then
						BComp.CVVec.x = -6000
					end
				end
				if Y < 50 then
					BComp.CVVec.y = BComp.CVVec.y + ( ( ( 50 - Y ) * 0.5 ) * 5 )
					if BComp.CVVec.y > 6000 then
						BComp.CVVec.y = 6000
					end
				elseif Y > ( ScrW() - 20 ) then
					BComp.CVVec.y = BComp.CVVec.y - ( ( ( Y - ( ScrW() - 50 ) ) * 0.5 ) * 5 )
					if BComp.CVVec.y < -6000 then
						BComp.CVVec.y = -6000
					end
				end
				
				
				------------------------------------Selection Display------------------------------------
				BComp.UnitsSelected = BComp.UnitsSelected or {}
				for _,i in ipairs(BComp.UnitsSelected) do
					if i && i:IsValid() then
						local effectdata = EffectData() 
						effectdata:SetOrigin( i:GetPos() ) --
						effectdata:SetStart( i:GetPos() ) 
						util.Effect( "RTSSelected", effectdata )
					end
				end
				
			else
				if ply.BCOrderBox then
					ply.BCOrderBox:SetVisible( false )
					gui.EnableScreenClicker( false )
				end
				ply.BCMode = false
				BComp.Prepped = false
			end
		else
			if ply.BCOrderBox then
				ply.BCOrderBox:SetVisible( false )
				gui.EnableScreenClicker( false )
			end
			ply.BCMode = false
		end
	else
		if ply.BCOrderBox then
			ply.BCOrderBox:SetVisible( false )
			gui.EnableScreenClicker( false )
		end
		ply.BCMode = false
	end
end

hook.Add("Think", "SBEPRTS", SBEPRTS)

--function SBEPRTSHud() 
	--Turns out this wasn't needed after all. I'm leaving it commented out, in case it ever turns out to be useful.	
--end 
--hook.Add("HUDPaint", "SBHud", SBHud)

function RTSC()
	local ply = LocalPlayer()
	ply.BCOrderBox:SetVisible( false )
	ply.BCOrderBox:Remove()
	ply.BCOrderBox = nil
end

function SBEPRTS_SetStance( Stance, Computer )
	for _,i in ipairs(Computer.UnitsSelected) do
		if i && i:IsValid() then
			LocalPlayer():ConCommand("RTSSetStance "..i:EntIndex().." "..Stance)
		end
	end
end

function SBEPRTS_IssueOrder( Vector, Computer, OrderType )
	for _,i in ipairs(Computer.UnitsSelected) do
		if i && i:IsValid() then
			LocalPlayer():ConCommand("IssueRTSOrder "..i:EntIndex().." "..Vector.x.." "..Vector.y.." "..Vector.z.." "..OrderType)
		end
	end
end

function SBEPBMView( ply, origin, angles, fov ) 
	if ply.BCMode then
		if ply.BComp && ply.BComp:IsValid() then
			
		 	origin = origin + ply.BComp.CVVec
			angles = Angle(90,0,0) 
		end
	end
	
	return GAMEMODE:CalcView(ply,origin,angles,fov)
end 
   
hook.Add("CalcView", "SBEPBMView", SBEPBMView)  