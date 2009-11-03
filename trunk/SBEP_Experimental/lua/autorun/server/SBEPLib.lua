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