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
	--Frost Fever maintain at all times via Howling Blast.
	{'Howling Blast', '!target.debuff(Frost Fever)'},
	--Obliterate with Killing Machine procs.
	{'Obliterate', 'player.buff(Killing Machine)'},
	--Howling Blast with Rime procs.
	{'Howling Blast', 'player.buff(Rime)'},
	--Obliterate to dump Runes.
	{'Obliterate', 'player.runes >= 4'},
	--Frost Strike to dump Runic Power.
	{'Frost Strike'}
}

local inCombat = {
	{Keybinds},
	{Survival, 'player.health < 100'},
	{Cooldowns, 'toggle(cooldowns)'},
	{AoE, {'toggle(AoE)', 'player.area(8).enemies >= 3'}},
	{ST, {'target.range < 8', 'target.infront'}}
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local outCombat = {
	{Keybinds},
}

NeP.CR:Add(251, '[|cff'..Xeer.Interface.addonColor..'Xeer|r] Death Knight - Frost', inCombat, outCombat, exeOnLoad)
