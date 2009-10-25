PANEL = {}

AccessorFunc(PANEL,'Keys','Keys')
AccessorFunc(PANEL,'KeyLine','KeyLine')

function PANEL:Init()
	--self.BaseClass.Init(self)
	self:SetTitle("Key Combination Editor")
	self.Keys = {}

	local descriptionLabel = vgui.Create("DLabel",self)
		descriptionLabel:SetAutoStretchVertical(true)
		descriptionLabel:SetText[[
To add Keys press the + button with the key held down]]
	self.DescriptionLabel = descriptionLabel

	local confirmButton = vgui.Create("DButton",self)
		confirmButton:SetText'Confirm'
		confirmButton.DoClick = function()
			if not self.CombIndex then
				self.Bind:AddKeyCombination(self.Keys)
			else
				self.Bind:ReplaceKeyCombination(self.CombIndex, self.Keys)
			end
			self.Creator:RefreshBinds()
			self.Creator:SizeToContents()
			self:Close()
		end
	self.ConfirmButton = confirmButton

	local cancelButton = vgui.Create("DButton",self)
		cancelButton:SetText'Cancel'
		cancelButton.DoClick = function() self:Close() end
	self.CancelButton = cancelButton

	local addButton = vgui.Create("DButton",self)
		addButton.DoClick = function()
			for _, key in key_bind.AllKeys() do
				if input.IsKeyDown(key) and not table.HasValue(self.Keys, key) then
					table.insert(self.Keys, key)
					self:RefreshKeys()
					break
				end
			end
		end
		addButton:SetText'+'
		addButton:SizeToContents()
	self.AddButton = addButton

	local keyLine = vgui.Create("DPanelList",self)
		keyLine:SetPadding(2)
		keyLine:SetSpacing(4)
		keyLine:EnableHorizontal(true)
		keyLine:SetAutoSize(true)
	self.KeyLine = keyLine

	self:SetSize(100,100)
	self:RefreshKeys()
	self:Center()
end

function PANEL:SetKeys(keyComb)
	self.Keys = keyComb
	self:RefreshKeys()
end

function PANEL:RefreshKeys()
	local keyLine = self:GetKeyLine()
		keyLine:Clear()
		for i, key in ipairs(self.Keys) do
			local keyButton = vgui.Create("DButton")
			keyButton:SetText(key_bind.GetNameFromKey(key))
			keyButton:SizeToContents()
			keyButton.DoClick = function()
				table.remove(self.Keys, i)
				self:RefreshKeys()
			end
			keyLine:AddItem(keyButton)
		end
		keyLine:AddItem(self.AddButton)
end

function PANEL:PerformLayout()
	self.BaseClass.PerformLayout(self)

	local x,y = 0, 20
	local label = self.DescriptionLabel
		label:SizeToContents()
		label:SetWide(self:GetWide())
		label:SetPos(x,y)
		y = y + label:GetTall()

	local keyLine = self:GetKeyLine()
		keyLine:SetPos(x,y)
		keyLine:SetWide(self:GetWide())
		y = y + keyLine:GetTall()

	local confirm, cancel = self.ConfirmButton, self.CancelButton
		confirm:SizeToContents()
		cancel:SizeToContents()
		cancel:SetPos(self:GetWide()/2 - (cancel:GetWide()+confirm:GetWide())/2 - cancel:GetWide()/2  ,y)
		confirm:SetPos(self:GetWide()/2 - (cancel:GetWide()+confirm:GetWide())/2 + confirm:GetWide()/2  ,y)
end

derma.DefineControl( "key_bind_KeyEditor", "Pop-up for modifying key combinations", PANEL, "DFrame" )