include('shared.lua')
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
ENT.MatTab = {
	SWSH = { Material( "sprites/SWSHblue"		) , { 42 , 30 } } ,
	SWDH = { Material( "sprites/greensquare"	) , { 30 , 30 } } ,
	DWSH = { Material( "sprites/redsquare"		) , { 30 , 30 } } ,
	DWDH = { Material( "sprites/yellowsquare"	) , { 30 , 30 } }
			}

ENT.Mat = ENT.MatTab.SWSH

--ENT.Mat2 = Material( "cable/blue_elec" )

function ENT:Draw()

	local type = self:GetNWString( "SBEPSpriteType" )
	self.Mat = self.MatTab[ type ][1] or self.MatTab.SWSH
	local dim1 = self.MatTab[ type ][2][1]
	local dim2 = self.MatTab[ type ][2][2]
	
	render.SetMaterial( self.Mat )
	render.DrawSprite( self:GetPos() , dim1 , dim2 , Color(255,255,255,255) )

	--[[render.SetMaterial( self.Mat2 )
	render.DrawBeam( self:GetPos() , self:GetPos() + 50 * self:GetForward() , 10 , 0 , 0 , Color(255,255,255,255) )
	
	render.DrawBeam( self:GetPos() , self:GetPos() + 50 * self:GetUp() , 10 , 0 , 0 , Color(255,255,255,255) )]]

end