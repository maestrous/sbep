AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" ) 

ENT.WireDebugName = "SBEP Door"

local DTT = {}

--[[DTT[ "Door Type Name (Class)"	]	= { model = "models/examplemodelpath.mdl" 	,
										UD = Length of sequence (s) , OD = time before door can be walked though   , CD = time before door becomes solid  ,
		Opening Sounds => { [time 1(s)] = "Sound 1 Name" , [time 2(s)] = "Sound 2 Name" , etc } ,
		Closing Soungs   => { [time 1(s)] = "Sound 1 Name" , [time 2(s)] = "Sound 2 Name" , etc } }]]

DTT[ "Door_Anim1"	]	= { model = "models/SmallBridge/SEnts/SBADoor1.mdl" 	,
										UD = 3 , OD = 2   , CD = 1 	,
		OS = { [0] = "Doors.Move14" , [1.45] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } ,
		CS = { [0] = "Doors.Move14" , [1.45] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } }

DTT[ "Door_Anim2"	]	= { model = "models/SmallBridge/SEnts/SBADoor2.mdl" 	,
										UD = 3 , OD = 1   , CD = 2 	,
		OS = { [0] = "Doors.Move14" , [1.95] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } ,
		CS = { [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } }

DTT[ "Door_Anim3"	]	= { model = "models/SmallBridge/SEnts/SBADoor3.mdl" 	,
										UD = 2 , OD = 1   , CD = 1 	,
		OS = { [0] = "Doors.Move14" , [1.95] = "Doors.FullOpen9" } ,
		CS = { [0] = "Doors.Move14" , [1.95] = "Doors.FullOpen9" } }

DTT[ "Door_Anim3dh"	]	= { model = "models/SmallBridge/SEnts/SBADoor3dh.mdl" 	,
										UD = 2 , OD = 1   , CD = 1 	,
		OS = { [0] = "Doors.Move14" , [1.95] = "Doors.FullOpen9" } ,
		CS = { [0] = "Doors.Move14" , [1.95] = "Doors.FullOpen9" } }

DTT[ "Door_Anim2"	]	= { model = "models/SmallBridge/SEnts/SBADoor2.mdl" 	,
										UD = 3 , OD = 1   , CD = 2 	,
		OS = { [0] = "Doors.Move14" , [1.95] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } ,
		CS = { [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } }

DTT[ "Door_Iris"		]	= { model = "models/SmallBridge/SEnts/SBADoorIris2.mdl",
										UD = 3 , OD = 2   , CD = 1 	,
		OS = { [0] = "Doors.Move14" , [0.90] = "Doors.FullOpen8" , [2.65] = "Doors.FullOpen9" } ,
		CS = { [0] = "Doors.Move14" , [1.95] = "Doors.FullOpen8" , [2.75] = "Doors.FullOpen9" } }

DTT[ "Door_DW"		]	= { model = "models/SmallBridge/SEnts/SBADoorWide.mdl" ,
										UD = 3 , OD = 1.5 , CD = 1.5 	,
		OS = { [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [1.95] = "Doors.FullOpen8" , [2.95] = "Doors.FullOpen9" } ,
		CS = { [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [1.95] = "Doors.FullOpen8" , [2.95] = "Doors.FullOpen9" } }

DTT[ "Door_DWDH"		]	= { model = "models/SmallBridge/SEnts/SBADoorWideDH.mdl" ,
										UD = 3 , OD = 1.5 , CD = 1.5 	,
		OS = { [0] = "Doors.Move14" , [0.80] = "Doors.FullOpen8" , [1.60] = "Doors.FullOpen8" , [2.40] = "Doors.FullOpen8" , [2.90] = "Doors.FullOpen9" } ,
		CS = { [0] = "Doors.Move14" , [1.35] = "Doors.FullOpen8" , [2.15] = "Doors.FullOpen8" , [2.90] = "Doors.FullOpen9" } }

DTT[ "Door_Sly1"		]	= { model = "models/Slyfo/SLYAdoor1.mdl" ,
										UD = 2 , OD = 0.5 , CD = 1.5 	,
		OS = { [0] = "Doors.Move14" , [1.80] = "Doors.FullOpen9" } ,
		CS = { [0] = "Doors.Move14" , [1.80] = "Doors.FullOpen9" } }
		
DTT[ "Door_DBS"		]	= { model = "models/SmallBridge/SEnts/SBADoorDBsmall.mdl" ,
										UD = 5 , OD = 4   , CD = 1.5	,
		OS = { [0] = "Doors.Move14" , [1.30] = "Doors.FullOpen8" , [2.60] = "Doors.FullOpen8" , [3.90] = "Doors.FullOpen9" , [4.90] = "Doors.FullOpen8" } ,
		CS = { [0] = "Doors.Move14" , [2.60] = "Doors.FullOpen8" , [3.95] = "Doors.FullOpen8" , [4.90] = "Doors.FullOpen9" } }

DTT[ "Door_Hull"		]	= { model = "models/SmallBridge/SEnts/SBAhullDsEb.mdl" ,
										UD = 3 , OD = 1.5 , CD = 1.5 ,
		OS = { [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [1.95] = "Doors.FullOpen8" , [2.85] = "Doors.FullOpen9" } ,
		CS = { [0] = "Doors.Move14" , [0.95] = "Doors.FullOpen8" , [1.95] = "Doors.FullOpen8" , [2.90] = "Doors.FullOpen9" } }

DTT[ "Door_ElevHatch_S"]	= { model = "models/SmallBridge/SEnts/sbahatchelevs.mdl" 	, 
										UD = 1 , OD = 0.6 , CD = 0.4 	,
		OS = { [0] = "Doors.Move14" , [0.40] = "Doors.FullOpen8" , [0.95] = "Doors.FullOpen9" } ,
		CS = { [0] = "Doors.Move14" , [0.40] = "Doors.FullOpen8" , [0.95] = "Doors.FullOpen9" } }

DTT[ "Door_ElevHatch_L"]	= { model = "models/SmallBridge/SEnts/sbahatchelevl.mdl" 	, 
										UD = 2 , OD = 0.6 , CD = 1 	,
		OS = { [0] = "Doors.Move14" , [1.00] = "Doors.FullOpen8" , [1.90] = "Doors.FullOpen9" } ,
		CS = { [0] = "Doors.Move14" , [1.00] = "Doors.FullOpen8" , [1.90] = "Doors.FullOpen9" } }
		
DTT[ "Door_ModBridge_11a"]	= { model = "models/Cerus/Modbridge/Misc/Doors/door11a_anim.mdl" 	, 
										UD = 3.8 , OD = 1.5 , CD = 2 	,
		OS = { [0] = "Doors.FullOpen8" , [0.50] = "Doors.Move14"    , [1.50] = "Doors.FullOpen8" , [3.40] = "Doors.FullOpen9" } ,
		CS = { [0] = "Doors.Move14" 	  , [1.50] = "Doors.FullOpen8" , [2.30] = "Doors.FullOpen9" , [3.00] = "Doors.Move14" , [3.60] = "Doors.FullOpen8" } }
		
DTT[ "Door_ModBridge_12a"]	= { model = "models/Cerus/Modbridge/Misc/Doors/door12a_anim.mdl" 	, 
										UD = 3.0 , OD = 1.5 , CD = 1.5 	,
		OS = { [0] = "Doors.Move14" , [0.90] = "Doors.FullOpen8" , [1.90] = "Doors.FullOpen8" , [2.70] = "Doors.FullOpen9" } ,
		CS = { [0] = "Doors.Move14" , [0.90] = "Doors.FullOpen8" , [1.90] = "Doors.FullOpen8" , [2.70] = "Doors.FullOpen9" } }
		
DTT[ "Door_ModBridge_13a"]	= { model = "models/Cerus/Modbridge/Misc/Doors/door13a_anim.mdl" 	, 
										UD = 4.8 , OD = 2 , CD = 3.5 	,
		OS = { [0] = "Doors.Move14" , [1.00] = "Doors.FullOpen8" , [1.90] = "Doors.FullOpen9" } ,
		CS = { [0] = "Doors.Move14" , [1.00] = "Doors.FullOpen8" , [1.90] = "Doors.FullOpen9" } }
		
DTT[ "Door_ModBridge_23a"]	= { model = "models/Cerus/Modbridge/Misc/Doors/door23a_anim.mdl" 	, 
										UD = 5.2 , OD = 4 , CD = 1.5 	,
		OS = { [0] = "Doors.Move14" 	, [0.90] = "Doors.Move14"    , [2.80] = "Doors.FullOpen8" 	, [5.00] = "Doors.FullOpen9" } , 
		CS = { [0] = "Doors.Fullopen8" 	, [2.40] = "Doors.FullOpen8" , [3.40] = "Doors.Move14" 		, [4.40] = "Doors.FullOpen8" , [5.20] = "Doors.FullOpen9" } }
		
DTT[ "Door_ModBridge_33a"]	= { model = "models/Cerus/Modbridge/Misc/Doors/door33a_anim.mdl" 	, 
										UD = 2.8 , OD = 1.6 , CD = 1.2 	,
		OS = { [0] = "Doors.Move14" , [1.00] = "Doors.FullOpen8" , [1.90] = "Doors.FullOpen9" } ,
		CS = { [0] = "Doors.Move14" , [1.00] = "Doors.FullOpen8" , [1.90] = "Doors.FullOpen9" } }
		
DTT[ "ACC_Furnace1"]	= { model = "models/Cerus/Modbridge/Misc/Accessories/acc_furnace1_anim.mdl" 	, 
										UD = 1 , OD = 0.2 , CD = 0.8 	,
		OS = { [0] = "Doors.Move14" 	, [1.00] = "Doors.FullOpen9" } , 
		CS = { [0] = "Doors.Fullopen8" 	, [1.00] = "Doors.FullOpen9" } }


function ENT:Initialize()
	self.D					= {}
	self.OpenStatus      	= false
	self.OpenTrigger		= false
	self.Locked     		= false
	self.DisableUse 		= false
	self.Timers 			= {}
	self.Index				= self.Entity:EntIndex()
	self.Entity:PhysicsInitialize()
end

function ENT:PhysicsInitialize()
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
		self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
		self.Entity:SetSolid( SOLID_VPHYSICS )
		local phys = self.Entity:GetPhysicsObject()  	
		if (phys:IsValid()) then  		
			phys:Wake()  
			phys:EnableGravity(false)
			--phys:EnableDrag(false)
			phys:EnableMotion( true )
		end
end

function ENT:SetDoorType( strType )
	if !strType || (!DTT[strType]) || (strType == self.type) then 
		print( "Invalid Door Type: "..tostring(strType) )
		return false 
	end
	self.Entity:SetDoorVars( strType )
	self.Entity:SetModel( self.D.model )
	self.Entity:GetSequenceData()
	self.Entity:PhysicsInitialize()	
	self.Entity:Close()
end

function ENT:SetDoorVars( strType )
	if !strType || (!DTT[strType]) then return end
	self.type  = strType
	self.D = DTT[ strType ]
end

function ENT:Attach( ent , V , A )
	self.Entity.D = self.Entity.D || {}
	
	local Voff = Vector(0,0,0)
	if V then Voff = Vector( V.x , V.y , V.z ) end
		self.Entity:SetPos( ent:LocalToWorld( Voff ) )
		
	local Aoff = Angle(0,0,0)
	if A then Aoff = Angle( A.p , A.y , A.r ) end
		self.Entity:SetAngles( ent:GetAngles() + Aoff )
		
	self.ATWeld = constraint.Weld( ent , self.Entity , 0, 0, 0, true )
	
		self.Entity:SetSkin( ent:GetSkin() )
		self.Entity.OpenTrigger = false
		
		self.Entity.ATEnt	= ent
		self.Entity.VecOff	= Voff
		self.Entity.AngOff	= Aoff
		
		self.Entity:GetPhysicsObject():EnableMotion( true )
	ent:DeleteOnRemove( self.Entity )
end

function ENT:SetController( cont , sysnum )
	if cont && cont:IsValid() then
		self.Cont = cont
	end
	if sysnum then
		self.SDN = sysnum
	end
end

function ENT:OpenDoorSounds()
	self.Entity:EmitSound( self.D.OS[0] )
	for k,v in pairs( self.D.OS ) do
		local var = "SBEP_"..tostring( self.Index ).."_OpenSounds_"..tostring( k )
		table.insert( self.Timers , var )
		timer.Create( var , k , 1 , function()
								self.Entity:EmitSound( v )
						end )
	end
end

function ENT:CloseDoorSounds()
	self.Entity:EmitSound( self.D.CS[0] )
	for k,v in pairs( self.D.CS ) do
		local var = "SBEP_"..tostring( self.Index ).."_CloseSounds_"..tostring( k )
		table.insert( self.Timers , var )
		timer.Create( var , k , 1 , function()
								self.Entity:EmitSound( v )
						end )
	end
end

function ENT:GetSequenceData()
	self.OSeq = self.Entity:LookupSequence( "open" )
	self.CSeq = self.Entity:LookupSequence( "close" )
end

function ENT:Open()
	self.Entity:ResetSequence( self.OSeq )
		self.Entity:OpenDoorSounds()
		local var = "SBEP_"..tostring( self.Index ).."_OpenSolid"
		table.insert( self.Timers , var )
		timer.Create( var , self.D.OD , 1 , function()
							self.Entity:SetNotSolid( true )
						end)
		local var = "SBEP_"..tostring( self.Index ).."_OpenStatus"
		table.insert( self.Timers , var )
		timer.Create( var , self.D.UD , 1 , function()
							self.OpenStatus = true
							if self.Cont then
								WireLib.TriggerOutput(self.Cont,"Open_"..tostring( self.SDN ),1)
							end
						end)
	if self.Cont then
		WireLib.TriggerOutput(self.Cont,"Open_"..tostring( self.SDN ),0.5)
	end
end

function ENT:Close()
	self.Entity:ResetSequence( self.CSeq )
		self.Entity:CloseDoorSounds()
		local var = "SBEP_"..tostring( self.Index ).."_CloseSolid"
		table.insert( self.Timers , var )
		timer.Create( var , self.D.CD , 1 , function()
							self.Entity:SetNotSolid( false )
						end)
		local var = "SBEP_"..tostring( self.Index ).."_CloseStatus"
		table.insert( self.Timers , var )
		timer.Create( var , self.D.UD , 1 , function()
							self.OpenStatus = false
							if self.Cont then
								WireLib.TriggerOutput(self.Cont,"Open_"..tostring( self.SDN ),0)
							end
						end)
	if self.Cont then
		WireLib.TriggerOutput(self.Cont,"Open_"..tostring( self.SDN ),0.5)
	end
end

function ENT:Think()
	if !(self.OpenTrigger == nil) then
		if self.OpenTrigger and !self.Entity:IsOpen() then
			if !self.OpenStatus then
				self.Entity:Open()
			end
		elseif !self.OpenTrigger and self.Entity:IsOpen() then
			if self.OpenStatus then
				self.Entity:Close()
			end
		end
	end
	if (self.ATEnt && self.ATEnt:IsValid() ) && (!self.ATWeld || !self.ATWeld:IsValid()) then
		self:Attach( self.ATEnt , self.VecOff , self.AngOff )
	end
	if self.Cont then
		if self.Entity:GetSkin() != self.Cont.Skin then
			self.Entity:SetSkin( self.Cont.Skin )
		end
	end
	self.Entity:NextThink( CurTime() + 0.05 )
	return true
end

function ENT:IsOpen()

	if self.Entity:GetSequence() == self.OSeq  then 
		return true 
	elseif self.Entity:GetSequence() == self.CSeq then 
		return false 
	end	

end

function ENT:OnRemove()
	for k,v in ipairs( self.Timers ) do
		if timer.IsTimer( v ) then
			timer.Remove( v )
		end
	end
	if self.Cont and ValidEntity( self.Cont ) then
		table.remove( self.Cont.DT , self.SDN )
		self.Cont:MakeWire( true )
	end
end

function ENT:PreEntityCopy()
	local DI = {}
	DI.type 	= self.type
	if self.Cont then
		DI.Cont 	= self.Cont:EntIndex()
	end
	DI.D 		= self.D
	DI.ATEnt	= self.ATEnt:EntIndex()
	DI.VecOff	= self.VecOff
	DI.AngOff	= self.AngOff
	DI.ATWeld	= self.ATWeld:EntIndex()
	duplicator.StoreEntityModifier(self, "SBEPD", DI)
end
duplicator.RegisterEntityModifier( "SBEPD" , function() end)

function ENT:PostEntityPaste(pl, Ent, CreatedEntities)
	self.type 	= Ent.EntityMods.SBEPD.type
	self.D 		= Ent.EntityMods.SBEPD.D
	self.ATEnt	= CreatedEntities[ Ent.EntityMods.SBEPD.ATEnt ]
	self.VecOff	= Ent.EntityMods.SBEPD.VecOff
	self.AngOff	= Ent.EntityMods.SBEPD.AngOff
	self.ATWeld = CreatedEntities[ Ent.EntityMods.SBEPD.ATWeld ]
	if Ent.EntityMods.SBEPD.Cont then
		self.Entity:SetController( CreatedEntities[ Ent.EntityMods.SBEPD.Cont ] )
	end
	self.Entity:PhysicsInitialize()
	self.Entity:GetSequenceData()
	self.Entity:Close()
end