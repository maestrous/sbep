-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
///																	SBEP Dev Library															      ///
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SBEP = SBEP or {} --Global Compatibility Check

function SBEP.T()
	return player.GetByID(1):GetEyeTrace()
end

function SBEP.TE()
	return player.GetByID(1):GetEyeTrace().Entity
end

function SBEP.TET()
	return player.GetByID(1):GetEyeTrace().Entity:GetTable()
end

function SBEP.PTET()
	return PrintTable( player.GetByID(1):GetEyeTrace().Entity:GetTable() )
end

function SBEP.Pressurise()
	table.insert(MasterPressureTable, SBEP.TE())
end

function SBEP.AddPressure( n )
	SBEP.TE().CPressure = SBEP.TE().CPressure + n
end


function SBEP.AmmoCrate(AT)
	if AT == 1 or AT == 2 or AT == 3 or AT == 4 or AT == 5 or AT == 6 or AT == 7 or AT == 8 or AT == 9 then
		local ply = player.GetByID(1)
		local NWeap = ents.Create( "item_ammo_crate" )
		if ( !NWeap:IsValid() ) then return end
		NWeap:SetKeyValue("AmmoType", AT or 1)
		NWeap.Entity:PhysicsInit( SOLID_VPHYSICS )
		NWeap.Entity:SetMoveType( MOVETYPE_VPHYSICS )
		NWeap.Entity:SetSolid( SOLID_VPHYSICS )
		NWeap:SetPos( ply:GetEyeTrace().HitPos + Vector(0,0,20) )
		NWeap:SetAngles( Angle(0,0,0) )
		NWeap:Spawn()
		NWeap:Activate()
		NWeap:GetPhysicsObject():Wake()
		NWeap:SetKeyValue("AmmoType", AT)
		NWeap.Entity:PhysicsInit( SOLID_VPHYSICS )
		NWeap.Entity:SetMoveType( MOVETYPE_VPHYSICS )
		NWeap.Entity:SetSolid( SOLID_VPHYSICS )
		undo.Create("Ammo Crate")
	    undo.AddEntity(NWeap)
	    undo.SetPlayer(ply)
		undo.Finish()
	end
end

function SBEP.Item(Item)
	local ply = player.GetByID(1)
	local NWeap = ents.Create( "SBEPInventoryItem" )
	if ( !NWeap:IsValid() ) then return end
	NWeap.ItemType = Item
	NWeap:SetPos( ply:GetEyeTrace().HitPos + Vector(0,0,math.random(0,60)) )
	NWeap:SetAngles( Angle(0,0,0) )
	NWeap:Spawn()
	NWeap:Activate()
	NWeap:Spawn()
	NWeap:Initialize()
	NWeap:Activate()
	NWeap:GetPhysicsObject():Wake()
	
	--print(NWeap:OBBMaxs())
	
	undo.Create(Item)
    undo.AddEntity(NWeap)
    undo.SetPlayer(ply)
	undo.Finish()
end
concommand.Add( "SBEPItem", SBEPItem )

function SBEP.ItemSpread()
	SBEPItem("P33 Pereira")
	SBEPItem("Turcotte SMG")
	SBEPItem("P33 Pereira")
	SBEPItem("Turcotte SMG")
	SBEPItem("Clark 15B")
	SBEPItem("Krylov FA-37")
	SBEPItem("Pilum H-AVR")
	SBEPItem("Scar 11")
	SBEPItem("Morretti SR4")
	SBEPItem("Park 52")
	SBEPItem("Bianchi FA-6")
	SBEPItem("Shuko K-80")
	SBEPItem("Ganz HMG")
end