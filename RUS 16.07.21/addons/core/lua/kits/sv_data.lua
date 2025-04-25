AmbKits = AmbKits or {}

local db = 'amb_kits'

AmbDB.createDataBase( db, [[ 
    'ID' varchar(255),
    'Diff_Time' bigint,
    'Kit' varchar(255)]] 
)


function AmbKits.SetTime( ePly, sKit, nTime )

    local ID = ePly:SteamID()

    AmbDB.insertDate( db, 'ID, Diff_Time, Kit', sql.SQLStr( ID )..', '..sql.SQLStr( nTime )..', '..sql.SQLStr( sKit ) )

end

function AmbKits.SaveTime( ePly, sKit, nTime )

    local ID = ePly:SteamID()

    sql.Query( 'UPDATE '..db..' SET Diff_Time='..sql.SQLStr( nTime )..' WHERE ID='..sql.SQLStr( ID )..' AND Kit='..sql.SQLStr( sKit ) )

end

function AmbKits.GetTime( ePly, sKit )

    local ID = ePly:SteamID()

    return sql.QueryValue( 'SELECT Diff_Time from '..db..' WHERE ID='..sql.SQLStr( ID )..' AND Kit='..sql.SQLStr( sKit ) )

end

function AmbKits.CreateDelay( ePly, sKit, nDelay )

    local ID = ePly:SteamID()

    if AmbKits.GetTime( ePly, sKit ) then

        AmbKits.SaveTime( ePly, sKit, nDelay )

    else

        AmbKits.SetTime( ePly, sKit, nDelay )

    end

end

function AmbKits.CheckDelay( ePly, sKit )

    local ID = ePly:SteamID()
    local delay = AmbKits.GetTime( ePly, sKit )

    if ( delay ) then

        if ( os.time() >= tonumber( delay ) ) then return false end

        return true

    else

        return false 

    end

end