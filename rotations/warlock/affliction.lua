local _, Xeer = ...
local GUI = {
}

local exeOnLoad = function()

	 Xeer.ExeOnLoad()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print("|cffADFF2F --- |rWARLOCK |cffADFF2FAffliction |r")
	print("|cffADFF2F --- |rRecommended Talents: 1/2 - 2/2 - 3/1 - 4/1 - 5/3 - 6/3 - 7/2")
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local _Xeer = {

	{'@Xeer.Targeting()', {'!target.alive', 'toggle(AutoTarget)'}},
}

local xCombat = {
{'Corruption', '!target.dot(Corruption).ticking'},
{'Drain Life'},

}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local Survival = {
	{'#5512', 'player.health<80'},
}

local Cooldowns = {
	--actions+=/berserking
	--{'Berserking'},
 	--actions+=/blood_fury
	--{'Blood Fury'},
 	--actions+=/soul_harvest
	{'Soul Harvest', 'talent(4,3)'},
 	--actions+=/potion,name=deadly_grace,if=buff.soul_harvest.remains|target.time_to_die<=45|trinket.proc.any.up
	--{'', ''},
}

local inCombat = {
	{Keybinds},
	--{Survival, 'player.health < 100'},
	{Cooldowns, 'toggle(cooldowns)'},
 	--actions+=/call_action_list,name=single_target
	{xCombat, {'target.range<40', 'target.infront'}}
}

local outCombat = {
	{Keybinds},
	--{PreCombat},
}

NeP.CR:Add(265, {
	name = '[|cff'..Xeer.addonColor..'Xeer|r] WARLOCK - Affliction',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
