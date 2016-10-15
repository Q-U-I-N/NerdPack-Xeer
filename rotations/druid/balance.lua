local _, Xeer = ...

local exeOnLoad = function()
	-- Xeer.ExeOnLoad()
end

local Survival = {

}

local Cooldowns = {
	{'Celestial Alignment'}
}

local AoE = {
	--Sunfire and Moonfire maintained at all times.
	{'Sunfire', 'target.debuff(Sunfire).duration < 5'},
	{'Moonfire', 'target.debuff(Moonfire).duration < 5'},
	--Starfall to dump Astral Power and apply Stellar Empowerment.
	{'Starfall', nil, 'target.ground'},
	--Lunar Strike as your Astral Power builder
	{'Lunar Strike'}
}

local ST = {
	--Sunfire and Moonfire maintained at all times.
	{'Sunfire', 'target.debuff(Sunfire).duration < 5'},
	{'Moonfire', 'target.debuff(Moonfire).duration < 5'},
	--Starsurge to dump Astral Power and build Lunar Empowerment and Solar Empowerment.
	{'Starsurge', 'player.energy >= 65'},
	--Solar Wrath to consume Solar Empowerment.
	{'Solar Wrath', 'player.buff(Solar Empowerment)'},
	--Lunar Strike to consume Lunar Empowerment.
	{'Lunar Strike', 'player.buff(Lunar Empowerment)'},
	--Solar Wrath as a filler spell and to build Astral Power when no Empowerments are present.
	{'Solar Wrath'}
}

local inCombat = {
	{Keybinds},
	{Survival, 'player.health < 100'},
	{Cooldowns, 'toggle(cooldowns)'},
	{AoE, {'toggle(AoE)', 'player.area(40).enemies >= 3'}},
	{ST, {'target.range < 40', 'target.infront'}}
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local outCombat = {
	{Keybinds},
}

NeP.CR:Add(102, '[|cff'..Xeer.Interface.addonColor..'Xeer|r] Druid - Balance', inCombat, outCombat, exeOnLoad)
