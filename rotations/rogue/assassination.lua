local _, Xeer = ...
local GUI = {
} 

local exeOnLoad = function()
	-- Xeer.ExeOnLoad()
end

local Survival = {

}

local Cooldowns = {
	{'Vendetta'}
}

local InCombat = {
	-- Poisons
	{'Deadly Poison', '!player.buff(Deadly Poison)'},
	{'Crippling Poison', '!player.buff(Crippling Poison)'},
	--Rupture maintained with 5 Combo Points.
	{'Rupture', {'player.combopoints >= 5', 'target.debuff(Rupture).duration < 5'}},
	--Garrote to maintain the DoT.
	{'Garrote', '!target.debuff(Garrote)'},
	--Envenom to dump excess Combo Points.
	{'Envenom', 'player.combopoints >= 5'},
	--Mutilate or  to build Combo Points.
	{'Fan of Knives', {'toggle(AoE)', 'player.area(8).enemies >= 3'}},
	{'Mutilate'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local inCombat = {
	{Keybinds},
	{Survival, 'player.health < 100'},
	{Cooldowns, 'toggle(cooldowns)'},
	{InCombat, {'target.range < 8', 'target.infront'}}
}

local outCombat = {
	{Keybinds},
	-- Poisons
	{'Deadly Poison', '!player.buff(Deadly Poison)'},
	{'Crippling Poison', '!player.buff(Crippling Poison)'},
}

NeP.CR:Add(259, {
	name = '[|cff'..Xeer.addonColor..'Xeer|r] Rogue - Assassination',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
