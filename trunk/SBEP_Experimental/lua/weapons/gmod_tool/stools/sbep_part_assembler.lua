TOOL.Category		= "SBEP"
TOOL.Name			= "#Part Assembler" 
TOOL.Command 		= nil 
TOOL.ConfigName 	= ""

TOOL.ClientConVar[ "skin"  	] = 0
TOOL.SPR = {}
TOOL.SPE = {}

local PAD = list.Get( "SBEP_PartAssemblyData" )

if CLIENT then
	language.Add( "Tool_sbep_part_assembler_name" , "SBEP Part Assembly Tool" 								)
	language.Add( "Tool_sbep_part_assembler_desc" , "Easily assemble SBEP parts." 							)
	language.Add( "Tool_sbep_part_assembler_0"	  , "Left click." 											)
end


function TOOL:LeftClick( trace ) 

	local ent = trace.Entity
	if !ent || !ent:IsValid() || ent:GetClass() ~= "sbep_base_sprite" then return end
	
	if self.ent1 && self.ent1:IsValid() then
	
		if self.ent1:GetSpriteType() ~= ent:GetSpriteType() then return end
	
		self.ent2 = ent
		local E1 = self.ent1
		local E2 = self.ent2
		local ENTS = { E1 , E2 , E1.SEO , E2.SEO }
		for k,v in ipairs( ENTS ) do
			v:GetPhysicsObject():EnableMotion( false )
		end
		
		E1.Following = false
		E1:SetPos( E2:GetPos() )
		E1:SetAngles( E2:LocalToWorldAngles( Angle(0,180,0) ) )

		E1.SEO:SetPos( E1:LocalToWorld( -1 * E1.Offset ) )
		E1.SEO:SetAngles( E1:LocalToWorldAngles( -1 * E1.Dir ) )
		
		constraint.Weld( E1.SEO , E2.SEO , 0 , 0 , 0 , true )
		
		E1:Remove()
		E2:Remove()
		
		self.ent1 = nil
		self.ent2 = nil
	else
		self.ent1 = ent
	end
	
	return true
end 

function TOOL:RightClick( trace ) 

	

end

function TOOL:Reload( trace ) 

	self.ent1 = nil
	self.ent2 = nil

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

		if ent.SPR && #ent.SPR == #data then return 
		--[[elseif ent.SPR then
			for k,v in pairs( ent.SPR ) do
				if v && v:IsValid() then v:Remove() end
			end
			ent.SPR = {}]]
		end

		if !ent.SPR then ent.SPR = {} end
		for k,v in ipairs( data ) do
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
					v.SPR = {}
				end
			end
		end
		
		return true
	end
end

function TOOL.BuildCPanel( panel )
	
	panel:SetSpacing( 10 )
	panel:SetName( "SBEP Part Assembler" )
	
 end  