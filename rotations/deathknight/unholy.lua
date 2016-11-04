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
	--Virulent Plague maintained at all times via Outbreak.
	{'Outbreak', '!target.debuff(Virulent Plague)'},
	--Death Coil with Sudden Doom procs.
	{'Death Coil', 'player.buff(Sudden Doom)'},
	--Scourge Strike to burst Festering Wound.
	{'Scourge Strike', 'target.debuff(Festering Wound)'},
	--Festering Strike to apply Festering Wound.
	{'Festering Strike', '!target.debuff(Festering Wound)'},
	--Death Coil to dump Runic Power.
	{'Death Coil'}
}

local inCombat = {
	{Keybinds},
	{Survival, 'player.health < 100'},
	{Cooldowns, 'toggle(cooldowns)'},
	{AoE, {'toggle(AoE)', 'player.area(8).enemies >= 3'}},
	{ST, {'target.range < 8', 'target.infront'}}
}

local Keybinds = {
	{'%pause', 'keybind(alt)'},
	{'Death and Decay', 'keybind(shift)', 'cursor.ground'},
}

local outCombat = {
	{Keybinds},
}

NeP.CR:Add(252, {
	name = '[|cff'..Xeer.addonColor..'Xeer|r] Death Knight - Unholy',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
