-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
///																	FIGHTERS																      ///
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local FighterTable = {}

	FighterTable[1] ={}



for k,v in pairs( FighterTable ) do
	list.Set( "SBEP_FighterModels", k , v )
end

--the information for making a fighter can just be a table
{
        name = "SWORD",
        parts = {
                {
                        ["model"] = "path to chair model",
                        ["type"] = "pilot",
                        ["pos"] = Vector(x,y,z),
                        ["ang"] = Angle(p,y,r)
                },
                {
                        ["model"] = "path to chair model",
                        ["type"] = "passenger",
                        ["pos"] = Vector(x,y,z),
                        ["ang"] = Angle(p,y,r)
                },
                {
                        ["model"] = "path to SWORD model",
                        ["type"] = "mount",
                        ["pos"] = Vector(x,y,z),
                        ["ang"] = Angle(p,y,r),
                        ["HP"] = {
                                {
                                        ["type"] = "weapon size",
                                        ["pos"] = Vector(x,y,z),
                                        ["ang"] = Angle(p,y,r)
                                },
                                {
                                        ["type"] = "weapon size",
                                        ["pos"] = Vector(x,y,z),
                                        ["ang"] = Angle(p,y,r)
                                }
                        }
                },
                {
                        ["model"] = "path to decorative part",
                        ["type"] = "prop",
                        ["pos"] = Vector(x,y,z),
                        ["ang"] = Angle(p,y,r)
                }
        }
}