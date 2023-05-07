if SERVER then
    
    -- Add Lua File for Client :
    AddCSLuaFile("aykii_hud/cl_hud.lua")

elseif CLIENT then

    -- Include Client :
    include("aykii_hud/cl_hud.lua")

end