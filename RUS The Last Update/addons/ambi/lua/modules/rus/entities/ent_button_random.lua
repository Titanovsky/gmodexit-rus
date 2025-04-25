local RegEntity, C = Ambi.RegEntity, Ambi.General.Global.Colors
local ENT = {}

ENT.Class       = 'rus_button_random'
ENT.Type	    = 'anim'

ENT.PrintName	= 'Button Random'
ENT.Author		= 'RUS'
ENT.Category	= 'RUS'
ENT.Spawnable   = true

ENT.Stats = {
    type = 'Entity',
    module = 'RUS',
    model = 'models/maxofs2d/button_02.mdl',
    date = '02.02.2022 23:43'
}

RegEntity.Register( ENT.Class, 'ents', ENT ) -- SHARED

if CLIENT then
    local Draw = Ambi.UI.Draw
    ENT.RenderGroup = Ambi.General.Global.Entities.RENDER
    local DISTANCE = 600

    function ENT:DrawTranslucent()
        self:DrawShadow( false )

        if ( LocalPlayer():GetPos():Distance( self:GetPos() ) <= DISTANCE ) then
            local rot = ( self:GetPos() - EyePos() ):Angle().yaw - 90
            local head = self:LocalToWorld( self:OBBCenter() ) + Vector( 0, 0, 12 )

            cam.Start3D2D( head, Angle( 0, rot, 100 ), 0.1 )
                Draw.SimpleText( 0, -200, 'Кнопка Рандомка', '64 Arial', C.AMBI_GREEN, 'center', 1, C.ABS_BLACK )
            cam.End3D2D()
        end
    end
    
    return RegEntity.Register( ENT.Class, 'ents', ENT ) -- CLIENT
end 

function ENT:Initialize()
    RegEntity.Initialize( self, ENT.Stats.model )
    RegEntity.Physics( self, nil, nil, nil, true, false )
end

function ENT:Use( ePly )
    if not ePly:IsPlayer() then return end
    if timer.Exists( 'DelayRandom:'..ePly:SteamID() ) then ePly:ChatPrint( 'Подождите '..math.floor( timer.TimeLeft( 'DelayRandom:'..ePly:SteamID() ) )..' секунд' ) return end
    timer.Create( 'DelayRandom:'..ePly:SteamID(), 60, 1, function() end )
    
    Ambi.Rus.CallRandomizer( ePly, Ambi.Rus.GetRandomizer() )
end

RegEntity.Register( ENT.Class, 'ents', ENT ) -- SERVER