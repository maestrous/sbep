require('key_bind')

PANEL = {}

AccessorFunc(PANEL, 'KeyList', 'KeyList')
AccessorFunc(PANEL, 'CurrentBind', 'Bind')
AccessorFunc(PANEL, 'BindLabel', 'BindLabel')

function PANEL:Init()
	local bindLabel = vgui.Create( "DLabel", self )
	bindLabel:SetText("Bind not Selected")
	bindLabel:SizeToContents()

	local keyList = vgui.Create( "DPanelList", self )

	local addButton = vgui.Create( "DButton", self )
		addButton:SetText("Add Key Combination")
		addButton:SizeToContents()
		addButton.DoClick = function()
			local keyEditor = vgui.Create'key_bind_KeyEditor'
			keyEditor.Bind = self:GetBind()
			keyEditor.Creator = self
		end

	self:SetBindLabel(bindLabel)
	self:SetKeyList(keyList)
	self.AddButton = addButton
end

function PANEL:SetBind( bind_id )
	local bind = key_bind.Get(bind_id)
	self.CurrentBind = bind

	local label = self.BindLabel
	label:SetText(bind.description)
	label:SizeToContents()

	self:RefreshBinds()
end

local function _makeRow(self, bind, index, keyComb)
	local row = vgui.Create('DPanelList')
	row:EnableHorizontal(true)
	row:SetSpacing(0)
	row:SetPadding(0)
	
	local removeButton = vgui.Create('DSysButton')
		removeButton:SetType('close')
		removeButton:SetSize(18,18)
		removeButton.DoClick = function()
			bind:RemoveKeyCombination(index)
			self:RefreshBinds()
		end
	local editButton = vgui.Create('DSysButton')
		editButton:SetType('question')
		editButton:SetSize(18,18)
		editButton.DoClick = function()
			local keyEditor = vgui.Create'key_bind_KeyEditor'
			keyEditor:SetKeys(table.Copy(keyComb))
			keyEditor.Bind = bind
			keyEditor.CombIndex = index
			keyEditor.Creator = self
		end

	local keyInfo
	if not type(keyComb) == 'table' then
		keyInfo = key_bind.GetNameFromKey(keyComb)
	else
		keyInfo = ""
		for i,key in ipairs(keyComb) do
			if i ~= 1 then
				keyInfo = keyInfo..' + '
			end
			keyInfo = keyInfo..key_bind.GetNameFromKey(key)
		end
	end

	local keyLabel = vgui.Create('DLabel')
		keyLabel:SetText(keyInfo)
		keyLabel:SizeToContents()

	row:SetWide(removeButton:GetWide()+editButton:GetWide()+keyLabel:GetWide()+2)
	row:AddItem(removeButton)
	row:AddItem(editButton)
	row:AddItem(keyLabel)

	return row
end

function PANEL:RefreshBinds()
	local keyList = self:GetKeyList()
	local bind = self:GetBind()
	keyList:Clear(true)

	-- Add All Keys
	for i, keyComb in ipairs(bind.keys) do
		keyList:AddItem( _makeRow(self, bind, i, keyComb) )
	end
	-- Add New Key Button
	--keyList:AddItem(  )

	self:InvalidateLayout()

	self:SizeToContents()
	self:TellParentAboutSizeChanges()
end

function PANEL:PerformLayout()
	local x,y = 0,0
	local label = self:GetBindLabel()
		label:SetPos(x,y)
		label:SetWide(self:GetWide())
		label:SizeToContentsY()
		y = y + label:GetTall()

	local keyList = self:GetKeyList()
		keyList:SetPos(x,y)
		keyList:SizeToContents()
		local maxwide = 0
		for _,pnl in pairs(keyList.Items) do
			if pnl:GetWide() > maxwide then maxwide = pnl:GetWide() end
		end
		keyList:SetWide( maxwide )
		y = y + keyList:GetTall()
	
	local addButton = self.AddButton
		addButton:SizeToContents()
		addButton:SetPos(self:GetWide()/2 - addButton:GetWide()/2, y)
end

function PANEL:SizeToContents()
	local label, kList = self:GetBindLabel(), self:GetKeyList():GetCanvas()
	self:SetWide( label:GetWide()>kList:GetWide() and label:GetWide() or kList:GetWide() )
	self:SetTall( label:GetTall() + kList:GetTall() + self.AddButton:GetTall() )
end

derma.DefineControl( "key_bind_QuickBind", "Key selection for a single bind", PANEL, "DPanel" )