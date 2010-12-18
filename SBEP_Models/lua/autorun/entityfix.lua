local oC = ents.Create
function ents.Create( sClass )
	return oC( string.lower( sClass ) )
end