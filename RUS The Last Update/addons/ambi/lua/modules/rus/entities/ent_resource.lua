local Ents, NW, C = Ambi.RegEntity, Ambi.NW, Ambi.General.Global.Colors
local ENT = {}

ENT.Class       = 'rus_resource'
ENT.Type	    = 'anim'

ENT.PrintName	= 'Resource'
ENT.Author		= 'Ambi'
ENT.Category	= 'RUS'
ENT.Spawnable   =  false

ENT.Stats = {
    type = 'Entity',
    module = 'RUS',
    model = 'models/props_c17/FurnitureFireplace001a.mdl',
    date = '14.03.2022 13:57'
}

Ents.Register( ENT.Class, 'ents', ENT )

if CLIENT then
    ENT.RenderGroup = RENDERGROUP_BOTH

    function ENT:DrawTranslucent()
        self:DrawShadow( false )
    end

    return Ents.Register( ENT.Class, 'ents', ENT )
end 

function ENT:Initialize()
    Ents.Initialize( self )
    Ents.Physics( self, nil, nil, nil, true, false )
end

function ENT:OnTakeDamage( damageInfo )
    local resources = self.resources
    if not resources then return end

    local ply = damageInfo:GetAttacker()
    if not IsValid( ply ) or not ply:IsPlayer() then return end

    local wep = ply:GetActiveWeapon()
    if not IsValid( wep ) then return end

    local can = false
    local instruments = self.instruments
    if not instruments then return end

    for _, class in ipairs( instruments ) do
        if ( class == wep:GetClass() ) then can = true break end    
    end
    if not can then return end

    local item = table.Random( resources )
    local random = math.random( 1, 100 )
    if ( random <= item.chance ) then
        local count = math.random( item.min, item.max )
        if not item.class then ply:ChatPrint( 'Не существует класса' ) return end
        if not Ambi.SimpleInventory.GetClass( item.class ) then ply:ChatPrint( 'Не существует '..item.class ) return end
        
        ply:AddItem( item.class, count, true, true )
        ply:ChatSend( C.ABS_WHITE, 'Вы добыли ', C.AMBI_GREEN, Ambi.SimpleInventory.GetClass( item.class ).name..' x'..count )
    end

    self:SetHealth( self:Health() - damageInfo:GetDamage() )
    if ( self:Health() <= 0 ) then self:Remove() return end
end

Ents.Register( ENT.Class, 'ents', ENT )

hook.Add( 'EntityRemoved', 'Ambi.Rus.GCForResourcesStarfall', function( eObj ) 
    local children = eObj.children_for_gc
    if not children then return end

    for _, v in ipairs( children ) do
        if IsValid( v ) then v:Remove() end
    end
end )