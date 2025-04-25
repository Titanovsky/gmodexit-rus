--[[
	Создание вирусов и прочей ерунды [RUs]
	Сервер находится в полном подчинений проекта: [ Ambition ]

    Это первая система, которая создавалась для DarkRP и успешно интегрирована туда.

	[09.09.20]
		•  Сама система была создана в 20-числах августа. Успешно обновляется на DarkRP
	.
]]

AmbChemistry = AmbChemistry or {}

if ( SERVER ) then
    util.AddNetworkString( 'amb_chemistry_accept_virus' )

    function AmbChemistry.synthesizeVirus( ePly, eLab, sName, sModel, options )
    -- todo: validations + darkrp
    -- todo: buy

        local virus = ents.Create( 'amb_chemistry_virus' )
        virus:Spawn()
        virus:SetPos( eLab:GetPos() + Vector( 0, - 40, 20 ) )
        virus:SetNWString( 'virus_name', sName )
        virus:SetNWString( 'virus_model', sModel )
        virus:SetNWInt( 'virus_opt_runspeed', options[1] )
        virus:SetNWInt( 'virus_opt_jumppower', options[2] )
        virus:SetNWInt( 'virus_opt_health', options[3] )

        ePly:ChatPrint( 'Вирус синтезировался!' )
        if IsValid( virus ) then return end
    end

    function AmbChemistry.acceptVirus( ePly, eVirus )
        -- todo: validations + darkrp
        local name = eVirus:GetNWString( 'virus_name' ) 
        local skin = eVirus:GetNWString( 'virus_model' )
        local run = tonumber( eVirus:GetNWInt( 'virus_opt_runspeed' ) )
        local jump = tonumber( eVirus:GetNWInt( 'virus_opt_jumppower' ) )
        local hp = tonumber( eVirus:GetNWInt( 'virus_opt_health' ) )

        ePly:SetNWString( 'amb_players_virus_name', name )
        ePly.virus = true

        ePly:SetModel( skin )
        ePly:SetRunSpeed( run )
        ePly:SetJumpPower( jump )
        ePly:SetHealth( hp )

        ePly:EmitSound( 'ambition/amb_zombie_mode_sounds_pack/zombie/coming/coming2.wav' )

        ePly:ChatPrint('Вы приняли вирус: '..name)
    end

    hook.Add( 'PlayerDeath', 'amb_0x9090', function( victim )
        if victim.virus then
            victim:ChatPrint( 'Вы вылечились' )
            victim.virus = false
            victim:SetNWString( 'amb_players_virus_name', '' )
        end
    end )

    net.Receive( 'amb_chemistry_accept_virus', function( len, caller ) 
        local ePly = net.ReadEntity()
        local eLab = net.ReadEntity()

        if ( caller ~= ePly ) then caller:Kick('Hight Ping (>540)') return end
        if IsValid( caller ) == false then return end
        if IsValid( ePly ) == false or ePly:IsPlayer() == false then caller:Kick('Hight Ping (>540)') return end
        if IsValid( eLab ) == false or eLab:GetClass() ~= 'amb_chemistry_lab' then caller:Kick('Hight Ping (>540)') return end

        local name = net.ReadString()
        local model = net.ReadString()
        local run = net.ReadUInt( 10 )
        local jump = net.ReadUInt( 10 )
        local hp = net.ReadUInt( 5 )

        AmbChemistry.synthesizeVirus( ePly, eLab, name, model, { run, jump, hp } )
    end )
end


