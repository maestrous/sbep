include('shared.lua')
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
ENT.MatTab = {
	SWSH = Material( "sprites/bluesquare"    ) ,
	SWDH = Material( "sprites/greensquare"   ) ,
	DWSH = Material( "sprites/redsquare"     ) ,
	DWDH = Material( "sprites/yellowsquare"  )
			}

ENT.Mat = ENT.MatTab.SWSH

ENT.Mat2 = Material( "cable/blue_elec" )

function ENT:Draw()

	self.Mat = self.MatTab[ self:GetNWString( "SBEPSpriteType" ) ]
	
	render.SetMaterial( self.Mat )
	render.DrawSprite( self:GetPos() , 30 , 30 , Color(255,255,255,255) )

	render.SetMaterial( self.Mat2 )
	render.DrawBeam( self:GetPos() , self:GetPos() + 50 * self:GetForward() , 10 , 0 , 0 , Color(255,255,255,255) )
	
	render.DrawBeam( self:GetPos() , self:GetPos() + 50 * self:GetUp() , 10 , 0 , 0 , Color(255,255,255,255) )

end