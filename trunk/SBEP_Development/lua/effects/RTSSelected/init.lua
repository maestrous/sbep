

EFFECT.Mat = Material( "effects/select_ring" )

/*---------------------------------------------------------
   Initializes the effect. The data is a table of data 
   which was passed from the server.
---------------------------------------------------------*/
function EFFECT:Init( data )
	
	local size = 8
	
	local Pos = data:GetOrigin()
		
	self.Entity:SetPos( Pos )
	
	self.Entity:SetAngles( data:GetNormal():Angle() + Angle( 0.01, 0.01, 0.01 ) )
	
	self.Entity:SetParentPhysNum( data:GetAttachment() )
	
	if (data:GetEntity():IsValid()) then
		self.Entity:SetParent( data:GetEntity() )
	end
	
	self.Pos = data:GetOrigin()
	self.Normal = data:GetNormal()
	
	self.Speed = math.Rand( 0.5, 1.5 )
	self.Size = 1000
	self.Alpha = 255
	
	self.Life = CurTime() + 0.05
	
end


/*---------------------------------------------------------
   THINK
---------------------------------------------------------*/
function EFFECT:Think( )
	
	if (self.Life < CurTime() ) then return false end
	return true
	
end

/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render( )

	if (self.Alpha < 1 ) then return end

	render.SetMaterial( self.Mat )
	
	render.DrawQuadEasy( self.Entity:GetPos(),
						 Angle(0,0,0):Up(),
						 self.Size, self.Size,
						 Color( math.Rand( 10, 150), math.Rand( 170, 220), math.Rand( 240, 255), 50 ) )
						 
						

end
