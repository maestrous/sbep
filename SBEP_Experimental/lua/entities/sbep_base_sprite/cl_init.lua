include('shared.lua')
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
local MatTab = {
	SWSH = { Material( "sprites/SWSHblue"		) , { 42 , 30 } } ,
	SWDH = { Material( "sprites/SWDHgreen"		) , { 21 , 30 } } ,
	DWSH = { Material( "sprites/DWSHred"		) , { 42 , 15 } } ,
	DWDH = { Material( "sprites/DWDHyellow"		) , { 42 , 30 } } ,
	
	ESML = { Material( "sprites/ESML"			) , { 35 , 35 } } ,
	ELRG = { Material( "sprites/ELRG"			) , { 35 , 35 } } ,
	
	LRC1 = { Material( "sprites/ESML"			) , { 35 , 35 } } ,
	LRC2 = { Material( "sprites/ESML"			) , { 35 , 35 } } ,
	LRC3 = { Material( "sprites/ESML"			) , { 35 , 35 } } ,
	LRC4 = { Material( "sprites/ESML"			) , { 35 , 35 } } ,
	LRC5 = { Material( "sprites/ESML"			) , { 35 , 35 } } ,
	LRC6 = { Material( "sprites/ESML"			) , { 35 , 35 } } ,
			}

ENT.Mat = MatTab.SWSH[1]

--ENT.Mat2 = Material( "cable/blue_elec" )

function ENT:Draw()
	local type = self:GetNWString( "SBEPSpriteType" ) || "SWSH"
	self.Mat = MatTab[ type ][1]
	local dim1 = MatTab[ type ][2][1]
	local dim2 = MatTab[ type ][2][2]
	
	render.SetMaterial( self.Mat )
	render.DrawSprite( self:GetPos() , dim1 , dim2 , Color(255,255,255,255) )

	--render.SetMaterial( self.Mat2 )
	--render.DrawBeam( self:GetPos() , self:GetPos() + 50 * self:GetForward() , 10 , 0 , 0 , Color(255,255,255,255) )
	
	--render.DrawBeam( self:GetPos() , self:GetPos() + 30 * self:GetUp() , 10 , 0 , 0 , Color(255,255,255,255) )

end

function ENT:DrawTranslucent()

	self:Draw()

end