local GUI = {

}

local exeOnLoad = function()
	-- Xeer.Core:Splash()
end

local Survival = {

}

local Cooldowns = {

}

local AoE = {
	{'Blade Flurry', '!player.buff(Blade Flurry)'}
}

local ST = {
	-- Remove Blade Flurry
	{'Blade Flurry', {
		'!player.buff(Blade Flurry)',
		'!player.area(8).enemies >= 3'
	}},
	--Roll the Bones with >= 5 Combo Points to maintain the random buffs.
	{'Roll the Bones', 'player.combopoints >= 5'},
	--Run Through to dump excess Combo Points.
	{'Roll the Bones', 'player.combopoints >= 5'},
	--Pistol Shot when buffed from Saber Slash.
	{'Pistol Shot', 'player.buff(Opportunity)'},
	--Ambush when possible to generate Combo Points.
	{'Ambush'},
	--Saber Slash or to build Combo Points.
	{'Saber Slash'}
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

NeP.CR:Add(260, '[|cff'..Xeer.Interface.addonColor..'Xeer|r] Rogue - Outlaw', inCombat, outCombat, exeOnLoad)