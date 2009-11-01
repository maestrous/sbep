TOOL.Category		= "SBEP"
TOOL.Name			= "#Part Assembler" 
TOOL.Command 		= nil 
TOOL.ConfigName 	= ""

TOOL.ClientConVar[ "skin"  	] = 0
TOOL.SPR = {}
TOOL.SPE = {}
TOOL.RotMode = false

local PAD = list.Get( "SBEP_PartAssemblyData" )

local SPD = {
	SWSH = "SWSH" ,
	SWDH = "SWDH" ,
	DWSH = "DWSH" ,
	DWDH = "DWDH" ,
	
	ESML = "ESML" ,
	ELRG = "ELRG" ,
	
	LRC1 = "LRC2" ,
	LRC2 = "LRC1" ,
	LRC3 = "LRC4" ,
	LRC4 = "LRC3" ,
	LRC5 = "LRC6" ,
	LRC6 = "LRC5"
			}

if CLIENT then
	language.Add( "Tool_sbep_part_assembler_name" , "SBEP Part Assembly Tool" 								)
	language.Add( "Tool_sbep_part_assembler_desc" , "Easily assemble SBEP parts." 							)
	language.Add( "Tool_sbep_part_assembler_0"	  , "Left-click an attachment point."						)
	language.Add( "Tool_sbep_part_assembler_1"	  , "Left-click another attachement point to connect to."	)
	language.Add( "Tool_sbep_part_assembler_2"	  , "Right-click to rotate, and left click to finish."		)
	language.Add( "undone_SBEP Part Assembly"	  , "Undone SBEP Part Assembly"								)
end

function TOOL:LeftClick( trace ) 

	local ply = self:GetOwner()

	if self.RotMode && self:GetStage() == 2 then
		self.E1.SEO:SetColor( 255,255,255,255 )
		local weld = constraint.Weld( self.E1.SEO , self.E2.SEO , 0 , 0 , 0 , true )	
		undo.Create( "SBEP Part Assembly Weld" )
			undo.AddEntity( weld )
			undo.SetPlayer( ply )
		undo.Finish()
		self.E1:Remove()
			self.E1 = nil
		self.E2:Remove()
			self.E2 = nil
		self:SetStage( 0 )
		self.RotMode = false
		return true
	end
	
	local ent = trace.Entity
	if !ent || !ent:IsValid() || ent:GetClass() ~= "sbep_base_sprite" then return end
	
	if self.E1 && self.E1:IsValid() then
	
		if self.E1:GetSpriteType() ~= SPD[ ent:GetSpriteType() ] then return end
		
		local pos = self.E1.SEO:GetPos()
		local ang = self.E1.SEO:GetAngles()
		
		self.E2 = ent
		local E1 = self.E1
		local E2 = self.E2
		local ENTS = { E1 , E2 , E1.SEO , E2.SEO }
		for k,v in ipairs( ENTS ) do
			v:GetPhysicsObject():EnableMotion( false )
		end
		
		E1.Following = false
		E1:SetPos( E2:GetPos() )
		E1:SetAngles( E2:LocalToWorldAngles( Angle(0,180,0) ) )
		
		local EO = Vector( E1.Offset.x , E1.Offset.y , E1.Offset.z )
		EO:Rotate( Angle( -1 * E1.Dir.p , E1.Dir.y , E1.Dir.r ) )
		E1.SEO:SetPos( E1:LocalToWorld( -1 * EO ) )
		E1.SEO:SetAngles( E1:LocalToWorldAngles( -1 * E1.Dir ) )
		
		if E1.RotMode then
			self.RotMode = true
			E1:SetNoDraw( true )
			E2:SetNoDraw( true )
			E1.SEO:SetColor( 255,255,255,180 )
			self:SetStage( 2 )
			return true
		else
			local weld = constraint.Weld( E1.SEO , E2.SEO , 0 , 0 , 0 , true )
			
			local function WeldUndo( Undo, Entity, pos , ang )
						if Entity:IsValid() then
							Entity:SetAngles( ang )
							Entity:SetPos( pos )
						end
					end
			
			undo.Create( "SBEP Part Assembly Weld" )
				undo.AddEntity( weld )
				undo.SetPlayer( self:GetOwner() )
				undo.AddFunction( WeldUndo, self.E1.SEO , pos , ang )
			undo.Finish()
			
			--E1.SEO.SPR = nil
			--E2.SEO.SPR = nil
			
			--[[if !E1.SEO.SBEPPAD && !E2.SEO.SBEPPAD then
				E1.SEO.ConstraintSystem:Remove()
			
				local System = ents.Create("phys_constraintsystem")
					System:SetKeyValue( "additionaliterations", 1 )
				System:Spawn()
				System:Activate()

				System.ARGHHHHH = true
				System.UsedEntities = { E1.SEO , E2.SEO }
				E1.SEO.ConstraintSystem = System
				E2.SEO.ConstraintSystem = System
				weld:SetEntity( "Constraint System Manager" , System )
			end]]
			
			--if !E1.SEO.SBEPPAD then E1.SEO.SBEPPAD = {} end
			--if !E2.SEO.SBEPPAD then E2.SEO.SBEPPAD = {} end
			--table.insert( E1.SEO.SBEPPAD , weld )
			--table.insert( E2.SEO.SBEPPAD , weld )
			
			E1:Remove()
				self.E1 = nil
			E2:Remove()
				self.E2 = nil
			self:SetStage( 0 )
		end
	else
		self.E1 = ent
		self:SetStage( 1 )
	end
	
	return true
end 

function TOOL:RightClick( trace ) 
	if self.RotMode && self:GetStage() == 2 then
		self.E1:SetAngles( self.E1:GetAngles() + Angle(0,0,90) )
		self.E1.SEO:SetAngles( self.E1:LocalToWorldAngles( -1 * self.E1.Dir ) )
	end
end

function TOOL:Reload( trace ) 

	self.E1 = nil
	self.E2 = nil
	self:SetStage(0)
	
	return true
end

if SERVER then
	function TOOL:Think()
		local ply = self:GetOwner()
		local trace = ply:GetEyeTrace()
		if !trace.Hit || trace.HitWorld || trace.HitSky then return end

		local ent = trace.Entity
		if !ent || !ent:IsValid() then return end
		
		local model = string.lower( ent:GetModel() )
		local data = PAD[ model ]
		if !data then return end

		if ent.SPR --[[&& #ent.SPR == #data]] then return 
		--[[elseif ent.SPR then
			for k,v in pairs( ent.SPR ) do
				if v && v:IsValid() then v:Remove() end
			end
			ent.SPR = {}]]
		end

		if !ent.SPR then ent.SPR = {} end
		for k,v in ipairs( data ) do
			if ent:GetClass() == "sbep_elev_housing" && (v.type == "ESML" || v.type == "ELRG") then break end
			local sprite = ents.Create( "sbep_base_sprite" )
			sprite:Spawn()

			sprite:SetSpriteType( v.type )
			sprite.Offset = v.pos
			sprite.Dir = v.dir
			sprite.SEO = ent
			sprite.Following = true

			ent:DeleteOnRemove( sprite )
			table.insert( ent.SPR , sprite )
			table.insert( self.SPR , sprite )
			table.insert( self.SPE , ent )
		end
	end
	
	function TOOL:Holster( wep )
		if self.SPR then
			for k,v in pairs( self.SPR ) do
				if v && v:IsValid() then
					v:Remove()
				end
			end
		end
		
		if self.SPE then
			for k,v in pairs( self.SPE ) do
				if v.SPR then
					v.SPR = nil
				end
			end
		end
		
		self.E1 = nil
		self.E2 = nil
		
		return true
	end
end

function TOOL.BuildCPanel( panel )
	
	panel:SetSpacing( 10 )
	panel:SetName( "SBEP Part Assembler" )
	
 end  