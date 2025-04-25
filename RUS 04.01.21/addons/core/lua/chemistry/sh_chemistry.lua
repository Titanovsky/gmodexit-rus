--[[
	Система Создания вирусов (в будущем вакцины/лекарств).
	Сервер находится в полном подчинений проекта: [ Ambition ]

	[ 26.08.20 ]
		• 25.08 был протестирован на Sandbox (это первый скрипт, который так тестировался) и после удачных результатов доделан и отправлен на PhonexRP.
        • Добавил валидацию и покупку синтеза вируса, и не сам вирус Remove() после принятия, а функция acceptVirus() его уничтожает.
	.
    [10.09.20]
        • Поправил спавн вируса (позицию).
    .
]]


AmbChemistry = AmbChemistry or {}
AmbChemistry.cost_synthesize_virus = 2000


if ( SERVER ) then
    util.AddNetworkString( 'amb_chemistry_accept_virus' )

    function AmbChemistry.synthesizeVirus( ePly, eLab, sName, sModel, options )
        if ( ePly:Team() ~= Tchemic1 ) then return end
        if ( IsValid( eLab ) == false ) or ( eLab:GetClass() ~= 'amb_chemistry_lab' ) then return end
        
    
        if ( AmbChemistry.buyVirus( ePly ) == false ) then return end

        local virus = ents.Create( 'amb_chemistry_virus' )
        virus:Spawn()
        virus:SetPos( eLab:GetPos() + Vector( 0, -25, 64 ) )
        virus:SetNWString( 'virus_name', sName )
        virus:SetNWString( 'virus_model', sModel )
        virus:SetNWInt( 'virus_opt_runspeed', options[1] )
        virus:SetNWInt( 'virus_opt_jumppower', options[2] )
        virus:SetNWInt( 'virus_opt_health', options[3] )

        ePly:ChatPrint( 'Вирус синтезировался!' )
        if IsValid( virus ) then return end
    end

    function AmbChemistry.buyVirus( ePly )

        if ( AmbStats.Players.getStats( ePly, '$' ) >= AmbChemistry.cost_synthesize_virus ) then
            AmbStats.Players.addStats( ePly, '$', -AmbChemistry.cost_synthesize_virus )
            return true
        else 
            ePly:ChatPrint('Не хватает денег 2000$') -- todo: AmbLib.chat
            return false
        end
    end

    function AmbChemistry.acceptVirus( ePly, eVirus )
        local name = eVirus:GetNWString( 'virus_name' ) 
        local skin = eVirus:GetNWString( 'virus_model' )
        local run = tonumber( eVirus:GetNWInt( 'virus_opt_runspeed' ) )
        local jump = tonumber( eVirus:GetNWInt( 'virus_opt_jumppower' ) )
        local hp = tonumber( eVirus:GetNWInt( 'virus_opt_health' ) )

        if ePly.virus then ePly:ChatPrint('Вы уже заражены!') return end

        ePly:SetNWString( 'amb_players_virus_name', name )
        ePly.virus = true

        ePly:StripWeapons()
        ePly:Give( 'arccw_melee_fists' )
        ePly:SetModel( skin )
        ePly:SetRunSpeed( run )
        ePly:SetJumpPower( jump )
        ePly:SetHealth( hp )

        ePly:EmitSound( 'ambition/amb_zombie_mode_sounds_pack/zombie/coming/coming'..tostring(math.random(1,10))..'.wav' )

        ePly:ChatPrint( 'Вы заразились: '..name )

        if IsValid( eVirus ) then eVirus:Remove() return end
    end

    hook.Add( 'PlayerDeath', 'amb_0x9090', function( victim )
        if ( victim.virus ) then
            victim:ChatPrint( 'Вы вылечились' )
            victim.virus = false
            victim:SetNWString( 'amb_players_virus_name', '' )
        end
    end )

    net.Receive( 'amb_chemistry_accept_virus', function( len, caller ) 
        local ePly = net.ReadEntity()
        local eLab = net.ReadEntity()

        if ( IsValid( caller ) == false ) then return end
        if ( caller ~= ePly ) then caller:Kick('Hight Ping (>540)') return end
        if IsValid( ePly ) == false or ePly:IsPlayer() == false then caller:Kick('Hight Ping (>540)') return end

        -- todo: сделать валидацию для name,model,run,jump,hp

        local name = net.ReadString()
        local model = net.ReadString()
        local run = net.ReadUInt( 10 )
        local jump = net.ReadUInt( 10 )
        local hp = net.ReadUInt( 10 )

        AmbChemistry.synthesizeVirus( ePly, eLab, name, model, { run, jump, hp } )
    end )
elseif ( CLIENT ) then

end


