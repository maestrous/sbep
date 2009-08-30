-- Key Bind module
local function endmodule()
	setfenv(2, _G);
end
local print = print
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

function BindMT:AddKeyCombination(...)
	local key_comb
	if type(select(1,...)) == 'table' then
		key_comb = select(1,...)
	else
		key_comb = {...}
	end
	if not rawget(self,'keys') then self.keys = {} end

	return table.insert(self.keys,key_comb)
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

endmodule()
return key_bind