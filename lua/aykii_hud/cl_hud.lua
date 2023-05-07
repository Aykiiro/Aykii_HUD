local hide = {
    ["CHudHealth"] = true,
    ["CHudBattery"] = true,
	["CHudAmmo"] = true
}
hook.Add("HUDShouldDraw", "HideHUD", function(name)
    if hide[name] then return false end
end)



surface.CreateFont("aykii_hud_32",
{
	font = "Times New Roman", 
	size = 36,
	weight = 500,
	antialias = true,
	strikeout = true, 
	additive = true,
	outline = true,
})
surface.CreateFont("aykii_hud_24",
{
	font = "Times New Roman", 
	size = 18,
	weight = 1000,
	antialias = true,
	strikeout = true,
	additive = true,
	outline = true,
})
surface.CreateFont("aykii_hud_26",
{
	font = "Times New Roman Bold", 
	size = 28,
	weight = 500,
	antialias = true,
	strikeout = true,
	additive = true,
	outline = true,
})
surface.CreateFont("aykii_hud_20",
{
	font = "Roboto", 
	size = 25,
	weight = 1000,
	antialias = true,
	strikeout = true,
	additive = true,
	outline = true,
})

surface.CreateFont("aykii_hud_30",
{
	font = "Times New Roman", 
	size = 15,
	weight = 1000,
	antialias = true,
	strikeout = true,
	additive = true,
	outline = true,
})

surface.CreateFont("aykii_hud_31",
{
	font = "Times New Roman", 
	size = 18,
	weight = 1000,
	antialias = true,
	strikeout = true,
	additive = true,
	outline = true,
})
surface.CreateFont("aykii_ammo",
{
	font = "Times New Roman", 
	size = 44,
	weight = 1000,
	antialias = true,
	strikeout = true,
	additive = true,
	outline = true,
})

--[[-------------------------------------------------------------------------
DRAWING HUD
---------------------------------------------------------------------------]]

hook.Add("HUDPaint", "Hud", function()
	local ply = LocalPlayer()
	local health = LocalPlayer():Health()
	local name = LocalPlayer():Name()
	local armor = LocalPlayer():Armor()
	local job = LocalPlayer():getDarkRPVar("job")
	local money = LocalPlayer():getDarkRPVar("money") or 0
	local salary = LocalPlayer():getDarkRPVar("salary") or 0
	local usergroup = LocalPlayer():GetNWString("usergroup")
	
	local background = Material("Materials/wop.png")
	local argent = Material("Materials/ryo.png")
	local salaire = Material("Materials/salary.png")
	local shield = Material("Materials/shieldos.png")
	--local logo = Material("Materials/logo.png")
	local ConVars = {}
	local HUDWidth
	local HUDHeight


	surface.SetMaterial(background)
	surface.SetDrawColor(250,250,250)
	surface.DrawTexturedRect(ScrW() / 3000, ScrH() - 300, 500, 300)

	surface.SetMaterial(argent)
	surface.SetDrawColor(250,250,250)
	surface.DrawTexturedRect(ScrW() / 17, ScrH() - 92, 20, 15)

	surface.SetMaterial(salaire)
	surface.SetDrawColor(250,250,250)
	surface.DrawTexturedRect(ScrW() - 1550, ScrH() - 92, 20, 15)

	surface.SetFont( "aykii_hud_24" )
	surface.SetTextColor(255, 255, 255)
	surface.SetTextPos( ScrW() - 139,ScrH() - 55) 
	draw.DrawText(name, "aykii_hud_20", ScrW() / 7.8, ScrH() - 140, Color(255, 255, 255), TEXT_ALIGN_CENTER)
	
	surface.SetFont( "aykii_hud_24" )
	surface.SetTextColor(255, 255, 255)
	surface.SetTextPos( ScrW() - 139, ScrH() - 55) 
	draw.DrawText(money, "aykii_hud_24", ScrW() / 19, ScrH() - 93, Color(255, 255, 255), TEXT_ALIGN_RIGHT)

	surface.SetFont( "aykii_hud_24" )
	surface.SetTextColor(255, 255, 255)
	surface.SetTextPos( ScrW() - 139, ScrH() - 55) 
	draw.DrawText(salary, "aykii_hud_24", ScrW() - 1505, ScrH() - 93, Color(255, 255, 255), TEXT_ALIGN_RIGHT)


	draw.RoundedBox(6, 80, ScrH() - 70, math.min(health, 800) * 0.425, 8.5, Color(255, 0, 0))
	draw.SimpleText(health, "aykii_hud_30", 245, ScrH() - 73, Color(255,255,255), TEXT_ALIGN_CENTER)


	draw.RoundedBox(6,147,ScrH() - 84, math.min(armor, 200) * 1.03,8, Color(20,100,175))
	draw.SimpleText(armor, "aykii_hud_30", 245, ScrH() - 88, Color(255,255,255), TEXT_ALIGN_CENTER)

	draw.SimpleText(job, "aykii_hud_31", 245, ScrH() - 170, Color(255,255,255), TEXT_ALIGN_CENTER)

	if (ply:IsAdmin() ) then
		draw.SimpleText(usergroup, "aykii_hud_31", 245, ScrH() - 110, Color(255,255,255), TEXT_ALIGN_CENTER)

		surface.SetMaterial(shield)
		surface.SetDrawColor(250,250,250)
		surface.DrawTexturedRect(ScrW() / 6.6, ScrH() - 107, 20, 15)

		surface.SetMaterial(shield)
		surface.SetDrawColor(250,250,250)
		surface.DrawTexturedRect(ScrW() / 10.5, ScrH() - 107, 20, 15)
	end

end)


function DrawHUD()
    for _, ply in pairs(player.GetAll()) do
        if not ply:IsDormant() and LocalPlayer():GetPos():Distance(ply:GetPos()) < 150 and ply:GetMoveType() ~= MOVETYPE_NOCLIP then
            local head_pos = ply:GetPos() + Vector(0, 0, 80)
            local head_pos_screen = head_pos:ToScreen()
            local ply_name = ply:Nick()
            local ply_health = ply:Health()

            draw.SimpleText(ply_name, "aykii_hud_24", head_pos_screen.x, head_pos_screen.y - 60, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

            draw.RoundedBox(12, head_pos_screen.x - 75, head_pos_screen.y - 40, 150, 20, Color(50, 50, 50, 200))
            draw.RoundedBox(12, head_pos_screen.x - 75, head_pos_screen.y - 40, math.Clamp(ply_health, 0, 800) * 0.187, 20, Color(255, 0, 0, 200))

            local img = Material("materials/black.png")
            surface.SetMaterial(img)
            surface.SetDrawColor(250,250,250)
            surface.DrawTexturedRect(head_pos_screen.x - -50, head_pos_screen.y - 60, 32, 32)

            draw.SimpleText(ply_health, "aykii_hud_30", head_pos_screen.x, head_pos_screen.y - 30, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end
end

function HUDPaint()
	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()
	if not IsValid(wep) then return end

	local clip = wep:Clip1()
	if clip < 0 then return end
	
	local ammo = ply:GetAmmoCount(wep:GetPrimaryAmmoType())

	local ammoback = Material("materials/ammo.png")
	surface.SetMaterial(ammoback)
	surface.SetDrawColor(250,250,250)
	surface.DrawTexturedRect(ScrW() - 290, ScrH() - 180, 300, 200)

	draw.SimpleText( clip, "aykii_ammo", 1805, ScrH() - 79, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
	draw.SimpleText( ammo, "aykii_ammo", 1750, ScrH() - 79, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
	draw.SimpleText( "||", "aykii_ammo", 1770, ScrH() - 105, Color( 255, 255, 255, 255 ), 0, 0 )
end

hook.Add("HUDPaint", "DrawMyHUD", DrawHUD)
hook.Add("HUDPaint", "DrawMyyHUD", HUDPaint)