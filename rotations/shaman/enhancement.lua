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

}

local Melee = {
	--Flametongue to maintain the buff.
	{'Flametongue', 'target.debuff(Flametongue).duration < 5'},
	--Crash Lightning on cooldown.
	{'Crash Lightning'},
	--Stormstrike whenever available. Watch for Stormbringer procs.
	{'Stormstrike'},
	--Lava Lash to dump excess Maelstrom.
	{'Lava Lash', 'player.maelstrom > 65'},
	--Rockbiter as a filler ability to build Maelstrom.
	{'Rockbiter'}
}

local ST = {
	{Melee, 'target.range < 8' },
	--Lightning Bolt if not in melee range.
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
	{AoE, {'toggle(AoE)', 'player.area(8).enemies >= 3'}},
	{ST, {'target.range < 40', 'target.infront'}}
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(263, '[|cff'..Xeer.Interface.addonColor..'Xeer|r] Shaman - Enhancement', inCombat, outCombat, exeOnLoad, GUI)