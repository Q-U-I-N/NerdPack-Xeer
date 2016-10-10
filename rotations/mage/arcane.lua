local GUI = {

}

local exeOnLoad = function()
	-- NeP.Xeer:Splash()
end

local Survival = {

}

local Cooldowns = {

}

local AoE = {

}

local ST = {

}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local inCombat = {
	{Keybinds},
	{Survival, 'player.health < 100'},
	{Cooldowns, 'toggle(cooldowns)'},
	{AoE, {'toggle(AoE)', 'player.area(8).enemies >= 3'}},
	{ST, {'target.range <= 40', 'target.infront'}}
}

local outCombat = {
	{Keybinds},
}

NeP.CR:Add(62, '[|cff'..NeP.Xeer.Interface.addonColor..'Xeer|r] Mage - Arcane', inCombat, outCombat, exeOnLoad)