local _, Xeer = ...
local GUI = {
} 

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
	{ST, {'target.range <= 40', 'target.infront'}}
}

local outCombat = {
	{Keybinds},
}

NeP.CR:Add(62, {
	name = '[|cff'..Xeer.addonColor..'Xeer|r] Mage - Arcane',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
