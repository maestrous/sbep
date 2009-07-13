AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" ) 

ENT.WireDebugName = "SBEP Door"

function ENT:InitDoorData( DoorData )
	
	if !DoorData or type( DoorData ) != "table" or #DoorData < 4 then return end
	
	self.DoorModel			= DoorData[1]
	self.OpenStatus      	= false
	self.Locked     		= false
	self.DisableUse 		= false
	self.UseDelay		 	= DoorData[2]
	self.OpenDelay			= DoorData[3]
	self.CloseDelay			= DoorData[4]
	
	self:SetModel( self.DoorModel )
	
	self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		
		local phys = self:GetPhysicsObject()  	
		if (phys:IsValid()) then  		
			phys:Wake()  
			phys:EnableGravity(false)			
		end
	
end

function ENT:OpenDoorSounds()

	self:EmitSound( self.OpenSounds[0] )
	for k,v in pairs( self.OpenSounds ) do
		timer.Simple( k , function()
							self:EmitSound( v )
						end )
	end

end

function ENT:CloseDoorSounds()

	self:EmitSound( self.CloseSounds[0] )
	for k,v in pairs( self.CloseSounds ) do
		timer.Simple( k , function()
							self:EmitSound( v )
						end )
	end

end

function ENT:GetSequenceData()

	self.OpenSequence = self:LookupSequence( "open" )
	self.CloseSequence = self:LookupSequence( "close" )

end

function ENT:Open()

	self:ResetSequence( self.OpenSequence )
		self:OpenDoorSounds()
		timer.Simple( self.OpenDelay , function()
							self:SetNotSolid( true )
						end)
		timer.Simple( self.UseDelay , function()
							self.OpenStatus = true
							WireLib.TriggerOutput(self.Controller,"Open_"..tostring( self.SysDoorNum ),1)
						end)
	WireLib.TriggerOutput(self.Controller,"Open_"..tostring( self.SysDoorNum ),0.5)

end

function ENT:Close()

	self:ResetSequence( self.CloseSequence )
		self:CloseDoorSounds()
		timer.Simple( self.CloseDelay , function()
							self:SetNotSolid( false )
						end)
		timer.Simple( self.UseDelay , function()
							self.OpenStatus = false
							WireLib.TriggerOutput(self.Controller,"Open_"..tostring( self.SysDoorNum ),0)
						end)
	WireLib.TriggerOutput(self.Controller,"Open_"..tostring( self.SysDoorNum ),0.5)

end

function ENT:Think()

	self.Entity:NextThink( CurTime() + 0.05 )
	
	return true
end

function CheckDoorAnim()

	if self:GetSequence() == self.OpenSequence  then return true  end
	if self:GetSequence() == self.CloseSequence then return false end	

end