include("shared.lua")

function ENT:Draw()

    self:DrawModel()

    if ( LocalPlayer():GetPos():Distance( self:GetPos() ) <= 1200 ) then

        cam.Start3D2D(self:LocalToWorld(Vector(-5,-10,12.7)), self:LocalToWorldAngles(Angle(0,90,0)),0.2)

            surface.SetDrawColor(100, 100, 100, 255)
            surface.DrawRect(1, 0, 50, 10)
            surface.DrawRect(1, 15, 50, 10)
            surface.SetDrawColor(255, 255, 255, 255)
            surface.SetMaterial(Material("icon16/control_eject.png"))
            surface.DrawTexturedRect(40, 15, 10, 10)
            surface.DrawTexturedRect(40, 0, 10, 10)
            
            surface.SetDrawColor(255, 255, 255, 255)
            surface.SetMaterial(tempmaterial)
            surface.DrawTexturedRect(80, 0, 16, 16)
            surface.SetMaterial(Material("icon16/stop.png"))
            surface.DrawTexturedRect(0, 30, 8, 8)

        cam.End3D2D()

    end
    
end

function ENT:Initialize() 
    tempmaterial = Material("icon16/page_white_tux.png")
    self:EmitSound("hl1/ambience/techamb2.wav", 70, 100, 1, CHAN_AUTO)
end

function ENT:OnRemove()
    self:StopSound("hl1/ambience/techamb2.wav")
end