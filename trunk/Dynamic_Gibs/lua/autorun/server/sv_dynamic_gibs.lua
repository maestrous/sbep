AddCSLuaFile("autorun/client/cl_dynamic_gibs.lua")

--Models that shouldn't Gib. There actually should be....alot.
local blacklist = {"ragdoll","player","npc","wreckedstuff"}

local function GibEntityRemove( ent )
	if (ent.GibTime and ent.GibTime >= CurTime()) and ent:IsValid() and (ent:Health() <= 0) and (ent:GetModel() ~= "") and (not IsPartiallyInTable(blacklist,ent:GetModel())) and (not IsPartiallyInTable(blacklist,ent:GetClass())) then	
		for k,v in pairs(player.GetAll()) do
			if v:GetInfo("cl_Dynamic_gibs") and v:GetInfo("cl_Dynamic_gibs") == "1" then
				DynamicGibEnt(ent,ply)
			end
		end
	end
end 
hook.Add("EntityRemoved","Dynamic_Gib_System_Hook",GibEntityRemove)

local function GibEntityData(ent, inflkr, atkr, amt, dmginfo)
	ent.GibTime = CurTime()+1
end
hook.Add("EntityTakeDamage","Dynamic_Gib_System_Data_Hook",GibEntityData)


function DynamicGibEnt(ent,ply)
	umsg.Start("gib_message", ply)
		umsg.Angle( ent:GetAngles() )
		umsg.Vector( ent:GetPos() )
		if ent.environment and ent.environment.IsSpace and ent.environment:IsSpace() then
			umsg.Bool(ent.environment:IsSpace())
		else
			umsg.Bool(false)
		end
		umsg.String(ent:GetModel())
		umsg.Short(ent:GetSkin())
	umsg.End() 
end 

function IsPartiallyInTable(tbl,str)
	if tbl and str then
		for k,v in pairs(tbl) do
			if type(v) == "string" then
				if string.find(string.lower(str),string.lower(v)) then return true end
			end
		end
	end
	return false
end

function SaveBlacklistToFile()
	file.Write("DynamicGibBlacklist.txt",glon.encode(blacklist))
end

function AddItemToBlacklist(ply,cmd,arg)
	if ply:IsAdmin() then
		if type(arg) == "table" then
			table.insert(blacklist,table.concat(arg," "))
		elseif type(arg) == "string" then
			table.insert(blacklist,arg)
		end
		SaveBlacklistToFile()
	end
end
concommand.Add("sv_dynamic_gibs_addtoblacklist",AddItemToBlacklist)

concommand.Add("sv_dynamic_gibs_printblacklist",function(ply,cmd,arg) 
	if ply:IsAdmin() then
		ply:ChatPrint("Dynamic Gib Mod by Levybreak, Current Serverside Gib Blacklist Banned Expressions:")
		for k,v in ipairs(blacklist) do
			ply:ChatPrint(v)
		end
	end
end)

hook.Add("InitPostEntity","Dynamic_Gibs_LoadConfig",function() 
	if file.Exists("DynamicGibBlacklist.txt") then
		blacklist = glon.decode(file.Read("DynamicGibBlacklist.txt"))
	end
	
	if gcombat then --we have gcombat... (this is so full of hax you should not read it for fear of utter confusion)
	local OldDevFunc = gcombat.devhit
	
	local lastEntCalled = nil
	local lastCallTS = 0
	local TSTolerance = 0.1
	function gcombat.devhit(e,d,p) --override the core hit functions
		OldDevFunc(e,d,p)
		lastEntCalled = e
		lastCallTS = CurTime()
	end
	function cbt_dealdevhit(e,d,p)
		OldDevFunc(e,d,p)
		lastEntCalled = e
		lastCallTS = CurTime()
	end
	
	local Entity = FindMetaTable("Entity")
	Entity.OldPreGCSetModel = Entity.SetModel
	function Entity:SetModel(str) --this is a fix for gcombat gibs not inheriting the parent's skin, it should work 99% of the time, unless someone's doing some wierd shit.
		if self:GetClass() == "wreckedstuff" and lastEntCalled and lastEntCalled:IsValid() and lastCallTS <= (CurTime() + TSTolerance) then
			if string.lower(str) == string.lower(lastEntCalled:GetModel()) then
				self:SetSkin(lastEntCalled:GetSkin())
			end
		end
		self:OldPreGCSetModel(str)
	end
	
	require("scripted_ents")
	
	local ENT = scripted_ents.Get("wreckedstuff") --override the model's init
	
	ENT.GCOldInit = ENT.Initialize
	
	function ENT:Initialize()
		if not self.copy then --we are the original, make the second half now.
		
			local PlaneNorm = Vector(math.Rand(0,1000),math.Rand(0,1000),math.Rand(0,1000)):Normalize()
		
			self:GCOldInit()
			self.brother = ents.Create("wreckedstuff")
			self.brother:SetModel( self:GetModel() )
			self.brother:SetAngles( self:GetAngles() )
			self.brother:SetPos( self:GetPos() )
			self.brother:SetSkin(self:GetSkin())
			self.brother.copy = true
			self.brother:Spawn()
			self.brother:Activate()
			local phys = self.brother:GetPhysicsObject()  	
			if (phys:IsValid()) then  		
				phys:Wake()
				phys:EnableGravity(false)
				phys:ApplyForceCenter(self:GetPhysicsObject():GetVelocity()+(PlaneNorm*20))
			end 
			
			SendUserMessage("ApplyClippingPlaneToGCObject",player.GetAll(),self:EntIndex(),PlaneNorm)
			SendUserMessage("ApplyClippingPlaneToGCObject",player.GetAll(),self.brother:EntIndex(),PlaneNorm*-1)
		else
			math.randomseed(CurTime())
			self.exploded = false
			self.fuseleft = CurTime() + 2
			self.deathtype = 0	
			self.Entity:PhysicsInit( SOLID_VPHYSICS )
			self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
			self.Entity:SetSolid( SOLID_VPHYSICS ) 
			self.Entity:SetColor(20,20,20,255)
			self.Entity:SetCollisionGroup( 0 )
		end
	end
	
	scripted_ents.Register(ENT,"wreckedstuff",true) --let's override it... hehehehe
end
end)