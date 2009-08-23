TOOL.Category		= "SBEP"
TOOL.Name			= "#Lift"
TOOL.Command		= nil
TOOL.ConfigName		= ""

if CLIENT then
    language.Add("Tool_sbep_lift_name", "SBEP: Lift")
    language.Add("Tool_sbep_lift_desc", "Going Up and down and up and down and up and down and up and down...")
    language.Add("Tool_sbep_lift_0",    "Left Click: Spawns an lift that won't spaz out and bash your brains in.")
	
	language.Add("sboxlimit_sbep_lifts", "You've hit the SBEP Lift limit!")
	language.Add("undone_SBEP: Lift", "Undone SBEP Lift")
end

if SERVER then
	CreateConVar('sbox_maxsbep_lifts', 10)
end


TOOL.ClientConVar["model"] = "models/SmallBridge/SBpanelelev2s/sbpanelelev2s.mdl"

cleanup.Register("sbep_lifts")

function TOOL:LeftClick(trace)
	if (not trace.HitPos) or trace.Entity:IsPlayer() then return false end
	if CLIENT then return true end

	local ply = self:GetOwner()
	
	if not ply:CheckLimit("sbep_lifts") then return false end
	
	local Ang = trace.HitNormal:Angle()
	Ang.pitch = Ang.pitch + 90
	
	local ent = ents.Create("sbmp_lift")
	ent:SetModel(self:GetClientInfo("model"))
	ent:SetPos(trace.HitPos - trace.HitNormal * ent:OBBMins().z)
	ent:SetAngles(Ang)
	ent:Spawn()
	
	undo.Create("SBEP: Lift")
		undo.AddEntity(ent)
		undo.SetPlayer(ply)
	undo.Finish()

	ply:AddCleanup("sbep_lifts", ent)

	return true
end

function TOOL:UpdateDaGhost(ent, ply)
	if not (ent and ent:IsValid()) then return end
	
	local trace = util.TraceLine(util.GetPlayerTrace(ply, ply:GetCursorAimVector()))

	if (not trace.Hit) or trace.Entity:IsPlayer() then
		return ent:SetNoDraw(true)
	end
	
	local Ang = trace.HitNormal:Angle()
	Ang.pitch = Ang.pitch + 90
	
	ent:SetPos(trace.HitPos - trace.HitNormal * ent:OBBMins().z)
	ent:SetAngles(Ang)
	
	return ent:SetNoDraw(false)
end

local AngZero = Angle( 0, 0, 0)
local VecZero = Vector(0, 0, 0)

function TOOL:Think()
	if not (self.GhostEntity and self.GhostEntity:IsValid() and self.GhostEntity:GetModel() == self:GetClientInfo("model")) then
		self:MakeGhostEntity(self:GetClientInfo("model"), VecZero, AngZero)
	end

	return self:UpdateDaGhost(self.GhostEntity, self:GetOwner())
end

function TOOL.BuildCPanel(panel)
	panel:AddControl("PropSelect", {Label = "Lift Model:",
									ConVar = "sbep_lift_model",
									Category = "SBEP Elevators",
									Models = list.Get("SBEP_ElevatorMdls")})
	panel:AddControl( "Label", { Text  = "1. Select a Model\n"
									   .."2. Spawn the Lift\n"
									   .."3. Separate the Ghosts from the lift with the physgun\n"
									   .."4. Place the ghosts where you want the lift to move to\n"
									   .."5. (Optional) Wire it up."}  )
end

