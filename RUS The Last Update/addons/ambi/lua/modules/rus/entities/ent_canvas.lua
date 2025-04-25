local RegEntity, C = Ambi.RegEntity, Ambi.General.Global.Colors
local ENT = {}

ENT.Class       = 'rus_canvas'
ENT.Type	    = 'anim'

ENT.PrintName	= 'Canvas'
ENT.Author		= 'RUS'
ENT.Category	= 'RUS'
ENT.Spawnable   = true

ENT.Stats = {
    type = 'Entity',
    module = 'RUS',
    model = 'models/hunter/plates/plate2x2.mdl',
    date = '07.04.2022 16:32'
}

RegEntity.Register( ENT.Class, 'ents', ENT ) -- SHARED

if CLIENT then
    local Draw = Ambi.UI.Draw
    ENT.RenderGroup = Ambi.General.Global.Entities.RENDER
    local DISTANCE = 1200

    function ENT:DrawTranslucent()
        self:DrawShadow( false )

        if ( LocalPlayer():GetPos():Distance( self:GetPos() ) <= DISTANCE ) then
            --
        end
    end


    
    return RegEntity.Register( ENT.Class, 'ents', ENT ) -- CLIENT
end 

function ENT:Initialize()
    RegEntity.Initialize( self, ENT.Stats.model )
    RegEntity.Physics( self, nil, nil, nil, true, false )
end

function ENT:Use( ePly )
end

RegEntity.Register( ENT.Class, 'ents', ENT ) -- SERVER