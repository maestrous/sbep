SBEPDoc = {}

function SBEPDoc.OpenManual()

	if SBEPDoc.Menu then return false end
	
	SBEPDoc.Menu = vgui.Create( "DFrame" )
		SBEPDoc.Menu:SetPos( 50,50 )
		SBEPDoc.Menu:SetSize( 700, 500 )
		SBEPDoc.Menu:SetTitle( "SBEP Help Manual" )
		SBEPDoc.Menu:SetVisible( true )
		SBEPDoc.Menu:SetDraggable( false )
		SBEPDoc.Menu:ShowCloseButton( true )
		SBEPDoc.Menu:MakePopup()
		SBEPDoc.Menu:SetDeleteOnClose( true )
		SBEPDoc.Menu.btnClose.DoClick = function( button ) 
									SBEPDoc.Menu:Close()
									SBEPDoc.Menu = nil
								end

	SBEPDoc.ReloadDocs()
	
	SBEPDoc.Menu.Sheet = vgui.Create( "DPropertySheet" , SBEPDoc.Menu )
		SBEPDoc.Menu.Sheet:SetPos( 5, 28 )
		SBEPDoc.Menu.Sheet:SetSize( 690 , 467 )
		SBEPDoc.Menu.Sheet:SetFadeTime( 0 )

	SBEPDoc.Menu.Tabs = {}
	for n,D in ipairs( SBEPDoc.DirTable ) do
		local T = vgui.Create( "DPanel" )
		SBEPDoc.Menu.Tabs[ D ] = T
		SBEPDoc.Menu.Sheet:AddSheet( D , T , "gui/silkicons/brick_add" , false, false, D.." Help" )
		
		T.Panel = vgui.Create( "DPanelList" , T )
			T.Panel:SetPos( 130 , 5 )
			T.Panel:SetSize( 545 , 426 )
			--T.Panel.m_bgColor = Color( 50,50,50,255 )
			T.Panel:EnableVerticalScrollbar(true)
		
		T.Form = vgui.Create( "DForm" )
			T.Form:SetPos( 0, 0 )
			T.Form:SetSize( 545 , 426 )
			--T.Form:SizeToContents( false )
			T.Form:SetVerticalScrollbarEnabled(true)
			T.Form:SetSpacing( 15 )
			T.Form:SetPadding( 5 )
		T.Form.Text = {}
		T.Panel:AddItem( T.Form )
		
		T.ListB = vgui.Create( "DPanelList" , T )
			T.ListB:SetPos( 5 , 5 )
			T.ListB:SetSize( 120 , 426 )
			T.ListB:SetSpacing( 5 )
			T.ListB:SetPadding( 5 )
		T.Btns = {}
		for i,F in ipairs( SBEPDoc.DocTable[ D ] ) do
			local B = vgui.Create( "DButton" )
				T.Btns[ F ] = B
				B:SetText( string.sub(F, 1, -5) )
				B.DoClick = function( button )
								T.Form:Clear()
								T.Form:SetName( string.sub(F, 1, -5) )
								T.Form.Text = {}
								for k,P in ipairs( SBEPDoc.ProcessDoc( file.Read( "sbep_manual/"..D.."/"..F ) ) ) do
									local L = vgui.Create( "DLabel" , T )
										T.Form.Text[k] = L
										L:SetText( P[1] )
										L:SetSize( 430 , 10 )
										L:SizeToContentsY( true )
										L:SetMultiline( true )
										L:SetWrap(true)
										L:SetAutoStretchVertical(true)
									local I = nil
									if P[2] then
										I = vgui.Create( "DImage" )
											I:SetImage( P[2] )
											I:SetSize( 120,120 )
									end
									if P[3] == 1 && I then
										T.Form:AddItem( I , L)
									else
										T.Form:AddItem( L , I)
									end
								end
								
							end
			T.ListB:AddItem( B )
		end
	end
end

function SBEPDoc.ReloadDocs()
	SBEPDoc.DirTable = file.FindDir( "sbep_manual/*" )
	SBEPDoc.DirEnumTable = {}
	SBEPDoc.DocTable = {}
	SBEPDoc.DocEnumTable = {}
	for n,D in ipairs( SBEPDoc.DirTable ) do
		SBEPDoc.DirEnumTable[ D ] = n
		SBEPDoc.DocTable[ D ] = file.Find( "sbep_manual/"..D.."/*.txt" )
		SBEPDoc.DocEnumTable[ D ] = {}
		for i,F in ipairs( SBEPDoc.DocTable[ D ] ) do
			SBEPDoc.DocEnumTable[ D ][ F ] = i
		end
	end
end

function SBEPDoc.ProcessDoc( File )
	
	local PT = {}
	for s in string.gmatch( File , "/%*(%*?.-%*?)%*/") do
	
		s = string.gsub( s , "\n", "")
		
		local i = string.match( s , "%[IMG%](.*)%[/IMG%]"  )
		s = string.gsub( s , "%[IMG%].*%[/IMG%]" , "")
		
		if string.Left( s , 1) == "*" && string.Right( s , 1) == "*" then
			s = "---------------------------------------------------------------------------------------------------------------------------------\n    "..string.sub( s , 2 )
			s = string.sub( s , 1 , -2 ).."\n---------------------------------------------------------------------------------------------------------------------------------"
		end
		table.insert( PT , { s , i } )
	end
	return PT

end

function SBEPDoc.OpenPage( Dtab , page )

	SBEPDoc.ReloadDocs()

	if !SBEPDoc.DirEnumTable[ Dtab ] || !SBEPDoc.DocEnumTable[ Dtab ] || !SBEPDoc.DocEnumTable[ Dtab ][ page ] then return false end
	if !SBEPDoc.Menu then SBEPDoc.OpenManual() end
	
	SBEPDoc.Menu.Sheet:SetActiveTab( SBEPDoc.Menu.Sheet.Items[ SBEPDoc.DirEnumTable[ Dtab ] ].Tab )
	SBEPDoc.Menu.Tabs[ Dtab ].Btns[ page ]:DoClick()	

end

local function UMOpenPage( um )
	Dtab = um:ReadString()
	page = um:ReadString()
	SBEPDoc.OpenPage( Dtab , page )
end
usermessage.Hook( "SBEPDocOpenPage" , UMOpenPage )