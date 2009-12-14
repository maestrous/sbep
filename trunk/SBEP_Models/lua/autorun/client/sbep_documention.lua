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
									SBEPDoc.CloseManual()
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
			T.Panel:EnableVerticalScrollbar(true)
		
		T.Form = vgui.Create( "DForm" )
			T.Form:SetPos( 0, 0 )
			T.Form:SetSize( 545 , 426 )
			T.Form:SetSpacing( 15 )
			T.Form:SetPadding( 5 )
		T.Form.Text = {}
		T.Panel:AddItem( T.Form )
		
		T.Form:SetName( "SBEP User Manual" )
		SBEPDoc.ClickPage( "sbep_manual/startup.txt" , "SBEP User Manual" , T.Form )
		
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
								SBEPDoc.ClickPage( "sbep_manual/"..D.."/"..F , string.sub(F, 1, -5) , T.Form )
							end
			T.ListB:AddItem( B )
		end
	end
	
	local SearchTab = vgui.Create( "DPanelList" )
		SBEPDoc.Menu.Search = SearchTab
		SearchTab:SetPadding( 5 )
		SearchTab:SetSpacing( 20 )
		SBEPDoc.Menu.Sheet:AddSheet( "Search" , SearchTab , "gui/silkicons/magnifier" , false, false, "Search for relevant topics." )
		
	local Form = vgui.Create( "DForm" )
		SBEPDoc.Menu.Search.Form = Form
		Form:SetName( "Search" )
		Form:SetSize( 680 , 10 )
		Form:SetSpacing( 15 )
		Form:SetPadding( 5 )
	SBEPDoc.Menu.Search:AddItem( Form )
	
	local SearchEntry = vgui.Create( "DTextEntry" )
		SBEPDoc.Menu.Search.TEntry = SearchEntry
		SearchEntry:SetWide( 590 )
		SearchEntry.OnEnter = function()
									local R, ser = SBEPDoc.SearchWiki( SearchEntry:GetValue() )
									print( R, ser )
									for k,L in ipairs( SBEPDoc.Menu.Search.Items ) do
										if k > 1 then
											L:Remove()
										end
									end

									if R then
										print( "results" )
										for n,T in ipairs( R ) do
											local P = vgui.Create( "DPanel" )
												P:SetSize( 600, 80 )
											SBEPDoc.Menu.Search:AddItem( P )
											
											local LinkBtn = vgui.Create( "DButton" , P)
												LinkBtn:SetText( T[1]..": "..string.sub(T[2], 1, -5))
												LinkBtn:SetPos( 20, 20 )
												LinkBtn:SetSize( 500, 40 )
												--LinkBtn:SizeToContentsX( true )
												LinkBtn.DoClick = function()
																	SBEPDoc.OpenPage( T[1] , T[2] )
																end
										end
									else
										print( "no results" )
										local P = vgui.Create( "DPanel" )
												P:SetSize( 600, 80 )
											SBEPDoc.Menu.Search:AddItem( P )
											
											local LinkBtn = vgui.Create( "DLabel" , P)
												LinkBtn:SetText( "No results found for '"..ser.."'." )
												LinkBtn:SetPos( 20, 20 )
												LinkBtn:SetSize( 500, 40 )
									end
								end
	
	local SearchBtn = vgui.Create( "DButton" )
		SBEPDoc.Menu.Search.Btn = SearchBtn
		SearchBtn:SetText( "Search" )
		SearchBtn.DoClick = function()
									SearchEntry:OnEnter()
								end
	Form:AddItem( SearchEntry , SearchBtn )
	
end
usermessage.Hook( "SBEPDocOpenManual" , SBEPDoc.OpenManual )
concommand.Add( "sbep_doc_openmanual" , SBEPDoc.OpenManual )

function SBEPDoc.ClickPage( File , name , Form )
	Form:Clear()
	Form:SetName( name )
	Form.Text = {}
	for k,P in ipairs( SBEPDoc.ProcessDoc( file.Read( File ) ) ) do
		local para = P[1]
		local image = P[2]
		local sizex = P[3]
		local sizey = P[4]
		local H = P[5]
		local label = vgui.Create( "DLabel" )
			Form.Text[k] = label
			label:SetText( para )
			if H then
				label:SetFont( "MenuLarge" )
			end
			label:SetSize( 430 , 10 )
			label:SizeToContentsY( true )
			label:SetMultiline( true )
			label:SetWrap(true)
			label:SetAutoStretchVertical(true)
		local Dimage = nil
		if image then
			Dimage = vgui.Create( "DImage" )
				Dimage:SetImage( image )
				Dimage:SetSize( sizex , sizey )
		end
		Form:AddItem( label  , Dimage)
	end
end

function SBEPDoc.CloseManual()
	if SBEPDoc.Menu then
		SBEPDoc.Menu:Close()
		SBEPDoc.Menu = nil
	end
end
usermessage.Hook( "SBEPDocCloseManual" , SBEPDoc.CloseManual )
concommand.Add( "sbep_doc_closemanual" , SBEPDoc.CloseManual )

function SBEPDoc.ToggleManual( um )
	if SBEPDoc.Menu then
		SBEPDoc.CloseManual()
	else
		SBEPDoc.OpenManual()
	end
end
usermessage.Hook( "SBEPDocToggleManual" , SBEPDoc.ToggleManual )
concommand.Add( "sbep_doc_togglemanual" , SBEPDoc.ToggleManual )

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
			SBEPDoc.RebuildTags( D , F )
			SBEPDoc.DocEnumTable[ D ][ F ] = i
		end
	end
end

function SBEPDoc.ProcessDoc( File )
	
	local PT = {}
	for s in string.gmatch( File , "/%*(%*?.-%*?)%*/") do
	
		s = string.gsub( s , "\n", "")
		
		local i = string.match( s , "%[IMG%](.*)%[/IMG%]"  )
		local iS = 3
		if i then
			iS = tonumber( string.match( i , "%[size%s*=%s*(%d)%]"  ) || 3 )
			i = string.gsub( i , "%[size%s*=%s*(%d)%]" , "")
		end
		iSx = 30 + 15 * iS
		iSy = 30 + 15 * iS
		s = string.gsub( s , "%[IMG%].*%[/IMG%]" , "")
		local H = false
		if string.Left( s , 1) == "*" && string.Right( s , 1) == "*" then
			H = true
			if i then
				local dl1 = "-------------------------------------------------------\n"
				local ml  = "    "..string.sub( s , 2 , -2 )
				local dl2 = "\n-------------------------------------------------------"
				if iS > 2 then
					dl1 = dl1.."\n"
					dl2 = "\n"..dl2
				end
				if (iS/3) >= 3 then
					dl1 = "\n\n\n"..dl1
				elseif (iS/3.4) > 2 then
					dl1 = "\n\n"..dl1
				elseif (iS/4) > 1 then
					dl1 = "\n"..dl1
				end
				s = dl1..ml..dl2
			else
				s = "--------------------------------------------------------------------------------------\n    "..string.sub( s , 2 )
				s = string.sub( s , 1 , -2 ).."\n--------------------------------------------------------------------------------------"
			end
		end
		table.insert( PT , { s , i , iSx , iSy , H } )
	end
	return PT

end

function SBEPDoc.OpenPage( Dtab , page )

	SBEPDoc.ReloadDocs()
	
	if Dtab == "Search" then
		if !SBEPDoc.Menu then SBEPDoc.OpenManual() end
		SBEPDoc.Menu.Sheet:SetActiveTab( SBEPDoc.Menu.Sheet.Items[ #SBEPDoc.Menu.Sheet.Items ].Tab )
	end
	
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
concommand.Add( "SBEPDoc_OpenPage" , UMOpenPage )

function SBEPDoc.RebuildTags( Dir , File )
	if !SBEPDoc.Tags then SBEPDoc.Tags = {} end
	if !SBEPDoc.Tags[ Dir ] then SBEPDoc.Tags[ Dir ] = {} end
	local text = file.Read( "sbep_manual/"..Dir.."/"..File )
		local t = string.match( text , "<t>(.*)</t>" )
	if t then
		SBEPDoc.Tags[ Dir ][ File ] = {}
		--for tag in string.gmatch(t, ".-%s") do
		for tag in string.gmatch(t, "%S+") do
			table.insert( SBEPDoc.Tags[ Dir ][ File ] , string.lower( tag ) )
		end
	end
	return SBEPDoc.Tags[ Dir ][ File ]
end

function SBEPDoc.SearchWiki( search )

	if !SBEPDoc.Menu then return {} end

	local SerTab = {}
	for i in string.gmatch( search , "%S+") do
		table.insert( SerTab , string.lower( i ) )
	end

	local Results = {}
	for D,fl in pairs( SBEPDoc.Tags ) do
		for F,tt in pairs( fl ) do
			for n, tag in ipairs( tt ) do
				for k, S in ipairs( SerTab) do
					if tag == S then
						table.insert( Results , { D , F } )
					end
				end
			end
		end
	end
	if #Results == 0 then 
		return nil, search
	end
	
	return Results, search
end

function SBEPDoc.OpenSearch( search )

	SBEPDoc.OpenPage( "Search" )
	SBEPDoc.Menu.Search.TEntry:SetValue( search )
	SBEPDoc.Menu.Search.TEntry:OnEnter()

end

local function UMOpenSearch( um )
	SBEPDoc.OpenSearch( um:ReadString() )
end
usermessage.Hook( "SBEPDocOpenSearch" , UMOpenSearch )










