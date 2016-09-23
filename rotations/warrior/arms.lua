local GUI = {

}

local exeOnLoad = function()
	Xeer.Splash()
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
	{ST, {'target.range < 8', 'target.infront'}}
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(71, '[|cff'..Xeer.Interface.addonColor..'Xeer|r] Warrior - Arms', inCombat, outCombat, exeOnLoad, GUI)