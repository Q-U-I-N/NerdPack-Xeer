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
	--Fists of Fury on cooldown with >= 3 Chi.
	{'Fists of Fury', {
		'target.infront',
		'player.chi >=3'
	}},
	--Blackout Kick with proc from Combo Breaker proc.
	{'Blackout Kick', 'player.buff(Combo Breaker proc)'},
	--Rising Sun Kick when available.
	{'Rising Sun Kick'},
	--Blackout Kick to dump additional Chi.
	{'Blackout Kick'},
	--Tiger Palm as default Chi builder and to proc Combo Breaker.
	{'Tiger Palm'}
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

NeP.CR:Add(269, {
	name = '[|cff'..Xeer.addonColor..'Xeer|r] Monk - Windwalker',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
