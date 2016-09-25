local GUI = {

}

local exeOnLoad = function()
	--Xeer.Splash()
end

local Survival = {

}

local Cooldowns = {
	--Bestial Wrath Use on cooldown.
	{'Bestial Wrath'},
	--Aspect of the Wild Use on cooldown.
	{'Aspect of the Wild'}
}

local Pet = {
	-- Mend Pet
	{'Mend Pet', 'pet.health < 100'},
	--Kill Command on cooldown.
	{'Kill Command', 'target.petrange < 25'},
}

local AoE = {
	--Dire Beast on cooldown.
	{'Dire Beast'},
	--Multi-Shot for Beast Cleave and to dump Focus.
	{'Multi-Shot'}
}

local ST = {
	--Cobra Shot as needed to dump Focus.
	{'Cobra Shot', 'player.focus > 65'},
	--Dire Beast on cooldown to generate Focus.
	{'Dire Beast'}
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local inCombat = {
	{Keybinds},
	{Survival, 'player.health < 100'},
	{Cooldowns, 'toggle(cooldowns)'},
	{pet, {'pet.exists', 'pet.alive'}},
	{AoE, {'toggle(AoE)', 'player.area(40).enemies >= 3'}},
	{ST, {'target.range < 40', 'target.infront'}}
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(253, '[|cff'..Xeer.Interface.addonColor..'Xeer|r] Hunter - Beast Mastery', inCombat, outCombat, exeOnLoad, GUI)