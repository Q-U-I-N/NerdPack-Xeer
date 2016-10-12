local GUI = {

}

local exeOnLoad = function()
	-- Xeer.Core:Splash()
end

local Survival = {

}

local Cooldowns = {
	{'Shadow Blades'}
}

local ST = {
	--Symbols of Death to maintain the buff.
	{'Symbols of Death', '!target.debuff(Symbols of Death).duration < 5'},
	--Nightblade maintained with >= 5 Combo Point refreshes.
	{'Nightblade', {'player.combopoints >= 5', 'target.debuff(Nightblade).duration < 5'}},
	--Shadow Dance with 2 or more charges.
	{'Shadow Dance', 'player.spell(Shadow Dance).charges >= 2'},
	--Eviscerate to dump excess Combo Points.
	{'Eviscerate', 'player.combopoints >= 5'},
	--Shadowstrike when available to build Combo Points.
	{'Shadowstrike'},
	--Backstab or Shuriken Storm to build Combo Points.
	{'Shuriken Storm', {'toggle(AoE)', 'player.area(8).enemies >= 3'}},
	{'Backstab'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local inCombat = {
	{Keybinds},
	{Survival, 'player.health < 100'},
	{Cooldowns, 'toggle(cooldowns)'},
	{ST, {'target.range < 8', 'target.infront'}}
}

local outCombat = {
	{Keybinds},
}

NeP.CR:Add(261, '[|cff'..Xeer.Interface.addonColor..'Xeer|r] Rogue - Subtlely', inCombat, outCombat, exeOnLoad)