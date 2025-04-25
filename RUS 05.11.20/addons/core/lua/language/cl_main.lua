AmbLang = AmbLang or {}

AmbLang.strings = {
    ['#test'] = { 
        'Test Text',
        'Тестовый Текст',
        'Testious Texus'
    },

    ['#puka_tuka'] = { 
        'Test Text',
        'Тестовый Текст',
        'Testious Texus'
    }
}

function AmbLang.str( str )
    if string.GetChar( str, 1 ) == '#' then
        for index, v in pairs( AmbLang.strings ) do
            if ( str == index ) then
                if ( GetConVar('amb_lang'):GetString() == 'en' ) then
                    return v[1]
                elseif ( GetConVar('amb_lang'):GetString() == 'ru' ) then
                    return v[2]
                elseif ( GetConVar('amb_lang'):GetString() == 'lt' ) then
                    return v[3]
                end
            end
        end
    end

    return str
end

function AmbLang.addStr( lang, index, str )
    AmbLang.strings[ index ] = {}

    if ( lang == 'en' ) then
       AmbLang.strings[ index ][1] = str
    elseif ( lang == 'ru' ) then
        AmbLang.strings[ index ][2] = str
    elseif ( lang == 'lt' ) then
        AmbLang.strings[ index ][3] = str
    end

    PrintTable(  AmbLang.strings )
end

if ( CLIENT ) then
    CreateClientConVar( 'amb_lang', 'en', true )
end
-- print( AmbLang.str( '#test' ) ) -- debug