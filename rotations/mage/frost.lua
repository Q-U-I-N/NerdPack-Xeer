local GUI = {

}

local exeOnLoad = function()
	-- Xeer.Core:Splash()
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

NeP.CR:Add(64, '[|cff'..Xeer.Interface.addonColor..'Xeer|r] Mage - Frost', inCombat, outCombat, exeOnLoad)