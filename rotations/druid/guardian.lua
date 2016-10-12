local exeOnLoad = function()
	Xeer.Core:Splash()
end

local Survival = {

}

local Cooldowns = {

}

local AoE = {
	--Mangle whenever available to generate Rage. Watch for Gore procs.
	{'Mangle'},
	--Thrash on cooldown.
	{'Thrash'},
	--Moonfire on as many targets as possible.
	{'Moonfire', 'target.debuff(Moonfire).duration < 5'},
	--Swipe as often as possible.
	{'Swipe'}
}

local ST = {
	--Mangle whenever available to generate Rage. Watch for Gore procs.
	{'Mangle'},
	--Thrash on cooldown.
	{'Thrash'},
	--Moonfire to maintain the DoT.
	{'Moonfire', 'target.debuff(Moonfire).duration < 5'},
	--Maul to dump excess Rage
	{'Maul'}
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

NeP.CR:Add(104, '[|cff'..Xeer.Interface.addonColor..'Xeer|r] Druid - Guardian', inCombat, outCombat, exeOnLoad)
