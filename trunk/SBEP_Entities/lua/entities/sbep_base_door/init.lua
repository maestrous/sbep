AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" ) 

ENT.WireDebugName = "SBEP Door"

local DoorTypesTable = {}

DoorTypesTable[ "Door_Anim1"	]	= { "models/SmallBridge/SEnts/SBADoor1.mdl" 	,
										3 , 2   , 1 	,
		{ [0] = "Doors.Move14" , [1.45] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } ,
		{ [0] = "Doors.Move14" , [1.45] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } }

DoorTypesTable[ "Door_Anim2"	]	= { "models/SmallBridge/SEnts/SBADoor2.mdl" 	,
										3 , 1   , 2 	,
		{ [0] = "Doors.Move14" , [1.95] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } ,
		{ [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } }

DoorTypesTable[ "Door_Anim3"	]	= { "models/SmallBridge/SEnts/SBADoor3.mdl" 	,
										2 , 1   , 1 	,
		{ [0] = "Doors.Move14" , [1.95] = "Doors.FullOpen9" } ,
		{ [0] = "Doors.Move14" , [1.95] = "Doors.FullOpen9" } }

DoorTypesTable[ "Door_Anim3dh"	]	= { "models/SmallBridge/SEnts/SBADoor3dh.mdl" 	,
										2 , 1   , 1 	,
		{ [0] = "Doors.Move14" , [1.95] = "Doors.FullOpen9" } ,
		{ [0] = "Doors.Move14" , [1.95] = "Doors.FullOpen9" } }

DoorTypesTable[ "Door_Anim2"	]	= { "models/SmallBridge/SEnts/SBADoor2.mdl" 	,
										3 , 1   , 2 	,
		{ [0] = "Doors.Move14" , [1.95] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } ,
		{ [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } }

DoorTypesTable[ "Door_Iris"		]	= { "models/SmallBridge/SEnts/SBADoorIris2.mdl",
										3 , 2   , 1 	,
		{ [0] = "Doors.Move14" , [0.90] = "Doors.FullOpen8" , [2.65] = "Doors.FullOpen9" } ,
		{ [0] = "Doors.Move14" , [1.95] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } }

DoorTypesTable[ "Door_DW"		]	= { "models/SmallBridge/SEnts/SBADoorWide.mdl" ,
										3 , 1.5 , 1.5 	,
		{ [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [1.95] = "Doors.FullOpen8" , [2.95] = "Doors.FullOpen9" } ,
		{ [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [1.95] = "Doors.FullOpen8" , [2.95] = "Doors.FullOpen9" } }

DoorTypesTable[ "Door_DWDH"		]	= { "models/SmallBridge/SEnts/SBADoorWideDH.mdl" ,
										3 , 1.5 , 1.5 	,
		{ [0] = "Doors.Move14" , [0.80] = "Doors.FullOpen8" , [1.60] = "Doors.FullOpen8" , [2.40] = "Doors.FullOpen8" , [2.90] = "Doors.FullOpen9" } ,
		{ [0] = "Doors.Move14" , [1.35] = "Doors.FullOpen8" , [2.15] = "Doors.FullOpen8" , [2.90] = "Doors.FullOpen9" } }

DoorTypesTable[ "Door_Sly1"		]	= { "models/Slyfo/SLYAdoor1.mdl" ,
										2 , 0.5 , 1.5 	,
		{ [0] = "Doors.Move14" , [1.80] = "Doors.FullOpen9" } ,
		{ [0] = "Doors.Move14" , [1.80] = "Doors.FullOpen9" } }
		
DoorTypesTable[ "Door_DBS"		]	= { "models/SmallBridge/SEnts/SBADoorDBsmall.mdl" ,
										5 , 4   , 1.5	,
		{ [0] = "Doors.Move14" , [1.30] = "Doors.FullOpen8" , [2.60] = "Doors.FullOpen8" , [3.90] = "Doors.FullOpen9" , [4.90] = "Doors.FullOpen8" } ,
		{ [0] = "Doors.Move14" , [2.60] = "Doors.FullOpen8" , [3.95] = "Doors.FullOpen8" , [4.90] = "Doors.FullOpen9" } }

DoorTypesTable[ "Door_Hull"		]	= { "models/SmallBridge/SEnts/SBAhullDsEb.mdl" ,
										3 , 1.5 , 1.5 ,
		{ [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [1.95] = "Doors.FullOpen8" , [2.85] = "Doors.FullOpen9" } ,
		{ [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [1.95] = "Doors.FullOpen8" , [2.90] = "Doors.FullOpen9" } }

DoorTypesTable[ "Door_ElevHatch"]	= { "models/SmallBridge/SEnts/sbahatchelevs.mdl" 	, 
										1 , 0.6 , 0.4 	,
		{ [0] = "Doors.Move14" , [0.40] = "Doors.FullOpen8" , [0.95] = "Doors.FullOpen9" } ,
		{ [0] = "Doors.Move14" , [0.40] = "Doors.FullOpen8" , [0.95] = "Doors.FullOpen9" } }

DoorTypesTable[ "Door_ElevHatch_L"]	= { "models/SmallBridge/SEnts/sbahatchelevl.mdl" 	, 
										2 , 0.6 , 1 	,
		{ [0] = "Doors.Move14" , [1.00] = "Doors.FullOpen8" , [1.90] = "Doors.FullOpen9" } ,
		{ [0] = "Doors.Move14" , [1.00] = "Doors.FullOpen8" , [1.90] = "Doors.FullOpen9" } }
		
DoorTypesTable[ "Door_ModBridge_11a"]	= { "models/Cerus/Modbridge/Misc/Doors/door11a_anim.mdl" 	, 
										3.8 , 1.5 , 2 	,
		{ [0] = "Doors.FullOpen8" , [0.50] = "Doors.Move14"    , [1.50] = "Doors.FullOpen8" , [3.40] = "Doors.FullOpen9" } ,
		{ [0] = "Doors.Move14" 	  , [1.50] = "Doors.FullOpen8" , [2.30] = "Doors.FullOpen9" , [3.00] = "Doors.Move14" , [3.60] = "Doors.FullOpen8" } }
		
DoorTypesTable[ "Door_ModBridge_12a"]	= { "models/Cerus/Modbridge/Misc/Doors/door12a_anim.mdl" 	, 
										3.0 , 1.5 , 1.5 	,
		{ [0] = "Doors.Move14" , [0.90] = "Doors.FullOpen8" , [1.90] = "Doors.FullOpen8" , [2.70] = "Doors.FullOpen9" } ,
		{ [0] = "Doors.Move14" , [0.90] = "Doors.FullOpen8" , [1.90] = "Doors.FullOpen8" , [2.70] = "Doors.FullOpen9" } }
		
DoorTypesTable[ "Door_ModBridge_13a"]	= { "models/Cerus/Modbridge/Misc/Doors/door13a_anim.mdl" 	, 
										4.8 , 2 , 3.5 	,
		{ [0] = "Doors.Move14" , [1.00] = "Doors.FullOpen8" , [1.90] = "Doors.FullOpen9" } ,
		{ [0] = "Doors.Move14" , [1.00] = "Doors.FullOpen8" , [1.90] = "Doors.FullOpen9" } }
		
DoorTypesTable[ "Door_ModBridge_23a"]	= { "models/Cerus/Modbridge/Misc/Doors/door23a_anim.mdl" 	, 
										5.2 , 4 , 1.5 	,
		{ [0] = "Doors.Move14" , [0.90] = "Doors.Move14"    , [2.80] = "Doors.FullOpen8" , [5.00] = "Doors.FullOpen9" } , 
		{ [0] = "Doors.Doors.Fullopen8" , [2.40] = "Doors.FullOpen8" , [3.40] = "Doors.Move14" , [4.40] = "Doors.FullOpen8" , [5.20] = "Doors.FullOpen9" } }

function ENT:PhysicsInitialize()

	self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		
		local phys = self:GetPhysicsObject()  	
		if (phys:IsValid()) then  		
			phys:Wake()  
			phys:EnableGravity(false)
			phys:EnableMotion( false )
		end

end

function ENT:SetDoorType( DoorType )

	self.DoorType  = DoorType
	self:SetDoorVars( DoorType )
	
	self.OpenStatus      	= false
	self.OpenTrigger		= false
	self.Locked     		= false
	self.DisableUse 		= false
	
	self:SetModel( self.DoorModel )
	
	self:GetSequenceData()
	
	self:PhysicsInitialize()	
		
	self:Close()
	
end

function ENT:SetDoorVars( DoorType )

	local DataTable = DoorTypesTable[ DoorType ]
	self.DoorModel, self.UseDelay, self.OpenDelay, self.CloseDelay, self.OpenSounds, self.CloseSounds = unpack( DataTable )
	
	self.Timers = {}

end

function ENT:Attach( ent , vecoff , angoff )

	local vecoff = vecoff or Vector(0,0,0)
	self.Entity:SetPos( ent:GetPos() + vecoff )

	local angoff = angoff or Angle(0,0,0)
	self.Entity:SetAngles( ent:GetAngles() + angoff )

	constraint.Weld( ent , self.Entity , 0, 0, 0, true )

	self.Entity:SetSkin( ent:GetSkin() )
	self.Entity.OpenTrigger = false

	self.Entity:GetPhysicsObject():EnableMotion( true )

	ent:DeleteOnRemove( self.Entity )
end

function ENT:SetController( controller , sysnum )

	self.Entity.Controller = controller
	self.Entity.SysDoorNum = sysnum

end

function ENT:OpenDoorSounds()

	self:EmitSound( self.OpenSounds[0] )
	for k,v in pairs( self.OpenSounds ) do
		local var = "SBEP_"..tostring( self:EntIndex() ).."_OpenSounds_"..tostring( k )
		table.insert( self.Timers , var )
		timer.Create( var , k , 1 , function()
								self:EmitSound( v )
						end )
	end
end

function ENT:CloseDoorSounds()

	self:EmitSound( self.CloseSounds[0] )
	for k,v in pairs( self.CloseSounds ) do
		local var = "SBEP_"..tostring( self:EntIndex() ).."_CloseSounds_"..tostring( k )
		table.insert( self.Timers , var )
		timer.Create( var , k , 1 , function()
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
		local var = "SBEP_"..tostring( self:EntIndex() ).."_OpenSolid"
		table.insert( self.Timers , var )
		timer.Create( var , self.OpenDelay , 1 , function()
							self:SetNotSolid( true )
						end)
		local var = "SBEP_"..tostring( self:EntIndex() ).."_OpenStatus"
		table.insert( self.Timers , var )
		timer.Create( var , self.UseDelay , 1 , function()
							self.OpenStatus = true
							if self.Controller then
								WireLib.TriggerOutput(self.Controller,"Open_"..tostring( self.SysDoorNum ),1)
							end
						end)
	if self.Controller then
		WireLib.TriggerOutput(self.Controller,"Open_"..tostring( self.SysDoorNum ),0.5)
	end
end

function ENT:Close()

	self:ResetSequence( self.CloseSequence )
		self:CloseDoorSounds()
		local var = "SBEP_"..tostring( self:EntIndex() ).."_CloseSolid"
		table.insert( self.Timers , var )
		timer.Create( var , self.CloseDelay , 1 , function()
							self:SetNotSolid( false )
						end)
		local var = "SBEP_"..tostring( self:EntIndex() ).."_CloseStatus"
		table.insert( self.Timers , var )
		timer.Create( var , self.UseDelay , 1 , function()
							self.OpenStatus = false
							if self.Controller then
								WireLib.TriggerOutput(self.Controller,"Open_"..tostring( self.SysDoorNum ),0)
							end
						end)
	if self.Controller then
		WireLib.TriggerOutput(self.Controller,"Open_"..tostring( self.SysDoorNum ),0.5)
	end
end

function ENT:Think()

	if !(self.OpenTrigger == nil) then
		if self.OpenTrigger and !self:CheckDoorAnim() then
			if !self.OpenStatus then
				self:Open()
			end
		elseif !self.OpenTrigger and self:CheckDoorAnim() then
			if self.OpenStatus then
				self:Close()
			end
		end
	end
	
	if self.Controller then
		if self:GetSkin() != self.Controller.Skin then
			self:SetSkin( self.Controller.Skin )
		end
	end

	self.Entity:NextThink( CurTime() + 0.05 )
	
	return true
end

function ENT:CheckDoorAnim()

	if self:GetSequence() == self.OpenSequence  then 
		return true 
	elseif self:GetSequence() == self.CloseSequence then 
		return false 
	end	

end

function ENT:OnRemove()
	
	for k,v in ipairs( self.Timers ) do
		if timer.IsTimer( v ) then
			timer.Remove( v )
		end
	end
	
	if self.Controller and ValidEntity( self.Controller ) then
		table.remove( self.Controller.Door , self.SysDoorNum )
		self.Controller:MakeWire( true )
	end
end

function ENT:PreEntityCopy()
	local dupeInfo = {}
	dupeInfo.DoorType = self.DoorType
	
	duplicator.StoreEntityModifier(self, "SBEPDoorDupeInfo", dupeInfo)
end
duplicator.RegisterEntityModifier( "SBEPDoorDupeInfo" , function() end)

function ENT:PostEntityPaste(pl, Ent, CreatedEntities)

	self.DoorType = Ent.EntityMods.SBEPDoorDupeInfo.DoorType
	self:PhysicsInitialize()
	self:SetDoorVars( self.DoorType )
	self:GetSequenceData()
	self:Close()

end