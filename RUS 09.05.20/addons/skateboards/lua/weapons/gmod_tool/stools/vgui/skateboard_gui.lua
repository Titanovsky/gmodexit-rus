
function PANEL:Init( )

	self.Attributes = {}

	self.BoardSelect = vgui.Create( "PropSelect", self )
	self.BoardSelect:SetConVar( "skateboard_model" )
	self.BoardSelect.Label:SetText( "Select Model" )



end

function PANEL:PerformLayout( )

	local vspacing = 10
	local ypos = 0

	self.BoardSelect:SetPos( 0, ypos )
	self.BoardSelect:SetSize( self:GetWide(), 165 )
	ypos = self.BoardSelect.Y + self.BoardSelect:GetTall() + vspacing

	/*self.PointsText:SetPos( 0, ypos )
	ypos = self.PointsText.Y + self.PointsText:GetTall() + vspacing*/
	
	for _, panel in pairs( self.Attributes ) do

		panel:SetPos( 0, ypos )
		panel:SetSize( self:GetWide(), panel:GetTall() )
		ypos = panel.Y + panel:GetTall() + vspacing

	end

	self:SetHeight( ypos )



end


function PANEL:Think( )


	if ( self.SkateboardTable ) then

		local selected = GetConVarString( self.BoardSelect:ConVar() )

		if ( selected != self.LastSelectedBoard ) then

			self.LastSelectedBoard = selected

			

			/*for _, board in pairs( self.SkateboardTable ) do

				if ( selected:lower() == board[ 'model' ]:lower() ) then

					for k, v in pairs( board[ 'bonus' ] ) do

						for name, panel in pairs( self.Attributes ) do

							if ( panel.Attribute == k:lower() ) then

								panel:SetText( ("%s +%d"):format( name, tonumber( v ) ) )
								panel.Label:SetTextColor( Color( 0, 200, 0, 255 ) )

							end

						end

					end

					break

				end

			end*/

		end

	end

end

function PANEL:PopulateBoards( tbl )

	for _, board in pairs( tbl ) do

		self.BoardSelect:AddModel( board[ 'model' ] )

		self.BoardSelect.Controls[ #self.BoardSelect.Controls ]:SetToolTip( board[ 'name' ] or "Unknown" )
	
	end

	self.SkateboardTable = tbl

end






