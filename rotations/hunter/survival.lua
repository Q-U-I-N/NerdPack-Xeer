local _, Xeer = ...
local GUI = {
} 

local exeOnLoad = function()
	-- Xeer.ExeOnLoad()
end

local Survival = {

}

local Cooldowns = {
	--Aspect of the Eagle Use on every cooldown.
	{'Aspect of the Eagle'}
}

local Pet = {
	-- Mend Pet
	{'Mend Pet', 'pet.health < 100'},
}

local AoE = {
	--Carve to dump excess Focus.
	{'Carve', 'player.focus > 65'}
}

local ST = {
	--Explosive Trap
	{'Explosive Trap'},
	--Lacerate maintained at all times.
	{'Lacerate', 'target.debuff(Lacerate).duration < 4'},
	--Mongoose Bite dump all charges when they stack to 3.
	{'Mongoose Bite', 'player.spell(Mongoose Bite).charges >= 3'},
	--Flanking Strike on cooldown.
	{'Flanking Strike'},
	--Raptor Strike to dump any extra Focus.
	{'Raptor Strike'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local inCombat = {
	{'Mongoose Bite', 'lastcast(Mongoose Bite)'},
	{Keybinds},
	{Survival, 'player.health < 100'},
	{Cooldowns, 'toggle(cooldowns)'},
	{pet, {'pet.exists', 'pet.alive'}},
	{AoE, {'toggle(AoE)', 'player.area(8).enemies >= 3'}},
	{ST, {'target.range < 8', 'target.infront'}}
}

local outCombat = {
	{Keybinds},
}

NeP.CR:Add(255, {
	name = '[|cff'..Xeer.addonColor..'Xeer|r] Hunter - Survival',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
