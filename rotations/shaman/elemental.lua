local GUI = {

}

local exeOnLoad = function()
	--Xeer.Splash()
end

local Survival = {

}

local Cooldowns = {

}

local AoE = {
	--Earthquake Totem maintained at all times.
	{'Earthquake Totem', nil, 'target.ground'},
	--Earth Shock when you have >= 80 Maelstrom.
	{'Earth Shock', 'player.maelstrom >= 80'},
	--Chain Lightning as a filler and to build Maelstrom.
	{'Chain Lightning'}
}

local ST = {
	--Flame Shock to maintain the DoT with 20 Maelstrom refreshes.
	{'Flame Shock', {
		'target.debuff(Flame Shock),duration < 5',
		'player.maelstrom >= 20'
	}},
	--Lava Burst when available. Watch for Lava Surge procs.
	{'Lava Burst'},
	--Earth Shock when you have >= 80 Maelstrom.
	{'Earth Shock', 'player.maelstrom >= 80'},
	--Lightning Bolt as a filler spell and to build Maelstrom.
	{'Lightning Bolt'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local inCombat = {
	{Keybinds},
	{Survival, 'player.health < 100'},
	{Cooldowns, 'toggle(cooldowns)'},
	{AoE, {'toggle(AoE)', 'player.area(40).enemies >= 3'}},
	{ST, {'target.range < 40', 'target.infront'}}
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(262, '[|cff'..Xeer.Interface.addonColor..'Xeer|r] Shaman - Elemental', inCombat, outCombat, exeOnLoad, GUI)