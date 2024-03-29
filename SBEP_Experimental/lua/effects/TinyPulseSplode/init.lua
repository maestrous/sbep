
 /*--------------------------------------------------------- 
    Initializes the effect. The data is a table of data  
    which was passed from the server. 
 ---------------------------------------------------------*/ 
function EFFECT:Init( data ) 
 	 
 	-- This is how long the spawn effect
 	-- takes from start to finish.
 	self.Time = .25
 	self.LifeTime = CurTime() + self.Time
	self.CScale = 0.6
	self.SpawnTime = CurTime()
 	
 	self.vOffset = data:GetOrigin()
 	self.vAng = data:GetAngle()
 	self.vFw = self.vAng:Forward()
 	self.vUp = self.vAng:Up()
 	self.vRi = self.vAng:Right()
 	
 	self.Magn = data:GetMagnitude() or 1
 	
 	local CVel = self.Magn * 50
	
	self.emitter = ParticleEmitter( self.vOffset )
	local scount = math.random(20,25)
		for i = 0, scount do
			
			local particle3 = self.emitter:Add( "effects/spark", self.vOffset )
			if (particle3) then
				particle3:SetVelocity( self.vFw * math.Rand(-10, -CVel) + self.vUp * math.Rand(-CVel, CVel) + self.vRi * math.Rand(-CVel, CVel) )
				particle3:SetLifeTime( 0 )
				particle3:SetDieTime( math.Rand( self.Magn, self.Magn * 1.5 ) )
				particle3:SetStartAlpha( math.Rand( 200, 255 ) )
				particle3:SetEndAlpha( 0 )
				particle3:SetStartSize( 5 )
				particle3:SetEndSize( 0 )
				particle3:SetRoll( math.Rand(0, 360) )
				particle3:SetRollDelta( math.Rand(-0.2, 0.2) )
				particle3:SetColor( 255 , 255 , 255 )
			end
			
		end
		
	self.emitter:Finish()
	self.Entity:SetColor(255,100,100,100)
 	self.Entity:SetModel( "models/Combine_Helicopter/helicopter_bomb01.mdl" )
 	self.Entity:SetMaterial("models/alyx/emptool_glow")
 	self.Entity:SetPos( self.vOffset )  
end 
   
   
 /*--------------------------------------------------------- 
    THINK 
    Returning false makes the entity die 
 ---------------------------------------------------------*/ 
function EFFECT:Think( )
	--self.Entity:SetColor(255,100,100,100)
	--self.CScale = (self.CScale + (self.Magn * 0.1)) * (CurTime() - self.SpawnTime)
	--print(CurTime() - self.SpawnTime)
	--self.Entity:NextThink( CurTime() + 0.01 )
	return ( self.LifeTime > CurTime() )  	 
end 
   
   
   
 /*--------------------------------------------------------- 
    Draw the effect 
 ---------------------------------------------------------*/ 
function EFFECT:Render()
	self.CScale = 2 * ((CurTime() - self.SpawnTime) / self.Time)
	self.Entity:SetModelWorldScale( Vector(self.CScale,self.CScale,self.CScale) )
	self:DrawModel()
end  