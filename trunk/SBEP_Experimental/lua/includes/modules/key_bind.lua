-- Key Bind module
local function endmodule()
	setfenv(2, _G);
end
local print, next, _G = print, next, _G
local tostring, pcall = tostring, pcall;
local pairs, ipairs = pairs, ipairs
local CurTime, LocalPlayer, RunConsoleCommand = CurTime, LocalPlayer, RunConsoleCommand
local function toconsole(b)
	if type(b) == 'boolean' then
		return b and "1" or "0"
	end
	return b
end
local function fromconsole(b)
	if b == "1" then return true  end
	if b == "0" then return false end
	return b
end
local getmetatable, setmetatable = getmetatable, setmetatable;
local rawget, type, select = rawget, type, select
local SERVER, CLIENT = SERVER, CLIENT;
local concommand, umsg = concommand, umsg;
local math, string, table = math, string, table;
local usermessage, hook, input = usermessage, hook, input;

module( 'key_bind' )

setmetatable(_M, _M)


-- k,v == id, table
binds = {};

BindMT = {
	id = "",
	tab = "Other",
	section = "Other",
	description = "",
	on_change = function(pl, bind, down) end,
	shared = false,
	entities = {},
	keys = {},
};
BindMT.__index = BindMT;


-- on_change = function(Player, Bind, WasPressed)

function Add(id, tab, section, description, on_change, shared)
	local bind
	if ( type(id == 'table') ) then
		bind = table.Copy(id);
	else
		bind = {id = id};
		if (tab)         then bind.tab = tab; end
		if (section)     then bind.section = section; end
		if (description) then bind.description = description; end
		if (on_change)   then bind.on_change = on_change; end
		if (shared)      then bind.shared = shared; end
	end
	
	setmetatable(bind, BindMT);

	binds[bind.id] = bind;

	if (SERVER and bind.shared) then
		AddClientside(bind)
	end

	return bind;
end

function Get(id)
	return binds[id]
end
function __call(...)
	return Get(...)
end

function GetBinds()
	local ret = {}

	for id, bind in pairs(binds) do
		local tab, section = bind.tab, bind.section
		if not ret[tab] then ret[tab] = {} end
		if not ret[tab][section] then ret[tab][section] = {} end
		ret[tab][section][id] = bind
	end

	return ret
end

function BindMT:__call(...)
	return self:IsDown(...)
end

-- on_change = function(entity, player, bind, down)
function BindMT:HookEntity(entity, on_change)
	if not rawget(self,'entities') then self.entities = {} end
	self.entities[entity] = on_change
end

if (SERVER) then

	function BindMT:IsDown(pl)
		return self.down[pl]
	end

	function BindMT:WasPressed(pl)
		return (CurTime() <= self.down_time[pl]) and self.down[pl];
	end

	function BindMT:WasReleased(pl)
		return (CurTime() <= self.down_time[pl]) and not self.down[pl];
	end

	concommand.Add("key_bind_update", function(pl, _, arg)
		--arg = {id, toconsole(value), pressed_key, pressed_type}
		--bind.down_time = Curtime()
		local bind = Get(arg[1])
		local value = fromconsole(arg[2])

		bind.down = bind.down or {}
		bind.down_time = bind.down_time or {}
		bind.down[pl] = value
		bind.down_time[pl] = CurTime()

		bind.on_change(pl, bind, value)

		for ent, func in pairs(bind.entities) do
			func(ent, pl, bind, value)
		end
	end, "not for player use")
	
	function AddClientside(bind,pl)
		umsg.Start("key_bind_AddClientBind",pl or RecipientFilter():AddAllPlayers())
			umsg.String(bind.id)
			umsg.String(bind.tab)
			umsg.String(bind.section)
			umsg.String(bind.description)
		umsg.End()
	end
end

if (CLIENT) then
	local function _BindPressed(keycomb)
		--print'Checking combination:'
		if type(keycomb) == 'number' then
			--print'Combination was single key'
			return input.IsKeyDown(keycomb)
		end
		for _, key in ipairs(keycomb) do
			if not input.IsKeyDown(key) then
				--print("Key",key,"Not Down")
				return false
			end
			--print("Key",key,"Is Down")
		end
		return true
	end

	local function _IsDown(bind)
		--print('Processing _IsDown on bind',bind.id)
		for _, keycomb in ipairs(bind.keys) do
			--print('Processing Combination', table.concat(keycomb, ' '))
			if (_BindPressed(keycomb)) then
				--print'Bind Down'
				return true
			end
			--print('Combination not pressed')
		end
		--print'Bind not Pressed'
		return false
	end

	function BindMT:IsDown()
		return self.down;
	end

	function BindMT:WasPressed()
		return (CurTime() <= self.down_time) and self.down;
	end

	function BindMT:WasReleased()
		return (CurTime() <= self.down_time) and not self.down;
	end

	function BindMT:AddKeyCombination(...)
		local key_comb = {...}
		if type(key_comb[1]) == 'table' then
			key_comb = key_comb[1]
		end
		if not rawget(self,'keys') then self.keys = {} end

		return table.insert(self.keys,key_comb)
	end

	function BindMT:RemoveKeyCombination(index)
		return table.remove(self.keys, index)
	end

	function BindMT:ReplaceKeyCombination(index, ...)
		local key_comb = {...}
		if type(key_comb[1]) == 'table' then
			key_comb = key_comb[1]
		end
		if not rawget(self,'keys') then self.keys = {} end

		self.keys[index] = key_comb
	end

	hook.Add("Think", "key_bind_Think", function()
		--print'KeyBind think running'
		for id, bind in pairs(binds) do
			--print("Bind", id)
			local value = _IsDown(bind)
			--print(value and "Down" or "Up")
			if (value ~= bind.down) then
				--print"Bind Changed"
				bind.down_time = CurTime()
				bind.down = value

				bind.on_change(LocalPlayer(), bind, value)
				
				for ent, func in pairs(bind.entities) do
					func(ent, LocalPlayer(), bind, value)
				end
				RunConsoleCommand("key_bind_update", id, toconsole(value))
			end
		end
	end)

	usermessage.Hook("key_bind_AddClientBind",function(um)
		local id = um:ReadString()
		if Get(id) then return end
		Add{id          = id,
			tab         = um:ReadString(),
			section     = um:ReadString(),
			description = um:ReadString()
		}
	end)

end

-- Handy Functions
-- Keys Iterator, skips non-key enums
local function keyIterate(state, last)
	local value
	while true do
		local k, v = next(state, last)
		if not k then return end
		if k:match'KEY_' then
			return k,v
		else
			last = k
		end
	end
end
function AllKeys()
	return keyIterate, _G, nil
end
local KeyToEnum = {}
for enum, key in AllKeys() do
	KeyToEnum[key] = enum
end
local KeyToName = {
	[1] = "0",
	[2] = "1",
	[3] = "2",
	[4] = "3",
	[5] = "4",
	[6] = "5",
	[7] = "6",
	[8] = "7",
	[9] = "8",
	[10] = "9",
	[11] = "A",
	[12] = "B",
	[13] = "C",
	[14] = "D",
	[15] = "E",
	[16] = "F",
	[17] = "G",
	[18] = "H",
	[19] = "I",
	[20] = "J",
	[21] = "K",
	[22] = "L",
	[23] = "M",
	[24] = "N",
	[25] = "O",
	[26] = "P",
	[27] = "Q",
	[28] = "R",
	[29] = "S",
	[30] = "T",
	[31] = "U",
	[32] = "V",
	[33] = "W",
	[34] = "X",
	[35] = "Y",
	[36] = "Z",
	[37] = "Num 0",
	[38] = "Num 1",
	[39] = "Num 2",
	[40] = "Num 3",
	[41] = "Num 4",
	[42] = "Num 5",
	[43] = "Num 6",
	[44] = "Num 7",
	[45] = "Num 8",
	[46] = "Num 9",
	[47] = "Num /",
	[48] = "Num *",
	[49] = "Num -",
	[50] = "Num +",
	[51] = "Num Enter",
	[52] = "Num .",
	[53] = "LBRACKET",
	[54] = "RBRACKET",
	[55] = ";",
	[56] = "'",
	[57] = "`",
	[58] = ",",
	[59] = ".",
	[60] = "/",
	[61] = "\\",
	[62] = "-",
	[63] = "=",
	[64] = "Enter",
	[65] = "Space",
	[66] = "Backspace",
	[67] = "Tab",
	[68] = "Caps lock",
	[69] = "Num lock",
	[70] = "Escape",
	[71] = "Scroll Lock",
	[72] = "Insert",
	[73] = "Delete",
	[74] = "Home",
	[75] = "End",
	[76] = "Page Up",
	[77] = "Page Down",
	[78] = "Break",
	[79] = "Left Shift",
	[80] = "Right Shift",
	[81] = "Left Alt",
	[82] = "Right Alt",
	[83] = "Left Control",
	[84] = "Right Control",
	[85] = "Left Super",
	[86] = "Right Super",
	[87] = "Application",
	[88] = "Up",
	[89] = "Left",
	[90] = "Donw",
	[91] = "Right",
	[92] = "F1",
	[93] = "F2",
	[94] = "F3",
	[95] = "F4",
	[96] = "F5",
	[97] = "F6",
	[98] = "F7",
	[99] = "F8",
	[100] = "F9",
	[101] = "F10",
	[102] = "F11",
	[103] = "F12",
--[[	Unusual Keys
	[104] = "CAPSLOCKTOGGLE",
	[105] = "NUMLOCKTOGGLE",
	[106] = "SCROLLLOCKTOGGLE",
	[107] = "COUNT",
	[114] = "XBUTTON_A",
	[115] = "XBUTTON_B",
	[116] = "XBUTTON_X",
	[117] = "XBUTTON_Y",
	[118] = "XBUTTON_LEFT_SHOULDER",
	[119] = "XBUTTON_RIGHT_SHOULDER",
	[120] = "XBUTTON_BACK",
	[121] = "XBUTTON_START",
	[122] = "XBUTTON_STICK1",
	[123] = "XBUTTON_STICK2",
	[153] = "XSTICK1_UP",
	[146] = "XBUTTON_UP",
	[147] = "XBUTTON_RIGHT",
	[155] = "XBUTTON_RTRIGGER",
	[148] = "XBUTTON_DOWN",
	[156] = "XSTICK2_RIGHT",
	[149] = "XBUTTON_LEFT",
	[157] = "XSTICK2_LEFT",
	[150] = "XSTICK1_RIGHT",
	[158] = "XSTICK2_DOWN",
	[151] = "XSTICK1_LEFT",
	[159] = "XSTICK2_UP",
	[152] = "XSTICK1_DOWN",
	[154] = "XBUTTON_LTRIGGER",
	[0] = "NONE",
--]]
}
function GetNameFromKey(key)
	return KeyToName[key]
end

endmodule()
return key_bind