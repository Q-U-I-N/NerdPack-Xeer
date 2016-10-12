local exeOnLoad = function()
	-- Xeer.ExeOnLoad()
end

local Survival = {
	{'Blur', 'player.health <= 60'}
}

local Interrupts = {
	{'Consume Magic'}
}

local Keybinds = {
	{'%pause', 'keybind(alt)'},
}

local Cooldowns = {
	{'Metamorphosis', nil, 'target.ground'}
}

local inCombat = {
	{Keybinds},
	{Survival, 'player.health < 100'},
	{Interrupts, 'target.interruptAt(50)'},
	{Cooldowns, 'toggle(cooldowns)'},
	{'Vengeful Retreat', {'target.range <= 6', 'player.spell(Fel Rush).charges >= 2', 'player.fury <= 85'}},
	{'Fel Rush', {'player.spell(Fel Rush).charges >= 2', 'target.range > 5'}},
	{'Blade Dance', {'toggle(AoE)', 'player.area(8).enemies >= 4'}},
	{'Chaos Strike', 'player.fury >= 70'},
	{'Demon\'s Bite'},
}

local outCombat = {
	{Keybinds}
}

NeP.CR:Add(577, '[|cff'..Xeer.Interface.addonColor..'Xeer|r] Demon Hunter - Havoc', inCombat, outCombat, exeOnLoad)
