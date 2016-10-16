local _, Xeer = ... 

local exeOnLoad = function()
	-- Xeer.ExeOnLoad()
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
	{ST, {'target.range < 40', 'target.infront'}}
}

local outCombat = {
	{Keybinds},
}

NeP.CR:Add(267, '[|cff'..Xeer.addonColor..'Xeer|r] Warlock - Destro', inCombat, outCombat, exeOnLoad)
