TOOL.Category		= "SBEP"
TOOL.Name			= "#Wiki Help" 
TOOL.Command 		= nil 
TOOL.ConfigName 	= ""

TOOL.ClientConVar[ "skin"  	] = 0
TOOL.ClientConVar[ "glass"  ] = 0

if ( CLIENT ) then
	language.Add( "Tool_sbep_wiki_name" , "SBEP Wiki Tool" 				)
	language.Add( "Tool_sbep_wiki_desc" , "Look up help and info on SBEP stuff." 		)
	language.Add( "Tool_sbep_wiki_0" 	, "Click something to look it up in the wiki." 	)
end


function TOOL:LeftClick( trace )
	if CLIENT then return end
	if trace.Entity:IsValid() then
		local class = trace.Entity:GetClass()
		print( class )
		
		umsg.Start( "SBEPDocOpenSearch" , RecipientFilter():AddPlayer( self:GetOwner() ) )
			umsg.String( class )
		umsg.End()
		
		return true
	end
end 

function TOOL:RightClick( trace ) 

end  

function TOOL.BuildCPanel( panel )
	
	panel:SetSpacing( 10 )
	panel:SetName( "SBEP Wiki Tool" )
	
 end  