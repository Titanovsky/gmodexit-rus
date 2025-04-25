ENT.Type="anim"
ENT.Base="base_anim"
ENT.PrintName="C4"
ENT.Spawnable=true
ENT.Category= "J.I. Defense Solutions"
ENT.Model="models/weapons/w_c4_planted.mdl"

function ENT:SetupDataTables()
    self:NetworkVar( "Int", 0, "StartTime" );
    self:NetworkVar( "Int", 1, "TimeToExplode");
    self:NetworkVar( "Bool", 0, "Started");
end
