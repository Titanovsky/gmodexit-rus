function zone:AddNewZone( map, tab )
	if ( string.lower( map ) != game.GetMap():lower() ) then return end
	
	tab.SizeForwards.x = math.abs( tab.SizeForwards.x )
	tab.SizeForwards.y = math.abs( tab.SizeForwards.y )
	tab.SizeForwards.z = math.abs( tab.SizeForwards.z )
	
	for k,v in pairs( { "x", "y", "z" } ) do
		tab.SizeForwards[ v ] = math.abs( tab.SizeForwards[ v ] )
		
		if ( tab.SizeBackwards[ v ] > 0 ) then
			tab.SizeBackwards[ v ] = tab.SizeBackwards[ v ] * -1
		end
	end
	
	table.insert( self.Data, tab )
end


function zone:InsideSafeZone( pos )
	for k,v in pairs( self.Data ) do
		if ( pos:WithinAABox( v.Center + v.SizeBackwards, v.Center + v.SizeForwards ) ) and v.Status == "safe" then
			return true
		end
	end return false
end

function zone:InsideBuildZone( pos )
	for k,v in pairs( self.Data ) do
		if ( pos:WithinAABox( v.Center + v.SizeBackwards, v.Center + v.SizeForwards ) ) and v.Status == "build" then
			return true
		end
	end return false
end

function zone:InsideBaseZone( pos )
	for k,v in pairs( self.Data ) do
		if ( pos:WithinAABox( v.Center + v.SizeBackwards, v.Center + v.SizeForwards ) ) and v.Status == "base"  and v.Base == 1 then
			return 1
		end
		if ( pos:WithinAABox( v.Center + v.SizeBackwards, v.Center + v.SizeForwards ) ) and v.Status == "base" and v.Base == 2 then
			return 2
		end
	end return false
end
