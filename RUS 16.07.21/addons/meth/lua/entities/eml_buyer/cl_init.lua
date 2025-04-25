include("shared.lua")
ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:Draw()
	self:DrawModel();

	self:DrawShadow(false)

	if self:GetPos():Distance( LocalPlayer():GetPos() ) < 300 then
        local pos = self:GetPos() + Vector(15, 0, 35)
        cam.Start3D2D( pos + self:GetAngles():Up(), Angle( 0, LocalPlayer():EyeAngles().yaw - 90, 90 ), 0.25 )
            draw.SimpleTextOutlined( "Покупатель наркоты", "DermaLarge", -120, -200, Color( 0, 0, 0, 255 ), TEXT_ALIGN_СENTER, TEXT_ALIGN_СENTER, 0.6, Color( 255, 255, 255, 255) )
            if ( self:GetNWBool("IsSmile") ) then
            	draw.SimpleText( ":)", "DermaLarge", -120, -260, Color( 0, 255, 0, 255 ), TEXT_ALIGN_СENTER, TEXT_ALIGN_СENTER )
            else
            	draw.SimpleText( ":(", "DermaLarge", -120, -260, Color( 150, 0, 0, 255 ), TEXT_ALIGN_СENTER, TEXT_ALIGN_СENTER )
            end
        cam.End3D2D()
    end
end;

function ENT:DrawTranslucent()
	self:Draw()
end

function ENT:BuildBonePositions( NumBones, NumPhysBones )
end
 
function ENT:SetRagdollBones( bIn )
	self.m_bRagdollSetup = bIn
end

function ENT:DoRagdollBone( PhysBoneNum, BoneNum )
--self:SetBonePosition( BoneNum, Pos, Angle )
end

--[[
size = 128;
draw_set_blend_mode(bm_subtract);
surface_set_target(light);
draw_ellipse_color(x-(size/2)-view_xview,y-(size/2)-view_yview,x+(size/2)-view_xview,y+(size/2)-view_yview, c_white, c_black, false);

surface_reset_target();
draw_set_blend_mode(bm_normal);
]]--