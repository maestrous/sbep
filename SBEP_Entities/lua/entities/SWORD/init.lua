AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

util.PrecacheSound( "SB/SteamEngine.wav" )

function ENT:Initialize()
	
	self.Entity:SetModel( "models/Spacebuild/medbridge2_doublehull_elevatorclamp.mdl" ) 
	self.Entity:SetName("SWORD")
	self.BaseClass:Initialize(self)

	self.Speed = 0
	self.TSpeed = 90
	self.Active = false
	--self.Skewed = true
	self.HSpeed = 0
	
	self.HPC			= 5
	self.HP				= {}
	self.HP[1]			= {}
	self.HP[1]["Ent"]	= nil
	self.HP[1]["Type"]	= { "GatRight","Large", "Medium" }
	self.HP[1]["Pos"]	= Vector(-60,-140,30)
	self.HP[1]["Angle"] = Angle(0,0,180)
	self.HP[2]			= {}
	self.HP[2]["Ent"]	= nil
	self.HP[2]["Type"]	= { "GatLeft","Large", "Medium" }
	self.HP[2]["Pos"]	= Vector(-60,140,30)
	self.HP[2]["Angle"] = Angle(0,0,180)
	self.HP[3]			= {}
	self.HP[3]["Ent"]	= nil
	self.HP[3]["Type"]	= { "GatMid","Medium", "Heavy", "Vehicle" }
	self.HP[3]["Pos"]	= Vector(130,0,25)
	self.HP[3]["Angle"] = Angle(0,0,180)
	self.HP[4]			= {}
	self.HP[4]["Ent"]	= nil
	self.HP[4]["Type"]	= { "Small", "Tiny" }
	self.HP[4]["Pos"]	= Vector(215,-30,40)
	self.HP[4]["Angle"]	= Angle(0,0,90)
	self.HP[5]			= {}
	self.HP[5]["Ent"]	= nil
	self.HP[5]["Type"]	= { "Small", "Tiny" }
	self.HP[5]["Pos"]	= Vector(215,30,40)
	self.HP[5]["Angle"]	= Angle(0,0,270)
	
end

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	
	local ent = ents.Create( "SWORD" )
	ent:SetPos( Vector( 100000,100000,100000 ) )
	ent:Spawn()
	ent:Initialize()
	ent:Activate()
	ent.SPL = ply
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16 + Vector(0,0,50)
	
	local ent2 = ents.Create( "prop_vehicle_prisoner_pod" )
	--gamemode.Call("PlayerSpawnedVehicle",ply,ent2)
	ent2:SetModel( "models/Slyfo/sword.mdl" ) 
	ent2:SetPos( SpawnPos )
	ent2:SetKeyValue("vehiclescript", "scripts/vehicles/prisoner_pod.txt")
	ent2:SetKeyValue("limitview", 0)
	ent2.HasHardpoints = true
	ent2:Spawn()
	ent2:Activate()
	local TB = ent2:GetTable()
	TB.HandleAnimation = function (vec, ply)
		return ply:SelectWeightedSequence( ACT_HL2MP_SIT ) 
	end 
	ent2:SetTable(TB)
	ent2.SPL = ply
	ent2:SetNetworkedInt( "HPC", ent.HPC )
	--Networked so the client knows these values
	ent2:SetNetworkedEntity("ViewEnt",ent2)
	ent2:SetNetworkedInt( "OffsetOut", 600 )
	
	ent.Pod = ent2
	ent2.Cont = ent
	ent2.Pod = ent2
	--Constrain so they get duped together
	constraint.NoCollide( ent, ent2, 0, 0 )
	
	return ent
end
